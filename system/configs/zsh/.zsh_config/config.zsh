# ZSH Options
setopt promptsubst
unsetopt autocd # don't change directory automatically
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt incAppendHistoryTime

zstyle :compinstall filename $HOME/.zshrc
autoload -U colors && colors
autoload -Uz compinit
    # Only regenerate .zcompdump once a day for faster startup
    if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
        compinit
    else
        compinit -C
    fi
autoload -U bashcompinit && bashcompinit

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

autoload -U promptinit
promptinit

disable -r time