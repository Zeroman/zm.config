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

    mkdir -p $(dirname $dst)
    test -e $dst && mv $dst ${dst}.old
    cp -afv $src $dst
}

install_all()
{
    author="$1"
    mail="$2"

    cp_and_backup_file .vimrc $HOME/.vimrc
    cp_and_backup_file .bashrc $HOME/.bashrc
    cp_and_backup_file bin/gen_tags $HOME/bin/gen_tags
    chmod +x $HOME/bin/gen_tags

    if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ];then
        git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    fi
    vim "+BundleInstall" "+quitall"

    sed -i "s#ZM_AUTHOR=.*#ZM_AUTHOR='$author'#g" $HOME/.bashrc
    sed -i "s#ZM_MAIL=.*#ZM_MAIL='$mail'#g" $HOME/.bashrc
    source $HOME/.bashrc
}

setup_gitconfig()
{
    git config --global status.showUntrackedFiles no
    git config --global user.name "$ZM_AUTHOR"
    git config --global user.email "$ZM_MAIL"
    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
    git config --global alias.stu status -unormal
    git config --global alias.df diff
    git config --global alias.dfn diff --name-only
    git config --global alias.up pull --recurse-submodules=yes
    git config --global alias.dir rev-parse --show-toplevel
    git config --global alias.unstage 'reset HEAD --'
    git config --global alias.last 'log -1 HEAD'
    git config --global alias.l "log --color --graph --decorate --pretty=oneline --abbrev-commit"
    git config --global alias.log "log --graph --abbrev-commit --date=relative --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%C(yellow)%an%Creset%Cgreen %cr)%Creset '"
}

err()
{
    echo $*
    exit 1
}

test -z "$1" && err "param error, $0 yourname yourmail, lile : $0 andy andy@gmail.com"
test -z "$2" && err "param error, $0 yourname yourmail, lile : $0 andy andy@gmail.com"
install_all $1 $2
setup_gitconfig
