#!/bin/bash - 

# Zeroman Yang (51feel@gmail.com)
# 11/15/2015


cp_and_backup_file()
{
    local src=$1
    local dst=$2

    test -e "$src" || return
    test -z "$src" && return
    test -z "$dst" && return 

    if [ -e "$dst" ];then
        mv $dst ${dst}.old
        cp -afv $src $dst
    fi
}

cp_and_backup_file .vimrc $HOME/.vimrc
cp_and_backup_file .bashrc $HOME/.bashrc

if [ ! -d "$HOME/.vim/bundle/vundle" ];then
    git clone --depth=1 https://github.com/Zemnmez/Vundle.vim.git $HOME/.vim/bundle/vundle
fi
vim -c "BundleInstall"
