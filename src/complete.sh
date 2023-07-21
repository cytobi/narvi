#!#!/bin/bash
# script to complete a task in the notion database, may not find task if it is not in the first 100 results or was recently added

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

# get last edited task with that name which is not completed (assumes that there are no more than 100 tasks with the same name)
PAGE_ID=`curl -s -X POST 'https://api.notion.com/v1/search' \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H 'Content-Type: application/json' \
  -H 'Notion-Version: 2022-06-28' \
  --data '{
    "query": "'"$1"'",
    "filter": {
        "value": "page",
        "property": "object"
    },
    "sort":{
      "direction":"descending",
      "timestamp":"last_edited_time"
    },
    "page_size": 100
  }' | jq '.results[] | select(.properties.Status.status.name != "done") | .id'`

# remove quotes from page id
PAGE_ID=`echo $PAGE_ID | tr -d '"'`

# check whether task was found
if [ -z "$PAGE_ID" ]; then
    echo 'No task with name "'$1'" found'
    exit 1
fi

# complete the task by updating status
curl -s https://api.notion.com/v1/pages/$PAGE_ID \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  -X PATCH \
	--data '{
  "properties": {
    "Status": {
        "status": {
            "name": "done"
        }
    }
  }
}' > /dev/null

echo 'completed task "'$1'"'