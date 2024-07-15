{ pkgs
, lib
, config
, isWorkstation
, ...
}:

with lib;

let
  cfg = config.module.programs.systemPackages;
in {
  options = {
    module.programs.systemPackages.enable = mkEnableOption "Enable System Software";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      nerdfonts
      corefonts
    ];

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

