{pkgs, ...}: {
  users.users.user = {
    isNormalUser = true;
    home = "/home/user";
    description = "user";
    extraGroups = ["wheel" "networkmanager" "dialout" "wireshark" "docker" ];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJe8i35RxB4wAbD+eL/uLHM2JdGcPfk78rCxE1zuyYyn user@nixos"];
    initialHashedPassword = "$y$j9T$fvSkv2fMuiZEl4Tiy3ufG.$wk/2oZhGLKd4n.jVZrIDhODtfuXVRjjJegPQFk06aS5";
  };
  home-manager = {
    users.user = {
      imports = [./user_home.nix];
      programs.git = {
        enable = true;
        userName = "user";
        userEmail = "user@nixos";
      };
      home.stateVersion = "23.11";
    };
  };
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}
