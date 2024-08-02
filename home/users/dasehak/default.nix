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
in {
  imports = [
    ../../../modules/nix
    # ../../modules/ssh
    ../../modules
  ];

  nixpkgs.overlays = [
    (import ../../overlays/vesktop)
    (import ../../overlays/catppuccin-papirus-folders)
  ];

  stylix.targets = {
    vscode.enable = false;
    kde.enable    = false;
  };

  module = {
    firefox.enable  = isLinux && isWorkstation;

    git.enable            = true;
    btop.enable           = true;
    fastfetch.enable      = true;
    nvim.enable           = false;
    fish.enable           = true;
    vscode.enable         = true;
    eza.enable            = true;
    hyprland.enable       = false;
    waybar.enable         = false;
    wofi.enable           = false;
    qt.enable             = false;
    arrpc.enable          = true;
    obs-studio.enable     = true;
    syncthing.enable      = true;
    yandex-music.enable   = false;

    nix-config = {
      enable                     = true;
      useNixPackageManagerConfig = true;
      useGarbageCollection       = false;
    };
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

      # Gayming
      winetricks
      mangohud
      inputs.pollymc.packages.${pkgs.system}.pollymc
      inputs.nix-gaming.packages.${pkgs.system}.wine-ge
      inputs.nix-gaming.packages.${pkgs.system}.wine-discord-ipc-bridge

      # Dev
      vscode
      zed-editor
      godot_4
      direnv
      nix-direnv
      nixd
      nixpkgs-fmt

      # Chats
      vesktop
      cinny-desktop
      mumble
      nur.repos.mur.ayugram-desktop

      # Icons
      catppuccin-papirus-folders

      # Office
      onlyoffice-bin

      # Misc
      keepassxc
      bandwhich
      nextcloud-client
      hyperfine
      tgpt
      strawberry
      tor-browser-bundle-bin
      krita
      kdenlive
      nicotine-plus
      killall
      qbittorrent
      wget
      unrar
      nekoray
      gparted
    ];
  };
}

