{
  config,
  lib,
  pkgs,
  ...
}:
let
  epaks = pkgs.emacsPackages;
  pypaks = pkgs.python312Packages;
  HOME = "/home/jwm";
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.apheleia
      epkgs.ripgrep
      epkgs.gnuplot
      epkgs.shfmt
      epkgs.pipenv
      epkgs.pandoc
      epkgs.all-the-icons
      epkgs.org-superstar
      epkgs.pytest

      pypaks.python-lsp-server

      pkgs.fd
      pkgs.cmake
      pkgs.clang
      pkgs.gnumake
      pkgs.nixfmt-rfc-style
      pkgs.sbcl
      pkgs.gdtoolkit_4

      pkgs.ispell
      pkgs.stylelint

      pkgs.shellcheck
      pkgs.graphviz

      pkgs.libtool
      pkgs.rustup
      pkgs.zig
      pkgs.pnpm
    ];
  };

  services.emacs = {
    enable = true;
    client.enable = false;
    defaultEditor = true;
    package =
      with pkgs;
      ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [
        epkgs.vterm
        epkgs.apheleia
        epkgs.ripgrep
        epkgs.gnuplot
        epkgs.shfmt
        epkgs.pipenv
        epkgs.pandoc
        epkgs.all-the-icons
        epkgs.org-superstar
        epkgs.pytest
      ]));

    startWithUserSession = true;
  };
  systemd.user.services.emacs = {
    Unit = {
      ExecStartPre = [ "${pkgs.bash}/bin/bash ${HOME}/.scripts/emacs.sh" ];
    };
  };
}
