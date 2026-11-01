

{ pkgs, ... }:

pkgs.writeShellScriptBin "bluetooth" ''
  # Dependencies
  BLUETOOTHCTL="${pkgs.bluez}/bin/bluetoothctl"
  FZF="${pkgs.fzf}/bin/fzf"
  NOTIFY="${pkgs.libnotify}/bin/notify-send"
  GREP="${pkgs.gnugrep}/bin/grep"
  AWK="${pkgs.gawk}/bin/awk"
  SLEEP="${pkgs.coreutils}/bin/sleep"
  TPUT="${pkgs.ncurses}/bin/tput"

  RED='\033[1;31m'
  GREEN='\033[1;32m'
  RST='\033[0m'

  TIMEOUT=10

  # Restore cursor on exit
  trap '"$TPUT" cnorm 2>/dev/null' EXIT

  notify() {
    "$NOTIFY" -e -t 2500 -u low "$@"
  }

  get-device-list() {
    "$BLUETOOTHCTL" power on >/dev/null 2>&1
    "$BLUETOOTHCTL" agent on >/dev/null 2>&1
    "$BLUETOOTHCTL" default-agent >/dev/null 2>&1

    printf 'Scanning for Bluetooth devices...\n'

    "$BLUETOOTHCTL" --timeout "$TIMEOUT" scan on >/dev/null 2>&1

    devices=$(
      "$BLUETOOTHCTL" devices | while read -r _ mac name; do
        [[ -z $mac ]] && continue

        info=$("$BLUETOOTHCTL" info "$mac" 2>/dev/null)

        paired="New"
        connected=""

        if "$GREP" -q 'Paired: yes' <<< "$info"; then
          paired="Paired"
        fi

        if "$GREP" -q 'Connected: yes' <<< "$info"; then
          connected="Connected"
        fi

        printf '%-20s %-10s %-12s %s\n' \
          "$mac" "$paired" "$connected" "$name"
      done
    )

    printf '\n%bScanning Finished.%b\n\n' "$GREEN" "$RST"

    if [[ -z $devices ]]; then
      notify "Bluetooth" "No devices found" -i "bluetooth-disabled"
      return 1
    fi
  }

  select-device() {
    local header
    header="MAC Address          Status     Connection   Device"

    local opts=(
      --border=sharp
      --border-label=' Bluetooth Devices '
      --ghost='Search devices'
      --header="$header"
      --height=~100%
      --highlight-line
      --info=inline-right
      --pointer=
      --reverse
    )

    mac=$(
      "$FZF" "''${opts[@]}" <<< "$devices" |
        "$AWK" '{print $1}'
    )

    [[ -z $mac ]] && return 1
  }

  connect-device() {
    local info
    info=$("$BLUETOOTHCTL" info "$mac" 2>/dev/null)

    if "$GREP" -q 'Connected: yes' <<< "$info"; then
      printf 'Disconnecting...\n'

      if "$BLUETOOTHCTL" disconnect "$mac"; then
        notify "Bluetooth" "Device disconnected" -i "bluetooth-active"
      else
        notify "Bluetooth" "Failed to disconnect" -i "dialog-error"
      fi

      return
    fi

    if ! "$GREP" -q 'Paired: yes' <<< "$info"; then
      printf 'Pairing device...\n'

      if ! "$BLUETOOTHCTL" pair "$mac"; then
        notify "Bluetooth" "Pairing failed" -i "dialog-error"
        return 1
      fi
    fi

    printf 'Trusting device...\n'
    "$BLUETOOTHCTL" trust "$mac" >/dev/null 2>&1

    printf 'Connecting...\n'

    if "$BLUETOOTHCTL" connect "$mac"; then
      notify "Bluetooth" "Successfully connected" -i "bluetooth-active"
    else
      notify "Bluetooth" "Failed to connect" -i "dialog-error"
      return 1
    fi
  }

  main() {
    local status
    status=$("$BLUETOOTHCTL" show)

    if ! "$GREP" -q 'Powered: yes' <<< "$status"; then
      "$BLUETOOTHCTL" power on
      notify "Bluetooth" "Bluetooth enabled" -i "bluetooth-active"
    fi

    "$TPUT" civis

    get-device-list || exit 1

    "$TPUT" cnorm

    select-device || exit 1

    connect-device
  }

  main
''

