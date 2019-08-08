#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2019 wystan
##
##       filename: sak.sh
##    description:
##        created: 2019-07-10 06:53:35
##         author: wystan
##
###########################################################################

.foreach() {
    declare -a local _servers=("${!1}")
    local one
    for one in "${_servers[@]}"
    do
        echo "==> $one"
        ssh -p 4344 $one "$2"
    done
}
.ls() {
    declare -a local _servers=("${!1}")
    local one
    for one in "${_servers[@]}"
    do
        echo "$one"
    done
}
.autossh() {
    declare -a local _servers=("${!1}")
    local one
    for one in "${_servers[@]}"
    do
        echo $"==> $one"
        ssh-copy-id -p 4344 $one
    done
}
.copy() {
    declare -a local _servers=("${!1}")
    local one
    for one in "${_servers[@]}"
    do
        echo $"==> $one"
        scp -P 4344 $2 $one:~/
    done
}

###########################################################################
