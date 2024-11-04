# Environment variables that can be changed at runtime with `source ~/.zshrc`


# Default prompt
PS1=%K{black}%F{cyan}%n@%m:%F{magenta}%~/\ \>

# Executable $PATH variable
typeset -U path
path=(~/bin ~/.local/bin ~/neovim/bin $path[@])

# Set width of man pages to 80 columns.
export MANWIDTH=${MANWIDTH:-80}

EDITOR="nvim"
VISUAL="nvim"
GIT_EDITOR="nvim"
SUDO_EDITOR="vim"
BROWSER='firefox'
