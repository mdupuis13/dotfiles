#!/usr/bin/env bash
dest=/mnt/dasnas/homes/backup/daspapa-pc

echo Supression des copies sur le réseau
rm -rf $dest/mdupuis-home-full*.tar*


echo Copie des fichiers sur le réseau
rsync --info=progress2 --update --inplace --partial --bwlimit=50m --modify-window=2 --human-readable -v /home/mdupuis/backup/*.tar* $dest/

echo Supression des copies locales
#rm -f /home/mdupuis/backup/*.tar*
