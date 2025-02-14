{ lib
, config
, username
, ...
}:

with lib;

let
  cfg = config.module.variables;
in
{
  options = {
    module.variables.enable = mkEnableOption "Enables variables";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # VDPAU_DRIVER = mkIf config.hardware.opengl.enable (mkDefault "va_gl");
      # MUFFIN_NO_SHADOWS = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      NIXPKGS_ALLOW_UNFREE = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_DESKTOP = "Hyprland";
      # WLR_RENDERER = "vulkan";
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      FLAKE = "/home/${username}/sources/nixos-config-remake";
      # QT_QPA_PLATFORMTHEME = "gtk3";
      TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY = "1";
    };
  };
}

