# Exports
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.cargo/bin

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export TERM="xterm-256color"
export TERMINAL="alacritty"
export EDITOR="nvim"
export VISUAL="nvim"
export GPG_TTY=$(tty)

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
alias ls="ls --color=auto"
alias vim="nvim"
alias history="history 0"
alias lg="lazygit"
alias y="yazi"

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

# Prompt configiguration. `man zshmisc` is helpful here.
# Allow command substitution in prompt.
setopt PROMPT_SUBST

# Pre-commands. This doesn't strictly belong in the prompt section, but it's
# the only place I'm actually using it.
precmd() {
    # The previous exit code needs to be obtained before we render the prompt,
    # else the wrong code will be used.
    PREV_EXIT_CODE=$?
}

# Display the working directory.
short_dir() {
    echo "%F{66}%~%f "
}

# Display the current git branch, if there is one.
git_branch() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    [[ -n $branch ]] && echo "%F{106}$branch%f "
}

# Display the number of background jobs, if there is at least 1.
bg_jobs() {
    echo '%(1j.%F{208}[%j]%f .)'
}

# Display the exit code of the previous command if it is not 0.
exit_code() {
    (( PREV_EXIT_CODE != 0 )) && echo "%F{167}[$PREV_EXIT_CODE]%f "
}

# Display the current timestamp (%*).
timestamp() {
    echo "%F{242}%*%f"
}

# Configure the prompt character.
prompt_char() {
    echo "%F{242}>%f "
}

# Configure the main prompt (left).
PROMPT='$(short_dir)$(git_branch)
$(prompt_char)'

# Configure the right prompt.
RPROMPT='$(exit_code)$(bg_jobs)$(timestamp)'
