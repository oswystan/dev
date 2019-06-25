#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2019 wystan
##
##       filename: user.sh
##    description:
##        created: 2019-06-25 23:23:08
##         author: wystan
##
###########################################################################


function user.add() {
    if [[ $# -ne 1 ]]; then
        echo "usage: $FUNCNAME <username>"
        return 1
    fi

    useradd -m -s /bin/bash -d /home/$1 $1 && \
    echo -e "$1@123\n$1@123" | passwd $1
}

function user.del() {
    if [[ $# -ne 1 ]]; then
        echo "usage: $FUNCNAME <username>"
        return 1
    fi
    userdel -r -f $1
}

function user.ls() {
    less /etc/passwd
}

###########################################################################
