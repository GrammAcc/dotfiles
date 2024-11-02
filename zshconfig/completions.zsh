autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

# Fuzzy completion.
zstyle ':completion:*' completer _expand_alias _complete _correct _approximate




