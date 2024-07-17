{ inputs
, ...
}:

with inputs;

{
  imports = [
    disko.nixosModules.disko

    ./extra-hardware
    ./graphics-card
    ./network
    ./kernel
    ./sound
    ./boot
    ./disks
  ];
}

