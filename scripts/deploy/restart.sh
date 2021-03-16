#!/bin/bash

function restart_xpapers {
    sudo supervisorctl restart xpapers
}

function restart_celery {
    sudo supervisorctl restart celery-xpapers
}

read -r -p 'restart xpapers [y/n] ' is_restart_xpapers

if [ "$is_restart_xpapers" == "y" ]
then
    restart_xpapers
fi

read -r -p 'restart xpapers-celery [y/n] ' is_restart_xpapers_celery

if [ "$is_restart_xpapers_celery" == "y" ]
then
    restart_celery
fi
