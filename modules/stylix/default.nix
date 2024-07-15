{ inputs
, pkgs
, config
, hostname
, ...
}:

let
  theme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  wallpaper = pkgs.fetchFromGitHub {
    owner = "hyprwm";
    repo = "Hyprland";
    rev = "0e87a08e15c023325b64920d9e1159f38a090695";
    sha256 = "sha256-gM4cDw45J8mBmM0aR5Ko/zMAA8UWnQhc4uZ5Ydvc4uo=";
  } + "/assets/wall2.png";
  fontsPackage = pkgs.noto-fonts;
  cursorSize = 24;
in {
  stylix = {
    enable = true;
    image = wallpaper;
    autoEnable = true;
    polarity = "dark";

    base16Scheme = theme;

    cursor = {
      size = cursorSize;
    };

    fonts = {
      emoji = { name = "Noto Emoji"; package = pkgs.noto-fonts-color-emoji; };
      monospace = { name = "Noto Sans Mono"; package = fontsPackage; };
      sansSerif = { name = "Noto Sans"; package = fontsPackage; };
      serif = { name = "Noto Serif"; package = fontsPackage; };

      sizes = {
        applications = 10;
        terminal     = 10;
        popups       = 10;
        desktop      = 10;
      };
    };
  };
}

