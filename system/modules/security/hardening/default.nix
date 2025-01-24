{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.security.hardening;
in
{
  options = {
    module.security.hardening = {
      enable = mkEnableOption "Enables hardening";

      cachyosKernel = mkOption {
        type = types.bool;
        description = "Whether to use CachyOS-hardened kernel instead of vanilla kernel.";
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {
    boot = {
      kernelPackages = if cfg.cachyosKernel then pkgs.linuxPackages_cachyos-hardened else pkgs.linuxPackages_hardened;

      kernelModules = [
        "nf_tables"
        "lkrg"
        "jitterentropy_rng"
      ];

      kernelParams = [
        "efi=disable_early_pci_dma"
        "iommu.passthrough=0"
        "mitigations=auto,nosmt"
        "pti=on"
        "extra_latent_entropy"
        "slab_nomerge"
        "init_on_alloc=1"
        "init_on_free=1"
        "page_alloc.shuffle=1"
        "randomize_kstack_offset=on"
        "vsyscall=none"
        "debugfs=off"
        "oops=panic"
        "quiet"
        "loglevel=0"
        "random.trust_cpu=off"
        "random.trust_bootloader=off"
        "intel_iommu=on"
        "amd_iommu=force_isolation"
        "iommu=force"
        "iommu.strict=1"
      ];

      blacklistedKernelModules = [
        "ax25"
        "netrom"
        "rose"

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
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
        "reiser4"

        "cfg80211"
        "intel_agp"
        "joydev"
        "mousedev"
        "psmouse"
        "virtio_balloon"
        "virtio_console"
        "amd76x_edac"
        "ath_pci"
        "evbug"
        "pcspkr"
        "snd_aw2"
        "snd_intel8x0m"
        "snd_pcsp"
        "usbkbd"
        "usbmouse"
      ];

      kernel.sysctl = {
        "kernel.yama.ptrace_scope" = "3";
        "kernel.sysrq" = "0";
        "fs.binfmt_misc.status" = "0";
        "kernel.io_uring_disabled" = "2";

        "net.ipv4.ip_forward" = "0";
        "net.ipv4.conf.all.forwarding" = "0";
        "net.ipv4.conf.default.forwarding" = "0";
        "net.ipv6.conf.all.forwarding" = "0";
        "net.ipv6.conf.default.forwarding" = "0";
        "net.ipv4.tcp_timestamps" = "0";
        "dev.tty.ldisc_autoload" = "0";
        "fs.protected_fifos" = "2";
        "fs.protected_hardlinks" = "1";
        "fs.protected_regular" = "2";
        "fs.protected_symlinks" = "1";
        "fs.suid_dumpable" = "0";
        "kernel.dmesg_restrict" = "1";
        "kernel.kexec_load_disabled" = "1";
        "kernel.kptr_restrict" = "2";
        "kernel.perf_event_paranoid" = "3";
        "kernel.printk" = "3 3 3 3";
        "kernel.unprivileged_bpf_disabled" = "1";
        "net.core.bpf_jit_harden" = "2";
        "net.ipv4.conf.all.accept_redirects" = "0";
        "net.ipv4.conf.all.accept_source_route" = "0";
        "net.ipv4.conf.all.rp_filter" = "1";
        "net.ipv4.conf.all.secure_redirects" = "0";
        "net.ipv4.conf.all.send_redirects" = "0";
        "net.ipv4.conf.default.accept_redirects" = "0";
        "net.ipv4.conf.default.accept_source_route" = "0";
        "net.ipv4.conf.default.rp_filter" = "1";
        "net.ipv4.conf.default.secure_redirects" = "0";
        "net.ipv4.conf.default.send_redirects" = "0";
        "net.ipv4.icmp_echo_ignore_all" = "1";
        "net.ipv6.icmp_echo_ignore_all" = "1";
        "net.ipv4.tcp_dsack" = "0";
        "net.ipv4.tcp_fack" = "0";
        "net.ipv4.tcp_rfc1337" = "1";
        "net.ipv4.tcp_sack" = "0";
        "net.ipv4.tcp_syncookies" = "1";
        "net.ipv6.conf.all.accept_ra" = "0";
        "net.ipv6.conf.all.accept_redirects" = "0";
        "net.ipv6.conf.all.accept_source_route" = "0";
        "net.ipv6.conf.default.accept_redirects" = "0";
        "net.ipv6.conf.default.accept_source_route" = "0";
        "net.ipv6.default.accept_ra" = "0";
        "kernel.core_pattern" = "|/bin/false";
        "vm.mmap_rnd_bits" = "32";
        "vm.mmap_rnd_compat_bits" = "16";
        "vm.unprivileged_userfaultfd" = "0";
        "net.ipv4.icmp_ignore_bogus_error_responses" = "1";

        "kernel.randomize_va_space" = "2";
        "kernel.perf_cpu_time_max_percent" = "1";
        "kernel.perf_event_max_sample_rate" = "1";

        "vm.mmap_min_addr" = "65536";

        "net.ipv4.conf.default.log_martians" = "1";
        "net.ipv4.conf.all.log_martians" = "1";
        "net.ipv4.conf.default.shared_media" = "0";
        "net.ipv4.conf.all.shared_media" = "0";
        "net.ipv4.conf.default.arp_announce" = "2";
        "net.ipv4.conf.all.arp_announce" = "2";
        "net.ipv4.conf.default.arp_ignore" = "1";
        "net.ipv4.conf.all.arp_ignore" = "1";
        "net.ipv4.conf.default.drop_gratuitous_arp" = "1";
        "net.ipv4.conf.all.drop_gratuitous_arp" = "1";
        "net.ipv4.icmp_echo_ignore_broadcasts" = "1";

        "net.ipv6.conf.default.router_solicitations" = "0";
        "net.ipv6.conf.all.router_solicitations" = "0";
        "net.ipv6.conf.default.accept_ra_rtr_pref" = "0";
        "net.ipv6.conf.all.accept_ra_rtr_pref" = "0";
        "net.ipv6.conf.default.accept_ra_pinfo" = "0";
        "net.ipv6.conf.all.accept_ra_pinfo" = "0";
        "net.ipv6.conf.default.accept_ra_defrtr" = "0";
        "net.ipv6.conf.all.accept_ra_defrtr" = "0";
        "net.ipv6.conf.default.autoconf" = "0";
        "net.ipv6.conf.all.autoconf" = "0";
        "net.ipv6.conf.default.dad_transmits" = "0";
        "net.ipv6.conf.all.dad_transmits" = "0";
        "net.ipv6.conf.default.max_addresses" = "1";
        "net.ipv6.conf.all.max_addresses" = "1";
        "net.ipv6.icmp.echo_ignore_all" = "1";
        "net.ipv6.icmp.echo_ignore_anycast" = "1";
        "net.ipv6.icmp.echo_ignore_multicast" = "1";
      };

      specialFileSystems = {
        "/dev/shm" = {
          fsType = "tmpfs";
          options = [
            "nosuid"
            "nodev"
            "noexec"
            "strictatime"
            "mode=1777"
            "size=${config.boot.devShmSize}"
          ];
        };

        "/run" = {
          fsType = "tmpfs";
          options = [
            "nosuid"
            "nodev"
            "noexec"
            "strictatime"
            "mode=755"
            "size=${config.boot.runSize}"
          ];
        };

        "/dev" = {
          fsType = "devtmpfs";
          options = [
            "nosuid"
            "noexec"
            "strictatime"
            "mode=755"
            "size=${config.boot.devSize}"
          ];
        };

        "/proc" = {
          fsType = "proc";
          device = "proc";
          options = [
            "nosuid"
            "nodev"
            "noexec"
            "hidepid=4"
            "gid=proc"
          ];
        };
      };
    };

    security = {
      protectKernelImage = true;
      forcePageTableIsolation = true;
      unprivilegedUsernsClone = true; # Chromium sandboxing workaround, maybe a little security hole
      virtualisation.flushL1DataCache = "always";
      pam = {
        loginLimits = [
          {
            domain = "*";
            item = "core";
            type = "hard";
            value = "0";
          }
        ];
        services = {
          passwd.text = ''
            password required pam_unix.so sha512 shadow nullok rounds=65536
          '';
          login.text = lib.mkDefault (
            lib.mkBefore ''
              # Enable securetty support.
              auth       requisite  pam_nologin.so
              auth       requisite  pam_securetty.so
            ''
          );

          su.requireWheel = true;
          su-l.requireWheel = true;
          system-login.failDelay.delay = "4000000";
        };
      };
    };

    services.jitterentropy-rngd.enable = true;

    hardware.bluetooth.settings = {
      General = {
        PairableTimeout = 30;
        DiscoverableTimeout = 30;
        MaxControllers = 1;
        TemporaryTimeout = 0;
      };

      Policy = {
        AutoEnable = false;
        Privacy = "network/on";
      };
    };

    environment.etc = {
      securetty.text = ''
        # /etc/securetty: list of terminals on which root is allowed to login.
        # See securetty(5) and login(1).
      '';
    };

    fileSystems = {
      "/root" = {
        device = "/root";
        options = [
          "bind"
          "nosuid"
          "noexec"
          "nodev"
        ];
      };

      "/tmp" = {
        device = "/tmp";
        options = [
          "bind"
          "nosuid"
          "nodev"
        ];
      };

      "/var" = {
        device = "/var";
        options = [
          "bind"
          "nosuid"
          "nodev"
        ];
      };

      "/srv" = {
        device = "/srv";
        options = [
          "bind"
          "nosuid"
          "noexec"
          "nodev"
        ];
      };

      "/etc" = {
        device = "/etc";
        options = [
          "bind"
          "nosuid"
          "nodev"
        ];
      };
    };

    users.groups.proc = { };

    systemd = {
      services = {
        systemd-logind.serviceConfig.SupplementaryGroups = [ "proc" ];
        "user@".serviceConfig.SupplementaryGroups = [ "proc" ];
      };
      coredump.extraConfig = lib.mkDefault ''
        Storage=none
      '';
      network.config.networkConfig.IPv6PrivacyExtensions = lib.mkDefault "kernel";
      tmpfiles.settings = {
        "restricthome"."/home/*".Z.mode = "0700";

        "restrictetcnixos"."/etc/nixos/*".Z = {
          mode = "0000";
          user = "root";
          group = "root";
        };
      };
    };
  };
}

