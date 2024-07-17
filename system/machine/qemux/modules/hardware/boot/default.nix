{ pkgs
, ...
}:

{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
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
  };
}

