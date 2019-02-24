#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2018 wystan
##
##       filename: github_backup.sh
##    description:
##        created: 2018-07-02 23:34:41
##         author: wystan
##
###########################################################################

get_all_repos() {
    curl -s -X GET "https://api.github.com/users/oswystan/repos?per_page=200"|jq -r '.[].name'
}

clone_repo() {
    echo "===> $1"
    git clone --mirror https://github.com/oswystan/$1 repo/$1.git
    [[ $? -ne 0 ]] && exit 1
}

clone_all() {
    repos=$(get_all_repos);
    for one in ${repos}
    do
        clone_repo $one
    done
}

check_tool() {
    jq=$(which jq)
    [[ -z ${jq} ]] && echo "NO jq found" && exit 1;
}

###########################################################################
check_tool
clone_all

