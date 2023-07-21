#!/bin/bash
# small script to retrieve the database from notion to test the API

# get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# source config and secrets
source $SCRIPT_DIR/../etc/config.sh
source $SCRIPT_DIR/../etc/secrets.sh

# retrieve the database
ENDPOINT="https://api.notion.com/v1/databases/${NOTION_DB_ID}"
curl $ENDPOINT \
    -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
    -H 'Notion-Version: 2022-06-28' \
    | jq '.'
