{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.wofi;
in {
  options = {
    module.wofi.enable = mkEnableOption "Enables wofi";
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };
  };
}