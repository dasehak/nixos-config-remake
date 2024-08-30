{ inputs
, config
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

    virtualisation = {
      docker.enable          = true;
      libvirtd.enable        = true;
      virt-manager.enable    = true;
      virtualbox-host.enable = true;
    };

    programs = {
      systemPackages.enable = true;
      steam.enable          = true;
      gamemode.enable       = true;
      kdeconnect.enable     = true;
    };

    security = {
      hardening = {
        enable        = true;
        cachyosKernel = true;
      };
      apparmor.enable  = true;
      antivirus.enable = true;
      usbguard = {
        enable   = true;
        ruleFile = config.sops.secrets.nyax_usb_rules.path;
      };
    };

    services = {
      bluetooth.enable = true;
      fwupd.enable     = true;
      printing.enable  = true;
      plasma.enable    = true;
      xserver.enable   = true;
      zram.enable      = true;
      sshd.enable      = true;
      libinput.enable  = true;
      flatpak.enable   = true;
    };
  };
}

