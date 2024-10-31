{ config, pkgs, lib, ... }:
let 
HOME = "/home/jwm";
in {
  imports = [ ./config/hyprland-conf.nix ];
  home.username = "jwm";
  home.homeDirectory = "/home/jwm";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    TERM = "alacritty";
    NIXOS_OZONE_WL = "1";
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib:/usr/lib";
  };

  # Home Stuff
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps.enable = false;
    
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        pkgs.xdg-desktop-portal-gtk
	pkgs.xdg-desktop-portal-hyprland
      ];
      config.common.default = "gtk";
    };

    configHome = "${HOME}/.config";
    cacheHome = "${HOME}/.cache";
    dataHome = "${HOME}/.local/share";
    stateHome = "${HOME}/.local/state";

    userDirs.createDirectories = false;
  };
  
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };
  programs.fish = {
    enable = false;
    interactiveShellInit = ''
      set fish_greeting ""
      alias ls="ls --color"
      alias vd="veracrypt -t -d"
      alias vc="veracrypt -t -c"
      alias vm="veracrypt -t"
      alias mpv="mpv --hwdec=nvdec"
      alias mino="killall -SIGKILL java"
       
      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias fishy="nvim ~/.config/fish/config.fish"
       
      alias mokuro="python3 -m mokuro"    
      alias fetch="fetcher.sh" 
      alias emacsc="emacsclient -c -a nvim"
      alias nixosFlake="nixos-rebuild switch --flake"
        # --ecryptfs
          alias mount.crypt="mount.ecryptfs_private"
      alias umount.crypt="umount.ecryptfs_private"
      alias ikey="insert.sh"
      set PATH "$HOME/.scripts/scripts:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"
    '';
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";
  };
  
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      zsh
    '';
  };
  programs.zsh = {
    enable = true;
    completionInit = "";
    initExtra = ''
      ZIM_HOME=~/.zim
      if [[ ! -e ''\${ZIM_HOME}/zimfw.zsh ]]; then
          curl -fsSL --create-dirs -o ''\${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
      fi

      if [[ ! ''\${ZIM_HOME}/init.zsh -nt ''\${ZDOTDIR:-''\${HOME}}/.zimrc ]]; then
          source ''\${ZIM_HOME}/zimfw.zsh init -q
      fi

      alias ls="ls --color"
      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias nixosFlake="sudo nixos-rebuild switch --flake ~/.nixos#cabbage"
      alias ls="ls --color"
      alias vd="veracrypt -t -d"
      alias vc="veracrypt -t -c"
      alias vm="veracrypt -t"
      alias mino="killall -SIGKILL java"
      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias mokuro="python3 -m mokuro"    
      alias fetch="fetcher.sh" 
      alias emacsc="emacsclient -c -a emacs"
        # --ecryptfs
          alias mount.crypt="mount.ecryptfs_private"
          alias umount.crypt="umount.ecryptfs_private"
          alias ikey="insert.sh"
      PATH="$HOME/.scripts/scripts:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"
      source $ZIM_HOME/init.zsh
    '';
  };
  home.file.".zimrc" = {
    enable = true;
    text = ''
      zmodule asciiship
      zmodule zsh-users/zsh-completions --fpath src
      zmodule completion
      zmodule zsh-users/zsh-syntax-highlighting
      zmodule zsh-users/zsh-autosuggestions
    '';
  };
  
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.kitty.enable = true;
  programs.alacritty.enable = true;
  programs.git = {
    enable = true;
    userName = "mintylotl";
    userEmail = "mintyaxolotl@proton.me";
  };

  # Hyprland
  home.pointerCursor = {
    x11.enable = true;

    gtk.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePineDawn-Linux";
    size = 24;
  };

  gtk = {
    enable = true;

    cursorTheme.name = "BreezeX-RosePineDawn-Linux";
    theme = {
      package = pkgs.breeze-gtk;
      name = "Breeze-Dark";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
    style.package = pkgs.qt6Packages.qtstyleplugin-kvantum;
  };
  home.stateVersion = "24.05";
}
