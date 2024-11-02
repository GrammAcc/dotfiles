
# Enable globbing (filename generation) for hidden (dot)files.
setopt glob_dots
# Allow extra glob patters such as exclusion '^'.
setopt extended_glob

# Share command history between terminal instances.
HISTFILE=~/.zsh_histfile
HISTSIZE=2000
SAVEHIST=2000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
# Use native syscall for file locking the histfile.
setopt hist_fcntl_lock

# Disable annoying autocorrect suggestions like "change test to tests?"
unsetopt correct

# Print exit codes on commandline.
setopt print_exit_value

# Warn about running background jobs when exiting the shell.
setopt check_jobs

# Set ${0} to the name of the function.
setopt function_argzero

# Make the exit status of a pipeline the rightmost failed command.
setopt pipe_fail


source ~/zshconfig/completions.zsh
source ~/zshconfig/vars/core.zsh
source ~/zshconfig/vars/arch.zsh
source ~/zshconfig/vars/python.zsh
source ~/zshconfig/vars/godot.zsh
source ~/zshconfig/vars/elixir.zsh
source ~/zshconfig/aliases/core.zsh
source ~/zshconfig/aliases/arch.zsh
# source ~/zshconfig/aliases/macos.zsh
source ~/zshconfig/aliases/godot.zsh
source ~/zshconfig/aliases/python.zsh
source ~/zshconfig/funcs/core.zsh
source ~/zshconfig/funcs/arch.zsh
source ~/zshconfig/plugins/arch.zsh

# Host-specific stuff
source ~/lzshconfig/vars.zsh
source ~/lzshconfig/aliases.zsh
source ~/lzshconfig/funcs.zsh
source ~/lzshconfig/plugins.zsh
