{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.qt;
in {
  options = {
    module.qt.enable = mkEnableOption "Enables Qt theming";
  };

  config = mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme = "qtct";
      style.name = "kvantum";
    };
  };
}