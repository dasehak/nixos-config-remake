{ lib
, config
, hostname
, inputs
, ...
}:

with lib;

let
  cfg = config.module.security.sops;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options = {
    module.security.sops.enable = mkEnableOption "Enables sops's keys";
  };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../../../secrets/sops/secrets.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      secrets.nyax_usb_rules = { };
    };
  };
}
