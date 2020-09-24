#!/bin/bash

function take_dump {

    db_user_name="postgres"
    db_name="xpapers_prod_db"

    echo "taking dump"
    pg_dump -U $db_user_name -d $db_name > /home/ubuntu/scp/xpapers/`date +%Y-%m-%d`-xpapers.sql
}

current_branch=$(git branch | grep \* | cut -d ' ' -f2)

read -r -p 'merge with '$current_branch' [y/n] ' is_merge

if [ "$is_merge" != "y" ]
then
    echo "Abort"
    exit 1
fi

read -r -p 'take db dump [y/n] ' is_dump

if [ "$is_dump" == "y" ]
then
    take_dump
elif [ "$is_dump" != "n" ]
then
    echo "enter a valid input"
    exit 1
fi

echo "merging with "$current_branch
git checkout $current_branch
git stash
git reset --hard HEAD~20
git fetch origin && git merge origin/$current_branch --ff-only

export DJANGO_SETTINGS_MODULE="settings.prod"
source /home/ubuntu/env_ild/bin/activate
cd /home/ubuntu/env_ild/ilovedjango
pip install -r requirements.txt
./manage.py migrate
sudo supervisorctl restart xpapers
sudo supervisorctl restart celery-xpapers


read -r -p 'show log [y/n] ' is_log
if [ "$is_log" == "y" ]
then
    git log
fi