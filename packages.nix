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

    xorg.xorgserver
    xorg.xrandr

    stuntman
    gvfs
    simple-mtpfs
    libmtp

    coreutils
    ntfs3g
    libxkbcommon
    alsa-plugins
    alsa-firmware
    alsa-lib
    xorg.xinit
    unrar
    alsa-tools
    ark

    # Project Zomboid
    dwarfs
    fuse-overlayfs
    libarchive
    gnutar

    #OVMF
    #qemu_full
    pkgs.umu

    cowsay
    kittysay
    pokemonsay
    pkgs.vulkan-loader
    smartmontools
    pkgs.vulkan-headers
    keyutils
    compsize
    gtk2
    gtk3
    udisks

    # GTK Libs
    zenity
    pkgs.gst_all_1.gstreamer
    pkgs.gst_all_1.gst-plugins-base
    pkgs.gst_all_1.gst-plugins-good
    pkgs.gst_all_1.gst-plugins-ugly
    pkgs.gst_all_1.gst-plugins-bad
    pkgs.gst_all_1.gst-libav

    mpv
    busybox
    htop
    neofetch
    speedcrunch
    openssl

    lutris
    protontricks

    fd
    ripgrep
    paks.rustup

    # QT
    qimgv

    # PrismLauncher Cracked
    prismlauncher

    # Python
    #System
    python312
    py.pip

    #Misc
    py.yt-dlp

    # System Utilities
    git
    btrfs-progs
    vulkan-tools
    rsync
    ffmpeg-full

    # Thumbnailers
    ffmpegthumbnailer
    #JAVA
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
    pkgs.wineWowPackages.stagingFull
    winetricks
    firefox
    telegram-desktop
    qbittorrent
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

  programs.dconf.enable = true;
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
  services.openssh.enable = true;

  #xdg = {
  #  terminal-exec.enable = true;
  #  terminal-exec.settings = { default = [ "alacritty.desktop" ]; };
  #  portal = {
  #    enable = true;
  #    extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-gtk ];
  #    xdgOpenUsePortal = true;
  #  };
  #  icons.enable = true;
  #  menus.enable = true;
  #  mime.enable = true;
  #};

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
