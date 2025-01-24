{ inputs
, ...
}:

with inputs;

{
  imports = [
    #stylix.homeManagerModules.stylix
    #../../modules/stylix
    nur.modules.homeManager.default
    nix-flatpak.homeManagerModules.nix-flatpak
    catppuccin.homeManagerModules.catppuccin

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
    ./usbguard-notifier
  ];
}

