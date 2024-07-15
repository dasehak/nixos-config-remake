{ inputs
, ...
}:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.nur.hmModules.nur
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
  ];
}

