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

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        # wlroots specific
        # use xdg-desktop-portal-gtk for gnome.
        xdg-desktop-portal-hyprland
      ];
      # uncomment for gnome
      # gtkUsePortal = true;
    };
  };
  
  xdg.portal.wlr.settings = {
    screencast = {
      # set the output_name (this doesn't really matter)
  	  output_name = "HDMI-A";
  	  max_fps = 60;
  	  chooser_type = "simple";
  	  chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";		
    };
};


}
