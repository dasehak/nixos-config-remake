{ inputs
, ...
}:

{
  imports = [
    inputs.chaotic.nixosModules.default
    inputs.sops-nix.nixosModules.sops

    inputs.stylix.nixosModules.stylix
    ../../modules/stylix

    ./locales
    ./network
    ./programs
    ./security
    ./services
    ./timedate
    ./users
    ./variables
    ./virtualization
  ];
}

