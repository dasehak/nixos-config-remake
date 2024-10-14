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
        permittedInsecurePackages = [
          "olm-3.2.16"
          "cinny-4.1.0"
          "cinny-desktop-4.1.0"
          "cinny-unwrapped-4.1.0"
        ];
        android_sdk.accept_license = true;
      };
      overlays = [
        inputs.nur.overlay
      ];
    };

    nix = optionalAttrs cfg.useNixPackageManagerConfig ({
      registry = {
        s.flake = inputs.self;
        nixpkgs.flake = inputs.nixpkgs;
        nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
        nixpkgs-stable.flake = inputs.nixpkgs-stable;
        nixpkgs-master.flake = inputs.nixpkgs-master;
      };
      package = pkgs.lix;

      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        substituters = [
          "http://cache.nixos.org"
          "https://hyprland.cachix.org"
          "https://nix-gaming.cachix.org"
          "https://nyx.chaotic.cx/"
          "https://mur.cachix.org/"
          "https://cache.garnix.io"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
          "mur.cachix.org-1:VncNRWnvAh+Pl71texI+mPOiwTB5267t029meC4HBC0="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        ];
        trusted-users = [
          "root"
          "dasehak"
        ];
        allowed-users = [
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
