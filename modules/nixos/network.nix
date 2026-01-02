{ # Блютуз, интернет, wifi
  hardware.bluetooth = {
    enable = true;
  };

  services.blueman.enable = true; # Tray for bluetooth

  networking = {
    # enableIPv6 = false;
    networkmanager.enable = true;
    hostName = "nixos";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall.enable = false;
  };

  programs.throne = {
    enable = true;
    tunMode = {
      enable = true;
      # setuid = true; # Если не работает tun мод
    };
  };
}
