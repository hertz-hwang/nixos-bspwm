{ config, lib, pkgs, inputs, user, ... }: {

  home.packages = with pkgs; [
    kate
    dragon
    neofetch
    pulsemixer
    lsd
    tdesktop
    flameshot
    vivaldi
    vivaldi-widevine
    vivaldi-ffmpeg-codecs
    kitty
    rofi
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    mpd
    polybar
    nitrogen
    picom-next
    cava
    jack2
    qjackctl
    gimp
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "lsd -alhF";
      update = "nix flake update";
      upgrade = "sudo nixos-rebuild switch --flake .#jaus";
    };
    history = {
      size = 10000;
      path = "/${config.xdg.dataHome}zsh/history"; 
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "ys";
    };
  };

  programs.git = {
    enable = true;
    userName = "Jaus_Hwang";
    userEmail = "jaus_hwang@88.com";
    extraConfig = { init = { defaultBranch = "main"; }; };
  };
  home.file = {
    ".xprofile" = {
      source = ./resources/.xprofile;
      recursive = true;
    };
    ".config/bspwm" = {
      source = ./resources/bspwm;
      recursive = true;
    };
    ".config/sxhkd" = {
      source = ./resources/sxhkd;
      recursive = true;
    };
    ".config/polybar" = {
      source = ./resources/polybar;
      recursive = true;
    };
    ".config/rofi" = {
      source = ./resources/rofi;
      recursive = true;
    };
    ".config/picom" = {
      source = ./resources/picom;
      recursive = true;
    };
    ".config/kitty" = {
      source = ./resources/kitty;
      recursive = true;
    };
    ".config/mpd" = {
      source = ./resources/mpd;
      recursive = true;
    };
    ".local/share/fonts" = {
      source = ./resources/fonts;
      recursive = true;
    };
  };
}
