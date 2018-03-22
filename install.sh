#!/bin/bash
if [ ! -e $HOME/.bmngr ]
then
	mkdir $HOME/.bmngr
fi

cp bmngrBackup.sh $HOME/.bmngr/bmngrBackup.sh
cp bmngrMonitor.sh $HOME/.bmngr/bmngrMonitor.sh
cp bmngr.sh $HOME/.bmngr/bmngr.sh
touch $HOME/.bmngr/bmngrFiles
mkdir $HOME/.bmngr/backups


echo -n "Add alias brmngr to your .bashrc? y/n: "
read ans
if [ "$ans" == "y" ]
then
	echo "" >> $HOME/.bashrc
	echo "# BMNGR ALIASES" >> $HOME/.bashrc
	echo "alias bmngr=\"sh $HOME/.bmngr/bmngr.sh\"" >> $HOME/.bashrc
fi

echo -n "Add autostart line to your .xprofile? y/n "
read ans
if [ "$ans" == "y" ]
then
	echo "" >> $HOME/.xprofile
	echo "# BMNGR AUTOSTART" >> $HOME/.xprofile
	echo "$HOME/.bmngr/bmngr.sh start & disown" >> $HOME/.xprofile
fi
