{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.sshd;
in
{
  options = {
    module.services.sshd.enable = mkEnableOption "Enable sshd";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      allowSFTP = true;
      ports = [ 5487 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        X11Forwarding = false;
        PermitRootLogin = "no";
        LogLevel = "VERBOSE";
      };
      extraConfig = ''
        AllowTcpForwarding no
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
        AuthenticationMethods publickey
        ClientAliveCountMax 2
        MaxAuthTries 3
        MaxSessions 2
        TCPKeepAlive no
      '';
    };
  };
}
