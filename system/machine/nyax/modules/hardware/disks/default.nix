_:

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };
            luks = {
              size = "800G";
              content = {
                type = "luks";
                name = "crypted";
                extraOpenArgs = [ ];
                settings.allowDiscards = true;
                content = {
                  type = "lvm_pv";
                  vg = "nyax_vg";
                };
              };
            };
            fedora = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "fedoryax_vg";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      nyax_vg = {
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
            size = "60G";
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
      fedoryax_vg = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "50G";
            content = {
              type = "filesystem";
              format = "btrfs";
            };
          };
          home = {
            size = "100%FREE";
            content = {
              type = "filesystem";
              format = "btrfs";
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=8G"
        "defaults"
        "mode=755"
      ];
    };
  };

  fileSystems."/persistent".neededForBoot = true;

  boot.initrd.luks.devices.root = {
    device = "/dev/nvme0n1p3";
    preLVM = true;
  };
}
