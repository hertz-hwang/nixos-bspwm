{
  description = "My personal NixOS/Home-manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      user = "jaus";
    in {
      nixosConfigurations = (
        import ./nixos {
	  inherit (nixpkgs) lib;
	  inherit inputs user system home-manager;
	}
      );
    };
}
