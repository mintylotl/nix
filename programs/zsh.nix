{ config, ... }: {
  programs.zsh = {
    enable = true;
    completionInit = "";
    initExtra = ''
      ZIM_HOME=~/.zim
      if [[ ! -e ''${ZIM_HOME}/zimfw.zsh ]]; then
          curl -fsSL --create-dirs -o ''${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
      fi

      if [[ ! ''${ZIM_HOME}/init.zsh -nt ''${ZDOTDIR:-''${HOME}}/.zimrc ]]; then
          source ''${ZIM_HOME}/zimfw.zsh init -q
      fi

      alias ls="ls --color"
      alias e="exit"
      alias vd="veracrypt -t -d"
      alias vc="veracrypt -t -c"
      alias vm="veracrypt -t"

      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias nixosFlake="sudo nixos-rebuild switch --flake /etc/nixos#cabbage"
      alias nixosFlakeF="sudo nixos-rebuild switch --flake /etc/nixos#cabbage --fast --offline"

      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias fetch="fetcher.sh"
      alias emacsc="emacsclient -c -a emacs -s /home/jwm/.doom.d/emacflurry/mcflurry"
      alias garb="sudo $HOME/.scripts/scripts/system/nixosgarbage.sh 1"
      alias garbBige="sudo $HOME/.scripts/scripts/system/nixosgarbage.sh 0"
      alias blender3="~/.local/state/nix/profiles/blender3/bin/blender"

        # --ecryptfs
        alias mount.crypt="mount.ecryptfs_private"
        alias umount.crypt="umount.ecryptfs_private"
        alias ikey="insert.sh"

        # --wireguard
        alias wgVlanU="sudo wg-quick up ~/.wireguard/vlan.conf"
        alias wgVlanD="sudo wg-quick down ~/.wireguard/vlan.conf"
        alias wgClientU="sudo wg-quick up ~/.wireguard/client2.conf"
        alias wgClientD="sudo wg-quick down ~/.wireguard/client2.conf"

      PATH="/home/jwm/.cargo/bin:/home/jwm/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin:$HOME/.scripts/scripts:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"

      eval "$(direnv hook zsh)"
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
}
