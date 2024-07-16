{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.security.sudo;
in {
  options = {
    module.security.sudo.enable = mkEnableOption "Enables sudo";
  };

  config = mkIf cfg.enable {
    security = {
      sudo.enable = false;
      sudo-rs = {
        enable = true;
        execWheelOnly = true;
      };
    };
  };
}
