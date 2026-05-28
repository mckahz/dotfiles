{ pkgs, user, ... }:
{
  networking.hostName = "laptop";

  imports = [
    ./hardware-configuration.nix
  ];

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = user.home;
    configFiles = [
      "${user.config}/DankMaterialShell/settings.json"
    ];
    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };

  programs.dms-shell.systemd = {
    enable = true;
    restartIfChanged = true;
  };

  environment.systemPackages = with pkgs; [
    ciscoPacketTracer9
    vmware-workstation
  ];

  keyboard = {
    enable = true;
    path = ./keyboard.kbd;
  };

  system.stateVersion = "25.11";
}
