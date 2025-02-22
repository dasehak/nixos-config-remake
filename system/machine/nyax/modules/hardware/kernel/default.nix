{ pkgs
, config
, ...
}:

{
  boot = {
    kernelModules = [
      "amdgpu"
      "kvm-intel"
      "udf"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    kernelParams = [
      "quiet"
      "loglevel=0"

      # IOMMU
      "intel_iommu=on"
      "iommu=pt"
      "efi=disable_early_pci_dma"
    ];

    initrd = {
      availableKernelModules = [
        "ehci_pci"
        "aesni_intel"
        "ahci"
        "cryptd"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];

      kernelModules = [
        "amdgpu"
        "dm-snapshot"
      ];
    };
  };
}

