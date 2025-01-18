{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.vscode;
in
{
  options = {
    module.vscode.enable = mkEnableOption "Enables VSCode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        ms-vscode.cmake-tools
        twxs.cmake
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        eamodio.gitlens
        bbenoist.nix
        jnoortheen.nix-ide
        streetsidesoftware.code-spell-checker
      ];

      userSettings = {
        files = {
          trimTrailingWhitespace = true;
          autoSave = "afterDelay";
        };
        workbench = {
          iconTheme = "catppuccin-perfect-mocha";
          colorTheme = "Catppuccin Mocha";
        };
        git.autofetch = true;
        window.titleBarStyle = "custom";
      };
    };
  };
}
