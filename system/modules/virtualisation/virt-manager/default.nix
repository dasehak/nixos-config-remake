{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.virtualisation.virt-manager;
in
{
  options = {
    module.virtualisation.virt-manager.enable = mkEnableOption "Enables virt-manager";
  };

  config = mkIf cfg.enable {
    programs.virt-manager.enable = true;
  };
}
