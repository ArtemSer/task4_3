#!/bin/bash
#Settings
BACKUPS_DIR="/tmp/backups/"
#Checking Backups directory
if [ ! -d "${BACKUPS_DIR}" ]; then mkdir "${BACKUPS_DIR}"; fi
#Amount of arguments
if [ "$#" -ne 2 ]; then echo "Invalid amount of arguments" >&2; exit 1; fi
#Checing first arguments: Folder XX
if ! [[ -d $1 ]]; then echo "$1: not found or isn't directory" >&2; exit 2; fi
if [[ $2 =~ '^[0-9]+$' ]]; then echo "$2 must be ineger number" >&2; exit 3; fi

BACKUP_NAME=$(echo $1 | sed -r 's/[/]+/-/g' | sed 's/^-//')
ARCH_NAME=${BACKUP_NAME}-$(date '+%Y%m%d-%H%M%S').tar.gz
tar --create --gzip --file="$BACKUPS_DIR$ARCH_NAME" "$1" 2> /dev/null
#Deleting old backups
find "$BACKUPS_DIR" -name "${BACKUP_NAME}*" -type f -printf "${BACKUPS_DIR}%P\n"| sort -n | head -n -"$2" | sed "s/.*/\"&\"/"| xargs rm -f

exit 0

