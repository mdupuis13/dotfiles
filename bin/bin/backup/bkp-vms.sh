#!/usr/bin/env bash
# Ce fichier effectue un backup des virtual machines

echo "Création de l'archive des VMs"
tar -c --file="$HOME/backup/vms.tar" -C$HOME VMs
