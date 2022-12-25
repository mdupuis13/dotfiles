#!/usr/bin/env bash
photos_folder=$HOME/Photographie 

echo Synchronisation de $photos_folder vers dasnas
if [[ -d $photos_folder ]]
then
  rsync --modify-window=2 --prune-empty-dirs --quiet --recursive --update $photos_folder/* /mnt/dasnas/media/Photo/
fi

if [[ -d $HOME/.var/app/org.darktable.Darktable/config/darktable ]]
  tar zxf darktable_config.tar.gz $HOME/.var/app/org.darktable.Darktable/config/darktable
fi
