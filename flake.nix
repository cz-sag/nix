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

  outputs = { self, nixpkgs, disko, home-manager } @inputs: 
  let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
    shared = [ 
      shared/config.nix
      shared/firefox.nix
      shared/gnome.nix
      shared/uhd.nix
      users/user.nix
      home-manager.nixosModules.home-manager
      disko.nixosModules.disko
    ];
  in {
    # Devshell
   devShells = forAllSystems ( system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in import ./shell.nix { inherit pkgs; }
    );
    # Systems
    nixosConfigurations = {
        goofy-liskov = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = shared ++ [ hosts/goofy_liskov/config.nix ];
        };
        hopeful-golick = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = shared;
      };
    };
  };
}

