export EDITOR='nvim'
export PLATFORM="mac"

# node only uses 4GB RAM max
export NODE_OPTIONS="--max-old-space-size=4096"
export NVM_DIR="$HOME/.nvm"

# Dotfiles directory
export DOT="$HOME/repos/dot"

# Disable Autoupdate with homebrew
HOMEBREW_NO_AUTO_UPDATE=1

# prevent annoying go folder in home directory, this way it's hidden
export GOPATH=~/.go

export GIT_EDITOR=nvim

export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/:$ANDROID_HOME/tools/bin/"

# Opt-out of dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Use git cli for cargo
export CARGO_NET_GIT_FETCH_WITH_CLI=true
export CHROME_EXECUTABLE="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

export PATH="$PATH:$HOME/telmio"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.scripts
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/env:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$PATH:$HOME/.scripts"
#export PATH="$PATH:/Users/aabi/.dotnet/tools"

export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"

export CPPFLAGS="-I/opt/homebrew/opt/libffi/include -I/opt/homebrew/opt/openjdk/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"

#export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

export TERM=xterm-256color
. "$HOME/.cargo/env"
