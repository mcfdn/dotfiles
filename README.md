# dotfiles

Simple script to install dotfiles. Run [dotfiles](https://github.com/jamesmcfadden/dotfiles/blob/master/bin/dotfiles) to download and install the dotfiles:

## Install

```
curl -o install_dotfiles.sh https://raw.githubusercontent.com/jamesmcfadden/dotfiles/master/bin/dotfiles
chmod +x install_dotfiles.sh
./install_dotfiles.sh
```

To force overwriting existing destination files, use the `-f` flag:

```
./install_dotfiles.sh -f
```

## Todo

- Backup existing dotfiles
- Homebrew support
