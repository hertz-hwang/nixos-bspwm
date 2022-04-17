{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    dotDir = ".config/zsh";
    shellAliases = {
      cdconf = "cd ~/.config/nix-config";
      update = "nix flake update";
      upgrade = "doas nixos-rebuild switch --flake .#world";
      fars = "curl -F 'c=@-' 'https://fars.ee/' <";
    };
    history = {
      size = 10000;
      save = 10000;
      path = ".config/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      #custom = "PATH";
      plugins = [ "git" ];
      theme = "agnoster";
      extraConfig = ''
      '';
    };
  };
}
