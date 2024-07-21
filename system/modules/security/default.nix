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
    ./usbguard
  ];

  module.security = {
    hardening.enable = mkDefault false;
    apparmor.enable  = mkDefault false;
    sudo.enable      = mkDefault true;
    sops.enable      = mkDefault true;
    antivirus.enable = mkDefault false;
    usbguard.enable  = mkDefault false;
  };
}
