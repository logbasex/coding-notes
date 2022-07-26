#! /bin/bash -v

RESET="\033[0m"
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
MAGENTA="\033[38;5;13m"
GREEN="\033[38;5;12m"
CYAN="\033[38;5;14m"

read -p "$(echo -e $BOLD$CYAN"Choose your action (Press 1 for backup db, 2 for restore db, 3 for both, 4 for backup and restore single document, 0 for exit)?"$RESET)"$'\n> ' option
echo

if [[ $option == "0" ]]; then
	exit 1
fi

if [[ $option == "1" || $option == "3" ]]; then
	read -p "$(echo -e $BOLD$YELLOW"Which is database you wanna backup (Press 1 for eko_test, 2 for eko_staging, 3 for custom URI):"$RESET)"$'\n> ' mongo_server
	echo

	read -p "$(echo -e $BOLD$MAGENTA"Which is database colllections to exclude (Split collection by comma, leave empty to ignore)?"$RESET)"$'\n> ' exclude_collections
	echo

	read -p "$(echo -e $BOLD$CYAN"Please enter your backup folder (Which is default stored in /tmp/mongodb-backups):"$RESET)"$'\n> ' folder
	echo
fi

if [[ $option == "4" ]]; then
  read -p "$(echo -e $BOLD$MAGENTA"Which is database you wanna backup (Press 1 for eko_test, 2 for eko_staging, 3 for custom URI):"$RESET)"$'\n> ' mongo_server
	echo

	read -p "$(echo -e $BOLD$GREEN"Which is database colllections to include (Split collection by comma, leave empty to ignore)?"$RESET)"$'\n> ' include_collections
	echo

	read -p "$(echo -e $BOLD$MAGENTA"Which is database you wanna restore (localhost)?"$RESET)"$'\n> ' local_database
	echo
fi

if [[ $mongo_server == "1" ]]; then
	mongo_server="mongodb://192.168.5.21:27017/eko_test"
elif [[ $mongo_server == "2" ]]; then
	mongo_server="mongodb+srv://ffclique-staging:aYKjVVddPLKUmYCK@clique-staging.c5mix.mongodb.net/eko_staging"
fi

BACKUP_COLLECTION_PARALLELISM=4
DEFAULT_BACKUP_PARENT_DIR="/tmp/mongodb-backups/"

# using default backup folder
mkdir -p "$DEFAULT_BACKUP_PARENT_DIR"
# Variables in the Bourne shell do not have to be declared, as they do in languages like C.
# But if you try to read an undeclared variable, the result is the empty string. You get no warnings or errors.
# https://www.shellscript.sh/variables1.html
if [ -z "${folder}" ]; then
	folder=$DEFAULT_BACKUP_PARENT_DIR
fi

# eko_test__2022-02-02
BACKUP_FOLDER_NAME=$(echo $mongo_server | cut -d "/" -f4 | cut -c -20)"__""$(date +%Y-%m-%d)"
# eko_test__2022-02-02/
BACKUP_FOLDER_NAME_TRAILING_SLASH=$BACKUP_FOLDER_NAME"/"
# eko_test__2022-02-02.gz
BACKUP_FILE_NAME=$BACKUP_FOLDER_NAME".gz"
# eko_test
BACKUP_DB_NAME=$(echo $mongo_server | cut -d "/" -f4)
EXIST_DUMP_FILE_ABSOLUTE_PATH="$DEFAULT_BACKUP_PARENT_DIR$BACKUP_FOLDER_NAME_TRAILING_SLASH$BACKUP_FILE_NAME"

clean_up() {
	if [ -f "$EXIST_DUMP_FILE_ABSOLUTE_PATH" ]; then
		read -p "The file $BACKUP_FILE_NAME is already existed. Do you want to overwrite it (y/n)?" CONT
		if [ "$CONT" = "y" ]; then
			rm "$BACKUP_FILE_NAME"
		else
			echo "Bye"
			exit 1
		fi
	fi
}

get_excluded_collections() {
	local collection_list=($(echo $exclude_collections | tr "," "\n"))
	local collections=""

	for word in "${collection_list[@]}"; do
		collection="--excludeCollection=""$word"" "
		collections+=$collection
	done

	echo "$collections"
}

# https://stackoverflow.com/questions/10582763/how-to-return-an-array-in-bash-without-using-globals
get_included_collections() {
	local -n arr=$1 # use nameref for indirection
	arr=($(echo $include_collections | tr "," "\n"))
}

backup_db() {
	echo "##################################"
	echo "Backup will start at '$(date)' for database: '$mongo_server'"
	echo "##################################"

	local excluded_collections=$(get_excluded_collections)

	local included_collections
	get_included_collections included_collections

	# https://serverfault.com/questions/477503/check-if-array-is-empty-in-bash
	# if have excluded collections
	if [[ ! -z "$excluded_collections" ]]; then
		mkdir -p $folder$BACKUP_FOLDER_NAME_TRAILING_SLASH
		sudo docker exec $MONGODB_CONTAINER_ID /bin/bash -c "exec mongodump --uri=$mongo_server --db=$BACKUP_DB_NAME --numParallelCollections=$BACKUP_COLLECTION_PARALLELISM --archive=$BACKUP_FILE_NAME $excluded_collections"
	fi

	last_status=$(echo $?)

	if [ "$last_status" == 0 ] && [[ ! -z "$excluded_collections" ]]; then
		sudo docker cp $MONGODB_CONTAINER_ID:/$BACKUP_FILE_NAME $folder$BACKUP_FOLDER_NAME_TRAILING_SLASH

		echo "##################################"
		echo "Backup completed at '$(date)' and stored in file '$folder$BACKUP_FOLDER_NAME_TRAILING_SLASH$BACKUP_FILE_NAME'"
		echo "##################################"
	else
		echo "Errors were occurred while dumping your DB."
	fi
}

backup_and_restore_single_document() {
	local included_collections
	get_included_collections included_collections

	# https://serverfault.com/questions/477503/check-if-array-is-empty-in-bash
	# if no excluded collections
	if ((${#included_collections[@]})); then
		mkdir -p $folder$BACKUP_FOLDER_NAME_TRAILING_SLASH
		for collection in "${included_collections[@]}"; do
			sudo docker exec -it $MONGODB_CONTAINER_ID /bin/bash -c "exec mongoexport --uri=$mongo_server --forceTableScan --db $BACKUP_DB_NAME --collection $collection --out $collection.json"
			sudo docker cp $MONGODB_CONTAINER_ID:"/""$collection"".json" $folder$BACKUP_FOLDER_NAME_TRAILING_SLASH
			sudo docker exec -it $MONGODB_CONTAINER_ID /bin/bash -c "exec mongoimport --uri=mongodb://localhost:27017/$local_database --collection $collection --drop --file=$collection.json"
		done
	fi
}

restore_db() {
	if [[ $1 == "2" ]]; then
		read -r -p "$(echo -e $BOLD$YELLOW"Please enter BACKUP_FILE's absolute path:""$RESET")"$'\n> ' backup_file_path

		# Double quote to prevent globbing and word splitting
		read -r -p "$(echo -e $BOLD$YELLOW"Please enter BACKUP_DB_NAME (Ex: eko_test):""$RESET")"$'\n> ' dump_db_name
		echo
	fi

	read -r -p "$(echo -e $BOLD$YELLOW"Which is database name to restore dump backup? (Default: eko_dev):""$RESET")"$'\n> ' restore_db_name
	echo

	if [[ $1 == "3" ]]; then
		dump_db_name=$BACKUP_DB_NAME
	fi

	local SOURCE_DB_NAME="$dump_db_name"".*"
	local TARGET_DB_NAME="$restore_db_name"".*"
	echo "##################################"
	echo "Restore will start at '$(date)' for database: '$SOURCE_DB_NAME'"
	echo "##################################"

	if [[ $1 == "3" ]]; then
		backup_file_path=$DEFAULT_BACKUP_PARENT_DIR/$BACKUP_FILE_NAME
	fi

	docker exec -i "$MONGODB_CONTAINER_ID" /bin/bash -c "mongorestore --archive --drop --nsFrom=$SOURCE_DB_NAME --nsTo=$TARGET_DB_NAME" <"$backup_file_path"
	echo "##################################"
	echo "Restore completed at '$(date)' to $TARGET_DB_NAME"
	echo "##################################"
}

# run
if [ -x "$(command -v docker)" ]; then
	MONGODB_CONTAINER_ID=$(sudo -S docker ps -q --filter ancestor=mongo -f status=running)

	if [[ "${MONGODB_CONTAINER_ID}" ]]; then
		clean_up

		if [[ $option == "1" ]]; then
			backup_db
		elif [[ $option == "2" ]]; then
			restore_db 2
		elif [[ $option == "3" ]]; then
			backup_db
			restore_db 3
		elif [[ $option == "4" ]]; then
			backup_and_restore_single_document
		fi
	else
		echo "MongoDB's container isn't running. Please check!"
	fi
else
	echo "Docker isn't installed yet. Please check!"
fi