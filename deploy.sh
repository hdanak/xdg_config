#!/bin/sh

CWD=`pwd`

for dir in `ls -d */`
do
    if [ -e $dir/deploy ]
    then
        . $dir/deploy
    fi
done
