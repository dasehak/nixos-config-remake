{ pkgs
, ...
}:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = false;
        consoleMode = "max";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    plymouth = {
      enable = true;
    };
    initrd.systemd.enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}

