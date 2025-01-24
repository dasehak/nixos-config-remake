{ lib
, config
, inputs
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.nvim;
in
{
  options = {
    module.nvim.enable = mkEnableOption "Enables nvim";
  };
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = true;
      plugins = {
        lualine.enable = true;
        lsp = {
          enable = true;
          servers = {
            lua_ls.enable = true;
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
            clangd.enable = true;
          };
        };
        telescope.enable = true;
        web-devicons.enable = true;
      };
      opts = {
        number = true;
        shiftwidth = 4;
      };
      globals.mapleader = ",";
    };
  };
}

