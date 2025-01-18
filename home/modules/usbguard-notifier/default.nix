{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.usbguard-notifier;
in
{
  options = {
    module.usbguard-notifier.enable = mkEnableOption "Enables usbguard-notifier";
  };

  config = mkIf cfg.enable {
    systemd.user.services.usbguard-notifier = {
      Unit = {
        Description = "Starts usbguard-notifier.";
        After = [ "usbguard.service" ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
      Service = {
        ExecStart = "${pkgs.usbguard-notifier}/bin/usbguard-notifier";
      };
    };
  };
}

