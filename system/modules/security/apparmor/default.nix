{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.security.apparmor;
in
{
  options = {
    module.security.apparmor.enable = mkEnableOption "Enables apparmor";
  };

  config = mkIf cfg.enable {
    security.apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = with pkgs; [
        apparmor-profiles
        roddhjav-apparmor-rules # I'm not sure if it's working
      ];
    };
  };
}
