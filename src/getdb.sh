#!/bin/bash

# small script to retrieve the database from notion to test the API

# source config and secrets
source ../etc/config.sh
source ../etc/secrets.sh

# retrieve the database
ENDPOINT="https://api.notion.com/v1/databases/${NOTION_DB_ID}"
curl $ENDPOINT \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H 'Notion-Version: 2022-06-28'
