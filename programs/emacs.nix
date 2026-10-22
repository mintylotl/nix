{
  config,
  lib,
  pkgs,
  ...
}:
let
  epaks = pkgs.emacsPackages;
  pypaks = pkgs.python314Packages;
  homeDir = "/home/jwm";
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
      epkgs.all-the-icons
      epkgs.org-superstar
      epkgs.pytest

      pypaks.python-lsp-server

      pkgs.fd
      pkgs.cmake
      pkgs.clang
      pkgs.gnumake
      pkgs.nixfmt
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
      pkgs.nixd
      pkgs.nodejs
      pkgs.gopls
      pkgs.gomodifytags
      pkgs.gotests
      pkgs.haskellPackages.hoogle
      pkgs.clang-tools
      pkgs.python3Packages.nose2
      pkgs.pyenv
      pkgs.js-beautify

      pkgs.python3
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
        epkgs.all-the-icons
        epkgs.org-superstar
        epkgs.pytest
	pkgs.python3
      ]));

    startWithUserSession = true;
  };
  systemd.user.services.emacs = {
    Unit = {
      ExecStartPre = [ "${pkgs.bash}/bin/bash ${homeDir}/.scripts/emacs.sh" ];
    };
  };
}
