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
    shared = [ 
      shared/config.nix
      shared/gnome.nix
      users/user.nix
      home-manager.nixosModules.home-manager
      disko.nixosModules.disko
    ];
  in {
    nixosConfigurations.goofy-liskov = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = shared ++ [ hosts/goofy_liskov/config.nix ];
    };
  };
}
