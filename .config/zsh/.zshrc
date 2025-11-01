# -- History ---------------------------------------------------------------------------------------

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.cache/zsh/history

# -- Options ---------------------------------------------------------------------------------------

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# Match .dotfiles automatically
setopt globdots

# Initialise zsh completions
autoload -Uz compinit && compinit

# -- Exports ---------------------------------------------------------------------------------------

export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:$HOME/.cargo/bin

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export TERM="xterm-256color"
export TERMINAL="alacritty"
export EDITOR="nvim"
export VISUAL="nvim"
export GPG_TTY=$(tty)

# -- Plugins ---------------------------------------------------------------------------------------

# zsh-autosuggestions has broken a bit in zsh 5.9, and doesn't mute the text
# correctly.
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/zsh-users/zsh-autosuggestions/tree/master#suggestion-highlight-style
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#626262"

# Load fzf keybindings (Ctrl+R, Ctrl+T, Alt+C)
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[[ -f /usr/share/doc/fzf/examples/completion.zsh ]] && source /usr/share/doc/fzf/examples/completion.zsh

# -- Keybinds --------------------------------------------------------------------------------------

bindkey -e

# Use fzf to search history
bindkey '^R' fzf-history-widget

# Ctrl+J for down, Ctrl+K for up
bindkey '^J' down-line-or-search
bindkey '^K' up-line-or-search

# Tab completion highlighting
zstyle ':completion:*' menu select

# Press Shift+Tab to reverse the current completion selection
bindkey '^[[Z' reverse-menu-complete

# Partial tab completions
# Stolen from https://github.com/ohmyzsh/ohmyzsh/blob/5ea2c68be88452b33b35ba8004fc9094618bcd87/lib/completion.zsh
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# -- Aliases ---------------------------------------------------------------------------------------

alias ls="ls --color=auto"
alias la="ls -la"
alias grep="grep --colour=auto"
alias history="history 0"

alias g="git"
alias lg="lazygit"
alias vim="nvim"

# -- Prompt ----------------------------------------------------------------------------------------

# Note: `man zshmisc` is helpful here.

function preexec() {
    # Start a timer before each command is executed.
    # This is used in prompt_timer().
    typeset -g __CMD_TIMER=$(date +%s%3N)

    # Store the delta time that the last command took to execute in a global
    # variable so it persists across prompt renders (even if no command is
    # executed).
    typeset -g __CMD_DELTA=0
}

# This function is called before each command prompt is displayed. It's only
# being used to build the prompt in this case.
function precmd() {
    # The previous exit code needs to be obtained before we do anything else,
    # otherwise the wrong code may be displayed.
    local prev_exit_code=$?

    # Set prompt dir. More info in `man zshmisc` under `%~`.
    local prompt_dir="%F{blue}%~%f "

    # Display background jobs if any are running. More info in `man zshmisc`
    # under `%j`.
    local prompt_bg_jobs="%(1j.%F{cyan}&%j%f .)"

    # Display the prompt character.
    local prompt_char="%F{242}$%f "

    # Display the current git branch if we're in a git repository.
    local prompt_git_branch
    if command git rev-parse --is-inside-work-tree &>/dev/null; then
        # Get the current git branch name, falling back to commit hash if HEAD
        # is detached.
        local ref=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

        # Append an asterisk (*) if there are uncommitted changes.
        local dirty=""
        if [[ -n $ref ]]; then
            if ! git diff --quiet --ignore-submodules --cached || ! git diff --quiet --ignore-submodules; then
                dirty="%F{yellow}*%f"
            fi
        fi

        # Append a caret (^) if the local branch is ahead of the upstream
        # branch.
        # First, check if the upstream branch exists.
        local ahead=""
        if git rev-parse --abbrev-ref --symbolic-full-name @{u} &>/dev/null; then
            # Count the number of commits ahead of the upstream.
            local commits_ahead=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null | awk '{print $1}')
            if (( commits_ahead > 0 )); then
                ahead="%F{yellow}^${commits_ahead}%f"
            fi
        fi

        prompt_git_branch="%F{green}${ref}${dirty}${ahead}%f "
    fi

    # Display the exit code of the previous command if it was not 0.
    local prompt_exit_code
    if (( prev_exit_code != 0 )); then
        prompt_exit_code="%F{167}!${prev_exit_code}%f "
    fi

    # Display the time taken for the last command to execute.
    if [[ -n $__CMD_TIMER && -n $__CMD_DELTA ]]; then
        local now=$(date +%s%3N)
        __CMD_DELTA=$(($now-$__CMD_TIMER))
        unset __CMD_TIMER

        prompt_timer="%F{cyan}${__CMD_DELTA}ms%f"
    fi

    # Configure the main prompt (left).
    export PROMPT="
${prompt_dir}${prompt_git_branch}${prompt_exit_code}${prompt_bg_jobs}
${prompt_char}"

    # Configure the right prompt.
    export RPROMPT="${prompt_timer}"
}
