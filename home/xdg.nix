{ config, lib, pkgs, inputs, ... }:
let HOME = "/home/jwm";
in {
  # Home Stuff
  xdg = {
    enable = true;

    mime.enable = false;
    mimeApps.enable = false;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config.common.default = "gtk";
      config.hyprland = {
        default = "gtk";
        #"org.freedesktop.impl.Screencast" = "wlr";
        #"org.freedesktop.impl.Screenshot" = "wlr";
      };
      #configPackages =
      #[ inputs.Hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland ];
    };

    configHome = "${HOME}/.config";
    cacheHome = "${HOME}/.cache";
    dataHome = "${HOME}/.local/share";
    stateHome = "${HOME}/.local/state";

    userDirs.createDirectories = true;

    desktopEntries = {
      "emacs-client.desktop" = {
        name = "Emacs (Client - Socket)";
        genericName = "Text Editor";
        comment = "Edit Text with Emacs";

        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
          "x-scheme-handler/org-protocol"
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
          "x-scheme-handler/org-protocol"
        ];

        icon = "emacs";
        type = "Application";
        #exec = ''
        #  WAYLAND_DISPLAY=$WAYLAND_DISPLAY emacsclient --alternate-editor= -s "${HOME}/.emacs.d/emacflurry/mcflurry" -c %F
        #'';

        terminal = false;
        categories = [ "Development" "TextEditor" ];
        startupNotify = true;

        settings = {
          Keywords = "emacsclient";
          StartupWMClass = "Emacsd";
        };

        actions."new-window" = {
          name = "New Frame";
          exec = ''
            emacsclient --alternate-editor= -s "${HOME}/.emacs.d/emacflurry/mcflurry" -c %F
          '';
        };
      };
    };

  };
}
