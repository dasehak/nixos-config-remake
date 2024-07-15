{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.vscode;
in {
  options = {
    module.vscode.enable = mkEnableOption "Enables VSCode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
    };
  };
}