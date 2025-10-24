# dotfiles

Nix-OS base configuration using my dotfiles
[ GIF WILL GO HERE] 
[Reddit post](https://www.reddit.com/r/unixporn/comments/1o5xhp2/niri_infinite_workspaces_with_niri/)


## Setup Guide
- Create Nixos basic configuration (here you could use the GUI installer and select no DE option)

- enter a nix shell with git and vim installed to help setup
```bash
nix-shell -p git vim
```

- clone the repo in the $HOME directory
```bash
git clone --branch nixos-from-scratch https://github.com/eduardofuncao/dotfiles
```

- copy needed config files to `$HOME/.config/`
```bash
mkdir ~/.config
cd ~/dotfiles
cp -r fish/ niri/ nvim/ ripgrep/ scripts/ swayidle/ wallpapers/ ~/.config
sudo cp kanata/kanata.kbd /etc/
```
ps. kitty, tmux and waybar config files are managed directly through nix

- copy the nixos config files in `$HOME/dotfiles/nixos` direcotory into `/etc/nixos/`,
keeping only your automatically generated `hardware-configuration.nix` file
```bash
# backup the current hardware-configuration.nix
sudo cp /etc/nixos/hardware-configuration.nix /tmp/

# remove everything from /etc/nixos
sudo rm -rf /etc/nixos/*

# copy everything from your dotfiles/nixos to /etc/nixos
sudo cp -rT ~/dotfiles/nixos /etc/nixos

# restore the hardware-configuration.nix file
sudo mv /tmp/hardware-configuration.nix /etc/nixos/nixos
```

- replace every instance of user "eduardo" with your username
in /etc/nixos/nixos/configuration.nix, /etc/nixos/home-manager/home.nix and /etc/nixos/flake.nix

- if you want, change hostname in /etc/nixos/nixos/configuration.nix and /etc/nixos/flake.nix

- build the system (we have to explicitly allow flakes on the first build. For next rebuilds,
just use `sudo nixos-rebuild switch --flake .#hostname`)
```bash
cd /etc/nixos
NIX_CONFIG="experimental-features = nix-command flakes" sudo nixos-rebuild switch --flake .#nixos
```
this will take a while ⏳

- run home-manager switch to setup user level config (similarly, on the first build we need to explicitly install home-manager.
for the next runs, just use `home-manager switch --flake .#user@hostname)
```bash
cd /etc/nixos
nix-shell -p home-manager
home-manager switch --flake .#eduardo@nixos
```

this will take an even longer while 😴

just `sudo reboot` your system and everything should work!

Done 🥳
