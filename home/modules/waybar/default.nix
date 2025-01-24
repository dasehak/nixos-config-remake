{ lib
, config
, ...
}:

with lib;

let
  cfg = config.module.waybar;
in
{
  options = {
    module.waybar.enable = mkEnableOption "Enables waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "bottom";
          height = 24;
          modules-left = [ "wlr/taskbar" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "battery" "clock" ];
          "hyprland/window" = {
            max-length = 50;
          };
          "wlr/taskbar" = {
            on-click = "activate";
            icon-size = 24;
          };
          battery = {
            format = "{capacity}% {icon}";
            format-icons = [ "" "" "" "" "" ];
          };
          clock = {
            format-alt = "{:%a, %d. %b  %H:%M}";
          };
        };
      };
    };
  };
}
