{ lib
, config
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.virtualisation;
in {
  options = {
    module.virtualisation.enable = mkEnableOption "Enables virtualisation";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      docker.enable      = true;
      libvirtd.enable    = true;
      vmware.host = {
        enable = true;
        extraConfig = ''
          # Allow unsupported device's OpenGL and Vulkan acceleration for guest vGPU
          mks.gl.allowUnsupportedDrivers = "TRUE"
          mks.vk.allowUnsupportedDevices = "TRUE"
        '';
      };
      virtualbox.host = {
        enable = true;
        enableExtensionPack = true;
      };
    };

    programs.virt-manager.enable = true;
  };
}
