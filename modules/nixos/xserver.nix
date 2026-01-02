{ pkgs, ... }: {

  services.displayManager = {
    defaultSession = "none+bspwm"; # only effective for GDM, LightDM and SDDM
    sddm = {
      # Чтоб задать аватарку юзеру, надо отправить png файл такой командой:
      # sudo cp image.png /var/lib/AccountsService/icons/username
      # То есть именно username, без .png в конце
      enable = true;
      # package = pkgs.kdePackages.sddm; # qt6 sddm
      theme = "chili";
    };
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      scrollMethod = "button";
      scrollButton = 9; # Узнать айди можно через `xev -event button | grep button`
      middleEmulation = false;
    };
    touchpad = {
      accelProfile = "flat";
      middleEmulation = false;
    };
  };

  services.xserver = {
    enable = true;
    windowManager = {
      bspwm.enable = true;
      i3.enable = true; # i3-gaps доступен в стоке в новых версиях
    };

    xkb = {
      layout = "us,ru";
      variant = "";
      options = "grp:caps_toggle"; # Менять язык на CapsLock
    };

    displayManager.sessionCommands = ''
      xsetroot -cursor_name left_ptr
    '';

    # Мб видеодрайвер можно не указывать
    # https://discourse.nixos.org/t/amd-gpu-optimal-settings/27648/3

    # videoDrivers = [ "nvidia" ]; # https://nixos.wiki/wiki/Nvidia
    videoDrivers = [ "amdgpu" ]; # https://nixos.wiki/wiki/AMD_GPU
    deviceSection = ''Option "TearFree" "True"'';
  };
}
