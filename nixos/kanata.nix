{ config, pkgs, ... }:

let
  dotfiles = pkgs.fetchFromGitHub {
    owner = "eduardofuncao";
    repo = "dotfiles";
    rev = "main";
    sha256 = "0l1b91idm74pr0rcsrwyp07bmgxvvy6i3icdsbz1wdsc84vfgiwg";
  };
  kanataConfig = "${dotfiles}/kanata/kanata.kbd";
in
{
  environment.systemPackages = [ pkgs.kanata ];
  
  systemd.services.kanata = {
    description = "Kanata keyboard remapper";
    documentation = [ "https://github.com/jtroo/kanata" ];
    
    wantedBy = [ "default.target" ];
    wants = [ "display-manager.service" ];
    after = [ "display-manager.service" ];
    
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kanata}/bin/kanata --cfg ${kanataConfig}";
      ExecReload = "${pkgs.util-linux}/bin/kill -HUP $MAINPID";
      Restart = "always";
      RestartSec = 3;
    };
    
    enable = true;
  };
}
