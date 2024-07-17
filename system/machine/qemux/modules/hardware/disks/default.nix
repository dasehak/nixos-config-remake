_:

{
  fileSystems = {
    "/" = {
      device = "/dev/qemux_vg/root";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };

    "/boot" = {
      device = "/dev/vda2";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };

    "/boot/efi" = {
      device = "/dev/vda1";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/qemux_vg/home";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };
  };

  boot.initrd.luks.devices.root = {
    device = "/dev/vda3";
    preLVM = true;
  };
}