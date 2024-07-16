{ pkgs
, lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.users;
in {
  options = {
    module.users.enable = mkEnableOption "Enables users";
  };

  config = mkIf cfg.enable {
    users = {
      mutableUsers = true;

      users = {
        ${username} = {
          isNormalUser = true;
          description = "${username}";
          home = "/home/${username}";
          shell = pkgs.fish;

          extraGroups = [
            "audio"
            "networkmanager"
            "input"
          ] ++ (if username == "dasehak" then [
            "wheel"
            "docker"
            "libvirtd"
            "vboxusers"
          ]
          else []);
        };

        root = {
          shell = pkgs.fish;
        };
      };
    };
  };
}

