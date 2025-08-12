export PLATFORM="mac"

# git things
export EDITOR='nvim'
export GIT_EDITOR=nvim

# node only uses 4GB RAM max
export NODE_OPTIONS="--max-old-space-size=4096"
export NVM_DIR="$HOME/.nvm"

# Dotfiles directory
export DOT="$HOME/repos/dot"

# gem things
export GEM_HOME="$HOME/.gems"
export PATH="$GEM_HOME/bin:$PATH"

# go things
# prevent annoying go folder in home directory, this way it's hidden
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# java things
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Android things
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/tools/bin/"
export CHROME_EXECUTABLE="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
export CHROME_BIN="$CHROME_EXECUTABLE"

# Flutter things
export PATH=$HOME/.flutter/bin:$PATH

# Opt-out of dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Use git cli for cargo
export CARGO_NET_GIT_FETCH_WITH_CLI=true

# personal scripts
export PATH="$PATH:$HOME/.scripts"

# localstack
export PATH="$PATH:$HOME/.local/bin"

# homebrew things
# Disable Autoupdate with homebrew
export HOMEBREW_NO_AUTO_UPDATE=1
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"

export CPPFLAGS="-I/opt/homebrew/opt/libffi/include -I/opt/homebrew/opt/openjdk/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

export ZSH_TMUX_ITERM2=true
export ZSH_TMUX_FIXTERM=true
export ZSH_TMUX_AUTONAME_SESSION=true

# flutter pub binaries
export PATH="$PATH":"$HOME/.pub-cache/bin"



# Load local environment variables (not tracked in git)
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
