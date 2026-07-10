{ ... }: {
  # systemd.user.services.wallpaper = {
  #   Unit = {
  #     Description = "Periodically sets a random wallpaper.";
  #   };
  #   Service = {
  #     Type = "oneshot";
  #     ExecStart = ''
  #       ${} wallpaper -r
  #     '';
  #   };
  # };

  # systemd.user.timers = {
  #   wallpaper = {
  #     Unit = {
  #       Description = "Timer for wallpaper.service.";
  #     };
  #     Timer = {
  #       OnBootSec = "2m";
  #       OnUnitActiveSec = "2m";
  #       Unit = "wallpaper.service";
  #     };
  #     Install = {
  #       WantedBy = [ "timers.target" ];
  #     };
  #   };
  # };
}
