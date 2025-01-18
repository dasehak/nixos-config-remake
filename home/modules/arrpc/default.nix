{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.arrpc;
in
{
  options = {
    module.arrpc.enable = mkEnableOption "Enables arrpc";
  };

  config = mkIf cfg.enable {
    services.arrpc = {
      enable = true;
    };
  };
}
