#!/bin/bash
# script to save narvi output to be executed later, also executes saved commands when called without arguments

# get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# source config and secrets
source $SCRIPT_DIR/../etc/config.sh
source $SCRIPT_DIR/../etc/secrets.sh

# check whether command was provided, if not, return saved commands
if [ -z "$1" ]; then
    # check whether saved commands is not empty
    if [ ! -s $SCRIPT_DIR/../cache/saved.sh ]; then
        echo 'no saved commands'
        exit 0
    fi
    cat $SCRIPT_DIR/../cache/saved.sh | sed 's/^/• /'
    # check whether api can be reached, if so execute saved commands
    curl -s https://api.notion.com/v1/databases/$NOTION_DB_ID > /dev/null
    if [ $? -eq 0 ]; then
        bash $SCRIPT_DIR/../cache/saved.sh | sed 's/^/\t /'
        echo '=> executed saved commands'
        > $SCRIPT_DIR/../cache/saved.sh
    else
        echo '=> could not reach notion api, not executing saved commands'
    fi
    exit 0
fi

# append command to saved cache
echo 'bash '"$SCRIPT_DIR"'/narvi.sh '"$@" >> $SCRIPT_DIR/../cache/saved.sh
echo 'saved "'"$@"'" for later execution'