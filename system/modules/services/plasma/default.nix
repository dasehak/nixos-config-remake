{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.plasma;
in
{
  options = {
    module.services.plasma.enable = mkEnableOption "Enable KDE Plasma";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (import ../../../overlays/catppuccin-sddm)
    ];

    services = {
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          theme = "catppuccin-mocha";
          wayland = {
            enable = true;
            compositor = "kwin";
          };
        };
        defaultSession = "plasma";
      };
    };

    programs = {
      partition-manager.enable = true;
    };

    environment.systemPackages = with pkgs; [
      catppuccin-sddm
    ];
  };
}
