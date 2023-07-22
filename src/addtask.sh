#!#!/bin/bash
# script to add a task to the notion database under a specific tag

# get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# source config and secrets
source $SCRIPT_DIR/../etc/config.sh
source $SCRIPT_DIR/../etc/secrets.sh

# check whether task name was provided
if [ -z "$1" ]; then
    echo "Please enter a task name"
    exit 1
fi

# check whether tag was provided
TAGPROPERTY=''
if [ ! -z "$2" ]; then
    TAGPROPERTY=', "Tags": { "multi_select": [ { "name": "'"$2"'" } ] }'
fi

# create a new task
curl -s 'https://api.notion.com/v1/pages' \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  --data '{
    "parent": { "database_id": "'"$NOTION_DB_ID"'" },
    "properties": {
      "Name": {
        "title": [
          {
            "text": {
              "content": "'"$1"'"
            }
          }
        ]
      }'"$TAGPROPERTY"'
    }
  }' > /dev/null

# check whether api could be reached
if [ $? -ne 0 ]; then
    echo "Error: could not reach notion api"
    exit 1
fi

# different output depending on whether tag was provided
if [ ! -z "$2" ]; then
    echo 'added task "'$1'" to tag "'$2'"'
    exit 0
fi
echo 'added task "'$1'"'