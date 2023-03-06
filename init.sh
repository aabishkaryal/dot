#! /bin/sh
# Initial Git Config
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

setopt AUTO_CD

# Enable key repeat and hold
defaults write -g ApplePressAndHoldEnabled -bool false;
