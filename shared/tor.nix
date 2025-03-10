{ config, pkgs, ... }:
let
  run-tor-host = pkgs.writeScriptBin "run-tor-browser.sh" ''
    #!/bin/sh
    ${pkgs.socat}/bin/socat -d TCP-LISTEN:6000,fork,bind=192.168.7.10 UNIX-CONNECT:/tmp/.X11-unix/X0 &
    SOCAT_PID=$!
    ${pkgs.xorg.xhost}/bin/xhost +
    ${pkgs.pulseaudio}/.bin-unwrapped/pactl load-module module-native-protocol-tcp auth-ip-acl=192.168.7.11 port=4656 listen=192.168.7.10
    PACTL_PID=$!
    ${pkgs.waypipe}/bin/waypipe ssh browser@192.168.7.11 run-tor-browser.sh
    kill $SOCAT_PID
    kill $PACTL_PID
  '';

  run-tor-container = pkgs.writeScriptBin "run-tor-browser.sh" ''
    #!/bin/sh
    ${pkgs.pulseaudio}/.bin-unwrapped/pactl load-module module-tunnel-sink server=tcp:192.168.7.10:4656
    ${pkgs.tor-browser}/bin/tor-browser $@
  '';
in {
  # relay usable on host
  services.tor.enable = true;
  services.tor.client.enable = true;
  environment.systemPackages = [ run-tor-host ];

  #networking setup for containerized browser
  networking.firewall.allowedTCPPorts = [ 4656 ];
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-tor-browser"];
    externalInterface = "enp4s0";
  };

  # container for browser
  containers.tor-browser = {
    tmpfs = [
      "/var"
      "/home"
      "/root"
    ];
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.7.10";
    localAddress = "192.168.7.11";
    config = {config, pkgs, ... }: {
      services.openssh = {
        enable = true;
        settings = {
          X11Forwarding = true;
          PasswordAuthentication = false;
        };
      };

      users.extraUsers.browser = {
        isNormalUser = true;
        home = "/home/browser";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJe8i35RxB4wAbD+eL/uLHM2JdGcPfk78rCxE1zuyYyn user@nixos"
        ];
        extraGroups = ["audio" "video"];
      };
      environment.systemPackages = [
        run-tor-container
        pkgs.waypipe
        pkgs.pulseaudio
      ];
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
    };
  };

  
}
