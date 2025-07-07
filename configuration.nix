{ nixpkgs, config, lib, pkgs, inputs, ... }:
let HOME = "/home/panda";
in {
  # nixOS
  imports = [
    ./hw-cfg.nix
    ./services.nix

    ./intel.nix
    ./packages.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nix;
    extraOptions = "experimental-features = nix-command flakes";
    settings = { trusted-users = [ "panda" ]; };

    optimise = {
      automatic = false;
      dates = [ "06:00" ];
    };
  };

  documentation = {
    dev.enable = true;
    man = {
      man-db.enable = false;
      mandoc.enable = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages;

    kernelParams = [ "module_blacklist=amdgpu" ];
    blacklistedKernelModules = [
      "nouveau"
      "nvidia"
      "nvidia_drm"
      "nvidia_uvm"
      "nvidia_modeset"
      "nvidiafb"
    ];
  };

  # NETWORKING
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  networking.hostName = "banana";
  networking.hosts = { "127.0.0.1" = [ "localhost" ]; };
  
  networking.wireless.enable = false;
  networking.dhcpcd.enable = false;

  time.timeZone = "Africa/Johannesburg";

  security.sudo = {
    enable = true;
    extraRules = [{
      users = [ "panda" ];
      commands = [
        {
          command = "/system/scripts/mounts.sh";
          options = [ "SETENV" "NOPASSWD" ];
        }
        {
          command = "/system/scripts/nixosgarbage.sh";
          options = [ "SETENV" "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "SETENV" "NOPASSWD" ];
        }
      ];
    }];
  };

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Groups
  users.groups = {
    panda = { };
    pulse = { };
    nm-openconnect = { };
    nicy = { };
  };
  # Users
  users.users.panda = {
    isNormalUser = true;
    home = "/home/panda";
    group = "panda";
    extraGroups = [ "wheel" "realtime" "nicy" "audio" ];
    linger = false;
    homeMode = "711";
  };

  # Sound

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Services
  services.pipewire = {
    enable = true;

    wireplumber.enable = true;

    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Securitay
  security.rtkit.enable = true;
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function (action, subject) {
      	let ids = [
	  "com.feralinteractive.GameMode.cpu-helper"
	  "com.feralinteractive.GameMode.governor-helper"
	];
        if (ids.indexOf(action.id) !== -1) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  security.pam.loginLimits = [{
    domain = "@nicy";
    type = "-";
    item = "nice";
    value = -16;
  }];

  environment.variables = {
    NIX_CONF_DIR = "/etc/nixos/intel";
    
    LIBVA_DRIVER_NAME = "iHD";
    MESA_LOADER_DRIVER_OVERRIDE = "iris";

    VK_ICD_FILENAMES = "${pkgs.mesa.drivers}/share/vulkan/icd.d/intel_icd.x86_64.json";
  };
  system.stateVersion = "24.05";
}
