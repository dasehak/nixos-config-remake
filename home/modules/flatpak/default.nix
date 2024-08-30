{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.flatpak;
in {
  options = {
    module.flatpak.enable = mkEnableOption "Enables flatpak";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;
      update.onActivation = true;
    };
  };
}

