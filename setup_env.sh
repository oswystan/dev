#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2018 wystan
##
##       filename: setup_env.sh
##    description:
##        created: 2018-03-10 10:44:21
##         author: wystan
##
###########################################################################

## setup vim env
setup_vim()
{
    rm -f ~/.vimrc
    rm -rf ~/.vim
    ln -s $PWD/vimrc ~/.vimrc
    ln -s $PWD/vim ~/.vim
}

## setup bashrc env
setup_bashrc()
{
    rc_file="$PWD/bashrc.sh"
    is_exist=`grep bashrc.sh ~/.bashrc | wc -l`
    if [ $is_exist -le 0 ]; then
        cat >>~/.bashrc <<!EOF

##############################################################
if [ -f $rc_file ]; then
    source $rc_file
fi
##############################################################

!EOF
    fi
}

## setup git
setup_git()
{
    cp gitconfig ~/.gitconfig
    git_ver=`git --version|cut -d' ' -f3`
    git config --global user.name oswystan
    git config --global user.email oswystan@126.com
    [[ $ver > '1.7.10' ]] && git config --global push.default simple

    rm -f ~/.git-completion.sh
    ln -s $PWD/git/git-completion.sh ~/.git-completion.sh
    sudo rm -f /usr/local/bin/git-release /usr/local/bin/git-unrelease /usr/local/bin/git-changelog
    sudo ln -s $PWD/git/git-release.sh /usr/local/bin/git-release
    sudo ln -s $PWD/git/git-unrelease.sh /usr/local/bin/git-unrelease
    sudo ln -s $PWD/git/git-changelog.sh /usr/local/bin/git-changelog
}

## setup tmux configuration
setup_tmux()
{
    rm -f ~/.tmux.conf && ln -s $PWD/tmux.conf ~/.tmux.conf
}

## setup clang-format
setup_clang()
{
    rm -f ~/.clang-format && ln -s $PWD/clang-format ~/.clang-format
}

## main
main() {
    setup_bashrc
    setup_vim
    setup_git
    setup_tmux
    setup_clang
}

###########################################################################
main $@
