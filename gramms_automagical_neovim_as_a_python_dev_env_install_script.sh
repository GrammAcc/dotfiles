#!/bin/bash

echo "This script will overwrite your neovim config and .editorconfig file with a basic python dev setup."
echo "Backup any changes to your neovim config and top-level .editorconfig before running this script."
read -p "Continue? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]] then
    mkdir ./build
    cd ./build
    git clone https://github.com/neovim/neovim
    cd neovim
    git checkout v0.11.2
    make distclean
    mv ~/neovim ~/neovim$(date +%s).bak
    make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=~/neovim install

    cd ../../

    pipx uninstall python-lsp-server
    pipx install python-lsp-server --preinstall black --preinstall flake8 --preinstall isort --preinstall ruff --preinstall pylsp-mypy --preinstall python-lsp-black --preinstall python-lsp-isort --preinstall python-lsp-ruff

    cp -r .config/nvim ~/.config/
    cp .editorconfig ~/
fi
