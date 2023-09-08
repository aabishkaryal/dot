#! /bin/sh
# Initial Git Config
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true
git config --global user.email "aabishkar.aryal@purplease.com"
git config --global user.name "Aabishkar Aryal"
git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"


setopt AUTO_CD
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Enable key repeat and hold
defaults write -g ApplePressAndHoldEnabled -bool false;

mkdir "$HOME/.go/"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/tmux"

ln -s "$(pwd)/.zshrc" "$HOME/.zshrc"
ln -s "$(pwd)/.zshenv" "$HOME/.zshenv"
ln -s "$(pwd)/nvim " "$HOME/.config/nvim"
ln -s "$(pwd)/.tmux " "$HOME/.config/tmux"
