{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
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
    extraSpecialArgs = { inherit inputs; };
    specialArgs = { inherit system; };
    modules = [
      ./nixos/configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  };

  };
}
