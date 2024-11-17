{ pkgs
, ...
}:

{
  services.xserver.videoDrivers = [
    "amdgpu"
    "radeonsi"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      libva
      libva-utils
      vdpauinfo
    ];
  };
}

