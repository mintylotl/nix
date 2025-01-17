{ pkgs_unst, pkgs, config, lib, inputs, ... }:
let
  paks = pkgs_unst;
  py = paks.python312Packages;

in {
  nixpkgs.overlays = [
    inputs.prism.overlays.default
    (final: prev: {
      umu = inputs.umuProton.packages.${pkgs.system}.umu.override {
        version = inputs.umuProton.shortRev;
        #truststore = true;
        #cbor2 = true;
      };
    })
  ];

  environment.systemPackages = with paks; [
    # General
    man-pages-posix

    zip
    imhex
    gzip
    lz4
    gnutar
    cheat
    tldr
    most
    less

    pkgs.anki-bin
    pkgs.anki-sync-server

    xorg.xeyes
    xorg.xorgserver
    xorg.xrandr

    ventoy-bin

    stuntman
    heimdall
    gvfs
    simple-mtpfs
    libmtp
    android-tools

    shadow
    coreutils
    direnv
    ntfs3g
    libxkbcommon
    alsa-plugins
    alsa-firmware
    alsa-lib
    alsa-tools
    alsa-utils
    godot_4
    ecryptfs
    xorg.xinit
    pkgs.megasync
    soulseekqt
    unrar
    wlr-randr
    pkgs.ark
    strawberry-qt6

    # Project Zomboid
    dwarfs
    fuse-overlayfs
    libarchive
    gnutar
    hyprpolkitagent

    #OVMF
    #qemu_full
    pkgs.umu

    cowsay
    kittysay
    pokemonsay
    pkgs.vulkan-loader
    smartmontools
    pkgs.vulkan-headers
    pkgs.blender
    keyutils
    compsize
    pkgs.gtk2
    pkgs.gtk3
    udisks
    timewarrior
    pkgs.nvtopPackages.nvidia

    # GTK Libs
    zenity
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-libav

    xcur2png
    pavucontrol
    audacity
    mpv
    busybox
    htop
    neofetch
    pkgs.speedcrunch
    openssl
    tailscale

    lutris
    protontricks

    fd
    ripgrep
    cmake
    clang
    gnumake
    paks.rustup
    paks.rust-analyzer

    # QT
    pkgs.qimgv
    pkgs.kdePackages.qt6ct

    # PrismLauncher Cracked
    pkgs.prismlauncher

    # Python
    #System
    python312
    py.pip

    #Misc
    py.yt-dlp

    #Emacs
    py.black
    py.isort
    py.pyflakes
    py.nose2

    # System Utilities
    discord
    bitwarden-desktop
    git
    gcc
    makemkv
    pkg-config
    btrfs-progs
    pkgs.vulkan-tools
    rsync
    xdotool
    nodejs_22
    yarn
    stow
    brightnessctl
    ffmpeg-full

    # Thumbnailers
    ffmpegthumbnailer
    #JAVA
    openjdk23
    openjdk21
    openjdk17
    openjdk8

    # WINE
    dxvk
    dxvk_2
    vkd3d-proton
    gamescope
    gamemode
    mangohud
    # Programs
    #wineWowPackages.waylandFull
    #wineWowPackages.stableFull
    #wineWowPackages.unstableFull
    wineWowPackages.stagingFull
    winetricks
    grim
    slurp
    hyprpaper
    wl-clipboard
    cliphist
    firefox
    telegram-desktop
    pkgs.qbittorrent
    mako
    rose-pine-cursor
    aria2

    # Icon_Themes
    adwaita-icon-theme
    breeze-gtk
    breeze-icons
    papirus-icon-theme
  ];

  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };
  programs.xfconf.enable = true;
  programs.dconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
      tumbler
      catfish
      garcon
      exo
    ];
  };
  programs.steam = {
    enable = true;
    protontricks.enable = true;
    gamescopeSession.enable = false;
  };
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  # Services
  services.vsftpd.enable = true;
  services.openssh.enable = true;
  services.tumbler.enable = true;

  services.jellyfin = {
    enable = true;
    dataDir = "/system/programs/jellyfin";
  };

  services.plex = {
    enable = true;
    package = pkgs.plex;
    accelerationDevices = [ ];
  };
  systemd.services.plex = {
    serviceConfig = {
      Environment = ''
        LD_LIBRARY_PATH="${pkgs.plex}/lib/plexmediaserver/lib"
      '';
    };
  };

  services.vaultwarden = {
    enable = true;
    package = pkgs.vaultwarden;
    environmentFile = "/system/programs/Vaultwarden/env.env";
    #config = "";
    dbBackend = "sqlite";
    config = {
      DATA_FOLDER = "/system/programs/Vaultwarden";
      ROCKET_ADRESS = "0.0.0.0";
      ROCKET_PORT = "37344";
    };
  };
  systemd.services.vaultwarden = {
    serviceConfig = {
      StateDirectory = lib.mkForce "/system/programs/Vaultwarden";
      ProtectSystem = lib.mkForce "off";
    };
  };

  xdg = {
    terminal-exec.enable = true;
    terminal-exec.settings = { default = [ "alacritty.desktop" ]; };
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
    };
    icons.enable = true;
    menus.enable = true;
    mime.enable = true;
  };
  programs.ecryptfs.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    proggyfonts
    font-awesome
  ];
}
