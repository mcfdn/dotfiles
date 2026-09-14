HISTSIZE=150000
SAVEHIST=100000
HISTFILE="$XDG_STATE_HOME/zsh/history"

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # discard the oldest duplicate first when trimming history
setopt hist_ignore_dups       # ignore a command identical to the previous history event
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# match .dotfiles automatically
setopt globdots

# initialise zsh completions
[[ -d $XDG_STATE_HOME/zsh ]] || mkdir -p -- "$XDG_STATE_HOME/zsh"
[[ -d $XDG_CACHE_HOME/zsh ]] || mkdir -p -- "$XDG_CACHE_HOME/zsh"
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

typeset -U path PATH
path+=(/usr/local/go/bin "$HOME/go/bin" "$HOME/.cargo/bin")

export NVM_DIR="$HOME/.config/nvm"

# load nvm only when it is explicitly used
nvm() {
    unfunction nvm
    [[ -s "$NVM_DIR/nvm.sh" ]] || return 1
    source "$NVM_DIR/nvm.sh"
    nvm "$@"
}

export EDITOR="nvim"
export VISUAL="nvim"

[[ -n $TTY ]] && export GPG_TTY=$TTY

# load fzf keybindings (ctrl+r, ctrl+t, alt+c)
[[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh

bindkey -e

# ctrl+j for down, ctrl+k for up
bindkey '^J' down-line-or-search
bindkey '^K' up-line-or-search

# tab completion highlighting
zstyle ':completion:*' menu select

# press shift+tab to reverse the current completion selection
bindkey '^[[Z' reverse-menu-complete

# partial tab completions
# stolen from https://github.com/ohmyzsh/ohmyzsh/blob/5ea2c68be88452b33b35ba8004fc9094618bcd87/lib/completion.zsh
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

alias ls="ls --color=auto"
alias grep="grep --colour=auto"
alias history="history 0"

alias lg="lazygit"
alias vim="nvim"

# display the current git branch, if any
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%F{green}%b%f '

precmd() {
    # the previous exit code needs to be obtained before we do anything else,
    # otherwise the wrong code may be displayed
    local prev_exit_code=$?

    # set prompt dir. more info in `man zshmisc` under `%~`
    local prompt_dir="%F{blue}%~%f "

    # display background jobs if any are running. more info in `man zshmisc`
    # under `%j`
    local prompt_bg_jobs="%(1j.%F{cyan}&%j%f .)"

    # display the prompt character.
    local prompt_char="%F{242}$%f "

    vcs_info

    # display the exit code of the previous command if it was not 0
    local prompt_exit_code
    if (( prev_exit_code != 0 )); then
        prompt_exit_code="%F{167}!${prev_exit_code}%f "
    fi

    PROMPT="
${prompt_dir}${vcs_info_msg_0_}${prompt_exit_code}${prompt_bg_jobs}
${prompt_char}"
}
