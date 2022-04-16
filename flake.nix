{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      user = "jaus";
    in {
      nixosConfigurations = {
        ${user} = lib.nixosSystem {
	  inherit system;
	  modules = [
	    ./configuration.nix
	    home-manager.nixosModules.home-manager {
	      home-manager = {
	        useGlobalPkgs = true;
		useUserPackages = true;
		users.${user} = {
		  imports = [ ./home.nix ];
		};
	      };
	    }
	  ];
	};
      };

    };

}
