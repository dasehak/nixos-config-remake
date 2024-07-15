_:

{
  fileSystems = {
    "/" = {
      device = "/dev/nyax_vg/gentoo";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };

    "/boot" = {
      device = "/dev/nvme0n1p2";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };

    "/boot/efi" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/nyax_vg/fedora_home";
      fsType = "btrfs";
      options = [ "compress-force=zstd:3" ];
    };
  };

  boot.initrd.luks.devices.root = {
    device = "/dev/nvme0n1p3";
    preLVM = true;
  };
}