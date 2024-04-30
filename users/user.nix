{ pkgs, ...}:
{
  users.users.user = {
    isNormalUser  = true;
    home  = "/home/user";
    description  = "user";
    extraGroups  = [ "wheel" "networkmanager" "dialout" ];
    openssh.authorizedKeys.keys  = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJe8i35RxB4wAbD+eL/uLHM2JdGcPfk78rCxE1zuyYyn user@nixos" ];
    initialHashedPassword = "$y$j9T$tvJEDhoWVGrQ1THRY3Y7.0$ArQpTFM1U02epH/ip/tjwe8EaAFIM7T2oE5Ok5sckQC";
  };
  home-manager = {
    users.user = {
      imports = [ ./user_home.nix ];
      programs.git = {
        enable = true;
        userName = "user";
        userEmail = "user@nixos";
      };
      home.stateVersion = "23.11";
    };
  };
}
