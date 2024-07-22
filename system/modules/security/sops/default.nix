{ lib
, config
, hostname
, ...
}:

with lib;

let
  cfg = config.module.security.sops;
in {
  options = {
    module.security.sops.enable = mkEnableOption "Enables sops's keys";
  };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../../../secrets/sops/secrets.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      secrets.nyax_usb_rules = {};
    };
  };
}
