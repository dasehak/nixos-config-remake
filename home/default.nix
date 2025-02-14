{ pkgs
, lib
, username
, stateVersion
, ...
}:

let
  isRoot = if (username == "root") then true else false;
  homeDirectory = if isRoot then "/root" else "/home/${username}";
in
{
  programs.home-manager.enable = true;

  imports = lib.optional (builtins.pathExists (./. + "/users/${username}")) ./users/${username};

  home = {
    inherit username;
    inherit stateVersion;
    inherit homeDirectory;
  };
}

