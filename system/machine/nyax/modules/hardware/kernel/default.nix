{ pkgs
, config
, ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;
    kernelModules = [
      "amdgpu"
      "kvm-amd"
      "kvm-intel"
    ];

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];


    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

    kernelParams = [
      "drm_kms_helper.poll=0"

      # Security settings
      "debugfs=off"
      "page_alloc.shuffle=1"
      "page_poison=1"
      "slab_nomerge"

      "mce=off"

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

    blacklistedKernelModules = [
      # Obscure network protocols
      "ax25"
      "netrom"
      "rose"

      # Old or rare or insufficiently audited filesystems
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];

    kernel.sysctl = {
      # Chromium sandboxing workaround, maybe a little security hole
      "kernel.unprivileged_userns_clone" = 1;

      # Hide kptrs even for processes with CAP_SYSLOG`
      "kernel.kptr_restrict" = 2;

      # Disable bpf() JIT (to eliminate spray attacks)
      "net.core.bpf_jit_enable" = false;

      # Disable ftrace debugging
      "kernel.ftrace_enabled" = false;

      # Enable strict reverse path filtering (that is, do not attempt to route
      # packets that "obviously" do not belong to the iface's network; dropped
      # packets are logged as martians).
      "net.ipv4.conf.all.log_martians" = true;
      "net.ipv4.conf.all.rp_filter" = "1";
      "net.ipv4.conf.default.log_martians" = true;
      "net.ipv4.conf.default.rp_filter" = "1";

      # Ignore broadcast ICMP (mitigate SMURF)
      "net.ipv4.icmp_echo_ignore_broadcasts" = true;

      # Ignore incoming ICMP redirects (note: default is needed to ensure that the
      # setting is applied to interfaces added after the sysctls are set)
      "net.ipv4.conf.all.accept_redirects" = false;
      "net.ipv4.conf.all.secure_redirects" = false;
      "net.ipv4.conf.default.accept_redirects" = false;
      "net.ipv4.conf.default.secure_redirects" = false;
      "net.ipv6.conf.all.accept_redirects" = false;
      "net.ipv6.conf.default.accept_redirects" = false;

      # Ignore outgoing ICMP redirects (this is ipv4 only)
      "net.ipv4.conf.all.send_redirects" = false;
      "net.ipv4.conf.default.send_redirects" = false;
    };
  };
}

