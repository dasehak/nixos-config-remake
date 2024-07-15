{ inputs
, stateVersion
, ...
}:

let
     printMessage = ''
        ${builtins.toString "\n\Here is text for the context:\n"}
     '';
    in
{
  # Helper function for generating home-manager configs
  mkHome = { username ? "dasehak", hostname ? "nixos", isWorkstation ? false, platform ? "x86_64-linux" }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit inputs platform username hostname stateVersion isWorkstation;
      };

      modules = [
        ../home
      ];
    };

  # Helper function for generating host configs
  mkHost = { hostname ? "nixos", username ? "dasehak", isWorkstation ? false, platform ? "x86_64-linux" }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs hostname username platform stateVersion isWorkstation;
      };

      modules = [
        ../system
      ];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "i686-linux"
    "x86_64-linux"
  ];
}
