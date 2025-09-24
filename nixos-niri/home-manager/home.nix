# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../modules/home-manager/work/work.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      inputs.neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "eduardo";
    homeDirectory = "/home/eduardo";
  };

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    inputs.zen-browser.packages.${system}.default
    (callPackage ../modules/home-manager/polycat.nix { })
    tmux starship
    dstask tldr fastfetch ncdu
    swaybg
    obs-studio bruno ferdium thunderbird

    papirus-folders
    arc-theme
    arc-icon-theme
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Eduardo Função";
    userEmail = "eduardofuncao@hotmail.com";
    extraConfig = {
      core.editor = "nvim";
    };
  };
  programs.starship = {
    enable = true;
  };
  programs.zoxide = {
    enable = true;
  };

  # Create the systemd user service
  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      Documentation = "man:swaybg(1)";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${config.home.homeDirectory}/.config/wallpapers/bg.jpg -m fill";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };



  # Theme
    gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Arc";
      package = pkgs.arc-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome-themes-extra;
    size = 16;
  };
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Arc-Dark";
      color-scheme = "prefer-dark";
    };
  };
  
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style = {
      name = "gtk2";
      package = pkgs.arc-theme;
    };
  };

  home.file.".config/mako/config".text = ''
    background-color=#181825
    text-color=#d8dee9
    border-color=#282a36
    border-size=2
    font=JetBrainsMono 10
  '';

  home.sessionVariables = {
    XCURSOR_SIZE = "16";
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
