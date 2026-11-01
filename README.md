# Nixri

A personal, modular NixOS configuration built around **Niri**, **Noctalia**, and **Home Manager**.

Designed to be modular, reproducible, and easy to customize.

## Preview

<!-- Incomming -->

## Features

- **NixOS** – Declarative system configuration.
- **Niri** – Scrollable-tiling Wayland compositor.
- **Noctalia** – Desktop shell and status bar.
- **Home Manager** – Declarative user environment management.
- **Flakes** – Reproducible system configurations.
- **Modular architecture** – Separate modules for desktop environments, applications, and system components.
- **Centralized variables** – Customize applications and desktop preferences from a single configuration.

## Structure

```text
Nixri/
├── flake.nix
├── flake.lock
├── hosts/
│   └── Doom/
├── modules/
│   ├── core/
│   ├── desktop/
│   └── programs/
├── home.nix
└── README.md
```

## Installation

<!-- Incomming -->

## Customization

Most system preferences are managed through centralized variable files.

You can customize:
- Desktop environment
- Terminal emulator
- Browser
- Text editor
- File manager
- Desktop shell and appearance

Modify the appropriate variable files and rebuild your system.

## Requirements

- NixOS
- Nix with Flakes enabled
- Git

## Acknowledgements

- [Sly-Harvey/NixOS](https://github.com/Sly-Harvey/NixOS) – Full Copy Except added Niri desktop and some features
- [NixOS](https://nixos.org/) – The declarative operating system.
- [Niri](https://github.com/YaLTeR/niri) – Scrollable-tiling Wayland compositor.
- [Noctalia](https://github.com/noctalia-dev/noctalia-shell) – Desktop shell.
