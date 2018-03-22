#!/bin/bash

# path to directory with bmngr scripts. Adjust to your needs.
BMNGRPATH="$HOME/.bmngr"

# backup expansion. Choose some name that you dont use because it may cause conflict and break your files
BMNGREXPAN=".bmngrB"

# gets absolute path of a file
function abspath { 
    if [[ -d "$1" ]]
    then
        pushd "$1" >/dev/null
        pwd
        popd >/dev/null
    elif [[ -e $1 ]]
    then
        pushd "$(dirname "$1")" >/dev/null
        echo $(pwd)/$(basename "$1")
        popd >/dev/null
    fi
}

# loads filenames from file and starts all monitoring processes
function start { 
	while read p; do
		if [ -e "$p" ]
		then
			$BMNGRPATH/bmngrMonitor.sh $p &
			disown
		fi
	done <$BMNGRPATH/bmngrFiles
}

# kills all monitoring processes
function stop { 
	pkill -f "$BMNGRPATH/bmngrMonitor.sh" &>/dev/null
}

# saves new file you want to monitor to file and starts new monitor process to handle it
function add {
	abspath $1 >> $BMNGRPATH/bmngrFiles
	sort -u $BMNGRPATH/bmngrFiles -o $BMNGRPATH/bmngrFiles

	$BMNGRPATH/bmngrMonitor.sh $(abspath $1) & 
	disown
}

# removes a file from list of monitored files
function remove { 
	if [ "$1" == "" ]
	then
		exit
	fi
	touch $BMNGRPATH/.bmngrFiles
	grep -vx "$(abspath $1)" "$BMNGRPATH/bmngrFiles" > "$BMNGRPATH/.bmngrFiles"
	cp "$BMNGRPATH/.bmngrFiles" "$BMNGRPATH/bmngrFiles"
}

# checks if file exists
function exists {
	if [ "$1" == "" ]
	then
		echo "No such file"
		exit
	fi
	if [ ! -e $(abspath $1) ]
	then
		echo "No such file"
		exit
	fi
	if [ -d $(abspath $1) ]
	then
		echo "It's a directory, not file"
		exit
	fi
}

# prints all monitored files
function list {
	cat $BMNGRPATH/bmngrFiles
}

function showHelp {
	echo "Simple script to keep your files backed up while running in the background"
	echo "Type 'start' to start monitoring your files"
	echo "Type 'stop' to stop monitoring your files"
	echo "Type 'restart' to restart script"
	echo "Type 'add FILENAME' to add new files to monitor"
	echo "Type 'remove FILENAME' to remove file from list of monitored files"
	echo "Type 'removeallimsureofit' to clear list of monitored files"	
	echo "Type 'list' to show all monitored files"
}




# input handling

if [ "$1" == "start" ]
then
	stop &>/dev/null
	start &>/dev/null
	exit
fi

if [ "$1" == "stop" ]
then
	stop &>/dev/null
	exit
fi

if [ "$1" == "add" ]
then
	exists $2
	add $2 &>/dev/null
	exit
fi

if [ "$1" == "remove" ]
then
	stop &>/dev/null
	exists $2
	remove $2 &>/dev/null
	start &>/dev/null
	exit
fi

if [ "$1" == "removeallimsureofit" ]
then
	stop &>/dev/null
	echo -n "" > "$BMNGRPATH/bmngrFiles"
	start &>/dev/null
	exit
fi

if [ "$1" == "restart" ]
then
	stop &>/dev/null
	start &>/dev/null
	exit
fi


if [ "$1" == "list" ]
then
	list
	exit
fi

if [ "$1" == "help" ]
then
	showHelp
	exit
fi

echo "No such command"
echo "Try 'help' for list of commands"
