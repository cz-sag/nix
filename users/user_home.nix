{pkgs, ...}: {
  imports = [
    ./home/sway.nix
    ./home/helix.nix
  ];
  programs = {
    bash = {
      enable = true;
      shellAliases = {
        ll = "${pkgs.coreutils}/bin/ls -l";
        la = "${pkgs.coreutils}/bin/ls -al";
      };
    };
    alacritty = {
      enable = true;
    };
  };
}
