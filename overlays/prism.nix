  self: super: {
    prismlauncher = super.prismlauncher.overrideAttrs (oldAttrs: {
      withWaylandGLFW = true;
    });
  }
