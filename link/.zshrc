## Exports
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="avit"
export DOTFILES=~/.dotfiles
export EDITOR="vim"
export SAVEHIST=10000
export HISTSIZE=10000
export GOPATH=/workspace/go
export PATH=$DOTFILES/bin/::/usr/local/mysql/bin/:/usr/local/go/bin:$GOPATH/bin:$PATH

plugins=(git)

## Options
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

source $ZSH/oh-my-zsh.sh
