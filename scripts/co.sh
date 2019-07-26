#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2019 wystan
##
##       filename: a.sh
##    description:
##        created: 2019-07-26 10:19:27
##         author: wystan
##
###########################################################################

fn="/tmp/_fifo"
[ -e $fn ] || mkfifo $fn
exec 3<> $fn
rm -f $fn

for (( i = 0; i < 10; i++ )); do
    echo >&3
done

for (( i = 0; i < 100; i++ )); do
    read -u3
    {
        sleep 0.5
        echo "$i"
        echo >&3
    }&
done

wait
exec 3<&-
exec 3>&-
echo ">done."

###########################################################################
