# Platform detection
case "$(uname -s)" in
  Darwin) export PLATFORM="mac" ;;
  Linux)  export PLATFORM="linux" ;;
  *)      export PLATFORM="unknown" ;;
esac

# Editor
export EDITOR='nvim'
export GIT_EDITOR=nvim

# Node
export NODE_OPTIONS="--max-old-space-size=4096"
export NVM_DIR="$HOME/.nvm"

# Dotfiles directory
export DOT="$HOME/repos/dot"

# Gem
export GEM_HOME="$HOME/.gems"
export PATH="$GEM_HOME/bin:$PATH"

# Go (common — platform files add binary path)
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# Cargo
export CARGO_NET_GIT_FETCH_WITH_CLI=true

# Personal scripts + local bin
export PATH="$PATH:$HOME/.scripts"
export PATH="$PATH:$HOME/.local/bin"

# Telemetry opt-out
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Truecolor
export COLORTERM=truecolor

# Shared tmux setting (autoname works everywhere)
export ZSH_TMUX_AUTONAME_SESSION=true

# Source platform-specific env
[[ -f "$HOME/.zshenv.$PLATFORM" ]] && source "$HOME/.zshenv.$PLATFORM"

# Source local secrets/overrides (not tracked in git)
[[ -f "$HOME/.zshenv.local" ]] && source "$HOME/.zshenv.local"

# Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
