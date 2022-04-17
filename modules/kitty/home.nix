{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 15;
    };
    theme = "Nord";
  };
}
