{ pkgs
, config
, ...
}:

{
  boot = {
    kernelParams = [
      "quiet"
    ];

    initrd = {
      kernelModules = [
        "virtio_balloon"
        "virtio_console"
        "virtio_rng"
        "virtio_gpu"
      ];

      availableKernelModules = [
        "ehci_pci"
        "aesni_intel"
        "ahci"
        "cryptd"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "virtio_net"
        "virtio_pci"
        "virtio_mmio"
        "virtio_blk"
        "virtio_scsi"
        "9p"
        "9pnet_virtio"
      ];

      kernelModules = [
        "dm-snapshot"
      ];
    };
  };
}

