{ inputs
, ...
}:

{
  imports = [
    inputs.chaotic.nixosModules.default

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

