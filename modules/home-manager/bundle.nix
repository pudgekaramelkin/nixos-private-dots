{
  imports = [
    ./ranger/ranger.nix

    ./mpv/mpv.nix
    ./obs/obs.nix

    ./terminal/alacritty.nix
    ./terminal/kitty.nix
    ./terminal/starship.nix
    ./terminal/zellij.nix
    ./terminal/zsh.nix

    ./mangohud.nix
    # ./symlinks.nix

    ##############
    ## WM (X11) ##
    ##############

    # Софт для работы WM на X11
    ./wm/rofi/rofi.nix
    ./wm/dunst.nix
    ./wm/lockscreen.nix

    # Для выключения i3 комментируй все строки ниже
    ./wm/i3.nix

    # Для выключения bspwm комментируй все строки ниже
    ./wm/bspwm/bspwm.nix
    ./wm/bspwm/polybar.nix
    ./wm/bspwm/sxhkd.nix

    ##################
    ## WM (Wayland) ##
    ##################

    # Wayland гавно лаганое, но мб на NixOS дела будут лучше
    # Мб я сделаю конфиги для sway и hyprland на ags
    # Каталог wm мб переименовать в X11 и создать отдельный Wayland

  ];
}
