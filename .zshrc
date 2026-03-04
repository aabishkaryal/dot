#! /bin/zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

COMPLETION_WAITING_DOTS="true"
DISABLE_LS_COLORS="true"

HIST_STAMPS="%T %d.%m.%y"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|pwd|cd)*"

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Common plugins (platform files add more)
plugins=(safe-paste z tmux)

source $ZSH/oh-my-zsh.sh

# Common aliases
alias reload="exec zsh"
alias vim="nvim"
alias vi="nvim"
alias oldvim="\vim"
alias oldvi="\vi"
alias lg="lazygit"
alias ldo="lazydocker"
alias docker-compose='docker compose'

source $HOME/.functions

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# FZF
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Source platform-specific config
[[ -f "$HOME/.zshrc.$PLATFORM" ]] && source "$HOME/.zshrc.$PLATFORM"

# Local overrides (not tracked in git)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
