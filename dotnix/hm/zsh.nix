{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa";
      c = "cargo";
      vf = "vifm";
      v = "nvim";
      lgit = "lazygit";
      config = "git --git-dir=$HOME/dotfiles --work-tree=$HOME";
    };
    initExtraFirst = ''
      auto-ls-git-onefetch () { if (ls -laF | grep .git/ >> /dev/null); then onefetch; fi; }
      pss () {
        folder=$(pwd)
        filename="Screen Shot $(date +%Y-%m-%d\ at\ %H.%M.%S).png"

        if [ $# -ne 0 ]; then
            if [[ -d $1 ]]; then
                if [ "$1" != "." ]; then folder=$1; fi
            else
                a=$(dirname "$1")
                b=$(basename "$1" .png)

                if [ "$b" != "" ]; then filename=$b.png; fi

                if [ "$a" != "." ]; then folder=$a; fi
            fi
        fi

        osascript -e "tell application \"System Events\" to ¬
                write (the clipboard as «class PNGf») to ¬
                (make new file at folder \"$folder\" ¬
                with properties {name:\"$filename\"})"
    }
    '';
    initExtra = ''
      source /etc/static/zshrc
      path+=("$HOME/.local/bin")
      path+=("$HOME/.cargo/bin")
      path+=("$HOME/Developing/bin")
      export PATH
    '';
    localVariables = { 
      AUTO_LS_COMMANDS = "git-onefetch"; 
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "desyncr/auto-ls"; }
        { name = "zsh-users/zsh-autosuggestions"; }
      ];
    };
  };  
}
