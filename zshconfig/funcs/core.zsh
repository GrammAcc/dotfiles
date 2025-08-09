neovimupdate () {
    currdir=$PWD
    cd ~/build/neovim/
    git checkout master
    git fetch
    git checkout stable
    make distclean
    mv ~/neovim ~/neovim$(date +%s).bak
    make CMAKE_BUILD_TYPE=$1 CMAKE_INSTALL_PREFIX=~/neovim install
    cd $currdir
}

