{ config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.hyprland.binds;

  mainMod       = "Super";
  terminal      = "${pkgs.alacritty}/bin/alacritty";
  fileManager   = "${pkgs.cinnamon.nemo}/bin/nemo";
  menu          = "${pkgs.wofi}/bin/wofi --show drun";
in {
  options = {
    module.hyprland.binds.enable = mkEnableOption "Enables binds in Hyprland";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "${mainMod}, Q, exec, ${terminal}"
        "${mainMod}, C, killactive,"
        "${mainMod}, M, exit,"
        "${mainMod}, E, exec, ${fileManager}"
        "${mainMod}, V, togglefloating,"
        "${mainMod}, F, fullscreen, 0"
        "L_Alt, Space, exec, ${menu}"
        "${mainMod}, P, pseudo,"
        "${mainMod}, J, togglesplit,"

        "${mainMod}, left, movefocus, l"
        "${mainMod}, right, movefocus, r"
        "${mainMod}, up, movefocus, u"
        "${mainMod}, down, movefocus, d"
	      "${mainMod}, S, togglespecialworkspace, magic"
        "${mainMod} SHIFT, S, movetoworkspace, special:magic"

        "${mainMod}, mouse_down, workspace, e+1"
        "${mainMod}, mouse_up, workspace, e-1"

        "L_Alt, Tab, cyclenext,"
        "L_Alt, Tab, bringactivetotop,"
      ]
      ++ (
        builtins.concatLists (
          builtins.genList (
            x: let
            ws = let
            c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
            in [
              "${mainMod}, ${ws}, workspace, ${toString (x + 1)}"
              "${mainMod} SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
        10)
      );
      bindm = [
          "${mainMod}, mouse:272, movewindow"
          "${mainMod}, mouse:273, resizewindow"
      ];
      windowrulev2 = [
        "float,class:.*"
      ];
    };
  };
}