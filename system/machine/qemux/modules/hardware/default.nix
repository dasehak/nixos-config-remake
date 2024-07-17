_:

{
  imports = [
    "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"

    ./extra-hardware
    ./graphics-card
    ./network
    ./kernel
    ./sound
    ./boot
    ./disks
  ];
}

