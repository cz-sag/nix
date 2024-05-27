{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = {
    self,
    alejandra,
    nixpkgs,
    disko,
    home-manager,
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
    shared = [
      ./shared
      users/user.nix
      home-manager.nixosModules.home-manager
      disko.nixosModules.disko
    ];
  in {
    # Formater
    formatter.x86_64-linux = alejandra.packages.x86_64-linux.default;
    # Devshell
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );
    # Systems
    nixosConfigurations = {
      goofy-liskov = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = shared ++ [hosts/goofy_liskov/config.nix];
      };
      hopeful-golick = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = shared;
      };
    };
  };
}
