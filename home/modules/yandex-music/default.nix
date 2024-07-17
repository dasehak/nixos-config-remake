{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.yandex-music;
in {
  options = {
    module.yandex-music.enable = mkEnableOption "Enables yandex-music";
  };

  config = mkIf cfg.enable {
    programs.yandex-music = {
      enable = true;
      tray.enable = true;
    };
  };
}