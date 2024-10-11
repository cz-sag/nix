{pkgs, ...}: {
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
    helix = {
      enable = true;
      settings = {
        theme = "onedarker";
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
      };
    };
  };
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "alacritty";
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
      input = {
        "*" = {
          xkb_layout="no";
        };
      };
    };
  };
}
