{ config, pkgs, user, ... }:

{
  services = {
    xserver = {
      enable = true;
      desktopManager.xfce = {
        enable = true;
	thunarPlugins = with pkgs; [
          xfce.thunar-archive-plugin
          xfce.thunar-volman
          xfce.thunar-media-tags-plugin
        ];
      };
      displayManager.defaultSession = "xfce";
    };
    picom = {
      enable = true;
      fade = true;
      inactiveOpacity = 0.9;
      shadow = false;
      fadeDelta = 4;
    };
  };
}
