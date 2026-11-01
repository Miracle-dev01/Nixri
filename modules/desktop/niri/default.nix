# modules/desktop/niri/default.nix
{ pkgs, inputs, ... }:

let
  vars = import ../../../hosts/Doom/variables.nix;

  # Build the script derivation locally
  fileManagerScript = pkgs.callPackage ./scripts/file-manager.nix {
    terminal = vars.terminal or "kitty";
  };
in
{
  imports = [
    inputs.noctalia.nixosModules.default
    ./programs/noctalia
  ];

  programs.niri.enable = true;

  home-manager.sharedModules = [
    (_: {
      xdg.configFile."niri/config.kdl".source = ./config.kdl;

      xdg.configFile."niri/cfg/animation.kdl".source = ./cfg/animation.kdl;
      xdg.configFile."niri/cfg/autostart.kdl".source = ./cfg/autostart.kdl;
      xdg.configFile."niri/cfg/display.kdl".source = ./cfg/display.kdl;
      xdg.configFile."niri/cfg/input.kdl".source = ./cfg/input.kdl;
      xdg.configFile."niri/cfg/layout.kdl".source = ./cfg/layout.kdl;
      xdg.configFile."niri/cfg/misc.kdl".source = ./cfg/misc.kdl;
      xdg.configFile."niri/cfg/rules.kdl".source = ./cfg/rules.kdl;

      # Inject the precise store path via keybinds.kdl.nix
      xdg.configFile."niri/cfg/keybinds.kdl".text =
        import ./cfg/keybinds.kdl.nix { inherit vars fileManagerScript; };
    })
  ];

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  environment.systemPackages = with pkgs; [
    swaylock
    swayidle
    kitty
    # fileManagerScript is intentionally omitted here to keep PATH clean!
  ];
}
