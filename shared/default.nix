{pkgs, ...}: {
  imports = [
    ./config.nix
    ./firefox.nix
    ./gnome.nix
    ./uhd.nix
    ./nvim.nix
  ];
}
