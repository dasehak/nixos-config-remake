{ inputs
, lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.nix-config;
  inherit (pkgs.stdenv) isLinux;
in {
  options = {
    module.nix-config = {
      enable = mkEnableOption "Enables nix-config";

      useNixPackageManagerConfig = mkOption {
        type = types.bool;
        description = "Whether to use custom Nix package manager settings.";
        default = true;
      };

      useGarbageCollection = mkOption {
        type = types.bool;
        description = "Whether to use garbage collection and other storage optimisations.";
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.nur.overlay
      ];
    };

    nix = optionalAttrs cfg.useNixPackageManagerConfig ({
      registry.s.flake = inputs.self;
      package = pkgs.lix;

      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        substituters = [
          "http://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://nyx.chaotic.cx/"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        ];
        trusted-users = [
          "root"
          "dasehak"
        ];
      };
    } // optionalAttrs cfg.useGarbageCollection {
      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
      } // optionalAttrs isLinux {
        dates = "daily";
      };
    });
  };
}