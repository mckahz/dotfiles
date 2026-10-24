# All modules in the modules/ directory follow the following structure-
{ inputs, den, ... }: {
  # this is where you add additional "flake" inputs to your project.
  # look for a `flake.nix` file in the root of the github repo.
  flake-file.inputs = {
    # For example-
    # noctalia.url = "github:user/repo";
    # hyprland.url = "github:user/repo";
  };

  # This is how you declare extra configuration to your system.
  # In this example, this module would represent any configuration
  # that has anything to do with work- any apps you need,
  # configuration for them, etc.
  # Once declared, don't forget to add it to your user's includes
  # alongside all the other `den.aspects.<name>`'s
  # Don't forget to run `git add .`!
  den.aspects.template = {
    nixos =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        # This is where nixos module configuration goes. For example-
        environment.systemPackages = with pkgs; [
          git
          vim
          neovim
        ];
        # Any time documentation says "put this in your `configuration.nix`"
        # It's refering to here.
      };

    hjem = { osConfig, ... }: {
      # This is where we link files that go in our home directory
      # For files that live in .config we use
      xdg.config.files."app/filename.ini".source = "${osConfig.flake}/modules/features/app/filename.ini";
      # And for other files which are raw dogging it in your home directory (/home/gmang/...) we use
      files."filename.ini".source = "${osConfig.flake}/modules/features/app/filename.ini";
    };
  };

}
