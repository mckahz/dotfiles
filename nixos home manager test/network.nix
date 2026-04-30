{ ... }:
{
  networking.networkmanager.enable = true;
  time.timeZone = "Australia/Melbourne";
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery of connected devices
        Experimental = true;
      };
    };
  };

}
