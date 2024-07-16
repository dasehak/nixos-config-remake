{ pkgs
, config
, ...
}:

{
  boot = {
    kernelModules = [
      "amdgpu"
      "kvm-intel"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    kernelParams = [
      "quiet"

      # IOMMU
      "intel_iommu=on"
      "iommu=pt"
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

