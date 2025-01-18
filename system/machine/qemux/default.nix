{ inputs
, ...
}:

{
  imports = [
    ../../modules
    ./modules/hardware
  ];

  module = {
    locales.enable = true;
    network.enable = true;
    timedate.enable = true;
    users.enable = true;
    variables.enable = true;

    programs = {
      systemPackages.enable = true;
    };

    security = {
      hardening.enable = true;
      apparmor.enable = true;
    };

    services = {
      plasma.enable = true;
      xserver.enable = true;
      zram.enable = true;
      libinput.enable = true;
    };
  };
}

