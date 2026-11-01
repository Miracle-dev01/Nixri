{ pkgs, terminal }:

pkgs.writeShellScriptBin "file-manager" ''
  manager="''${1:-yazi}"

  case "$manager" in
    thunar)   exec thunar ;;
    dolphin)  exec dolphin ;;
    nautilus) exec nautilus ;;
    pcmanfm)  exec pcmanfm ;;
    nemo)     exec nemo ;;

    yazi)     exec "kitty" --class fileManager -e yazi ;;
    lf)       exec "kitty" --class fileManager -e lf ;;
    nnn)      exec "kitty" --class fileManager -e nnn ;;
    ranger)   exec "kitty" --class fileManager -e ranger ;;
    mc)       exec "kitty" --class fileManager -e mc ;;

    *)
      echo "Unknown file manager: $manager"
      exit 1
      ;;
  esac
''
