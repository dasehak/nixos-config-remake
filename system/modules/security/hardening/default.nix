{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.security.hardening;
in {
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
      kernelPackages = if cfg.cachyosKernel then pkgs.linuxPackages_cachyos-hardened else pkgs.linuxPackages_6_9_hardened;

      kernelModules = [
        "lkrg"
      ];

      kernelParams = [
        # Security settings
        "debugfs=off"
        "page_alloc.shuffle=1"
        "page_poison=1"
        "slab_nomerge"
        "init_on_alloc=1"
        "init_on_free=1"
        "page_alloc.shuffle=1"
        "randomize_kstack_offset=on"
        "vsyscall=none"
        "random.trust_cpu=off"
      ];

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
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
        "ufs"
      ];

      kernel.sysctl = {
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

        "net.ipv4.conf.all.forwarding" = false;
        "net.ipv4.tcp_rfc1337" = true;
        "net.ipv4.icmp_echo_ignore_all" = true;
        "net.ipv4.tcp_sack" = false;
        "net.ipv4.tcp_dsack" = false;

        "net.ipv6.conf.all.accept_ra" = false;
        "net.ipv6.conf.default.accept_ra" = false;

        "dev.tty.ldisc_autoload" = false;

        "kernel.yama.ptrace_scope" = 2;
        "kernel.sysrq" = 0;
        "kernel.unprivileged_bpf_disabled" = true;
        "kernel.printk" = "3 3 3 3";
        "kernel.kexec_load_disabled" = true;

        "fs.protected_fifos" = 2;
        "fs.protected_regular" = 2;
        "fs.suid_dumpable" = false;

        "vm.unprivileged_userfaultfd" = false;
        "vm.mmap_rnd_bits" = 32;
        "vm.mmap_rnd_compat_bits" = 16;
      };
    };

    security = {
      protectKernelImage = true;
      forcePageTableIsolation = true;
      unprivilegedUsernsClone = true; # Chromium sandboxing workaround, maybe a little security hole
      virtualisation.flushL1DataCache = "always";
    };
  };
}

