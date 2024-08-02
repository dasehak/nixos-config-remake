{ lib
, ...
}:

with lib;

{
  imports = [
    ./docker
    ./libvirtd
    ./virt-manager
    ./virtualbox-host
  ];
}
