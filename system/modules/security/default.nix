{ lib
, ...
}:

with lib;

{
  imports = [
    ./hardening
    ./apparmor
    ./sudo
    ./sops
  ];

  module.security = {
    hardening.enable = mkDefault false;
    apparmor.enable  = mkDefault false;
    sudo.enable      = mkDefault true;
    sops.enable      = mkDefault true;
  };
}
