{ inputs
, ...
}:

{
  imports = [
    ../../modules
    ./modules/hardware
  ];

  module = {
    locales.enable                 = true;
    network.enable                 = true;
    timedate.enable                = true;
    users.enable                   = true;
    variables.enable               = true;
    virtualisation.enable          = false;

    programs = {
      systemPackages.enable = true;
      steam.enable          = false;
      gamemode.enable       = false;
      kdeconnect.enable     = false;
    };

    security = {
      hardening.enable = true;
      apparmor.enable  = true;
    };

    services = {
      bluetooth.enable = false;
      fwupd.enable     = false;
      printing.enable  = false;
      hyprland.enable  = false;
      plasma.enable    = true;
      xserver.enable   = true;
      zram.enable      = true;
    };
  };
}

