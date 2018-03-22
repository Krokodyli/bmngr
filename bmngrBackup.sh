#!/bin/bash
# Gets directory/file path on $1
# Adjust to your needs

BMNGREXPAN=".bmngrB" # backup expansion. Choose some name that you dont use because it may cause conflict and break your files
BMNGRPATH="$HOME/.bmngr"

FILENAME="$(basename $1)"
DIRNAME="$(dirname $1)"

cd $DIRNAME
cp "$FILENAME" "$BMNGRPATH/backups/$FILENAME$BMNGREXPAN$(date +%F)" &>/dev/null

cd $BMNGRPATH/backups
BNUMBER=$(ls *$FILENAME$BMNGREXPAN* | sort | wc -l)
 
if (( $BNUMBER > 7 ))
then
	ls *$FILENAME$BMNGREXPAN* | sort | head -n $[$BNUMBER-7] | xargs rm &>/dev/null
	exit
fi
