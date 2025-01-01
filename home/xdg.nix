{ config, lib, pkgs, ... }:
let HOME = "/home/jwm";
in {
  # Home Stuff
  xdg = {
    enable = true;

    mimeApps.enable = false;
    mime = {
      enable = true;

      applications = {
        "emacs-client.desktop" = {
          Name = "Emacs (Client - Socket)";
          GenericName = "Text Editor";
          Comment = "Edit Text with Emacs";
          MimeType =
            "text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;x-scheme-handler/org-protocol;'text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;x-scheme-handler/org-protocol;";
          Icon = "emacs";
          Type = "Application";
          Exec = "emacsclient --alternate-editor= --reuse-frame %F";

          Terminal = "false";
          Categories = "Development;TextEditor";
          StartupNotify = "true";
          StartupWMClass = "Emacs";
          Keywords = "emacsclient";
          Actions = "new-window";

          "Desktop Action new-window" = {
            Name = "New Frame";
            Exec = "emacsclient --alternate-editor= --reuse-frame %F";
          };
        };
      };

      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        config.common.default = "gtk";
        config.hyprland = {
          default = "gtk";
          "org.freedesktop.impl.Screencast" = "wlr";
          "org.freedesktop.impl.Screenshot" = "wlr";
        };
        configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
      };

      configHome = "${HOME}/.config";
      cacheHome = "${HOME}/.cache";
      dataHome = "${HOME}/.local/share";
      stateHome = "${HOME}/.local/state";

      userDirs.createDirectories = true;
    };
  };
}
