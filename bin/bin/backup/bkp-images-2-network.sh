#!/usr/bin/env bash
photos_folder=$HOME/Photographie 

echo Synchronisation de $photos_folder vers dasnas

if [[ -d $photos_folder ]]; then
  rsync --modify-window=2 --prune-empty-dirs --recursive --update --progress $photos_folder/* /mnt/dasnas/media/Photos/

  # --modify-window
  #     When comparing two timestamps, rsync treats the timestamps as being equal if they differ by no more than the modify-window value. This is normally 0 (for an exact match), but you may find it useful to set this to a larger value in some situations. In particular, when transferring to or from an MS Windows FAT filesystem (which represents times with a 2-second resolution), --modify-window=1 is useful (allowing times to differ by up to 1 second). 

  # -m, --prune-empty-dirs
  #     This option tells the receiving rsync to get rid of empty directories from the file-list, including nested directories that have no non-directory children. This is useful for avoiding the creation of a bunch of useless directories when the sending rsync is recursively scanning a hierarchy of files using include/exclude/filter rules.

  # --progress
  #   This option tells rsync to print information showing the progress of the transfer. This gives a bored user something to watch. Implies --verbose if it wasn't already specified. 
    
  # -r, --recursive
  #     This tells rsync to copy directories recursively. See also --dirs (-d). 

  # -u, --update
  #     This forces rsync to skip any files which exist on the destination and have a modified time that is newer than the source file. (If an existing destination file has a modification time equal to the source file's, it will be updated if the sizes are different.) 
fi
