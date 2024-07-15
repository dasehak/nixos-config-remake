_: prev: {
  vesktop = prev.vesktop.overrideAttrs (e: rec {
    desktopItem = e.desktopItem.override (d: {
      exec = "${d.exec} --disable-gpu";
    });
    installPhase = builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ] e.installPhase;
  });
}
