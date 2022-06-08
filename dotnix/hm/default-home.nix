{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "21.11";

  home.packages = with pkgs; [
    # cli tools
    gh
    exa
    bat
    wget
    git
    lazygit
    vifm
    btop

    onefetch
    neofetch

    # docker stuff
    docker
    # docker-compose # broken

    # video/audio stuff
    yt-dlp    
    ffmpeg
    mpv
  ];
}
