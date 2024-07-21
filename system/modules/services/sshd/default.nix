{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.sshd;
in {
  options = {
    module.services.sshd.enable = mkEnableOption "Enable sshd";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      passwordAuthentication = false;
      allowSFTP = false; # Don't set this if you need sftp
      challengeResponseAuthentication = false;
      extraConfig = ''
        AllowTcpForwarding yes
        X11Forwarding no
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
        AuthenticationMethods publickey
        PermitRootLogin no
      '';
    };
  };
}
