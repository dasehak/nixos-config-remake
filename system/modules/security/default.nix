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
    ./secure-dns
  ];

  module.security = {
    sudo.enable = mkDefault true;
    sops.enable = mkDefault true;
    secure-dns.enable = mkDefault true;
  };
}
