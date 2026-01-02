{ # Блютуз, интернет, wifi
  hardware.bluetooth = {
    enable = true;
  };

  networking = {
    # enableIPv6 = false;
    networkmanager.enable = true;
    hostName = "nixos";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall.enable = false;
  };

  services.blueman.enable = true; # Tray for bluetooth
}
