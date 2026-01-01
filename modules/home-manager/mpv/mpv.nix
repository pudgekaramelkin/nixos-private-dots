{
  programs.mpv.enable = true;

  home = {
    # Решил нужные зависимости писать в packages.nix
    # packages = with pkgs; [
    #   yt-dlp # Смотреть онлайн видео через mpv
    #   xclip # Буфер обмена на x11 для некоторых плагинов
    #   #wl-clipboard # Буфер обмена на wayland для некоторых плагинов
    # ];

    file = {
      ".config/mpv/mpv.conf".source = ./mpv.conf;
      ".config/mpv/input.conf".source = ./input.conf;
      ".config/mpv/scripts".source = ./scripts;
      ".config/mpv/script-opts".source = ./script-opts;
      ".config/mpv/fonts".source = ./fonts;
    };
  };
}
