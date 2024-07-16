{ inputs
, ...
}:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    ../../modules
    ./modules/hardware
  ];

  module = {
    locales.enable                 = true;
    network.enable                 = true;
    timedate.enable                = true;
    users.enable                   = true;
    variables.enable               = true;
    virtualisation.enable          = true;

    programs = {
      systemPackages.enable = true;
      steam.enable          = true;
      gamemode.enable       = true;
      kdeconnect.enable     = true;
    };

    security = {
      hardening.enable = true;
      apparmor.enable  = true;
    };

    services = {
      bluetooth.enable = true;
      fwupd.enable     = true;
      printing.enable  = true;
      hyprland.enable  = false;
      plasma.enable    = true;
      xserver.enable   = true;
      zram.enable      = true;
    };
  };
}

