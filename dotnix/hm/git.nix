{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "37375448+Builditluc@users.noreply.github.com";
    userName = "Builditluc";
    ignores = [ "*~" ".DS_Store" ".diff" ];
    extraConfig = {
      core = { editor = "nvim"; filemode = false; };
      pull = { rebase = true; };
    };
  };
}
