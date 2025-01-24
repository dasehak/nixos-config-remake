{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.syncthing;
in
{
  options = {
    module.syncthing.enable = mkEnableOption "Enables Syncthing"; # TODO: add tray as option
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      tray = {
        enable = false;
        package = pkgs.syncthingtray;
      };
    };
  };
}
