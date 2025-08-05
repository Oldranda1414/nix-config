{
  description = "A very basic flake";

  inputs = {
    # nixpkgs version
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # system theming
    stylix.url = "github:danth/stylix";
    # text editor
    nixvim.url = "github:nix-community/nixvim";

    # user config management
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

    # Generate NixOS configurations for each host in the `hosts` directory.
    nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host;
          value = nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
            };
            modules = [ 
              ./hosts/${host}
              stylix.nixosModules.stylix
              home-manager.nixosModules.default
            ];
          };
        }) (builtins.attrNames (builtins.readDir ./hosts))
      );
  };
}
