{ lib, inputs, ... }:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  services = {
    flatpak = {
      enable = true;

      # remotes = lib.mkOptionDefault [
      #   {
      #     name = "penguinburner";
      #     location = "https://jpietek.github.io/PenguinBurner/penguin-burner.flatpakrepo";
      #   }
      # ];

      # List the Flatpak applications you want to install
      # Use the official Flatpak application ID (e.g., from flathub.org)
      # Examples:
      packages = [
        "com.github.tchx84.Flatseal" # Manage flatpak permissions - should always have this
        "io.github.flattool.Warehouse" # Manage flatpaks, clean data, remove flatpaks and deps
        "io.github.Faugus.faugus-launcher"
        "it.mijorus.gearlever"           # Manage and support AppImages
        "com.rtosta.zapzap"              # WhatsApp client

        # "io.github.dvlv.boxbuddyrs"      #  Manage distroboxes
        "de.schmidhuberj.tubefeeder"     # watch YT videos

        # Add other Flatpak IDs here, e.g., "org.mozilla.firefox"
        # { appId = "io.github.jpietek.PenguinBurner"; origin = "penguinburner";  }
      ];

      overrides.settings.global = {
        Context.filesystem = [
          "xdg-config/Kvantum:ro"
        ];
        Environment = {
          QT_STYLE_OVERRIDE = "kvantum";
        };
      };

      # Optional: Automatically update Flatpaks when you run nixos-rebuild swit ch
      update.onActivation = true;
    };
  };
}
