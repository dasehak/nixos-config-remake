{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.git;
in {
  options = {
    module.git.enable = mkEnableOption "Enables git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "dasehak";
      userEmail = "dasehak@disroot.org";
    };
  };
}

