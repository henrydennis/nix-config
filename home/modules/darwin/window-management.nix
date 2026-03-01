{ ... }:
{
  programs = {
    alacritty = {
      enable = false;
      settings = {
        terminal.shell.program = "zsh";
      };
    };

    aerospace = {
      enable = true;
      launchd.enable = true;
      userSettings = {
        "after-startup-command" = [ ];
        "start-at-login" = false;
        "enable-normalization-flatten-containers" = true;
        "enable-normalization-opposite-orientation-for-nested-containers" = true;
        "accordion-padding" = 30;
        "default-root-container-layout" = "tiles";
        "default-root-container-orientation" = "auto";
        "on-focused-monitor-changed" = [ "move-mouse monitor-lazy-center" ];
        "automatically-unhide-macos-hidden-apps" = false;
        "key-mapping" = {
          preset = "qwerty";
        };

        gaps = {
          inner.horizontal = 0;
          inner.vertical = 0;
          outer.left = 0;
          outer.bottom = 0;
          outer.top = 0;
          outer.right = 0;
        };

        mode.main.binding = {
          "cmd-ctrl-alt-shift-b" = "exec-and-forget open -a Dia";
          "cmd-ctrl-alt-enter" = "exec-and-forget open -a Ghostty";
          "cmd-ctrl-alt-space" = "exec-and-forget open -a Raycast";
          "cmd-ctrl-alt-shift-f" = "exec-and-forget open .";

          "cmd-ctrl-alt-left" = "focus left";
          "cmd-ctrl-alt-down" = "focus down";
          "cmd-ctrl-alt-up" = "focus up";
          "cmd-ctrl-alt-right" = "focus right";

          "cmd-ctrl-alt-shift-left" = "move left";
          "cmd-ctrl-alt-shift-down" = "move down";
          "cmd-ctrl-alt-shift-up" = "move up";
          "cmd-ctrl-alt-shift-right" = "move right";

          "cmd-ctrl-alt-1" = "workspace 1";
          "cmd-ctrl-alt-2" = "workspace 2";
          "cmd-ctrl-alt-3" = "workspace 3";
          "cmd-ctrl-alt-4" = "workspace 4";
          "cmd-ctrl-alt-5" = "workspace 5";
          "cmd-ctrl-alt-6" = "workspace 6";
          "cmd-ctrl-alt-7" = "workspace 7";
          "cmd-ctrl-alt-8" = "workspace 8";
          "cmd-ctrl-alt-9" = "workspace 9";

          "cmd-ctrl-alt-shift-1" = "move-node-to-workspace 1";
          "cmd-ctrl-alt-shift-2" = "move-node-to-workspace 2";
          "cmd-ctrl-alt-shift-3" = "move-node-to-workspace 3";
          "cmd-ctrl-alt-shift-4" = "move-node-to-workspace 4";
          "cmd-ctrl-alt-shift-5" = "move-node-to-workspace 5";
          "cmd-ctrl-alt-shift-6" = "move-node-to-workspace 6";
          "cmd-ctrl-alt-shift-7" = "move-node-to-workspace 7";
          "cmd-ctrl-alt-shift-8" = "move-node-to-workspace 8";
          "cmd-ctrl-alt-shift-9" = "move-node-to-workspace 9";

          "cmd-ctrl-alt-tab" = "workspace --wrap-around next";
          "cmd-ctrl-alt-shift-tab" = "workspace --wrap-around prev";

          "cmd-ctrl-alt-j" = "layout tiles horizontal vertical";
          "cmd-ctrl-alt-t" = "layout floating tiling";
          "cmd-ctrl-alt-f" = "fullscreen";
          "cmd-ctrl-alt-w" = "close";
          "cmd-ctrl-alt-g" = "layout accordion";
          "cmd-ctrl-alt-shift-g" = "layout tiles";
          "cmd-ctrl-alt-equal" = "resize smart +50";
          "cmd-ctrl-alt-minus" = "resize smart -50";

          "cmd-ctrl-alt-s" = "workspace S";
          "cmd-ctrl-alt-shift-s" = "move-node-to-workspace S";

          "cmd-ctrl-alt-shift-semicolon" = "mode service";
        };

        mode.service.binding = {
          esc = [
            "reload-config"
            "mode main"
          ];
          r = [
            "flatten-workspace-tree"
            "mode main"
          ];
          f = [
            "layout floating tiling"
            "mode main"
          ];
          backspace = [
            "close-all-windows-but-current"
            "mode main"
          ];

          "cmd-ctrl-alt-shift-h" = [
            "join-with left"
            "mode main"
          ];
          "cmd-ctrl-alt-shift-j" = [
            "join-with down"
            "mode main"
          ];
          "cmd-ctrl-alt-shift-k" = [
            "join-with up"
            "mode main"
          ];
          "cmd-ctrl-alt-shift-l" = [
            "join-with right"
            "mode main"
          ];

          down = "volume down";
          up = "volume up";
          "shift-down" = [
            "volume set 0"
            "mode main"
          ];
        };
      };
    };
  };
}
