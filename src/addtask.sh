#!#!/bin/bash
# small script to retrieve the database from notion to test the API

# get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# source config and secrets
source $SCRIPT_DIR/../etc/config.sh
source $SCRIPT_DIR/../etc/secrets.sh

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
      }
    }
  }' > /dev/null

echo 'added task "'$1'"'