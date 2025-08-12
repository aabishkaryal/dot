# Development Environment Setup

## Quick Setup

Run the following command to setup your machine:

```bash
curl -o- https://raw.githubusercontent.com/aabishkaryal/dot/main/init.sh | zsh
```

## Tools Needed

The setup script will install most tools automatically, but ensure you have:

- **macOS** (tested on macOS 10.15+)
- **curl** (for downloading installers)
- **git** (for cloning repositories)
- **Internet connection** (for downloading dependencies)

The script automatically installs:
- Homebrew (macOS package manager)
- Node.js via NVM (versions 18 and 20)
- Tmux Plugin Manager
- Oh My Zsh and plugins (via existing dotfile configs)

## Post-Setup Configuration

After running the setup script, configure your local environment variables:

1. **Edit the local environment file**:
   ```bash
   # The setup script creates ~/.zshenv.local from template
   nano ~/.zshenv.local
   ```

2. **Add your API keys, tokens, and secrets**:
   ```bash
   # In ~/.zshenv.local, replace placeholders with your actual values:
   export GITHUB_PERSONAL_ACCESS_TOKEN="your_actual_token_here"
   export OTHER_API_KEY="your_api_key_here"
   export SECRET_VALUE="your_secret_here"
   ```

3. **Reload your shell configuration**:
   ```bash
   source ~/.zshenv
   # or restart your terminal
   ```

**Note**: The `.zshenv.local` file is not tracked in git, so your secrets remain secure.

## Security

This dotfiles repository uses a secure token management system:

- **Template files**: `.zshenv.local.template` contains placeholders for sensitive data
- **Local files**: `.zshenv.local` is created locally and not tracked in git
- **Environment variables**: All tools (MCP, etc.) use environment variables instead of hardcoded tokens

## What's Included

- **Shell configuration**: zsh with Oh My Zsh and plugins
- **Editor**: Neovim with LSP, plugins, and custom configuration  
- **Terminal**: Kitty terminal with custom themes
- **Multiplexer**: Tmux with plugin manager and custom configuration
- **Development tools**: Node.js, Go, Java, Android SDK paths
- **Claude Code**: MCP servers and AI development tools
- **Scripts**: Custom utility scripts for development workflows

## Manual Setup (Alternative)

If you prefer manual setup:

1. Clone the repository:
   ```bash
   git clone https://github.com/aabishkaryal/dot.git ~/repos/dot
   cd ~/repos/dot
   ```

2. Run the setup script:
   ```bash
   ./init.sh
   ```

3. Follow the post-setup configuration steps above.
