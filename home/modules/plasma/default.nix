{ pkgs
, inputs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.plasma;
  wallpaper = pkgs.fetchFromGitHub
    {
      owner = "hyprwm";
      repo = "Hyprland";
      rev = "0e87a08e15c023325b64920d9e1159f38a090695";
      sha256 = "sha256-gM4cDw45J8mBmM0aR5Ko/zMAA8UWnQhc4uZ5Ydvc4uo=";
    } + "/assets/wall2.png";
in
{
  imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];

  options = {
    module.plasma.enable = mkEnableOption "Enables plasma-manager";
  };

  config = mkIf cfg.enable {
    programs.plasma = {
      enable = true;
      workspace = {
        clickItemTo = "select";
        cursor.theme = "Catppuccin-Mocha-Dark";
        lookAndFeel = "org.kde.breezedark.desktop";
        iconTheme = "Papirus-Dark";
        wallpaper = wallpaper;
        colorScheme = "CatppuccinMochaLavender";
      };
      panels = [
        {
          location = "bottom";
          widgets = [
            {
              kickoff = {
                icon = "nix-snowflake-white"; # CHANGEME
              };
            }
            {
              name = "org.kde.plasma.icontasks";
              config = {
                General = {
                  launchers = [
                    "applications:systemsettings.desktop"
                    "preferred://filemanager"
                    "preferred://browser"
                    "applications:vesktop.desktop"
                    "applications:org.kde.konsole.desktop"
                  ];
                  showOnlyCurrentActivity = false;
                  showOnlyCurrentDesktop = false;
                  showOnlyCurrentScreen = true;
                };
              };
            }
            "org.kde.plasma.marginsseparator"
            "org.kde.plasma.systemtray"
            {
              digitalClock = {
                calendar.firstDayOfWeek = "sunday";
                time.format = "12h";
              };
            }
          ];
        }
      ];
      powerdevil = {
        AC = {
          powerButtonAction = "lockScreen";
          turnOffDisplay = {
            idleTimeout = "never";
          };
        };
      };
      kscreenlocker = {
        autoLock = true;
        passwordRequired = true;
        lockOnResume = true;
        timeout = 10;
      };
      input.keyboard = {
        layouts = [
          {
            layout = "us";
          }
          {
            layout = "ru";
          }
        ];
        options = [
          "grp:caps_toggle"
        ];
      };
      configFile = {
        baloofilerc."Basic Settings"."Indexing-Enabled" = {
          value = false;
          immutable = true;
        };
      };
    };
    home.packages = with pkgs; [
      haruna
    ] ++ (with pkgs.kdePackages; [
      akonadi
      akonadiconsole
      akonadi-search
      akonadi-calendar
      akonadi-calendar-tools
      akonadi-contacts
      akonadi-import-wizard
      akonadi-mime
      kdepim-addons
      kdepim-runtime
      kmail-account-wizard
      gwenview
      krfb
      kmail
      kget
      sddm-kcm
      spectacle
      tokodon
      kjournald
      kpmcore
      neochat
      plasma-vault
      discover
      kaccounts-providers
      kaccounts-integration
      qtwebengine
      plasma-systemmonitor
      isoimagewriter
      krdc
      filelight
      ksystemlog
      kteatime
      kontact
    ]);
  };
}
