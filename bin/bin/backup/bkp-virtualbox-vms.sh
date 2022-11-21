#!/usr/bin/env bash
# Ce fichier effectue un backup des virtual machines

echo "Création de l'archive de VirtualBox"
tar -c --file="$HOME/backup/virtualbox-vms.tar" -C$HOME VirtualBox\ VMs
