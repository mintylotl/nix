{
  config,
  lib,
  pkgs,
  ...
}:
let
  epaks = pkgs.emacsPackages;
  pypaks = pkgs.python312Packages;
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages =
      epkgs: with pkgs; [
        epaks.vterm
        epaks.apheleia
        epaks.ripgrep
        epaks.gnuplot
        epaks.shfmt
        epaks.pipenv
        epaks.pandoc
        epaks.all-the-icons
        epaks.org-superstar
        epaks.pytest

        pypaks.python-lsp-server

        fd
        cmake
        clang
        gnumake
        nixfmt-rfc-style
        sbcl
        gdtoolkit_4

        ispell
        stylelint

        shellcheck
        graphviz

        libtool
        rustup
        rust-analyzer
        zig
        pnpm
      ];
  };

  services.emacs = {
    enable = true;
    client.enable = false;
    defaultEditor = true;

    startWithUserSession = true;
  };
  systemd.user.services.emacs = {
    Unit.After = [ "emacs-mounts.service" ];
  };
}
