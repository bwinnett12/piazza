#!/bin/bash

# Find all folders that contain _Finished or _TODO
# Grab those files contained in the folder
# Copy them to upper most level
# If they are not found in any other _TODO, remove

DIR_CURRENT=$(pwd)
DIRS_TODO=$(find . -type d -name "_TODO")
DIRS_FINISHED=$(find . -type d -name "_FINISHED")
DIRS_TODO_TOP=$(find . -type d -name "__TODO")
DIRS_FINISHED_TOP=$(find . -type d -name "__FINISHED")
FILES_TODO=[]



# For each todo folder, add each folder to an array
for todo in $DIRS_TODO
do
	if [[ "$todo" != "$DIR_CURRENT" ]]
	then	
		# Get a list of all files found in $todo
		# Get a list of all files found in __todo
		# If file is found in $todo and not in __todo -> copy to __todo
		# If file is found in __todo and not in $todo -> copy
		# HOW should files that are removed from __todo can be then removed from $todo?

		# Make a directory for that particular todo
		TODO_FOLDER_NAME="$(basename "$(dirname "$todo")")"
		TODO_FOLDER_PATH="${DIRS_TODO_TOP}/${TODO_FOLDER_NAME}"
		mkdir -p "$TODO_FOLDER_PATH" 
	

		FILES_IN_MAIN_TODO=$(ls -p ${TODO_FOLDER_PATH} | grep -v /)
		FILES_IN_MINOR_TODO=$(ls -p ${todo} | grep -v /)
		 

		cp -a "${todo}/." $TODO_FOLDER_PATH

	fi
done


# For each finished folder
for fini in $DIRS_FINISHED
do
	if [[ "$fini" != "$DIR_CURRENT" ]]
	then
		# Make a directory for that finished
		FINI_FOLDER_NAME="$(basename "$(dirname "$fini")")"
		FINI_FOLDER_PATH="${DIRS_FINISHED_TOP}/${FINI_FOLDER_NAME}"
		mkdir -p "$FINI_FOLDER_PATH"

		cp -a "${fini}/." $FINI_FOLDER_PATH

	fi
done
