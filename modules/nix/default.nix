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
in
{
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
          "dotnet-runtime-wrapped-6.0.36"
          "dotnet-runtime-6.0.36"
          "dotnet-sdk-wrapped-6.0.428"
          "dotnet-sdk-6.0.428"
        ];
        android_sdk.accept_license = true;
      };
      overlays = [
        inputs.nur.overlays.default
      ];
    };

    nix = optionalAttrs cfg.useNixPackageManagerConfig ({
      registry = {
        s.flake = inputs.self;
        nixpkgs.flake = inputs.nixpkgs;
        nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
        nixpkgs-stable.flake = inputs.nixpkgs-stable;
        nixpkgs-master.flake = inputs.nixpkgs-master;
        chaotic.flake = inputs.chaotic;
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
          "https://nix-community.cachix.org/"
          "https://chaotic-nyx.cachix.org/"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          "mur.cachix.org-1:VncNRWnvAh+Pl71texI+mPOiwTB5267t029meC4HBC0="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
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
