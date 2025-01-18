{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.fish;
in
{
  options = {
    module.fish.enable = mkEnableOption "Enables fish";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}

