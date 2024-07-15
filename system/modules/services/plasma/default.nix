{ pkgs
, lib
, config
, ...
}:

with lib;

let
  cfg = config.module.services.plasma;
in {
  options = {
    module.services.plasma.enable = mkEnableOption "Enable KDE Plasma";
  };

  config = mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          theme = "catppuccin-mocha";
        };
        defaultSession = "plasma";
      };
    };

    environment.systemPackages = with pkgs; [
      (catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      })
      (catppuccin-sddm.override {
        flavor = "mocha";
        fontSize = "10";
      })
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
      akonadi-notes
      kdepim-addons
      kdepim-runtime
      kmail-account-wizard
      gwenview
      krfb
      kmail
      sddm-kcm
      spectacle
      tokodon
      kjournald
      partitionmanager
      kpmcore
      neochat
      plasma-vault
    ]);
  };
}