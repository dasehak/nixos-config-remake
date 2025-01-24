{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.security.antivirus;

  notifyAllUsers = pkgs.writeScript "notifyAllUsersAboutVirus"
    ''
      #!/bin/sh
      ALERT="Signature detected by clamav: $CLAM_VIRUSEVENT_VIRUSNAME in $CLAM_VIRUSEVENT_FILENAME"
      # Send an alert to all graphical users.
      for ADDRESS in /run/user/*; do
          USERID=''${ADDRESS#/run/user/}
         /run/wrappers/bin/sudo -u "#$USERID" DBUS_SESSION_BUS_ADDRESS="unix:path=$ADDRESS/bus" ${pkgs.libnotify}/bin/notify-send -i dialog-warning "Virus detected!" "$ALERT"
      done
    '';

  dirsToScan = [
    "/home/dasehak"
  ];

  securiteinfo_token = builtins.readFile ../../../../secrets/git/securiteinfo_token;
in
{
  options = {
    module.security.antivirus.enable = mkEnableOption "Enable antivirus";
  };

  config = mkIf cfg.enable {
    security.sudo = {
      extraConfig =
        ''
          clamav ALL=(ALL) NOPASSWD: SETENV: ${pkgs.libnotify}/bin/notify-send
        '';
    };
    services = {
      clamav = {
        scanner.enable = true;
        daemon = {
          enable = true;
          settings = {
            OnAccessIncludePath = dirsToScan;
            OnAccessExtraScanning = "yes";
            OnAccessExcludeUname = "clamav";
            VirusEvent = "${notifyAllUsers}";
            MaxRecursion = 32;
            MaxFileSize = "5G";
            MaxScanSize = "5G";
          };
        };
        updater = {
          enable = true;
          settings = {
            PrivateMirror = mkDefault "https://mirror.truenetwork.ru/clamav";
            DatabaseCustomURL = [
              "https://www.rfxn.com/downloads/rfxn.ndb"
              "https://www.rfxn.com/downloads/rfxn.hdb"
              "https://www.rfxn.com/downloads/rfxn.yara"
            ];
          };
        };
        fangfrisch = {
          enable = true;
          settings = {
            interserver.enabled = "yes";
            sanesecurity = {
              enabled = "yes";
              prefix = "https://mirror.rollernet.us/sanesecurity/";
            };
            securiteinfo = {
              enabled = "yes";
              customer_id = "${securiteinfo_token}";
            };
            urlhaus.enabled = "yes";
          };
        };
      };
    };
    systemd.services.clamav-clamonacc = {
      description = "ClamAV daemon (clamonacc)";
      after = [ "clamav-freshclam.service" ];
      wantedBy = [ "multi-user.target" ];
      restartTriggers = [ "/etc/clamav/clamd.conf" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.systemd}/bin/systemd-cat --identifier=av-scan ${pkgs.clamav}/bin/clamonacc -F --fdpass";
        PrivateTmp = "yes";
        PrivateDevices = "yes";
        PrivateNetwork = "yes";
      };
    };
  };
}
