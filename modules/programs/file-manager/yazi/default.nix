{ pkgs, lib, ... }:
let
  initLua = import ./plugins { inherit lib; };
  openerConfig = import ./openers.nix;
  keybindConfig = import ./keybinds.nix;
in
{
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [ trash-cli ];
      programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

        # Fixes 7z/RAR extraction errors inside Yazi by using the unfree 7zz package with RAR support
        package = pkgs.yazi.override {
          _7zz = pkgs._7zz-rar;
        };

        initLua = initLua;

        plugins = {
          compress = pkgs.yaziPlugins.compress; # Compressing tool
          chmod = pkgs.yaziPlugins.chmod; # Permissions tool
          recycle-bin = pkgs.yaziPlugins.recycle-bin; # trash-cli integration
        };
        settings = openerConfig // {
          mgr = {
            show_hidden = false;
            show_symlink = true;
            sort_dir_first = true;
            linemode = "size"; # or size, permissions, owner, mtime
            ratio = [
              # or 0 3 4
              1
              3
              4
            ];
          };
          preview = {
            # wrap = "yes";
            tab_size = 4;
            image_filter = "triangle"; # from fast to slow but high quality: nearest, triangle, catmull-rom, lanczos3
            max_width = 1920; # maybe 1000
            max_height = 1080; # maybe 1000
            # max_width = 1500;
            # max_height = 1500;
            image_quality = 90;
          };
        };

        keymap = keybindConfig;

        theme = {
          mgr = {
            border_symbol = " ";
            # border_symbol = "│";
            # border_style = { fg = "gray" } ;
          };
          status = {
            separator_open = "";
            separator_close = "";
          };
        };
      };
    })
  ];
}
