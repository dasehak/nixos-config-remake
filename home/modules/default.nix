{ inputs
, ...
}:

with inputs;

{
  imports = [
    stylix.homeManagerModules.stylix
    nur.hmModules.nur
    yandex-music.homeManagerModules.default
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
    ./yandex-music
    ./plasma
    ./flatpak
  ];
}

