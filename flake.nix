{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... } @ inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
      	allowUnfree = true;
      };
    };

  in
  {

  nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    modules = [
      ./nixos/configuration.nix

      stylix.nixosModules.stylix

      inputs.home-manager.nixosModules.default
    ];
    specialArgs = { inherit inputs; };
  };

  };
}
