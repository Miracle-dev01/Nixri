{pkgs, ...}:
let 
    flakePath = "$HOME/ZyNixOS/flake.nix";
in

pkgs.writeShellScriptBin "keybinds-yad" ''
  if ${pkgs.procps}/bin/pidof rofi >/dev/null; then
    ${pkgs.procps}/bin/pkill rofi
  fi

  if ${pkgs.procps}/bin/pidof yad >/dev/null; then
    ${pkgs.procps}/bin/pkill yad
  fi

  get_nix_value() {
    ${pkgs.gawk}/bin/awk '
      /settings = {/ {inside_settings=1; next}
      inside_settings && /}/ {inside_settings=0}
      inside_settings && $0 ~ key {
        print gensub(/.*"([^"]+)".*/, "\\1", "g", $0)
      }
    ' key="$1" "${flakePath}"
  }

  _browser=$(get_nix_value "browser =")
  _terminal=$(get_nix_value "terminal =")
  _fileManager=$(get_nix_value "fileManager =")

  ${pkgs.yad}/bin/yad \
    --center \
    --title="Hyprland Keybinds" \
    --no-buttons \
    --list \
    --width=745 \
    --height=920 \
    --column="Key:" \
    --column="Description:" \
    --column="Command:" \
    "──── APPLICATIONS ────" "" "" \
    "SUPER Return" "Launch terminal" "$_terminal" \
    "SUPER T" "Launch terminal" "$_terminal" \
    "SUPER E" "Launch file manager" "$_fileManager" \
    "SUPER B" "Launch browser" "$_browser" \
    "SUPER SHIFT S" "Launch Spotify" "spotify" \
    "SUPER A" "Launch application menu" "launcher drun" \
    "SUPER SPACE" "Launch application menu" "launcher drun" \
    "SUPER SHIFT W" "Launch wallpaper menu" "launcher wallpaper" \
    "SUPER SHIFT T" "Launch tmux sessions" "launcher tmux" \
    "SUPER G" "Game launcher" "launcher games" \
    "SUPER Z" "Launch emoji picker" "launcher emoji" \
    "SUPER SHIFT M" "Online music" "rofimusic" \
    "──── SYSTEM ────" "" "" \
    "CTRL ALT Delete" "Open system monitor" "$_terminal -e btop" \
    "SUPER U" "Rebuild system" "$_terminal -e rebuild" \
    "SUPER ALT L" "Lock screen" "hyprlock" \
    "SUPER Backspace" "Power menu" "wlogout -b 4" \
    "SUPER Delete" "Exit Hyprland session" "exit" \
    "CTRL Escape" "Toggle bar" "pkill waybar; pkill hyprpanel; waybar" \
    "SUPER SHIFT N" "Open notification panel" "swaync-client -t -sw" \
    "SUPER SHIFT Q" "Open notification panel" "swaync-client -t -sw" \
    "SUPER V" "Clipboard manager" "clipmanager" \
    "SUPER ALT G" "Enable game mode" "gamemode" \
    "──── WINDOWS ────" "" "" \
    "SUPER Q" "Close active window" "killactive" \
    "ALT F4" "Force kill active window" "forcekillactive" \
    "SUPER W" "Toggle floating window" "togglefloating" \
    "SUPER SHIFT G" "Toggle window group" "togglegroup" \
    "ALT Return" "Toggle fullscreen" "fullscreen" \
    "SUPER, Left Click" "Move window with mouse" "movewindow" \
    "SUPER, Right Click" "Resize window with mouse" "resizewindow" \
    "──── WINDOW FOCUS ────" "" "" \
    "SUPER ←" "Move focus left" "movefocus l" \
    "SUPER →" "Move focus right" "movefocus r" \
    "SUPER ↑" "Move focus up" "movefocus u" \
    "SUPER ↓" "Move focus down" "movefocus d" \
    "ALT Tab" "Move focus down" "movefocus d" \
    "SUPER Tab" "Cycle next window" "cyclenext" \
    "──── WINDOW MOVEMENT ────" "" "" \
    "SUPER SHIFT CTRL ←" "Move window left" "movewindow l" \
    "SUPER SHIFT CTRL →" "Move window right" "movewindow r" \
    "SUPER SHIFT CTRL ↑" "Move window up" "movewindow u" \
    "SUPER SHIFT CTRL ↓" "Move window down" "movewindow d" \
    "──── WINDOW RESIZE ────" "" "" \
    "SUPER SHIFT →" "Resize window right" "resizeactive 30 0" \
    "SUPER SHIFT ←" "Resize window left" "resizeactive -30 0" \
    "SUPER SHIFT ↑" "Resize window up" "resizeactive 0 -30" \
    "SUPER SHIFT ↓" "Resize window down" "resizeactive 0 30" \
    "SUPER SHIFT L" "Resize right (HJKL)" "resizeactive 30 0" \
    "SUPER SHIFT H" "Resize left (HJKL)" "resizeactive -30 0" \
    "SUPER SHIFT K" "Resize up (HJKL)" "resizeactive 0 -30" \
    "SUPER SHIFT J" "Resize down (HJKL)" "resizeactive 0 30" \
    "──── WORKSPACES ────" "" "" \
    "SUPER 1-0" "Switch to workspace 1-10" "workspace 1-10" \
    "SUPER ALT 10-20" "Switch to workspace 10-20" "workspace 10-20" \
    "SUPER SHIFT 1-0" "Move to workspace 1-10" "movetoworkspace 1-10" \
    "SUPER CTRL →" "Switch to next workspace" "workspace r+1" \
    "SUPER CTRL ←" "Switch to previous workspace" "workspace r-1" \
    "SUPER CTRL ↓" "Go to first empty workspace" "workspace empty" \
    "──── SCRATCHPAD ────" "" "" \
    "SUPER CTRL S" "Move to scratchpad" "movetoworkspacesilent special" \
    "SUPER S" "Toggle scratchpad workspace" "togglespecialworkspace" \
    "──── AUDIO ────" "" "" \
    "XF86AudioLowerVolume" "Lower volume" "pamixer -d 2" \
    "XF86AudioRaiseVolume" "Increase volume" "pamixer -i 2%" \
    "XF86AudioMicMute" "Mute microphone" "pamixer --default-source -t" \
    "SUPER M" "Mute microphone" "pamixer --default-source -t" \
    "XF86AudioMute" "Mute audio" "pamixer -t" \
    "XF86AudioPlay" "Play/Pause media" "playerctl play-pause" \
    "XF86AudioNext" "Next media track" "playerctl next" \
    "XF86AudioPrev" "Previous media track" "playerctl previous" \
    "──── DISPLAY ────" "" "" \
    "XF86MonBrightnessDown" "Decrease brightness" "brightnessctl set 2%-" \
    "XF86MonBrightnessUp" "Increase brightness" "brightnessctl set +2%" \
    "SUPER F9" "Enable night mode" "hyprsunset --temperature 2500" \
    "SUPER F10" "Disable night mode" "pkill hyprsunset" \
    "SUPER CTRL mouse_down" "Zoom in" "zoom in" \
    "SUPER CTRL mouse_up" "Zoom out" "zoom out" \
    "──── SCREENSHOT ────" "" "" \
    "SUPER P" "Screenshot (select area)" "screenshot s" \
    "SUPER CTRL P" "Screenshot (frozen screen)" "screenshot sf" \
    "SUPER Print" "Screenshot (current monitor)" "screenshot m" \
    "SUPER ALT P" "Screenshot (all monitors)" "screenshot p" \
    "──── RECORDING ────" "" "" \
    "SUPER SHIFT R" "Screen record (select area)" "screen-record a" \
    "SUPER CTRL R" "Screen record (select monitor)" "screen-record m" \
    "──── UTILITIES ────" "" "" \
    "SUPER D" "Useful Commands" "kitty bash -c ".."" \
    "SUPER CTRL C" "Colour picker" "hyprpicker --autocopy" \
    "SUPER ALT K" "Change keyboard layout" "keyboardswitch"\
    "────── BONGO ──────" "" "" \
    "SUPER F" "Bongo" "bongo-exec --toggle"\
''
