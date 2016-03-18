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

git_config()
{
    items=$1
    shift
    if [ ${items::5} = "alias" ];then
        git config --global --unset-all $items
    fi
    git config --global $items "$@"
}

setup_gitconfig()
{
    git_config status.showUntrackedFiles no
    git_config user.name "$ZM_AUTHOR"
    git_config user.email "$ZM_MAIL"
    git_config color.ui auto
    git_config credential.helper store

    git_config alias.co 'checkout'
    git_config alias.br 'branch'
    git_config alias.ci 'commit'
    git_config alias.st 'status'
    git_config alias.stu 'status -unormal'
    git_config alias.df 'diff'
    git_config alias.dfn 'diff --name-only'
    git_config alias.up 'pull --recurse-submodules=yes'
    git_config alias.dir 'rev-parse --show-toplevel'
    git_config alias.unstage 'reset HEAD --'
    git_config alias.last 'log -1 HEAD'
    git_config alias.l "log --color --graph --decorate --pretty=oneline --abbrev-commit"
    git_config alias.lg "log --graph --abbrev-commit --date=relative --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%C(yellow)%an%Creset%Cgreen %cr)%Creset '"
}

setup_fonts()
{
    case ${OSTYPE} in
        linux*)
            ;;
        darwin*)
            ;;
        cygwin)
            mkdir ~/.fonts
            ln -s $SYSTEMROOT/Fonts/msyh.ttf ~/.fonts/
            ;;
        *)
            ;;
    esac
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
setup_fonts
