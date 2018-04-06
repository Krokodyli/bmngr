# bmngr
Simple script that manages backups. 

Every minute it's checking for change in date of modification of monitored files. If some file changed it saves daily backup of it in the script's directory. It saves up to 7 backups of one file.

install.sh creates needed directories and move files to it. It also, after confirmation, add alias to end of your .bashrc and enable service in systemctl.

bmngr.sh manages bmngrMonitor processes and list of monitored files.

bmngr.service is configuration for systemctl.

bmngrMonitor.sh monitores a file and if the file changed it starts bmngrBackup.sh.

bmngrBackup.sh backups a file, checks if there are more than 7 backups and remove older ones.
