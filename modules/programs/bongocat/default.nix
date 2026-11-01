{
  imports = [
    ./nixos-module.nix
  ];

  programs.wayland-bongocat = {
    enable = true;

    autostart = true;

    catHeight = 180;
    catAlign = "right";
    catXOffset = 0;
    catYOffset = 35;
    overlayHeight = 190;
    overlayOpacity = 0;
    overlayPosition = "bottom";

    layer = "top";

    fps = 60;
    keypressDuration = 100;
    enableHandMapping = true;

    inputDevices = [ ];
    inputDeviceNames = [
      "AT Translated Set 2 keyboard"
    ];
  };
}

