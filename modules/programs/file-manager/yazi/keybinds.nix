{
          mgr.prepend_keymap = [
            # recycle-bin plugin
            {
              on = [
                "R"
                "b"
              ];
              run = "plugin recycle-bin";
              desc = "Open Recycle Bin Menu";
            }

            # chmod plugin
            {
              on = [
                "R"
                "x"
              ];
              run = "plugin chmod";
              desc = "Chmod on selected files";
            }

            # compress plugin
            {
              on = [
                "<S-c>"
                "a"
              ];
              run = "plugin compress";
              desc = "Compress selected files";
            }
            {
              on = [
                "<S-c>"
                "p"
              ];
              run = "plugin compress -p";
              desc = "Compress selected files (password)";
            }
            {
              on = [
                "<S-c>"
                "h"
              ];
              run = "plugin compress -ph";
              desc = "Compress selected files (password+header)";
            }
            {
              on = [
                "<S-c>"
                "l"
              ];
              run = "plugin compress -l";
              desc = "Compress selected files (compression level)";
            }
            {
              on = [
                "<S-c>"
                "u"
              ];
              run = "plugin compress -phl";
              desc = "Compress selected files (password+header+level)";
            }

            {
              on = "q";
              run = "close";
            }
            {
              on = [ "e" ];
              run = "open";
            }
             {
               on = [ "<S-o>" ];
               run = "open --interactive";
               desc = "Open with..";
             }
            {
              on = [
                "g"
                "D"
              ];
              run = "cd /home/miracle/Documents";
            }
            {
              on = [
                "g"
                "p"
              ];
              run = "cd /mnt/work/Projects";
            }
            {
              on = [
                "g"
                "P"
              ];
              run = "cd /mnt/games/Windows/Pirate";
            }
          ];
        }