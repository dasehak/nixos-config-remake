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
      mutableUsers = false;

      users = {
        ${username} = (mkMerge [{
          isNormalUser = true;
          description = "${username}";
          home = "/home/${username}";
          shell = pkgs.fish;

          extraGroups = [
            "audio"
            "networkmanager"
            "input"
          ];
        } (mkIf (username == "dasehak") {
          extraGroups = [
            "wheel"
            "docker"
            "libvirtd"
            "vboxusers"
          ];

          hashedPassword = "$6$5IZeCNcdDeFAW2xI$TcZuPTl.nqtsQpuNTqyzZmOaDyOdsLarbkeqbKjXO5UX80GNaAeVuuLB5iPZq90PdiyN0ru2eC7SiGxLoSvws.";
        })]);

        root = {
          shell = pkgs.fish;

          hashedPassword = "!";
        };
      };
    };
  };
}

