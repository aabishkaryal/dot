#!/bin/sh
# Dotfiles setup script with error handling
# Compatible with bash, zsh, and POSIX sh

set -e  # Exit immediately if any command exits with a non-zero status

# Detect shell for compatibility
if [ -n "${ZSH_VERSION:-}" ]; then
    SHELL_TYPE="zsh"
    set -o pipefail 2>/dev/null || true  # zsh supports pipefail
elif [ -n "${BASH_VERSION:-}" ]; then
    SHELL_TYPE="bash"  
    set -u          # bash supports -u
    set -o pipefail # bash supports pipefail
else
    SHELL_TYPE="sh"
    # POSIX sh - limited options available
fi

echo "🚀 Starting dotfiles setup..."

# Initial Git Config
echo "📝 Configuring Git..."
git config --global init.defaultBranch main || { echo "❌ Failed to set default branch"; exit 1; }
git config --global push.autoSetupRemote true || { echo "❌ Failed to set auto setup remote"; exit 1; }
git config --global user.email "45176384+aabishkaryal@users.noreply.github.com" || { echo "❌ Failed to set email"; exit 1; }
git config --global user.name "Aabishkar Aryal" || { echo "❌ Failed to set name"; exit 1; }

# Install Homebrew
echo "🍺 Installing Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "❌ Failed to install Homebrew"; exit 1; }
    # Add Homebrew to PATH for Apple Silicon Macs
    if [ "$(uname -m)" = "arm64" ]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

# Install NVM and Node.js
echo "📦 Installing Node.js via NVM..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash || { echo "❌ Failed to install NVM"; exit 1; }
fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v nvm >/dev/null 2>&1; then
    nvm install 20 || { echo "❌ Failed to install Node.js 20"; exit 1; }
    nvm install 22 || { echo "❌ Failed to install Node.js 22"; exit 1; }
    nvm alias default 22 || { echo "❌ Failed to set default Node.js version"; exit 1; }
else
    echo "❌ NVM installation failed"; exit 1
fi

# Install Tmux package manager
echo "🖥️  Installing Tmux Plugin Manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || { echo "❌ Failed to install Tmux Plugin Manager"; exit 1; }
else
    echo "✅ Tmux Plugin Manager already installed"
fi

# macOS settings
echo "⚙️  Configuring macOS settings..."
defaults write -g ApplePressAndHoldEnabled -bool false || { echo "❌ Failed to disable press and hold"; exit 1; }

# Setup basic home folders
echo "📁 Creating directory structure..."
mkdir -p "$HOME/.go/" || { echo "❌ Failed to create Go directory"; exit 1; }
mkdir -p "$HOME/.config/nvim" || { echo "❌ Failed to create nvim config directory"; exit 1; }
mkdir -p "$HOME/.config/tmux" || { echo "❌ Failed to create tmux config directory"; exit 1; }
mkdir -p "$HOME/repos/aabishkaryal" || { echo "❌ Failed to create repos directory"; exit 1; }

# Get the absolute path to the dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "🔗 Linking config files from $DOTFILES_DIR..."

# Function to create symlink with error handling
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "⚠️  $target already exists, skipping..."
        return 0
    fi
    
    if [ ! -e "$source" ]; then
        echo "⚠️  Source $source doesn't exist, skipping..."
        return 0
    fi
    
    ln -s "$source" "$target" || { echo "❌ Failed to link $source to $target"; return 1; }
    echo "✅ Linked $target"
}

# Create symlinks for config files
create_symlink "$DOTFILES_DIR/functions" "$HOME/.functions"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/kitty" "$HOME/.config/kitty"
create_symlink "$DOTFILES_DIR/tmux" "$HOME/.config/tmux"
create_symlink "$DOTFILES_DIR/.ssh/config" "$HOME/.ssh/config"
create_symlink "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
create_symlink "$DOTFILES_DIR/scripts" "$HOME/.scripts"
create_symlink "$DOTFILES_DIR/.claude" "$HOME/.claude"

# Setup local environment file
echo "🔧 Setting up local environment file..."
if [ ! -f ~/.zshenv.local ]; then
    if [ -f "$DOTFILES_DIR/.zshenv.local.template" ]; then
        cp "$DOTFILES_DIR/.zshenv.local.template" ~/.zshenv.local || { echo "❌ Failed to copy environment template"; exit 1; }
        echo "⚠️  Update local env variables in ~/.zshenv.local"
    else
        echo "❌ Template file .zshenv.local.template not found"; exit 1
    fi
else
    echo "✅ Local environment file already exists"
fi

# Final Git configuration
echo "🔑 Configuring Git SSH..."
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/" || { echo "❌ Failed to set Git SSH URL"; exit 1; }

# Check if Brewfile exists and ask user about installation
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo ""
    echo "📦 Install development tools and applications?"
    echo "This will install packages from Brewfile (brew, casks, mas, vscode extensions)"
    printf "Install now? (y/N): "
    read -r install_brew

    if [ "$install_brew" = "y" ] || [ "$install_brew" = "Y" ]; then
        echo "📥 Installing packages from Brewfile..."
        cd "$DOTFILES_DIR" || { echo "❌ Failed to change to dotfiles directory"; exit 1; }
        brew bundle install || { echo "❌ Failed to install from Brewfile"; exit 1; }
        echo "✅ Brewfile installation completed"
    else
        echo "⏭️  Skipped Brewfile installation"
        echo "💡 You can install later by running: cd $DOTFILES_DIR && brew bundle install"
    fi
fi

echo ""
echo "🎉 Dotfiles setup completed successfully!"
echo ""
echo "📝 Next steps:"
echo "1. Edit ~/.zshenv.local to add your API keys and tokens"
echo "2. Restart your terminal or run 'source ~/.zshenv'"
if [ -f "$DOTFILES_DIR/Brewfile" ] && [ "$install_brew" != "y" ] && [ "$install_brew" != "Y" ]; then
    echo "3. Optionally install tools: cd ~/repos/dot && brew bundle install"
fi
echo ""
