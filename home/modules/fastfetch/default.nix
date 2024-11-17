{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.fastfetch;
in {
  options = {
    module.fastfetch.enable = mkEnableOption "Enables fastfetch";
  };

  config = mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
    };
  };
}