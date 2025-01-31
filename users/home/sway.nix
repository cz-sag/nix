{ pkgs, ... }:
let
  mod = "Mod4";
  swaylock = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
in {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "alacritty";
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
        {
          command = ''
            ${pkgs.swayidle}/bin/swayidle -w \
            timeout 300 '${swaylock}' \
            timeout 600 'swaymsg output * dpms off' \
                 resume 'swaymsg output * dpms on' \
            before-sleep '${swaylock}'
          '';
        }
      ];
      input = {
#        "type:keyboard" = {
#          xkb_layout="no";
#        };
        "1293:4160:Belkin" = {
          xkb_layout="no";
        };
        "3141:30354:SONiX_USB_Keyboard" = {
          xkb_layout="us";
          xkb_variant="altgr-intl";
        };
      };
      keybindings = {
        "${mod}+0" = "workspace number 10";
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+Down" = "focus down";
        "${mod}+Left" = "focus left";
        "${mod}+Return" = "exec alacritty";
        "${mod}+Right" = "focus right";
        "${mod}+Shift+0" = "move container to workspace number 10";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+Shift+q" = "kill";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+Up" = "focus up";
        "${mod}+a" = "focus parent";
        "${mod}+b" = "splith";
        "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        "${mod}+e" = "layout toggle split";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+minus" = "scratchpad show";
        "${mod}+r" = "mode resize";
        "${mod}+s" = "layout stacking";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+v" = "splitv";
        "${mod}+w" = "layout tabbed";

        "${mod}+Escape" = "exec ${swaylock}";
      };
      modes = {
        "resize" = {
          "Down" = "resize grow height 10 px";
          "Escape" = "mode default";
          "Left" = "resize shrink width 10 px";
          "Return" = "mode default";
          "Right" = "resize grow width 10 px";
          "Up" = "resize shrink height 10 px";
          "h" = "resize shrink width 10 px";
          "j" = "resize grow height 10 px";
          "k" = "resize shrink height 10 px";
          "l" = "resize grow width 10 px";
        };
      };
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];
    };
    extraConfig = ''
      for_window [window_role="pop-up"] floating enable
      for_window [window_role="bubble"] floating enable
      for_window [window_role="task_dialog"] floating enable
      for_window [window_role="Preferences"] floating enable
      for_window [window_type="dialog"] floating enable
      for_window [window_type="menu"] floating enable
      for_window [window_role="About"] floating enable
      for_window [app_id="pavucontrol"] floating enable
    '';
  };
  programs.swaylock = {
    enable = true;
    settings = {
      color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };
}
