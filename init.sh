#! /bin/sh
# Initial Git Config
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
git config --global user.email "45176384+aabishkaryal@users.noreply.github.com"
git config --global user.name "Aabishkar Aryal"
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"

setopt AUTO_CD

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Enable key repeat and hold
defaults write -g ApplePressAndHoldEnabled -bool false;

# Setup basic home folders
mkdir "$HOME/.go/"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/tmux"

# Link config files
ln -s "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -s "$(pwd)/.zshenv" "$HOME/.zshenv"
ln -s "$(pwd)/nvim" "$HOME/.config/nvim"
ln -s "$(pwd)/tmux" "$HOME/.config/tmux"
ln -s "$(pwd)/.ssh/config" "$HOME/.ssh/config"
