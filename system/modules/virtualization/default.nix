{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.virtualisation;
in {
  options = {
    module.virtualisation.enable = mkEnableOption "Enables virtualisation";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker.enable = true;
      libvirtd.enable = true;
      virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
      };
    };

    programs.virt-manager.enable = true;
  };
}
