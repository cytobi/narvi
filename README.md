# narvi
a notion cli written in bash, tailored to my needs specifically

## Setup
- create a notion integration
- copy the api key
- create etc/secrets.sh
- add `#!/bin/bash` to secrets.sh
- add `NOTION_API_KEY="<your_api_key>"` to secrets.sh
- [get the database id](https://developers.notion.com/reference/retrieve-a-database) of the database you want to use
- add `NOTION_DB_ID="<your_database_id>"` to secrets.sh
