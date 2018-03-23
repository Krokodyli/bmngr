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

echo -n "Add autostart (systemctl)? y/n "
read ans
if [ "$ans" == "y" ]
then
	echo "[Unit]" >> $HOME/.bmngr/bmngr.service
	echo "Description=Backup Manager" >> $HOME/.bmngr/bmngr.service
	echo "" >> $HOME/.bmngr/bmngr.service
	echo "[Service]" >> $HOME/.bmngr/bmngr.service
	echo "Type=oneshot" >> $HOME/.bmngr/bmngr.service
	echo "ExecStart=$HOME/.bmngr/bmngr.sh start" >> $HOME/.bmngr/bmngr.service
	echo "RemainAfterExit=true" >> $HOME/.bmngr/bmngr.service
	echo "" >> $HOME/.bmngr/bmngr.service
	echo "[Install]" >> $HOME/.bmngr/bmngr.service
	echo "WantedBy=default.target" >> $HOME/.bmngr/bmngr.service
	systemctl --user enable --now $HOME/.bmngr/bmngr.service
fi
