{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.services.printing;
in
{
  options = {
    module.services.printing.enable = mkEnableOption "Enable printing";
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        canon-capt
        canon-cups-ufr2
        # cups-bjnp
        carps-cups
        # cnijfilter2
        gutenprint
        gutenprintBin
        hplipWithPlugin
        postscript-lexmark
        samsung-unified-linux-driver
        splix
        brlaser
        brgenml1lpr
        brgenml1cupswrapper
      ];
    };
    hardware.printers.ensurePrinters = [
      {
        name = "L11121E";
        location = "Home";
        deviceUri = "usb://Canon/LBP2900?serial=0000b27BB98M";
        model = "canon/CanonLBP-2900-3000.ppd";
      }
    ];
  };
}

