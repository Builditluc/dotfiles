My nix-darwin configuration.

## Installing
> Permission denied error: `sudo chown -R builditluc /nix`
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
