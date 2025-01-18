{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.bluetooth;
in
{
  options = {
    module.services.bluetooth.enable = mkEnableOption "Enable bluetooth";
  };

  config = mkIf cfg.enable {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            Enable = "Source,Sink,Media,Socket";
          };
        };
      };
    };
  };
}
