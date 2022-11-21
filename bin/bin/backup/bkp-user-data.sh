#!/usr/bin/env bash
##################### 
#  backup user data
#####################

echo "Création de l'archive gigantesque de $HOME"
tar -cz --file="$HOME/backup/mdupuis-home-full-backup.tar.gz" --exclude-vcs --exclude-ignore-recursive='.tar_exclude' --files-from="$HOME/bin/backup/mdupuis-home-full-backup.tar_include"
echo "Création de l'archive pour Darktable"
tar cvfz $HOME/backup/darktable-config.tar.gz -C $HOME/.var/app/org.darktable.Darktable/config darktable 

# apt config
~/bin/backup/bkp-config.sh

# email
~/bin/backup/bkp-emails.sh

# calibre
~/bin/backup/bkp-calibre.sh

echo Copie des fichiers usr le réseau
#rsync --info=progress2 --update --modify-window=2 --human-readable /home/mdupuis/backup/*.tar* /mnt/dasnas/homes/Backup/dasboss-pc/

#rm -f /home/mdupuis/backup/*.tar*
