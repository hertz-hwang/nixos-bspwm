{ config, lib, pkgs, user, ... }:

{
  services = {
    xserver = {
      enable = true;
      desktopManager.xfce = {
	thunarPlugins = with pkgs; [
          xfce.thunar-archive-plugin
          xfce.thunar-volman
          xfce.thunar-media-tags-plugin
        ];
      };
      windowManager = {
        bspwm = {
	  enable = true;
	};
      };
      displayManager = {
        lightdm = {
          enable = true;
	  background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
	  greeters = {
	    gtk = {
	      theme = {
	        name = "Dracula";
		package = pkgs.dracula-theme;
	      };
	      cursorTheme = {
	        name = "Dracula-cursors";
		package = pkgs.dracula-theme;
		size = 16;
	      };
	    };
	  };
	};
        defaultSession = "none+bspwm";
      };
    };
  };
}
