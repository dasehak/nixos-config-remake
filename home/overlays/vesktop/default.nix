_: prev: {
  vesktop = prev.vesktop.overrideAttrs (old: {
    desktopItems = map (x: x.override{ exec = "vesktop --disable-gpu %U"; }) old.desktopItems;
  });
}
