# dotfiles
My personal linux config files.

## dotFilez repo
- [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
- [GNU Stow](http://www.gnu.org/software/stow/)

## backup config

Those commands will:

1. copy the given files into the dotfiles folder
2. using GNU Stow, create a symlink from that folder into the parent folder (which is `$HOME` in this case)

```bash
cd $HOME
mkdir -p dotfiles/<program_name>
# copy config file/folder into $HOME/dotfiles/<program_name>
cd dotfiles && stow <program_name>
```

## restore
1. clone the git repo into `$HOME/dotfiles`
2. run `stow <program_name>` to _restore_ a program's settings


## special devices config
[github gist](https://gist.github.com/mdupuis13/3d0a4f265e8fbbfe098baf290c8bf043)
