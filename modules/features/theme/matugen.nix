{inputs, ...}: {
  flake-file.inputs.matugen-nix = {
    url = "github:MOIS3Y/matugen-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.theme.nixos = {lib, pkgs, config, ...}: {
      imports = [
        inputs.matugen-nix.nixosModules.default
      ];

      options.theme = {
        substitute = lib.mkOption {};
      };

      config = {
        theme.substitute = template:
          let
            inherit (config.matugen.theme.generated) colors;
          in
          pkgs.substitute
            {
              src = template;
              substitutions = [
                "--replace-quiet" "\{\{colors.primary.dark.hex\}\}" "${colors.primary.dark}"
                "--replace-quiet" "\{\{colors.on_primary.dark.hex\}\}" "${colors.on_primary.dark}"
                "--replace-quiet" "\{\{colors.primary_container.dark.hex\}\}" "${colors.primary_container.dark}"
                "--replace-quiet" "\{\{colors.on_primary_container.dark.hex\}\}" "${colors.on_primary_container.dark}"
              ];
            };

        matugen = {
          enable = true;
          seedColor = "#ffffff";
          customColors = {
            catppuccin.mocha = {
              rosewater = "#f5e0dc"; flamingo  = "#f2cdcd"; pink      = "#f5c2e7";
              mauve     = "#cba6f7"; red       = "#f38ba8"; maroon    = "#eba0ac";
              peach     = "#fab387"; yellow    = "#f9e2af"; green     = "#a6e3a1";
              teal      = "#94e2d5"; sky       = "#89dceb"; sapphire  = "#74c7ec";
              blue      = "#89b4fa"; lavender  = "#b4befe"; text      = "#cdd6f4";
              subtext1  = "#bac2de"; subtext0  = "#a6adc8"; overlay2  = "#9399b2";
              overlay1  = "#7f849c"; overlay0  = "#6c7086"; surface2  = "#585b70";
              surface1  = "#45475a"; surface0  = "#313244"; base      = "#1e1e2e";
              mantle    = "#181825"; crust     = "#11111b";
            };
          };
        };
      };

  };
}
