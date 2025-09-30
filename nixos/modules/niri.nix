{ config, pkgs, ... }:

{
  programs.niri.enable = true; # Only if using NixOS 24.05+ or a flake that provides niri
  security.polkit.enable = true; # For polkit support
  services.gnome.gnome-keyring.enable = true; # Secret service

  security.pam.services.swaylock = {}; # PAM integration for swaylock

  programs.waybar.enable = true; # Top bar

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    swaylock
    mako
    swayidle
  ];
}
