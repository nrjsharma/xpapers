#!/bin/bash

db_user_name="postgres"
db_name="xpapers_prod_db"

pg_dump -U $db_user_name -d $db_name > /home/ubuntu/scp/xpapers/`date +%Y-%m-%d`-xpapers.sql