#! /bin/bash -v

DEFAULT_BACKUP_PARENT_DIR="/tmp/mongodb-backups/"
BACKUP_COLLECTION_PARALLELISM=4

RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
MAGENTA="\033[38;5;13m"
GREEN="\033[38;5;12m"
CYAN="\033[38;5;14m"

mkdir -p "$DEFAULT_BACKUP_PARENT_DIR"

read -p "$(echo -e $BOLD$CYAN"Do you want to backup and restore mongodb (Press 1 for backup, 2 for restore, 3 for both, 0 for exit)?"$RESET)"$'\n> ' option
echo

if [[ $option == "0" ]]; then
    exit 1;
fi

read -p "$(echo -e $BOLD$YELLOW"Which is database you wanna backup (Press 1 for eko_test, 2 for eko_staging, 3 for custom URI):"$RESET)"$'\n> ' mongo_server
echo

if [[ $mongo_server == "1" ]]; then
    mongo_server="mongodb://192.168.5.21:27017"
elif [[ $mongo_server == "2" ]]; then
    mongo_server="mongodb+srv://ffclique-staging:aYKjVVddPLKUmYCK@clique-staging.c5mix.mongodb.net/eko_staging"
fi

read -p "$(echo -e $BOLD$YELLOW"Which is database colllections to exclude (Split collection by comma)?"$RESET)"$'\n> ' exclude_collections
echo

BACKUP_FILE_NAME=$(echo $mongo_server| cut -d "/" -f3 | cut -c -20)"__""$(date +%Y-%m-%d)"".gz"

read -p "$(echo -e $BOLD$CYAN"Please enter your backup folder (Which is default stored in /tmp/mongodb-backups):"$RESET)"$'\n> ' folder
echo

split_on_commas() {
    local WORD_LIST=($(echo $exclude_collections | tr "," "\n"))
    local collections=""

    for word in "${WORD_LIST[@]}";do
        collection="--excludeCollection=""$word"" "
        collections+=$collection
    done

    echo "$collections"
}


backup() {
    echo "##################################"
    echo "Backup will start at '`date`' for database: '$mongo_server'"
    echo "##################################"

    local excluded_collections=$(split_on_commas)
    sudo docker exec $MONGODB_CONTAINER_ID /bin/bash -c "exec mongodump --uri=$mongo_server --numParallelCollections=$BACKUP_COLLECTION_PARALLELISM --archive=$BACKUP_FILE_NAME $excluded_collections"

    LAST_STATUS=$(echo $?)

    if [ $LAST_STATUS == 0 ]; then

        if [[ "${folder}" ]]; then
            sudo docker cp $MONGODB_CONTAINER_ID:/$BACKUP_FILE_NAME $folder
        else
            folder=$DEFAULT_BACKUP_PARENT_DIR
            sudo docker cp $MONGODB_CONTAINER_ID:/$BACKUP_FILE_NAME $DEFAULT_BACKUP_PARENT_DIR
        fi

        echo "##################################"
        echo "Backup completed at '`date`' and located in $folder'"
        echo "##################################"
    else
        echo "Errors were occurred while dumping your DB."
    fi
}


restore() {
    if [[ $0 == "2" ]]; then
        read -p "$(echo -e $BOLD$YELLOW"Please enter BACKUP_FILE's absolute path:"$RESET)"$'\n' backup_file_path
        echo
    fi

    read -p "$(echo -e $BOLD$YELLOW"Please enter BACKUP_DB_NAME (Default: eko_test):"$RESET)"$'\n>' backup_db_name
    echo

    read -p "$(echo -e $BOLD$YELLOW"Please enter RESTORE_DB_NAME (Default: eko_dev):"$RESET)"$'\n>' restore_db_name
    echo

    SOURCE_DB_NAME=$backup_db_name".*"
    TARGET_DB_NAME=$restore_db_name".*"
    echo "##################################"
    echo "Restore will start at '`date`' for database: '$SOURCE_DB_NAME'"
    echo "##################################"

    sudo docker exec -i $MONGODB_CONTAINER_ID /bin/bash -c 'mongorestore --archive --drop --nsFrom="$SOURCE_DB_NAME" --nsTo="$TARGET_DB_NAME"' < $DEFAULT_BACKUP_PARENT_DIR/$BACKUP_FILE_NAME

    echo "##################################"
    echo "Restore completed at '`date`' to '$TARGET_DB_NAME"
    echo "##################################"
}


if [ -x "$(command -v docker)" ]; then
    MONGODB_CONTAINER_ID=$(sudo -S docker ps -q  --filter ancestor=mongo -f status=running)
    echo $MONGODB_CONTAINER_ID

    if [[ "${MONGODB_CONTAINER_ID}" ]]; then

        if [[ $option == "1" ]]; then
            backup
        elif [[ $option == "2" ]]; then
            restore
        elif [[ $option == "3" ]]; then
            backup
            restore
        fi
    else
        echo "MongoDB's container isn't running. Please check!"
    fi
else
    echo "Docker isn't installed yet. Please check!"
fi