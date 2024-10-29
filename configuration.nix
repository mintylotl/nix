{ config, lib, pkgs, ... }:
let
  HOME = "/home/jwm";
in
{
  # nixOS
  	imports = [
	  ./hardware-configuration.nix
	  ./daemons/nginx.nix
	  ./daemons/vsftpd.nix
	  ./daemons/aria2.nix
	  ./nvidia.nix
	  ./packages.nix
	];

  	nixpkgs.config.allowUnfree = true;

  	nix = {
  	  package = pkgs.nixVersions.stable;
  	  extraOptions = ''
  	      experimental-features = nix-command flakes
  	  '';
	  settings = {
	    trusted-users = [ "jwm" ];
	  };
  	};

  	# Use the systemd-boot EFI boot loader.
  	boot.loader.systemd-boot.enable = true;
  	boot.loader.efi.canTouchEfiVariables = true;
        boot.kernelPackages = pkgs.linuxPackages;

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
	};
	# Users
	users.users.jwm = {
	    isNormalUser = true;
	    home = "/home/jwm";
	    group = "jwm";
	    extraGroups = [ "wheel" "freezer" ];
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
	hardware.pulseaudio.enable = false;

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
  security.pki.certificateFiles = [
    ./resources/certs/ca/ca.pem
  ];
  
  security.polkit.enable = true;

  environment.sessionVariables = {
    NIX_CONF_DIR = "${HOME}/.nixos";
    NIX_OZONE_WL = "1";
  };
  # system.copySystemConfiguration = true;
  system.stateVersion = "24.05";
}
