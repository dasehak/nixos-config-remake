{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.virtualisation.libvirtd;
in
{
  options = {
    module.virtualisation.libvirtd.enable = mkEnableOption "Enables libvirtd";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
  };
}
