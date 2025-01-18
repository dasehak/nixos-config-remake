{ pkgs
, inputs
, ...
}:

{
  home = {
    # Software
    packages = with pkgs; [
      # Utils
      inputs.any-nix-shell
    ];
  };

  imports = [
    ../../../modules/nix
    ../../modules
  ];

  module = {
    git.enable = true;
    btop.enable = true;
    fastfetch.enable = true;
    # nvim.enable    = true;
    fish.enable = true;
    eza.enable = true;

    nix-config = {
      enable = true;
      useNixPackageManagerConfig = false;
    };
  };
}

