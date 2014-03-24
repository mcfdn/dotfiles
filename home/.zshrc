# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"

source ~/.exports
source ~/.aliases

plugins=(git)

# Larger zsh history
SAVEHIST=10000
HISTSIZE=10000

setopt APPEND_HISTORY

# Share between multiple shells
setopt SHARE_HISTORY

# Ignore sequential duplicates
setopt HIST_IGNORE_DUPS

# Command time and duration
setopt EXTENDED_HISTORY

source $ZSH/oh-my-zsh.sh
