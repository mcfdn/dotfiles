# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Exports
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.cargo/bin

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export EDITOR="nvim"
export VISUAL="nvim"

# Much history
HISTSIZE=50000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# Match .dotfiles automatically
setopt globdots

# Theme
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
# https://github.com/zsh-users/zsh-autosuggestions/tree/master#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#626262"

# Keybinds
bindkey -e

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

## Keybinds - zsh-history-substring-search
bindkey '^K' history-substring-search-up
bindkey '^J' history-substring-search-down

# Tab completion/highlighting
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist
zstyle ':completion:*' menu select
# Shift+Tab reverses selection
bindkey '^[[Z' reverse-menu-complete

# Partial tab completions, stolen from https://github.com/ohmyzsh/ohmyzsh/blob/5ea2c68be88452b33b35ba8004fc9094618bcd87/lib/completion.zsh
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# Aliases
alias vim="nvim"
alias history="history 0"
alias lg="lazygit"

## Aliases - Git
alias g="git"
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gp="git pull"
alias gP="git push"
alias gco="git checkout"
alias gl="git log"
alias grsh="git reset --soft HEAD~"

alias la="ls -la"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
