{ lib
, pkgs
, config
, ...
}:

{
  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    firmware = with pkgs; [
      linux-firmware
    ];
  };
}

