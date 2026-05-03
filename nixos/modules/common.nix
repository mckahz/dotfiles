{ user, ... }:
{
  imports = [
    ./programs.nix
    ./network.nix
    ./keyboard.nix
    ./nvidia.nix
  ];

  users.users.${user.name} = {
    isNormalUser = true;
    description = user.name;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    packages = [ ];
  };

  nix.extraOptions = ''
    trusted-users = root ${user.name}
  '';

  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65536";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [
    "ntfs"
    "ext4"
  ];

  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "ciscoPacketTracer8-8.2.2"
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1; # Forces apps to boot with wayland if they can
    XDG_CONFIG_HOME = user.config;
  };

  virtualisation.vmware.host.enable = true;
}
