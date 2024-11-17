{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.timedate;
in {
  options = {
    module.timedate.enable = mkEnableOption "Enables timedate";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/Moscow";
    services.timesyncd.enable = true;
  };
}

