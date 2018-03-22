#!/bin/bash

# Gets directory/file path on $1

BMNGRPATH="$HOME/.bmngr"
BMNGREXPAN=".bmngrB" # backup expansion. Choose some name that you dont use because it may cause conflict and ignore your files

if [ ! -e $1 ]
then
	exit
fi

MODDATE="$(date -r $1 +"%s")"

while true;
do
	sleep 60
	if [ "$MODDATE" != "$(date -r $1 +"%s")" ]
	then
		sh $BMNGRPATH/bmngrBackup.sh "$1" 
		MODDATE="$(date -r $1 +"%s")"
	fi
done
