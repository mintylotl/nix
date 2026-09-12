{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  HOME = "/home/jwm";
in
{
  # Home Stuff
  xdg = {
    enable = true;

    mime.enable = true;
    mimeApps.enable = false;

    #configFile."mimeapps.list".force = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];

      configPackages = with pkgs; [ firefox-devedition ];
      config.common = {
        default = [
          "hyprland"
          "wlr"
          "gtk"
        ];
        "org.freedesktop.portal.OpenURI" = [ "firefox-developer-edition" ];
      };
      config.Hyprland = {
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland.portal";
        "org.freedesktop.impl.portal.Screenshot" = "hyprland.portal";
        "org.freedesktop.impl.portal.GlobalShortcuts" = "hyprland.portal";
      };
      config.labwc = {
        default = [
          "wlr"
        ];
      };
    };

    configHome = "${HOME}/.config";
    cacheHome = "${HOME}/.cache";
    dataHome = "${HOME}/.local/share";
    stateHome = "${HOME}/.local/state";

    userDirs.createDirectories = false;

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
          "text/x-c"
          "text/x-c++"
          "x-scheme-handler/org-protocol"
        ];

        icon = "emacs";
        type = "Application";
        exec = ''
          emacsclient --alternate-editor= -s "${HOME}/.doom.d/emacflurry/mcflurry" -c %F
        '';

        terminal = false;
        categories = [
          "Development"
          "TextEditor"
        ];
        startupNotify = true;

        settings = {
          Keywords = "emacsclient";
          StartupWMClass = "Emacsd";
        };

        #actions."new-window" = {
        #  name = "New Frame";
        #  exec = ''
        #    emacsclient --alternate-editor= -s "${HOME}/.emacs.d/emacflurry/mcflurry" -c %F
        #  '';
        #};
      };
    };

  };
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };
}
