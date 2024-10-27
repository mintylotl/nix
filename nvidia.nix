{ config, pkgs, lib, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-utils
      libva
      vulkan-loader
      vulkan-validation-layers
      nvidia-vaapi-driver
      libGL
      libGLU
      libglvnd
      mesa.drivers
      opencl-headers

      xorg.libX11 xorg.libXext xorg.libXrandr xorg.libXi
    ];
    extraPackages32 = with pkgs;
      [
        #nvidia-vaapi-drive
        driversi686Linux.libva-vdpau-driver
      ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.finegrained = false;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.txt".text =
    ''
          {
          "rules": [
              {
                  "pattern": {
                      "feature": "procname",
                      "matches": "Hyprland"
                  },
                  "profile": "Limit Free Buffer Pool On Wayland Compositors"
              }
          ],
          "profiles": [
              {
                  "name": "Limit Free Buffer Pool On Wayland Compositors",
                  "settings": [
                      {
                          "key": "GLVidHeapReuseRatio",
                          "value": 1
                      }
                  ]
              }
          ]
      }
    '';

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
    VK_DRIVER_FILES =
      "/nix/store/c4s0nxrxws9vqradv5b5sjvqgidnc5zv-nvidia-x11-560.35.03-6.6.57/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  };
}
