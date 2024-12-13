{pkgs, ...}: {
  imports = [
    ./config.nix
    ./firefox.nix
    #./gnome.nix
    ./helix.nix
    ./nvim.nix
    ./networking.nix
    ./uhd.nix
    ./virt.nix
    ./sway.nix # done by home-manager
  ];
}
