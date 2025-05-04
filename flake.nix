{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hydenix = {
      url = "github:richen604/hydenix";
    };
  };

  outputs = { self, nixpkgs, home-manager, hydenix, ... } @ inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
	  hydenix = hydenix.packages.${system};
	})
      ];

      config = {
      	allowUnfree = true;
      };
    };

  in
  {

  nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    modules = [
      ./nixos/configuration.nix

      inputs.home-manager.nixosModules.default
    ];
    specialArgs = { inherit inputs pkgs; };
  };

  };
}
