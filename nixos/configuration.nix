# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, inputs, ... }:

{
  # =========================================================================
  # IMPORTS
  # =========================================================================
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
    ./kanata.nix
  ];

  # =========================================================================
  # SYSTEM SETTINGS
  # =========================================================================
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # =========================================================================
  # BOOT CONFIGURATION
  # =========================================================================
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # =========================================================================
  # NETWORKING
  # =========================================================================
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # =========================================================================
  # LOCALIZATION
  # =========================================================================
  
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # =========================================================================
  # USER MANAGEMENT
  # =========================================================================
  
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.eduardo = {
    isNormalUser = true;
    description = "Eduardo Função";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # =========================================================================
  # PROGRAMS AND SHELLS
  # =========================================================================
  
  programs.zsh.enable = true;

  
  # =========================================================================
  # SERVICES
  # =========================================================================
  
  hardware.bluetooth.enable = true;

  # Audio services
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # =========================================================================
  # SYSTEM PACKAGES
  # =========================================================================
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    vim
    git wget curl jq unzip
    kanata
    tmux oh-my-zsh starship
    ripgrep zoxide fzf fd bat eza
    btop light pavucontrol alsa-utils wireplumber blueman
    imv zathura mpv
    gcc gnumake cmake nodejs nodePackages.npm go python3 openjdk
    docker-compose
  ];

  # =========================================================================
  # SECURITY AND FIREWALL
  # =========================================================================
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
