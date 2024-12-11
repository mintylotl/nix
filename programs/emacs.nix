{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs:
      with pkgs; [
        epkgs.vterm
        fd
        ripgrep
        cmake
        clang
        jsbeautifier
        nixfmt-classic
        ispell
        gnuplot
        shfmt
        gnumake
        pipenv
        cmigemo
        stylelint
        shellcheck
        zig
        graphviz
        pandoc
        libtool
        rustup
        rust-analyzer
        pnpm
        html-tidy
        sbcl
      ];
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;

    startWithUserSession = true;
  };
}
