{ pkgs
, lib

, hostname
, platform
, stateVersion ? null
, ...
}:

{
  imports = [
    ../modules/nix
  ]
  ++ lib.optional (builtins.pathExists (./. + "/machine/${hostname}")) ./machine/${hostname};

  module.nix-config.enable = true;

  system.stateVersion = stateVersion;
  nixpkgs.hostPlatform = platform;
}

