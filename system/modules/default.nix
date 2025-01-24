{ inputs
, ...
}:

with inputs;

{
  imports = [
    chaotic.nixosModules.default
    fps.nixosModules.programs-sqlite
    catppuccin.nixosModules.catppuccin

    #stylix.nixosModules.stylix
    #../../modules/stylix

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

