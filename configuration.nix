{ 
  nixpkgs, config, lib, pkgs,
  inputs,
  ... 
}:
let
  HOME = "/home/jwm";
in
{
  # nixOS
  	imports = [
	  ./hw-cfg.nix
	  ./services.nix

	  # Daemons
	  ./daemons/nginx.nix
	  ./daemons/vsftpd.nix
	  ./daemons/aria2.nix
	  
	  ./nvidia.nix
	  ./packages.nix
	  ./programs/hyprland.nix
	];

  	nixpkgs.config.allowUnfree = true;

  	nix = {
  	  package = pkgs.nix;
  	  extraOptions = ''
  	      experimental-features = nix-command flakes
  	  '';
	  settings = {
	    trusted-users = [ "jwm" ];
	  };
  	};
        
  	# Use the systemd-boot EFI boot loader.
  	boot = {
          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
          kernelPackages = pkgs.linuxPackages;
          #initrd.kernelModules = [ "nvidia" "nvidia_drm" "nvidia_uvm" ];
          kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
        };

	# NETWORKING
  	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  	networking.networkmanager.enable = true;
  	networking.firewall.enable = false;

	networking.hostName = "cabbage";
        networking.hosts = {
	  "127.0.0.1" = [ "ariaweb.srv" "jellyfin.srv" ];
	  "192.168.2.2" = [ "vault.tld" ];
	};
	networking.interfaces.enp42s0.macAddress = "2C:F0:5D:E5:E2:E1";

	time.timeZone = "Africa/Johannesburg";

        security.sudo = {
          enable = true;
	  extraRules = [
	    { 
	      users = [ "jwm" ];
	      commands = [
	        {
		  command = "${HOME}/.scripts/scripts/system/mounts.sh";
		  options = [ "SETENV" "NOPASSWD" ];
		}
		{
		  command = "${HOME}/.scripts/scripts/system/leds.sh";
		  options = [ "SETENV" "NOPASSWD" ];
		}
		{
		  command = "${HOME}/.scripts/programs/musicbee/prio.sh";
		  options = [ "SETENV" "NOPASSWD" ];
		}
		{
		  command = "${HOME}/.scripts/scripts/system/nixosgarbage.sh";
		  options = [ "SETENV" "NOPASSWD" ];
		}
		{
		  command = "${HOME}/.scripts/programs/musicbee/musicbee.sh";
		  options = [ "SETENV" "NOPASSWD" ];
		}
	      ];
	    }
	  ];
        };

  	# Locale
  	i18n.defaultLocale = "en_US.UTF-8";
	
	# Groups
	users.groups = {
	  freezer = {};
	  jwm = {};
	  ftpsecure = {};
	  ssh = {};
	  certs = {};
	  aria2 = {};
	  pulse = {};
	  nm-openconnect = {};
	};
	# Users
	users.users.jwm = {
	    isNormalUser = true;
	    home = "/home/jwm";
	    group = "jwm";
	    extraGroups = [ "wheel" "freezer" "realtime" ];
	};
	users.users.ftpsecure = {
	    isNormalUser = true;
	    home = "/var/lib/jail";
	    group = "ftpsecure";
	    password = "123";
	    createHome = false;
	    homeMode = "755";
	};
	users.users.nginx = {
	  extraGroups = [ "certs" ];
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
          if [ "org.freedesktop.pipewire" ].indexOf(action.id) !== -1 {
	      return polkit.Result.YES;
	  }
      });
    '';
  };

  security.pam.loginLimits = [
    {
      domain = "jwm";
      type = "-";
      value = "nice";
      value = -13;
    }
  ];
  
  security.pki.certificateFiles = [
    ./resources/certs/ca/ca.pem
  ];

  environment.variables = {
    NIX_CONF_DIR = "${HOME}/.nixos";
    NIX_OZONE_WL = "0";

    LD_LIBRARY_PATH = lib.mkForce "${config.boot.kernelPackages.nvidiaPackages.beta}/lib:${config.boot.kernelPackages.nvidiaPackages.beta}/share/vulkan/icd.d";
    
    MESA_LOADER_DRIVER_OVERRIDE  = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
    VK_DRIVER_FILES = "${config.boot.kernelPackages.nvidiaPackages.beta}/share/vulkan/icd.d/nvidia_icd.x86_64.json";
    VK_ICD_FILENAMES = "${config.boot.kernelPackages.nvidiaPackages.beta}/share/vulkan/icd.d/nvidia_icd.x86_64.json";
  };
  system.stateVersion = "24.05";
}
