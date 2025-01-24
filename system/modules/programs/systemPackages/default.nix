{ pkgs
, lib
, config
, isWorkstation
, ...
}:

with lib;

let
  cfg = config.module.programs.systemPackages;

  nerdfonts = builtins.filter pkgs.lib.isDerivation (builtins.attrValues pkgs.nerd-fonts);
in
{
  options = {
    module.programs.systemPackages.enable = mkEnableOption "Enable System Software";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      corefonts
    ] ++ nerdfonts;

    services.tailscale.enable = true;
    virtualisation.vmware.host.enable = true;
    networking.wireguard.enable = true;
    system.switch = {
      enable = lib.mkForce false;
      enableNg = true;
    };
    catppuccin.flavor = "mocha";
    catppuccin.enable = true;
    services.sunshine.enable = true;
    services.sunshine.capSysAdmin = true;
    services.sunshine.openFirewall = true;
    services.freenet.enable = true;
    systemd.oomd.enableRootSlice = true;
    systemd.oomd.enableSystemSlice = true;
    systemd.oomd.extraConfig = { DefaultMemoryPressureDurationSec = "20s"; };

    environment.systemPackages = with pkgs; [
      # Utils
      git
      home-manager
      nix-output-monitor
      curl
      wget
      tree
      file
      zip
      unzip

      # Hardware utils
      glxinfo
      pciutils
      usbutils
      powertop
      lm_sensors
      strace
      ltrace
      lsof
      sysstat
      cpufetch
      sbctl
      smartmontools

      # Network
      inetutils
      wireguard-tools
      dig
      nmap
      dnsutils
      iperf3
      mtr
      ipcalc
      cacert
      iptables-legacy
    ] ++ optionals isWorkstation [
      # Hardware
      microcodeIntel
      libGL

      # Hardware utils
      libva-utils
      fwupd
      fwupd-efi
    ];
  };
}

