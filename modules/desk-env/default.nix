{ config, pkgs, user, ... }:

{
  imports = [
    #./xfce/xfce.nix
    ./bspwm/bspwm.nix
  ];
}
