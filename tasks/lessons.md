# Lessons

- Interactive commands inside file-list loops must read from `/dev/tty`, otherwise they can consume the loop input and fail when prompting.
- Dotfile-managed script installs should preserve the repo's symlink model; do not copy scripts into `~/.scripts`.
- When `~/.scripts` is already symlinked to the repo `scripts/` directory, do not create per-script symlinks inside it.
- When a general redesign discussion becomes a concrete one-off request, separate the immediate command from the smallest requested script maintenance.
