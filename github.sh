#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2017 wystan
##
##       filename: github.sh
##    description:
##        created: 2017-01-04 22:56:12
##         author: wystan
##
###########################################################################

pub_key="$HOME/.ssh/id_rsa.pub"
pri_key="$HOME/.ssh/id_rsa"

function check_key() {
    if [ -f $pub_key ]; then
        return
    fi

    comm="${USER}@"`hostname`

    ssh-keygen -t rsa -C $comm -f $pri_key -q -N ""
}


## add public key to github account
function add_key() {
    ## make sure the key exist
    check_key

    ## modify it to your own username and pwd
    user="oswystan"
    pwd=""

    key=`cat $pub_key`

    data="{
        \"key\": \"$key\"
    }"

    curl -X POST -d "$data" -H "User-Agent: Chrome" https://$user:$pwd@api.github.com/user/keys
}

add_key

###########################################################################

