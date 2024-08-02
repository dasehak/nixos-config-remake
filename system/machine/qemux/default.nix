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

    programs = {
      systemPackages.enable = true;
      steam.enable          = false;
      gamemode.enable       = false;
      kdeconnect.enable     = false;
    };

    security = {
      hardening.enable = true;
      apparmor.enable  = true;
      antivirus.enable = false;
    };

    services = {
      bluetooth.enable = false;
      fwupd.enable     = false;
      printing.enable  = false;
      hyprland.enable  = false;
      plasma.enable    = true;
      xserver.enable   = true;
      zram.enable      = true;
      sshd.enable      = false;
      libinput.enable  = true;
    };
  };
}

