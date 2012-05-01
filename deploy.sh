#!/bin/bash

function source_deploy
{
    if [ -e $1/deploy ]
    then
        . $1/deploy
    fi
}

function deploy_dotfile
{
    ln -si {$CWD/$1/,~/.}$2
}

function deploy_dotdir
{
    if [ -h ~/.$1 ]
    then
        rm ~/.$1
    fi
    ln -si {$CWD/,~/.}$1
}

CWD=`pwd`

if [ $# -eq 1 ]
then
    source_deploy $1
    exit
fi

for dir in `ls -d */`
do
    source_deploy $dir
done
