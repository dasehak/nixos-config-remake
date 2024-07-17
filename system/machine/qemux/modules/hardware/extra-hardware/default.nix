{ lib
, pkgs
, config
, ...
}:

{
  hardware = {
    enableAllFirmware = true;

    firmware = with pkgs; [
      linux-firmware
    ];
  };
}

