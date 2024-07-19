{ inputs
, ...
}:

with inputs;

{
  imports = [
    disko.nixosModules.disko
    impermanence.nixosModules.impermanence

    ./extra-hardware
    ./graphics-card
    ./network
    ./kernel
    ./sound
    ./boot
    ./disks
    ./impermanence
  ];
}

