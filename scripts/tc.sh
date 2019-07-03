#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2019 wystan
##
##       filename: tc.sh
##    description:
##        created: 2019-07-03 12:21:02
##         author: wystan
##
###########################################################################

declare -a local tc_servers=(
    "root@1.1.1.1"
)

tc.foreach() {
    declare -a local _servers=("${!1}")
    local one
    for one in "${_servers[@]}"
    do
        echo "==> $one"
        ssh -p 4344 $one "$2"
    done
}
tc.ls() {
    declare -a local _servers=("${!1}")
    local one
    for one in "${_servers[@]}"
    do
        echo "$one"
    done
}
tc.autossh() {
    declare -a local _servers=("${!1}")
    local one
    for one in "${_servers[@]}"
    do
        echo $"==> $one"
        ssh-copy-id -p 4344 $one
    done
}

###################################
## app
###################################
tc.app.foreach() {
    tc.foreach tc_servers[@] "$*"
}
tc.app.ls() {
    tc.ls tc_servers[@]
}
tc.app.autossh() {
    tc.autossh tc_servers[@]
}

###########################################################################
