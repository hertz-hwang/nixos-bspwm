{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      neofetch
      bpytop
      xfce.thunar
      pulsemixer
      polybar
      htop
      leafpad
      tdesktop
      flameshot
      qjackctl
      pavucontrol
      ardour
      cava
      ncmpcpp
    ];
  };
}
