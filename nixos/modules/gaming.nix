{ config, pkgs, ... }:

{
  # Enable gaming-related services and configurations
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # NVIDIA GPU configuration
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # OpenGL and Vulkan support
  hardware.graphics = {
    enable = true;
  };

  # Gaming packages
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    mangohud
    gamemode
    discord
  ];

  # Performance optimizations
  powerManagement.cpuFreqGovernor = "performance";
  
  # Kernel parameters for gaming
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];
}
