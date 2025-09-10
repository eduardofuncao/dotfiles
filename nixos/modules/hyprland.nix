{ config, pkgs, ...}:
let
in {
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kitty
    
    wl-clipboard
    libnotify
    swaynotificationcenter
    networkmanagerapplet
    wofi

    hyprpaper
    hypridle
    hyprlock
    waybar

    grim
    slurp
    swappy

    nordic
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}
