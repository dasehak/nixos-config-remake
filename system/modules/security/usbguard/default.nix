{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.security.usbguard;
in {
  options = {
    module.security.usbguard.enable = mkEnableOption "Enables usbguard";
  };

  config = mkIf cfg.enable {
    services.usbguard = {
      enable = true;
    };
  };
}
