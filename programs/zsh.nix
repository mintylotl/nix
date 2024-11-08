{ config, ... }:
{
  programs.zsh = {
    enable = true;
    completionInit = "";
    initExtra = ''
      ZIM_HOME=~/.zim
      if [[ ! -e ''\${ZIM_HOME}/zimfw.zsh ]]; then
          curl -fsSL --create-dirs -o ''\${ZIM_HOME}/zimfw.zsh \
          https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
      fi

      if [[ ! ''\${ZIM_HOME}/init.zsh -nt ''\${ZDOTDIR:-''\${HOME}}/.zimrc ]]; then
          source ''\${ZIM_HOME}/zimfw.zsh init -q
      fi

      alias ls="ls --color"
      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias nixosFlake="sudo nixos-rebuild switch --flake /etc/nixos#cabbage"
      alias ls="ls --color"
      alias vd="veracrypt -t -d"
      alias vc="veracrypt -t -c"
      alias vm="veracrypt -t"
      alias mounts="sudo $HOME/.scripts/scripts/system/mounts.sh"
      alias mokuro="python3 -m mokuro"    
      alias fetch="fetcher.sh" 
      alias emacsc="emacsclient -c -a emacs"
      alias garbitch="sudo $(echo $HOME)/.scripts/scripts/system/nix-garbage.sh"
        # --ecryptfs
          alias mount.crypt="mount.ecryptfs_private"
          alias umount.crypt="umount.ecryptfs_private"
          alias ikey="insert.sh"

      PATH="$HOME/.scripts/scripts:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"
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
