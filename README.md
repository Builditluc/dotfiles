My dotfiles

## How can I use these dotfiles?

Prior to the installation make sure you have committed the alias to you `.bashrc` or `.zshrc`:
```
alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
```

Now clone this repository
```
git clone --bare https://github.com/builditluc/dotfiles $HOME/dotfiles
```

Checkout the actual content from the bare repository to your `$HOME`:
```
config checkout
```

## Installing
### Install nix
```
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
```
### Add the right channel
```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://channels.nixos.org/nixpkgs-unstable nixpkgs
nix-channel --update
```

### Install nix-darwin
```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```
### Install iTerm2
```
wget https://iterm2.com/downloads/stable/iTerm2-3_4_12.zip
unzip iTerm2-3_4_12.zip
mv iTerm2.app /Applications/iTerm.app
```
### Update
```
update-nix-fetchgit $HOME/.config/nixpkgs/home.nix && nix-channel --update && darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/configuration.nix
```

And you're ready to go!


## Acknowledgements

- https://www.atlassian.com/git/tutorials/dotfiles
