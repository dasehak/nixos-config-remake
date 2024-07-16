{ lib
, ...
}:

with lib;

{
  imports = [
    ./hardening
    ./apparmor
    ./sudo
  ];

  module.security = {
    hardening.enable = mkDefault false;
    apparmor.enable  = mkDefault false;
    sudo.enable      = mkDefault true;
  };
}
