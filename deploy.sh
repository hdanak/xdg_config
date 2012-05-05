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

function deploy_cache
{
    mkdir -p ~/.cache/$1
    touch ~/.cache/$1/$2
    if [ -e "~/.$2" ]
    then
        if [ ! -h "~/.$2" ]
        then
            mv ~/.{,cache/$1/}$2
        else
            warning "~/.$2 is symbolic link"
        fi
    fi
    ln -si ~/.cache/$1/$2 ~/.$2
}

function warning
{
    echo "[33m" "WARNING: " $* "[0m"
}
function error
{
    echo "[31m" "ERROR: " $* "[0m"
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
