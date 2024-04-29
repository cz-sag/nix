{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    diskio = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = { self, nixpkgs, diskio, home-manager}: 
  let
    shared = [ shared/config.nix diskio.nixosModules.diskio ];
  in {
    nixosConfigurations.goofy_liskov = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = shared ++ [ hosts/goofy_liskov/config.nix ];
    };
  };
}
