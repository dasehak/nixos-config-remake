_:

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                settings.allowDiscards = true;
                content = {
                  type = "lvm_pv";
                  vg = "qemux_vg";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      qemux_vg = {
        type = "lvm_vg";
        lvs = {
          persistent = {
            size = "10G";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/persistent";
              mountOptions = [
                "defaults"
                "compress-force=zstd:3"
              ];
            };
          };
          nix = {
            size = "20G";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/nix";
              mountOptions = [
                "defaults"
                "compress-force=zstd:3"
              ];
            };
          };
          home = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "btrfs";
              mountpoint = "/home";
              mountOptions = [
                "defaults"
                "compress-force=zstd:3"
              ];
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=2G"
        "defaults"
        "mode=755"
      ];
    };
  };

  fileSystems."/persistent".neededForBoot = true;

  boot.initrd.luks.devices.root = {
    device = "/dev/vda3";
    preLVM = true;
  };
}
