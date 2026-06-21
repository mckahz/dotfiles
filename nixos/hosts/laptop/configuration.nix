{ pkgs, user, ... }:
{
  networking.hostName = "laptop";

  imports = [
    ./hardware-configuration.nix
  ];

  # services.displayManager.dms-greeter = {
  #   enable = true;
  #   compositor.name = "niri";
  #   configHome = user.home;
  #   configFiles = [
  #     "${user.config}/DankMaterialShell/settings.json"
  #   ];
  #   logs = {
  #     save = true;
  #     path = "/tmp/dms-greeter.log";
  #   };
  # };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd ${pkgs.niri}/bin/niri-session";
        user = user.name;
      };
    };
  };

  # programs.dms-shell.systemd = {
  #   enable = true;
  #   restartIfChanged = true;
  # };

  # To avoid OOM issues
  nix.settings = {
    max-jobs = 2;
    cores = 0;
  };
  systemd.services.nix-daemon.serviceConfig = {
    MemoryHigh = "5GB";
    MemoryMax = "6GB";
  };

  environment.systemPackages = with pkgs; [
    ciscoPacketTracer9
    vmware-workstation
  ];

  keyboard = {
    enable = true;
    device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
  };

  system.stateVersion = "25.11";
}
