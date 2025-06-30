# Much history
HISTSIZE=1000000
SAVEHIST=1000000
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

autoload -Uz compinit && compinit

# Exports
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.cargo/bin

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export TERM="xterm-256color"
export TERMINAL="alacritty"
export EDITOR="nvim"
export VISUAL="nvim"
export GPG_TTY=$(tty)

# Plugins
# zsh-autosuggestions has broken a bit in zsh 5.9, and doesn't mute the text
# correctly.
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/zsh-users/zsh-autosuggestions/tree/master#suggestion-highlight-style
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#626262"

# Load fzf keybindings (Ctrl+R, Ctrl+T, Alt+C)
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
# [[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh

# Keybinds
bindkey -e

# Use fzf to search history
bindkey '^R' fzf-history-widget

# Ctrl+J for down, Ctrl+K for up
bindkey '^K' up-line-or-search
bindkey '^J' down-line-or-search

# Tab completion/highlighting
zstyle ':completion:*' menu select
bindkey '^[[Z' reverse-menu-complete # Shift+Tab reverses selection

# Partial tab completions, stolen from https://github.com/ohmyzsh/ohmyzsh/blob/5ea2c68be88452b33b35ba8004fc9094618bcd87/lib/completion.zsh
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
