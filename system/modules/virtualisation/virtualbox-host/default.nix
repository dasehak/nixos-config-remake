{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.virtualisation.virtualbox-host;
in {
  options = {
    module.virtualisation.virtualbox-host.enable = mkEnableOption "Enables VirtualBox host";
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
}
