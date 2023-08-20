# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Much history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt HIST_SAVE_NO_DUPS

# Match .dotfiles automatically
setopt globdots

# Theme
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# https://github.com/zsh-users/zsh-autosuggestions/tree/master#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#626262"

# Keybinds
## Keybinds - zsh-history-substring-search
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# Tab completion/highlighting
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit
zmodload -i zsh/complist
zstyle ':completion:*' menu select
# Shift+Tab reverses selection
bindkey '^[[Z' reverse-menu-complete

# Aliases
alias vim="nvim"
alias arkenfox="bash /home/james/.mozilla/firefox/e92kyuj3.default-release"

## Aliases - Git
alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gp="git push"
alias gl="git log"
alias grsh="git reset --soft HEAD~"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

