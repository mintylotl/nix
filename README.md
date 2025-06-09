## My Nix Flakes
- Modular and separated into sub-categories.

Programs, shells, scripts, systemd units, packages, and so on are
all self contained modules.

## System
The flakes build on **nixos-25.05** **(stable)**.
+ The kernel is also built on this nixpkgs.
+ Some packages like ffmpeg and libs like zlib are on bleeding edge nixpkgs.

## Extra
There are devShells made for blender3 and more.
These are put into the user registry, then installed by using
```nix
nix profile install devshell#blender3
```



