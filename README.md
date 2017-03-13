# dotfiles

Simple package to download and install dotfiles.

## Install

```
curl -o dotfiles.sh https://raw.githubusercontent.com/jamesmcfadden/dotfiles/master/bin/dotfiles
chmod +x dotfiles.sh
./dotfiles.sh install
```

Once installed, remove the installation file:

```
rm dotfiles.sh
```

Dotfiles will be available in your path:

```
dotfiles
usage: dotfiles [command]

Available commands:
install    Install dotfiles
push       Push changes to the dotfiles repository
pull       Pull changes from the dotfiles repository

Docs: https://github.com/jamesmcfadden/dotfiles
```

### Force install

To force overwriting existing destination files, use the `-f` flag:

```
./dotfiles.sh install -f
```

## Update

### Push

Push new and modified dotfiles:

```
dotfiles push
```

### Pull

Pull and install dotfiles:

```
dotfiles pull
```

To force the install while pulling:

```
dotfiles pull -f
```

### Status

Display modified dotfiles:

```
dotfiles status
```

## Todo

- Homebrew support
- Add confirmation between commit and push
