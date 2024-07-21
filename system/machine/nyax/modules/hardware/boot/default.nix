{ pkgs
, ...
}:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = false;
        consoleMode = "max";
        editor = false;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
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

