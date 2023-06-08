#!/usr/bin/env bash
echo Supression des copies sur le réseau
rm -rf /mnt/dasnas/homes/backup/dasboss-pc/mdupuis-home-full*.tar*


echo Copie des fichiers sur le réseau
rsync --info=progress2 --update --inplace --partial --modify-window=2 --human-readable -v /home/mdupuis/backup/*.tar* /mnt/dasnas/homes/backup/dasboss-pc/

echo Supression des copies locales
#rm -f /home/mdupuis/backup/*.tar*
