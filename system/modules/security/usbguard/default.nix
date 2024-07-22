{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.security.usbguard;
in {
  options = {
    module.security.usbguard = {
      enable = mkEnableOption "Enables usbguard";

      ruleFile = mkOption {
        type = types.path;
        description = "Path to USBGuard rules file.";
        default = null;
      };
    };
  };

  config = mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      ruleFile = cfg.ruleFile;
    };
  };
}
