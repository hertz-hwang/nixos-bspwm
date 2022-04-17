{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    package = pkgs.picom-next;
    experimentalBackends = true;
    blur = true;
    blurExclude = [
      "class_i = 'polybar'"
    ];
    activeOpacity = "1.0";
    inactiveOpacity = "1.0";
    menuOpacity = "1.0";
    opacityRule = [
      "85:class_i = 'kitty'"
      "100:class_i ~= 'Vivaldi$'"
    ];
    shadow = false;
    shadowOffsets = [ (-15) (-15) ];
    shadowOpacity = "0.8";
    shadowExclude = [
      "window_type *= 'menu'"
      "name ~= 'Firefox$'"
      #"focused = 1"
    ];
    fade = true;
    fadeDelta = 4;
    fadeSteps = [ "0.03" "0.03" ];
    inactiveDim = "0.1";
    vSync = true;
    extraOptions = ''
      transition-length = 300;
      transition-pow-x = 0.7;
      transition-pow-y = 0.7;
      transition-pow-w = 0.7;
      transition-pow-h = 0.7;
      size-transition = true;
      corner-radius = 20.0;
      round-borders = 4;
      rounded-corners-exclude = [
        "class_g = 'Polybar'",
      ];
      shadow-radius = 0;
      blur: {
        method = "dual_kawase";
      };
    '';
  };
}
