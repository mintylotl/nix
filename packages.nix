{
  pkgs,
  #pkgs_bleeding,
  pkgs_old,
  config,
  lib,
  inputs,
  prism,
  ...
}:
let
  #paksold = pkgs_old;
  py = pkgs.python312Packages;
  #bleed = pkgs_bleeding;
in
{
  environment.systemPackages = with pkgs; [
    prism.packages.${pkgs.stdenv.system}.prismlauncher
    typescript-language-server
    typescript
    eslint
    vtsls

    pkgs.tree-sitter-grammars.tree-sitter-typescript
    pkgs.tree-sitter-grammars.tree-sitter-tsx

    # General
    man-pages-posix
    vivid

    #protonvpn-cli
    openvpn
    #zrythm
    bespokesynth
    zlib
    zip
    imhex
    gzip
    lz4
    gnutar
    cheat
    tldr
    most
    less

    xdg-desktop-portal-wlr
    swaybg

    #vscode-fhs
    wineasio
    unzip
    #surge
    #sfizz
    rmpc
    poppler-utils
    pnpm
    p7zip
    nvme-cli
    ardour
    arch-install-scripts
    #veracrypt
    hdparm
    libreoffice-qt6-fresh
    rpcs3
    vitetris
    joystickwake
    sdl-jstest
    jstest-gtk
    linuxConsoleTools
    hyprpicker
    ngrok
    cachix
    nicotine-plus
    filezilla
    mokuro
    jellyfin-mpv-shim
    osu-lazer-bin
    anki-bin
    anki-sync-server
    prisma-engines

    #Dicts
    hunspellDicts.ko_KR
    hunspellDicts.en_GB-ize
    hunspell

    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))

    #cudaPackages.cudatoolkit
    xorg.xeyes
    xorg.xorgserver
    xorg.xrandr

    stuntman
    heimdall
    gvfs
    simple-mtpfs
    libmtp
    android-tools

    #Emacs
    cmigemo
    tidyp
    jsbeautifier
    html-tidy
    gnumake
    pkg-config
    cmake
    libtool
    libvterm
    editorconfig-checker
    editorconfig-core-c
    sbcl
    gdtoolkit_4
    libxml2
    gopls
    gomodifytags
    gotests
    gore
    haskell-language-server
    #llvmPackages.clang-tools
    pandoc
    nixfmt-rfc-style
    shfmt
    shellcheck
    stylelint
    graphviz
    tk
    tree
    ocrmypdf
    php
    sl
    lsof
    hdparm
    gocryptfs
    fscryptctl

    #Python
    py.python
    py.black
    py.nose2
    py.pyflakes
    py.pytest
    py.isort
    py.tkinter

    jdk17

    pipenv
    poetry
    pyenv

    mumble
    shadow
    wget
    coreutils
    psmisc
    ntfs3g
    libxkbcommon
    alsa-plugins
    alsa-firmware
    alsa-lib
    alsa-tools
    alsa-utils
    xorg.xinit
    unrar
    kdePackages.ark

    # Project Zomboid
    dwarfs
    fuse-overlayfs
    libarchive
    hyprpolkitagent

    #OVMF
    qemu
    umu-launcher

    cowsay
    kittysay
    pokemonsay
    smartmontools
    pkgs.blender
    keyutils
    compsize
    udisks
    timewarrior

    # GTK Libs
    zenity
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-libav

    vulkan-loader
    vulkan-headers

    xcur2png
    pavucontrol
    #audacity
    mpv
    #busybox
    htop
    neofetch
    speedcrunch
    openssl

    lutris
    protontricks

    fd
    ripgrep
    cmake
    clang
    gcc
    rustup
    rust-analyzer

    # QT
    qimgv
    kdePackages.qt6ct

    # PrismLauncher Cracked
    #pkgs.prismlauncherCracked

    (retroarch.withCores (
      cores: with cores; [
        mgba
        mame2003-plus
        mame2010
        snes9x
        nestopia
        ppsspp
        dolphin
        swanstation
        bsnes-mercury-performance
        bsnes-mercury
        #fbalpha2012
        pcsx-rearmed
        genesis-plus-gx
        mame2000
        melonds
      ]
    ))
    retroarch-assets

    typescript
    # Python
    #System
    py.pip

    #Misc
    py.yt-dlp
    py.numpy

    # System Utilities
    home-manager
    discord
    bitwarden-desktop
    git

    #makemkv
    pkg-config
    btrfs-progs
    vulkan-tools
    rsync
    xdotool
    nodejs_22
    yarn
    stow
    brightnessctl
    ffmpeg-full
    yt-dlp
    zig
    (ghc.withPackages (
      hp: with hp; [
        zlib
        cabal-install
      ]
    ))

    # Thumbnailers
    ffmpegthumbnailer
    #JAVA
    openjdk21
    openjdk17
    openjdk8

    # WINE
    wireshark-qt
    wireguard-tools
    duperemove
    # Programs
    #wineWowPackages.waylandFull
    #wineWowPackages.stableFull
    #wineWowPackages.unstableFull
    wineWowPackages.stableFull
    winetricks
    grim
    slurp
    hyprpaper
    wl-clipboard
    cliphist
    firefox-devedition
    telegram-desktop
    pkgs.qbittorrent
    rose-pine-cursor
    aria2

    # Icon_Themes
    adwaita-icon-theme
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    papirus-icon-theme
  ];

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };
  programs.tmux.enable = true;
  programs.xfconf.enable = true;
  programs.dconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      xfce.thunar-volman
      xfce.thunar-archive-plugin
      xfce.catfish
      xfce.garcon
      xfce.exo
      xfce.tumbler

      totem
      webp-pixbuf-loader
      mcomix
      f3d
      gnome-epub-thumbnailer
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
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Existing dependencies
        zlib
        glib
        nspr
        nss
        glibc
        dbus
        atk
        at-spi2-core
        cups
        cairo
        gtk3
        pango
        expat
        libxkbcommon
        systemd
        alsa-lib
        gcc
        pkg-config
        libgbm

        # X11 libs
        xorg.libX11
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
        xorg.libxcb

        # Missing Graphics stack (libGL, libGLX, libEGL, libOpenGL)
        libGL
        libGLX
        libglvnd # Provides libOpenGL and vendor-neutral dispatch
        mesa # Essential for hardware acceleration/drivers

        # Font & System libs
        fontconfig # libfontconfig.so.1
        freetype # libfreetype.so.6
        libgpg-error # libgpg-error.so.0

        # Other
        wayland # libwayland-client.so.0
        bzip2 # libbz2.so.1.0
        libadwaita # libadwaita-1.so.0
        gtk4 # libgtk-4.so.1
        pango # libpango-1.0.so.0
        gdk-pixbuf # libgdk_pixbuf-2.0.so.0
        cairo # libcairo.so.2
        glib # libgio-2.0.so.0, libgobject-2.0.so.0, libglib-2.0.so.0

        # Common dependencies often required by GTK4/Adwaita apps
        glibc
        libGL
        vulkan-loader
        xorg.libX11

        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
      ];
    };
  };
  programs.fuse = {
    userAllowOther = true;
    mountMax = 20;
  };

  programs.labwc.enable = true;

  # Services
  services.seatd.enable = true;
  services.vsftpd.enable = true;
  services.openssh = {
    enable = true;
    extraConfig = ''
      ClientAliveInterval 60
      ClientAliveCountMax 3
    '';
  };
  services.tumbler.enable = true;

  services.jellyfin = {
    enable = true;
    dataDir = "/system/programs/jellyfin";
  };

  services.flatpak.enable = true;

  services.dnsmasq = {
    enable = true;
    settings = {
      # Listen only on the local loopback interface
      listen-address = [
        "11.0.0.2"
      ];
      interface = [
        "enp42s0"
      ];
      bind-interfaces = true;

      # Upstream DNS servers
      server = [
        "8.8.8.8"
        "9.9.9.9"
        "11.0.0.254"
      ];

      address = [
        "/.vault.tld/11.0.0.2"
      ];

      # Optional: Cache size and optimization
      cache-size = 1000;
    };
  };
  systemd.services.dnsmasq = {
    after = [ "NetworkManager-wait-online.service" ];
  };

  services.vaultwarden = {
    enable = true;
    package = pkgs.vaultwarden;
    environmentFile = "/system/programs/Vaultwarden/env.env";
    #config = "";
    dbBackend = "sqlite";
    config = {
      DATA_FOLDER = "/system/programs/Vaultwarden";
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = "37344";
    };
  };
  systemd.services.vaultwarden = {
    serviceConfig = {
      ProtectSystem = lib.mkForce "off";
    };
  };

  services.murmur = {
    enable = true;
    port = 37374;
    registerName = "Mumbone";
    bonjour = true;
    users = 7;
    welcometext = "Welcome to the Abyss";
  };

  services.mongodb = {
    enable = false;
  };
  virtualisation.docker = {
    enable = false;
  };

  services.komga = {
    enable = true;
    stateDir = "/system/programs/komga";
    settings.server = {
      port = 37322;
    };
  };
  systemd.services.komga = {
    wants = [
      "mounts.service"
    ];
    after = [
      "mounts.service"
    ];
  };

  services.nix-serve = {
    enable = true;
    port = 32999;
    secretKeyFile = "/system/programs/nixserve/cache.key";
  };

  services.aria2 = {
    enable = true;
    rpcSecretFile = "/system/programs/aria2/rpcsecret.txt";
    settings = {
      dir = "/home/jwm/Downloads/Aria";
      conf-path = "/system/programs/aria2/aria2.conf";
    };
  };
  systemd.services.aria2 = {
    serviceConfig = {
      User = "aria2";
      Group = "aria2";
    };
  };

  virtualisation.waydroid.enable = true;

  xdg = {
    terminal-exec.enable = true;
    terminal-exec.settings = {
      default = [ "alacritty.desktop" ];
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };
    icons.enable = true;
    menus.enable = true;
    mime.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji

    proggyfonts
    font-awesome
    andika

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.hack
  ];
}
