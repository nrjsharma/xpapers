#!/bin/bash

source_path="/home/ubuntu/xpapers_env/bin/activate"
project_path="/home/ubuntu/xpapers_env/xpapers"
scp_path="/home/ubuntu/scp/xpapers/`date +%Y-%m-%d`-xpapers.sql"
db_user_name="postgres"
db_name="xpapers_prod_db"

function take_dump {
    echo "taking dump"
    pg_dump -U $db_user_name -d $db_name > $scp_path
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

read -r -p 'stash [y/n], any other key to abort ' is_stash

if [ "$is_stash" == "y" ]
then
    git stash
elif [ "$is_stash" != "n" ]
then
    echo "Abort"
    exit 1
fi

git stash
git reset --hard HEAD~20
git fetch origin && git merge origin/$current_branch --ff-only

read -r -p 'stash apply [y/n]' is_stash_apply

if [ "$is_stash_apply" == "y" ]
then
    git stash apply
fi

export DJANGO_SETTINGS_MODULE="settings.prod"
source $source_path
cd $project_path
pip install -r requirements.txt --no-cache-dir
./manage.py migrate
sudo supervisorctl restart xpapers
sudo supervisorctl restart celery-xpapers


read -r -p 'show log [y/n] ' is_log
if [ "$is_log" == "y" ]
then
    git log
fi