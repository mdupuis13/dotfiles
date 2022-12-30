#!/usr/bin/env bash
##################### 
#  backup user data
#####################

echo "Création de l'archive gigantesque de $HOME"
tar -cz --file="$HOME/backup/mdupuis-home-full-backup.tar.gz" --exclude-vcs --exclude-ignore-recursive='.tar_exclude' --files-from="$HOME/bin/backup/mdupuis-home-full-backup.tar_include"

echo "Création de l'archive pour Darktable"
if [[ -d $HOME/.var/app/org.darktable.Darktable/config/darktable ]]; then
  tar cz --file="$HOME/backup/darktable-config.tar.gz" -C $HOME/.var/app/org.darktable.Darktable/config darktable 
fi


# apt config
~/bin/backup/bkp-config.sh

# email
~/bin/backup/bkp-emails.sh

# calibre
~/bin/backup/bkp-calibre.sh

# copy to network
#~/bin/backup/copy-2-network.sh

