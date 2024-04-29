{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = { self, nixpkgs, disko, home-manager}@inputs: 
  let
    shared = [ shared/config.nix disko.nixosModules.disko ];
  in {
    nixosConfigurations.goofy_liskov = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = shared ++ [ hosts/goofy_liskov/config.nix ];
    };
  };
}
