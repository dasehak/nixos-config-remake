{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.xserver;
in {
  options = {
    module.services.xserver.enable = mkEnableOption "Enable xserver";
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}

