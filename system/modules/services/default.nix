{ lib
, ...
}:

with lib;

{
  imports = [
    ./bluetooth
    ./cpu-autofreq
    ./greetd-tui
    ./printing
    ./xserver
    ./polkit
    ./fwupd
    ./zram
    ./tlp
    ./plasma
    ./hyprland
    ./sshd
    ./libinput
    ./flatpak
  ];
}

