neovim_build_dir=~/build/neovim
neovim_install_dir=~/neovim

rebuildneovim () {
    currdir=$PWD
    cd $neovim_build_dir
    git checkout stable
    make distclean
    mv $neovim_install_dir $neovim_install_dir$(date +%s).bak
    make CMAKE_BUILD_TYPE=$1 CMAKE_INSTALL_PREFIX=$neovim_install_dir install
    cd $currdir
}

updateneovim () {
    currdir=$PWD
    cd $neovim_build_dir
    git checkout master
    git fetch --tags --force
    git checkout stable
    make distclean
    mv $neovim_install_dir $neovim_install_dir$(date +%s).bak
    make CMAKE_BUILD_TYPE=$1 CMAKE_INSTALL_PREFIX=$neovim_install_dir install
    cd $currdir
}

comparechecksums () {
    cat $1 | grep $2 > tmp1.txt && shasum -a$3 $2 > tmp2.txt && diff tmp1.txt tmp2.txt
}
