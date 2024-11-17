{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.virtualisation.docker;
in {
  options = {
    module.virtualisation.docker.enable = mkEnableOption "Enables Docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
