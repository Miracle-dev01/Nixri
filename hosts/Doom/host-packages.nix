{ pkgs,inputs, ... }:

  {
  environment.systemPackages = with pkgs; [
    obsidian # Best note taker
    ludusavi # For game saves
    godot # For game development
    proton-vpn # VPN
    github-desktop # Self explanatory
    tree-sitter # Neovim dependency
    localsend # Amazing File sharing took
    flatpak # Application Store
    pokego # Overlayed Pokemon
    transmission_4-qt # Torrenting Application
    mousepad # Basic Notepad
    vscode # Code Editort

    exiftool # Metadata reader for images

    bluetuith # tui version of bluetoothctl

    #fetch # 3d fastfetch
    thunar # optional file-manager
    inkscape # image-editor

    hplipWithPlugin # hp printer support

    cmatrix # Dont worry about it

    alacritty

    # DwarFS 0.15.6
    # dwarfs

    # Photo editor
    kdePackages.gwenview
    gdk-pixbuf
    libwebp
    kdePackages.kimageformats
    imagemagick

    snapshot # Basic Cmera
    # Peripheral mobile device compatibility tool
    libimobiledevice
    ifuse
    usbutils
    gvfs
    android-file-transfer
    glib

    # Image modifier
    python3Packages.img2pdf
    
    inputs.sda-qt6.packages.${system}.default
    # Zen-Browser
    # inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    # lua-language-server

    # All-in-one front-end for emulators
    (retroarch.withCores (cores: with cores; [
      citra # Nintendo - 3DS
      dolphin # Nintendo - GameCube / Wii
      # fbneo # Arcade
      flycast # Sega - Dreamcast / Naomi
      genesis-plus-gx # Sega - MD/SG/GG/MD/CD
      melondsds
      melonds # Nintendo - DS
      mgba # Nintendo - Game Boy Advance
      mupen64plus # Nintendo - N64
      pcsx2 # Sony - PlayStation 2
      ppsspp # Sony - PlayStation Portable (PSP)
      picodrive # Sega - MD/32X
      prosystem # Atari - 7800 / 2600
      sameboy # Nintendo - Game Boy / Color
      snes9x # Nintendo - SNES / SFC
      swanstation # Sony - PlayStation
    ]))
  ];
}
