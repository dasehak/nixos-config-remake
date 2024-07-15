{ inputs
, config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.hyprland;
in {
  imports = [
    ./binds
  ];

  options = {
    module.hyprland.enable = mkEnableOption "Enable Hyprland";
  };

  config = mkIf cfg.enable {
    module.hyprland = {
      binds.enable = mkDefault cfg.enable;
    };

    home.packages = with pkgs; [
      alacritty
      grimblast
      wl-clipboard
      hyprpicker
      waypaper
      imv
      dbus
      xdg-utils
      pavucontrol
      cinnamon.nemo
      networkmanagerapplet
      brightnessctl
      mpv
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;

      systemd = {
        enable = true;
        extraCommands = lib.mkBefore [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };

      settings = {
        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        ];

        exec-once = [ "waybar" ];

        animations = {
          enabled = true;
          bezier = [ "md3_decel, 0.05, 0.7, 0.1, 1" "workspace,0.17, 1.17, 0.3,1" ];

          animation = [
            "border, 1, 2, default"
            "fade, 1, 2, md3_decel"
            "windows, 1, 4, md3_decel, popin 60%"
            "workspaces, 1, 5, workspace, slidefadevert 8%"
          ];
        };

        xwayland = {
          force_zero_scaling = "true";
        };

        decoration = {
          rounding = 6;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };

          drop_shadow = "yes";
          shadow_range = 4;
          shadow_render_power = 3;
        };

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 1;
          layout = "dwindle";

          allow_tearing = false;
        };

        input = {
          kb_layout = "us,ru";
          kb_options = "grp:caps_toggle";
          accel_profile = "adaptive";
          sensitivity = 0.5;
          follow_mouse = 0;

          touchpad = {
            natural_scroll = true;
          };
        };

        misc = {
          disable_autoreload = false;
          focus_on_activate = false;
        };

        plugin = {
          hyprbars = {
            bar_height = 24;
            bar_color = "rgb(1e1e2e)";
            bar_part_of_window = true;
            bar_precedence_over_border = true;

            hyprbars-button = [
              "rgb(ff4040), 14, , hyprctl dispatch killactive"
              "rgb(eeee11), 14, , hyprctl dispatch fullscreen 1"
            ];
          };
        };
      };
      plugins = [
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        # inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];
    };
  };
}
