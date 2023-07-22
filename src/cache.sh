#!/bin/bash
# script to cache narvi output for faster retrieval
# run this periodically with cron: e.g. */5 * * * * narvi cache getdb
# and retrieve with narvi cache

# get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# source config and secrets
source $SCRIPT_DIR/../etc/config.sh
source $SCRIPT_DIR/../etc/secrets.sh

# check whether command was provided
if [ -z "$1" ]; then
    cat $SCRIPT_DIR/../cache/narvi.cache
    exit 0
fi

# check whether api can be reached
curl -s https://api.notion.com/v1/databases/$NOTION_DB_ID > /dev/null
if [ $? -ne 0 ]; then
    echo "Error: could not reach notion api"
    exit 1
fi

# call narvi piping into cache file (only when api is reachable)
bash $SCRIPT_DIR/narvi.sh "$@" > $SCRIPT_DIR/../cache/narvi.cache
echo 'cached output for command "'"$1"'"'