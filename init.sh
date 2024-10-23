#! /bin/sh
# Initial Git Config
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
git config --global user.email "45176384+aabishkaryal@users.noreply.github.com"
git config --global user.name "Aabishkar Aryal"

setopt AUTO_CD

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install 18
nvm install 20
nvm alias default 20

# Install Tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Enable key repeat and hold
defaults write -g ApplePressAndHoldEnabled -bool false;

# Setup basic home folders
mkdir "$HOME/.go/"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/tmux"
mkdir -p "$HOME/repos/aabishkaryal"
mkdir -p "$HOME/.config/yt-dlp"
git clone https://github.com/aabishkaryal/dot.git

# Link config files
ln -s "$(pwd)/.functions" "$HOME/.functions"
ln -s "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -s "$(pwd)/.zshenv" "$HOME/.zshenv"
ln -s "$(pwd)/nvim" "$HOME/.config/"
ln -s "$(pwd)/kitty" "$HOME/.config/"
ln -s "$(pwd)/tmux" "$HOME/.config/"
ln -s "$(pwd)/.ssh/config" "$HOME/.ssh/config"
ln -s "$(pwd)/.p10k.zsh" "$HOME/.p10k.zsh"
ln -s "$(pwd)/scripts" "$HOME/.scripts"
ln -s "$(pwd)/yt-dlp" "$HOME/.config/"

git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"
