{
  imports = [
    ./ranger/ranger.nix

    # ./gui/vscode.nix

    ./imv/imv.nix
    ./mpv/mpv.nix
    ./obs/obs.nix

    ./terminal/alacritty.nix
    ./terminal/git.nix
    ./terminal/kitty.nix
    ./terminal/lynx.nix
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

    # Для выключения i3wm комментируй все строки ниже
    ./wm/i3.nix

    # Для выключения bspwm комментируй все строки ниже
    ./wm/bspwm/bspwm.nix
    ./wm/bspwm/polybar.nix
    ./wm/bspwm/sxhkd.nix
  ];
}
