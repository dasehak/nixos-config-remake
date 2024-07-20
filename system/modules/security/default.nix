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
    ./antivirus
  ];

  module.security = {
    hardening.enable = mkDefault false;
    apparmor.enable  = mkDefault false;
    sudo.enable      = mkDefault true;
    sops.enable      = mkDefault true;
    antivirus.enable = mkDefault false;
  };
}
