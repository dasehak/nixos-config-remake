{ inputs
, ...
}:

with inputs;

{
  imports = [
    #stylix.homeManagerModules.stylix
    #../../modules/stylix
    
    nix-flatpak.homeManagerModules.nix-flatpak
    ../../modules/stylix

    ./firefox
    ./git
    ./btop
    ./neovim
    ./fish
    ./fastfetch
    ./eza
    ./vscode
    ./hyprland
    ./waybar
    ./wofi
    ./qt
    ./arrpc
    ./obs-studio
    ./syncthing
    ./plasma
    ./flatpak
  ];
}

