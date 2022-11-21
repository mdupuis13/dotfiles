#!/usr/bin/env bash
echo "Création de l'archive des emails et de la  config"

if [ -d "$HOME/.claws-mail/" ]; then
    tar -cz --file "$HOME/backup/claws-mail.tar.gz"  --exclude-ignore-recursive='.tar_exclude' -C$HOME .claws-mail Mail
else
    printf "No claws-mail profile found at %s\n" "$HOME/.claws-mail/"
fi
