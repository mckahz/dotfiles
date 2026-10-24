{ inputs, den, ... }:
{
  den.aspects.editor = {
    nixos = { pkgs, ... }: {
      # Allows zed to load dynamic libraries
      programs.nix-ld.enable = true;
      environment.systemPackages = with pkgs; [
        zed-editor
        # godot_4

        nixd
        nil
        nixfmt
        lua-language-server
      ];

      programs.direnv.enable = true;
    };

    hjem = {osConfig, ...}: {
      xdg.config.files."zed/settings.json".source = "${osConfig.flake}/modules/features/editor/settings.json";
    };
  };
}
