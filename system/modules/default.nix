{ inputs
, ...
}:

with inputs;

{
  imports = [
    chaotic.nixosModules.default
    sops-nix.nixosModules.sops
    fps.nixosModules.programs-sqlite

    stylix.nixosModules.stylix
    ../../modules/stylix

    ./locales
    ./network
    ./programs
    ./security
    ./services
    ./timedate
    ./users
    ./variables
    ./virtualisation
  ];
}

