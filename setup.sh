#!/bin/bash
# install dependencies and setup the environment
# this script is meant to be run from the root of the project

# check whether in root of project
if [ ! -f "setup.sh" ]; then
    echo "Please run this script from the root of the project"
    exit 1
fi

# install dependencies
# check whether jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found, installing..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install jq -y
fi

# create environment files
touch etc/secrets.sh
echo "#!/bin/bash" > etc/secrets.sh
echo "Please enter your Notion API key:"
read -s NOTION_API_KEY
echo "NOTION_API_KEY=\"$NOTION_API_KEY\"" >> etc/secrets.sh
echo "Please enter your Notion database ID:"
read NOTION_DB_ID
echo "NOTION_DB_ID=\"$NOTION_DB_ID\"" >> etc/secrets.sh

echo "NARVI_PATH=\"$(pwd)\"" >> etc/secrets.sh

echo "alias narvi=\"bash "$(pwd)"/src/narvi.sh\"" >> ~/.bashrc

source ~/.bashrc

echo "Setup complete!"
