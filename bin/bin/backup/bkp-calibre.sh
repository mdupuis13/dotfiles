#!/usr/bin/env bash

echo Synchronisation de la library Calibre
rsync --quiet --recursive --delete-during --update --modify-window=2 --prune-empty-dirs $HOME/Calibre\ Library/* /mnt/dasnas/media/LibrairieCalibre/
