{pkgs, ...}: {
  imports = [
    ./config.nix
    ./firefox.nix
    #./gnome.nix
    ./helix.nix
    ./nvim.nix
    ./uhd.nix
    ./sway.nix # done by home-manager
  ];
}
