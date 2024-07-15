{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.programs.steam;
in {
  options = {
    module.programs.steam.enable = mkEnableOption "Enable Steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
