{ config, pkgs, lib, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-utils
      libva-vdpau-driver
      nvidia-vaapi-driver
    ];
    extraPackages32 = with pkgs; [ driversi686Linux.libva-vdpau-driver ];
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    windowManager.bspwm = { enable = true; };
  };

  hardware.nvidia = {
    modesetting.enable = true;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;

    powerManagement.finegrained = false;
    powerManagement.enable = true;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors" =
    {
      text = ''
                {
                "rules": [
                  {
                    "pattern": {
                      "feature": "procname", "matches": "foobar" },
                      "profile": "Limit Free Buffer Pool On Wayland Compositors"
                  }
        	  {
                    "pattern": {
                      "feature": "procname", "matches": "/etc/profiles/per-user/jwm/bin/Hyprland" },
                      "profile": "Limit Free Buffer Pool On Wayland Compositors"
                  }
                  {
                    "pattern": {
                      "feature": "procname", "matches": "/etc/profiles/per-user/jwm/bin/alacritty" },
                      "profile": "Limit Free Buffer Pool On Wayland Compositors"
                  }
                  {
                    "pattern": {
                      "feature": "procname", "matches": "Xwayland" },
                      "profile": "Limit Free Buffer Pool On Wayland Compositors"
                  }
                  {
                    "pattern": {
                      "feature": "procname", "matches": "/nix/store/pigw9014x0fgzlawxmrknk6wj33v0vk1-system-path/bin/firefox" },
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
    };
}
