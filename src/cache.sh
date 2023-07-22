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

# call narvi piping into cache file
bash $SCRIPT_DIR/narvi.sh "$@" > $SCRIPT_DIR/../cache/narvi.cache
echo 'cached output for command "'"$1"'"'