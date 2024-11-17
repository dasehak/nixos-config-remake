{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.libinput;
in {
  options = {
    module.services.libinput.enable = mkEnableOption "Enable libinput";
  };

  config = mkIf cfg.enable {
    services.libinput.enable = true;
  };
}

