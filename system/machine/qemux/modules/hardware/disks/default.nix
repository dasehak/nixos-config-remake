_:

{
  disko.devices = {
    disk = {
      vda = {
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
                mountpoint = "/boot";
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
          root = {
            size = "30G";
            content = {
              type = "filesystem";
              format = "brtfs";
              mountpoint = "/";
              mountOptions = [
                "defaults"
                "compress-force=zstd:3"
              ];
            };
          };
          home = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "brtfs";
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
  };

  boot.initrd.luks.devices.root = {
    device = "/dev/vda3";
    preLVM = true;
  };
}