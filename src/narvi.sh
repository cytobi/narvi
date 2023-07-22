#!/bin/bash
# script to manage all narvi scripts

# get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# source config and secrets
source $SCRIPT_DIR/../etc/config.sh
source $SCRIPT_DIR/../etc/secrets.sh

# check whether command was provided
if [ -z "$1" ]; then
    echo "Please enter a command"
    exit 1
fi

# check which command was provided and execute it
if [ "$1" == "getdb" ]; then
    bash $SCRIPT_DIR/getdb.sh
elif [ "$1" == "get" ]; then
    bash $SCRIPT_DIR/getimportant.sh "$2"
elif [ "$1" == "add" ]; then
    bash $SCRIPT_DIR/addtask.sh "$2" "$3"
elif [ "$1" == "complete" ]; then
    bash $SCRIPT_DIR/complete.sh "$2"
elif [ "$1" == "cache" ]; then
    bash $SCRIPT_DIR/cache.sh "${@:2}"
else
    echo "Command not found"
    exit 1
fi