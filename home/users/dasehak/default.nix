{ pkgs
, inputs
, config
, isWorkstation
, lib
, ...
}:


with lib;

let
  inherit (pkgs.stdenv) isLinux;
in
{
  imports = [
    ../../../modules/nix
    # ../../modules/ssh
    ../../modules
  ];

  nixpkgs.overlays = [
    (import ../../overlays/vesktop)
    (import ../../overlays/catppuccin-papirus-folders)
  ];

  #stylix.targets = {
  #  vscode.enable    = false;
  #  kde.enable       = false;
  #  hyprland.enable  = false;
  #  hyprpaper.enable = false;
  #};

  module = {
    firefox.enable = isLinux && isWorkstation;

    git.enable = true;
    btop.enable = true;
    fastfetch.enable = true;
    nvim.enable = true;
    fish.enable = true;
    vscode.enable = true;
    eza.enable = true;
    hyprland.enable = false;
    waybar.enable = false;
    wofi.enable = false;
    qt.enable = false;
    arrpc.enable = true;
    obs-studio.enable = true;
    syncthing.enable = true;
    plasma.enable = true;
    flatpak.enable = true;
    usbguard-notifier.enable = true;


    nix-config = {
      enable = true;
      useNixPackageManagerConfig = true;
      useGarbageCollection = false;
    };
  };

  catppuccin.enable = true;
  services.nextcloud-client = {
      enable = true;
      startInBackground = true;
  };

  home = {
    # Software
    packages = with pkgs; [
      # Utils
      bat
      ffmpeg
      imagemagick

      # Security
      age
      sops
      git-agecrypt
      grype
      syft
      veracrypt
    ] ++ lib.optionals isWorkstation [
      # Text Editors
      obsidian

      # Misc
      yt-dlp

      # Security
      semgrep
    ] ++ lib.optionals (isLinux && isWorkstation) [
      # 3D
      inputs.nixpkgs-blender-3-6-5.legacyPackages.${pkgs.system}.blender-hip

      # Gaming
      winetricks
      mangohud

      inputs.nix-gaming.packages.${pkgs.system}.wine-ge
      # inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge
      openttd
      warzone2100
      xonotic-glx
      mindustry
      gzdoom
      superTuxKart
      prismlauncher
      minetest
      openra
      steam-run
      fallout-ce
      heroic

      # Dev
      vscode
      godot_4
      direnv
      nix-direnv
      nixd
      nixpkgs-fmt
      lazarus-qt6

      # Chats
      inputs.nixpkgs-materialgram.legacyPackages.${pkgs.system}.materialgram
      vesktop
      element-desktop
      mumble

      # Icons
      catppuccin-papirus-folders

      # Office
      onlyoffice-bin
      libreoffice-qt6-fresh

      # Misc
      keepassxc
      bandwhich
      hyperfine
      tgpt
      strawberry
      krita
      kdenlive
      nicotine-plus
      killall
      qbittorrent
      wget
      unrar
      nekoray
      flatpak
      python313
      woeusb-ng
      ventoy-full
      clang
      noto-fonts
      noto-fonts-color-emoji
      aseprite

      udftools # TODO
      syncthingtray
    ];
  };
}

