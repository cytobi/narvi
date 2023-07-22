#!/bin/bash
# script to get tasks from the notion database

# get script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# source config and secrets
source $SCRIPT_DIR/../etc/config.sh
source $SCRIPT_DIR/../etc/secrets.sh

# define filters
FILTERS='{
    "and": [
        {
            "property": "Tags",
            "multi_select": {
                "is_empty": true
            }
        },
        {
            "property": "Status",
            "status": {
                "equals": "Important"
            }
        }
    ]
}'

# define sorts
SORTS='[
    {
        "property": "created",
        "direction": "descending"
    }
]'

# retrieve the database
ENDPOINT="https://api.notion.com/v1/databases/${NOTION_DB_ID}/query"
JSON=`curl -s $ENDPOINT \
    -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
    -H 'Notion-Version: 2022-06-28' \
    -H "Content-Type: application/json" \
    --data '{
        "filter": '"$FILTERS"',
        "sorts": '"$SORTS"'
    }'`

# check for errors
ERROR=`echo $JSON | jq '.object' | tr -d '"'`
if [ $ERROR == "error" ]; then
    echo "Error: $JSON"
    exit 1
fi

echo $JSON | jq '.results[].properties.Name.title[].text.content' | tr -d '"' | sed 's/^/• /'
