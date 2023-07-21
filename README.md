# narvi
a notion cli written in bash, tailored to my needs specifically

## Setup
- create a notion integration
- take note of the api key
- [get the database id](https://developers.notion.com/reference/retrieve-a-database) of the database you want to use
- navigate to the narvi directory (where this README is)
- run `bash setup.sh`
- enter the api key when prompted
- enter the database id when prompted
- allow narvi to access this database by opening the meatballs menu (the three dots) in the upper right corner and clicking "Add connections" and then "narvi"
- run `bash src/getdb.sh` to get the database and test if everything works
