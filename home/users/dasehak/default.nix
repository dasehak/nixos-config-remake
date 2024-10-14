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
    vscode.enable    = false;
    kde.enable       = false;
    hyprland.enable  = false;
    hyprpaper.enable = false;
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
    plasma.enable         = true;
    flatpak.enable        = true;

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
      openttd
      warzone2100
      xonotic-glx
      mindustry
      gzdoom
      superTuxKart

      # Dev
      vscode
      godot_4
      direnv
      nix-direnv
      nixd
      nixpkgs-fmt
      android-studio

      # Chats
      materialgram
      vesktop
      # cinny-desktop
      element-desktop
      mumble
      # nur.repos.mur.ayugram-desktop
      inputs.ayugram-desktop.packages.${pkgs.system}.default

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
      krita
      kdenlive
      nicotine-plus
      killall
      qbittorrent
      wget
      unrar
      nekoray
      gparted
      steam-run
      flatpak
    ];
  };
}

