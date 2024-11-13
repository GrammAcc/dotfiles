# Environment variables that can be changed at runtime with `source ~/.zshrc`


# Default prompt
export PS1=%K{black}%F{cyan}%n@%m:%F{magenta}%~/\ \>

# Executable $PATH variable
typeset -U path
path=(~/bin ~/.local/bin ~/neovim/bin $path[@])

# Set width of man pages to 80 columns.
export MANWIDTH=${MANWIDTH:-80}

export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"
export SUDO_EDITOR="vim"
export BROWSER="firefox"
