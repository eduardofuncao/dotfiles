{ pkgs, ... }:

{
  home.packages = with pkgs; [
    android-studio
    httptoolkit
    dbeaver-bin
    openfortivpn
  ];
}
