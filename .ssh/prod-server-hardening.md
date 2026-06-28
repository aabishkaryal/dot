# Production Server Hardening Runbook

This runbook is safe to commit. It intentionally avoids private keys, passwords, tokens, real domains, database URLs, and application secrets.

Assumptions:

- Ubuntu Server 24.04 LTS or similar Debian-based Linux.
- Manual deployments over SSH.
- Public ports should be limited to `22/tcp`, `80/tcp`, and `443/tcp`.
- Applications should bind to localhost and be exposed through a reverse proxy.
- Commands that modify the server should be run as `root` or with `sudo`.

## 1. First Access Checklist

Keep the original SSH session open until a second terminal confirms key-based login works.

```sh
ssh <admin-user>@<server-host>
```

Verify the OS and basic network state:

```sh
hostnamectl
ip -br addr
ip route
timedatectl
```

Update package metadata before installing security tooling:

```sh
apt update
apt upgrade -y
```

If `apt` fails with `Temporary failure resolving`, debug DNS before changing package mirrors.

## 2. SSH Key Setup

Install the public key for the admin user:

```sh
mkdir -p ~/.ssh
chmod 700 ~/.ssh
printf '%s\n' '<public-key-here>' >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

Validate key-only login from the local machine:

```sh
ssh -o PasswordAuthentication=no <admin-user>@<server-host>
```

Do not remove password fallback or root access until the non-root admin user can log in with a key from a second terminal.

## 3. Admin User

Create a non-root admin user:

```sh
adduser <admin-user>
usermod -aG sudo <admin-user>
mkdir -p /home/<admin-user>/.ssh
cp /root/.ssh/authorized_keys /home/<admin-user>/.ssh/authorized_keys
chown -R <admin-user>:<admin-user> /home/<admin-user>/.ssh
chmod 700 /home/<admin-user>/.ssh
chmod 600 /home/<admin-user>/.ssh/authorized_keys
```

Verify:

```sh
ssh -o PasswordAuthentication=no <admin-user>@<server-host>
sudo -v
```

## 4. SSH Hardening

Create a dedicated hardening file:

```sh
cat >/etc/ssh/sshd_config.d/99-hardening.conf <<'EOF'
PermitRootLogin prohibit-password
PasswordAuthentication no
KbdInteractiveAuthentication no
ChallengeResponseAuthentication no
PubkeyAuthentication yes
PermitEmptyPasswords no
X11Forwarding no
AllowTcpForwarding no
ClientAliveInterval 300
ClientAliveCountMax 2
MaxAuthTries 3
AllowUsers <admin-user>
EOF
```

Check for cloud-init or vendor override files:

```sh
ls -la /etc/ssh/sshd_config.d/
grep -R "PasswordAuthentication\|PermitRootLogin\|AllowUsers" /etc/ssh/sshd_config /etc/ssh/sshd_config.d/ || true
```

Validate and reload SSH:

```sh
sshd -t
systemctl reload ssh
```

Verify effective settings:

```sh
sshd -T | grep -E '^(passwordauthentication|kbdinteractiveauthentication|permitrootlogin|pubkeyauthentication|allowusers|maxauthtries)'
```

Test from a new local terminal:

```sh
ssh -o PasswordAuthentication=no <admin-user>@<server-host>
```

## 5. Firewall

Use `ufw` to expose only SSH, HTTP, and HTTPS:

```sh
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw enable
ufw status verbose
```

Do not expose app runtimes, databases, Redis, admin panels, or metrics ports publicly. Bind those services to `127.0.0.1`.

Audit listening sockets:

```sh
ss -tulpn
```

Expected public listeners should be limited to SSH and the reverse proxy.

## 6. Package Updates

Install baseline security tooling:

```sh
apt update
apt install -y curl git ufw fail2ban unattended-upgrades ca-certificates gnupg
```

Enable security updates:

```sh
dpkg-reconfigure --priority=low unattended-upgrades
systemctl status unattended-upgrades
```

Routine updates:

```sh
apt update
apt list --upgradable
apt upgrade -y
reboot
```

## 7. Fail2ban

Enable SSH brute-force protection:

```sh
systemctl enable --now fail2ban
fail2ban-client status sshd
```

Optional stricter jail:

```sh
cat >/etc/fail2ban/jail.d/sshd.local <<'EOF'
[sshd]
enabled = true
maxretry = 4
findtime = 10m
bantime = 1h
EOF

systemctl restart fail2ban
fail2ban-client status sshd
```

## 8. Reverse Proxy And TLS

Prefer Caddy for low-maintenance TLS:

```sh
apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf https://dl.cloudsmith.io/public/caddy/stable/gpg.key | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt >/etc/apt/sources.list.d/caddy-stable.list
apt update
apt install -y caddy
```

Example `/etc/caddy/Caddyfile`:

```caddyfile
example.com {
	reverse_proxy 127.0.0.1:3000
}
```

Validate and reload:

```sh
caddy validate --config /etc/caddy/Caddyfile
systemctl reload caddy
```

Production rule:

- Only the reverse proxy should listen publicly on `80/tcp` and `443/tcp`.
- Application runtimes should listen on `127.0.0.1`, not `0.0.0.0`.
- Do not open app ports such as `3000`, `8000`, `8080`, database ports, Redis, admin panels, or metrics ports in `ufw`.
- Add the app domain to the reverse proxy only after DNS points to the server.
- Validate the reverse proxy config before reloading.

For each app, verify the local-only backend before exposing it:

```sh
ss -tulpn
curl -I http://127.0.0.1:<app-port>
```

Then verify the public path:

```sh
curl -I https://example.com
journalctl -u caddy -n 100 --no-pager
```

If the app accidentally listens on `0.0.0.0:<app-port>`, fix the app bind address before deploying publicly.

## 9. Application User And Systemd

Run apps as a dedicated unprivileged user:

```sh
adduser --system --group --home /srv/<app-name> <app-user>
mkdir -p /srv/<app-name>/releases /srv/<app-name>/shared
chown -R <app-user>:<app-user> /srv/<app-name>
```

Example service:

```ini
[Unit]
Description=<app-name>
After=network.target

[Service]
User=<app-user>
Group=<app-user>
WorkingDirectory=/srv/<app-name>/current
EnvironmentFile=/srv/<app-name>/shared/.env
ExecStart=<start-command>
Restart=always
RestartSec=5
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=full
ProtectHome=true

[Install]
WantedBy=multi-user.target
```

Enable the service:

```sh
systemctl daemon-reload
systemctl enable --now <app-name>
systemctl status <app-name>
```

Service ownership rule:

- Do not run production apps as `root`.
- Do not run long-lived app services as the human admin user.
- Use one Linux user per app when possible, for example `<app-user>`.
- Keep deployable code under `/srv/<app-name>/releases/`.
- Keep mutable runtime state under `/srv/<app-name>/shared/`.
- Keep secrets in `/srv/<app-name>/shared/.env` with mode `600`.
- Restart apps through `systemd`, not ad hoc background shell jobs.

Recommended layout:

```text
/srv/<app-name>/
  current -> /srv/<app-name>/releases/<timestamp>
  releases/
    <timestamp>/
  shared/
    .env
    uploads/
```

Manual deploy shape:

```sh
cd /srv/<app-name>
git clone <repo-url> releases/<timestamp>
cd releases/<timestamp>
# install dependencies
# build application
ln -sfn /srv/<app-name>/releases/<timestamp> /srv/<app-name>/current
systemctl restart <app-name>
systemctl status <app-name>
journalctl -u <app-name> -n 100 --no-pager
```

Before using this for real production data, create and test backup/restore for `/srv/<app-name>/shared/` and any database backing the app.

## 10. Secrets

Store runtime secrets outside Git:

```sh
touch /srv/<app-name>/shared/.env
chown <app-user>:<app-user> /srv/<app-name>/shared/.env
chmod 600 /srv/<app-name>/shared/.env
```

Never commit:

- Private SSH keys.
- API keys.
- Database URLs.
- Session/JWT secrets.
- OAuth client secrets.
- Real production `.env` files.

## 11. Manual Deployment Pattern

Use timestamped releases and an atomic `current` symlink:

```sh
cd /srv/<app-name>
git clone <repo-url> releases/<timestamp>
cd releases/<timestamp>
# install dependencies
# build application
ln -sfn /srv/<app-name>/releases/<timestamp> /srv/<app-name>/current
systemctl restart <app-name>
systemctl status <app-name>
journalctl -u <app-name> -n 100 --no-pager
```

Before deploying:

```sh
ufw status verbose
systemctl --failed
df -h
free -h
```

After deploying:

```sh
curl -I http://127.0.0.1:<app-port>
curl -I https://example.com
journalctl -u <app-name> -n 100 --no-pager
```

## 12. Backups

Back up these items off-server:

- Application env files.
- Uploaded files.
- Database dumps.
- Reverse proxy config.
- Systemd service files.
- Deployment scripts.

For databases, prefer logical dumps over raw filesystem copies. Test restore before relying on the backup plan.

## 13. Monitoring And Audit Commands

Useful checks:

```sh
journalctl -u <app-name> -f
journalctl -u caddy -f
fail2ban-client status sshd
last -a
lastb -a
ss -tulpn
df -h
free -h
systemctl --failed
journalctl -p warning -n 200 --no-pager
```

Check for unexpected SSH keys:

```sh
find /root /home -maxdepth 3 -path '*/.ssh/authorized_keys' -print -exec sed -n '1,120p' {} \;
```

## 14. DNS And Apt Troubleshooting

If apt fails with `Temporary failure resolving '<host>'`, gather evidence first:

```sh
ip route
ls -l /etc/resolv.conf
cat /etc/resolv.conf
resolvectl status || true
getent hosts archive.ubuntu.com || true
ping -c 1 1.1.1.1 || true
ping -c 1 archive.ubuntu.com || true
```

Interpretation:

- IP ping works but hostname lookup fails: DNS resolver problem.
- IP ping fails too: routing, provider, firewall, or broader network problem.
- Only one mirror fails: mirror or mirror-routing issue.

Temporary DNS repair for systemd-resolved:

```sh
mkdir -p /etc/systemd/resolved.conf.d
cat >/etc/systemd/resolved.conf.d/dns.conf <<'EOF'
[Resolve]
DNS=1.1.1.1 8.8.8.8
FallbackDNS=9.9.9.9
EOF

systemctl restart systemd-resolved
resolvectl flush-caches || true
getent hosts archive.ubuntu.com
apt update
```

Use the provider's documented resolver if available. Public resolvers are a pragmatic fallback, not a substitute for understanding provider networking.

## 15. Location Verification

Do not rely on provider order forms alone. Verify location signals from the server and from outside:

```sh
curl -4 ifconfig.me
curl -s https://ipinfo.io/json
curl -s https://ipapi.co/json
timedatectl
```

IP geolocation databases can be wrong. The strongest practical evidence is a combination of provider region, public IP geolocation, network latency from nearby regions, and traceroute path.

## 16. Minimum Safe State

Before treating the server as production-ready:

- Key-based SSH works for a non-root admin user.
- Password SSH is disabled.
- Root password SSH is disabled.
- `ufw` allows only `22/tcp`, `80/tcp`, and `443/tcp`.
- Application services run as non-root users.
- App ports bind to `127.0.0.1`.
- TLS terminates at a reverse proxy.
- Secrets live outside Git with restrictive permissions.
- Security updates are enabled.
- Backups exist off-server and restore has been tested.
- `ss -tulpn` shows no unexpected public listeners.
