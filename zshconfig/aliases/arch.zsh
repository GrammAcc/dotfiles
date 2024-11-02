# General utils

alias ls="ls -a --color=auto"

# Pacman

alias pS="sudo pacman -S"
alias pSyu="sudo pacman -Syu"
alias pSyyu="sudo pacman -Syyu"
alias pSyyuu="sudo pacman -Syyuu"
alias pSyy="sudo pacman -Syy"
alias pR="sudo pacman -Rs"
alias pRns="sudo pacman -Rns"
alias pRsc="sudo pacman -Rsc"
alias pRdd="sudo pacman -Rdd"
alias pSc="sudo pacman -Sc"

# List true orphan packages
alias pQdt="sudo pacman -Qdt"

# List true orphan packages without version strings
alias pQqdt="sudo pacman -Qqdt"

# List true and optional orphan packages
alias pQdtt="sudo pacman -Qdtt"

# List true and optional orphan packages without version strings
alias pQqdtt="sudo pacman -Qqdtt"

# Remove true orphans
alias pRorphans="sudo pacman -Qtdq | sudo pacman -Rns -"

# Remove true and optional orphans
alias pRallorphans="sudo pacman -Qqdtt | sudo pacman -Rns -"

# List installed packages
alias pkglistexport="sudo pacman -Qq > ~/pkglist.txt"
alias expkglistexport="sudo pacman -Qqe > ~/explicitpkglist.txt"
alias chkpkglist="sudo pacman -Qq | less"
alias chkexpkglist="sudo pacman -Qqe | less"

# Foreign packages
alias chkfpkglist="sudo pacman -Qqm"
alias chkexfpkglist="sudo pacman -Qqme"
alias exfpkglistexport="sudo pacman -Qqme > ~/explicitforeignpkglist.txt"
alias chkpaccash="sudo ls /var/cache/pacman/pkg | less"

# Back up the mirrorlist before using reflector to generate a new mirrorlist of the 10 most recently synchronised mirrors sorted by speed
alias updatemirrors="sudo cp -av /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && sudo reflector --verbose --country 'United States' --latest 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"


# System entropy

alias chkent="cat /proc/sys/kernel/random/entropy_avail"


# Powercycle

alias reboot="sudo systemctl reboot"
alias shutdown="sudo systemctl poweroff"


# Dynamic power management

alias powsaveoff="xset s off -dpms"
alias pow9000="xset dpms 0 0 9000"
alias pow3600="xset dpms 0 0 3600"


# System volume

alias vo10="amixer -q sset Master 10%"
alias vo15="amixer -q sset Master 15%"
alias vo20="amixer -q sset Master 20%"
alias vo25="amixer -q sset Master 25%"
alias vo30="amixer -q sset Master 30%"
alias vo35="amixer -q sset Master 35%"
alias vo40="amixer -q sset Master 40%"
alias vo45="amixer -q sset Master 45%"
alias vo50="amixer -q sset Master 50%"
alias vo55="amixer -q sset Master 55%"
alias vo60="amixer -q sset Master 60%"
alias vo65="amixer -q sset Master 65%"
alias vo70="amixer -q sset Master 70%"
alias vo75="amixer -q sset Master 75%"
alias vo80="amixer -q sset Master 80%"
alias vo85="amixer -q sset Master 85%"
alias vo90="amixer -q sset Master 90%"
alias vo95="amixer -q sset Master 95%"
alias vo100="amixer -q sset Master 100%"
alias vomu="amixer -q sset Master toggle"


# Kernel modules

alias modlistexport="lsmod > ~/kmodlist.txt"
alias chkmodlist="lsmod | less"


# X session

alias x="startx"


# xbindkeys

alias rexkeys="pkill -x xbindkeys && xbindkeys"

alias rexkeys-blender="pkill -x xbindkeys && xbindkeys -f $HOME/.xbindkeysrc-blender"


# Fluxbox menu

alias mkfluxmenu="mmaker -f FluxBox"

# File editing

alias vimx="vim ~/.xinitrc"
alias vimz="vim ~/.zshrc"
alias vimenv="vim ~/.zshenv"
alias vimbash="vim ~/.bashrc"
alias vimxkeys="vim ~/.xbindkeysrc"


# Containers

alias podup="podman-compose up --build --force-recreate --remove-orphans --no-cache --detach"
