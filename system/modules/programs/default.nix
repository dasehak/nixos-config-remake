{ lib
, ...
}:

with lib;

{
  imports = [
    ./systemPackages
    ./home-manager
    ./nix-helper
    ./kdeconnect
    ./xdg-portal
    ./gnupg
    ./fish
    ./mtr
    ./dconf
    ./steam
    ./gamemode
  ];

  module.programs = {
    dconf.enable      = mkDefault true;
    gnupg.enable      = mkDefault true;
    hm.enable         = mkDefault true;
    nh.enable         = mkDefault true;
    kdeconnect.enable = mkDefault true;
    mtr.enable        = mkDefault true;
    xdg-portal.enable = mkDefault false;
    fish.enable       = mkDefault true;
    steam.enable      = mkDefault true;
    gamemode.enable   = mkDefault true;
  };
}

