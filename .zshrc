# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

eval "$(/opt/homebrew/bin/brew shellenv)"

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-function:$FPATH

    autoload -Uz compinit
    compinit
fi
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitignore safe-paste alias-finder brew z gh macos yarn zsh-autosuggestions tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
 export ARCHFLAGS="-arch x86_64"

zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

alias x86="arch -x86_64";
alias disablesleep="sudo pmset -a disablesleep";
alias reload="exec zsh";
alias rm="trash";
alias vim="nvim";
alias vi="nvim";
alias oldvim="\vim";
alias oldvi="\vi";
alias lg="lazygit";
alias perf="sudo asitop";
alias tmux="TERM=screen-256color-bce tmux"
alias sed="gsed"

function pomo() {
  if [ -n "$1" ]
  then
    timer $1 && terminal-notifier -title 'Pomodoro' \
      -message 'Pomodoro Timer is up! 😊'\
      -sound Crystal;
  else
    echo "Specify the time for pomo session."
  fi
}

function archive() {
    mv $1 ~/repos/Archives/;
}

function hide() {
    mv $1 "/Users/aabishkar/Library/Mobile Documents/com~apple~CloudDocs/Photos/.secret/"
}

function configure-git() {
  if [[ $1 == "work" ]]; then
    git config user.email "aabishkar.aryal@purplease.com"
    git config user.name "Aabishkar Aryal"
    echo "Git configured for work"
  elif [[ $1 == "personal" ]]; then
    git config user.email "45176384+aabishkaryal@users.noreply.github.com"
    git config user.name "Aabishkar Aryal"
    echo "Git configured for personal"
  elif [[ $1 == "sosvertigo" ]]; then
    git config user.email "aabishkar.aryal@sosvertigo.com"
    git config user.name "Aabishkar Aryal"
    echo "Git configured for sosvertigo"
  else
    echo "Invalid argument. Usage: configure-git work|personal|sosvertigo"
  fi
}

export CONDA_CONFIG_DIR=""
export NVM_CONFIG_DIR=""
function cd() {
	builtin cd "$@" &&
	if [ -f $PWD/.conda_config ]; then
		export CONDA_CONFIG_DIR=$PWD
		conda activate $(cat .conda_config)
	elif [ "$CONDA_CONFIG_DIR" ]; then
		if [[ $PWD != *"$CONDA_CONFIG_DIR"* ]]; then
			export CONDA_CONFIG_DIR=""
			conda deactivate
		fi
	fi 

  if [ -f $PWD/.nvmrc ]; then
    export NVM_CONFIG_DIR=$PWD
    nvm use
  elif [ "$NVM_CONFIG_DIR" ]; then
    if [[ $PWD != *"$NVM_CONFIG_DIR"* ]]; then
      export NVM_CONFIG_DIR=""
      nvm deactivate
    fi
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval $(thefuck --alias)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun completions
[ -s "/Users/aabishkar/.bun/_bun" ] && source "/Users/aabishkar/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# gcloud
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

