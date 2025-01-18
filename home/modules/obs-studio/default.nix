{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.obs-studio;
in
{
  options = {
    module.obs-studio.enable = mkEnableOption "Enables obs-studio";
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
        obs-vkcapture
        obs-pipewire-audio-capture
      ];
    };
  };
}

