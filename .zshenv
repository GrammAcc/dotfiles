# Shell environment variable defaults that cannot be changed at runtime with `zresource` #


#
# format is	VARIABLE [DEFAULT=[value]] [OVERRIDE=[value]]
#
#  example	XDG_CONFIG_HOME DEFAULT=@{HOME}/.config
#
# format can also be simple [VARIABLE=value] pair
#

EDITOR='nvim'
VISUAL='nvim'
SUDO_EDITOR='nvim'
BROWSER='firefox'
GNUPGHOME=/GhostFiles/.gnupg
LC_MESSAGES='en_US.UTF-8'
QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
GTK_THEME=Adwaita:dark

zvarlist=~/ZshConfig/ZVarList
zfunclist=~/ZshConfig/ZFuncList
zaliaslist=~/ZshConfig/ZAliasList

lzvarlist=~/lZshConfig/lZVarList
lzfunclist=~/lZshConfig/lZFuncList
lzaliaslist=~/lZshConfig/lZAliasList

bootconf=/boot/EFI/BOOT/refind.conf
bashrc=~/.bashrc
zshrc=~/.zshrc
zprofile=~/.zprofile
zenv=~/.zshenv

