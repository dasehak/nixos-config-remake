{ pkgs
, lib
, config
, inputs
, ...
}:

with lib;

let
  cfg = config.module.programs.xdg-portal;
in {
  options = {
    module.programs.xdg-portal.enable = mkEnableOption "Enable xdg-portal";
  };

  config = mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = "*";
      };

      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-hyprland
      ];
    };
  };
}

