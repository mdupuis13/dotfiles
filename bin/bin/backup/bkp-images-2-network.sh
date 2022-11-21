#!/usr/bin/env bash
echo Synchronisation du drive USB 1To_Seagate
if [[ -d $HOME/Photographie ]]
then
  rsync --modify-window=2 --prune-empty-dirs --quiet --recursive --update $HOME/Photographie/* /mnt/dasnas/media/Photo/
fi

if [[ -d $HOME/.var/app/org.darktable.Darktable/config/darktable ]]
  tar zxf darktable_config.tar.gz $HOME/.var/app/org.darktable.Darktable/config/darktable
fi
