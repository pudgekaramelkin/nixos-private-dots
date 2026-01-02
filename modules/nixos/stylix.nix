# Управление системной темой
# Часть настроек вынесено в bspwm.nix

{ pkgs, config, ... }: {

  stylix = { # Wiki - https://stylix.danth.me/options/nixos.html

    enable = true;
    # autoEnable = true;

    polarity = "dark"; # "light" or "either". Если "either", то он сам определяет что будет красивее
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml"; # Если хочешь генерить тему из обоев, то удали эту строку
    # image = config.lib.stylix.pixel "base00"; # Вместо обоев будет заливка фона одним цветом из темы
    image = ./nix-glow-gruvbox.jpg; # Если хочешь норм обои, то просто укажи путь до изображения

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24; # default = 32
    };

    fonts = {

      # Ширина символов одинаковая
      monospace = { # default = DejaVu Sans Mono
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMonoNL Nerd Font Mono";
      };

      emoji = { # default = Noto Color Emoji
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      # Без засечек
      sansSerif = { # default = DejaVu Sans
        package = pkgs.nerd-fonts.noto;
        name = "NotoSans Nerd Font";
      };

      # С засечками
      serif = { # default = DejaVu Serif
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
        # package = pkgs.noto-fonts;
        # name = "Noto Serif";
      };

      # sizes = {
      #   applications = 12;
      #   terminal = 15;
      #   desktop = 10;
      #   popups = 10;
      # };
    };

    # opacity = {
    #   applications = 1.0;
    #   terminal = 1.0;
    #   desktop = 1.0;
    #   popups = 1.0;
    # };

  };

  ###################################################
  ## Тема qt через stylix у меня не работает       ##
  ## Хотя в видео у других людей всё менялось      ##
  ## Приходится руками ставить грувбокс через qtct ##
  ###################################################

  # https://discourse.nixos.org/t/guide-to-installing-qt-theme/35523/2
  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "qt5ct";
  };
}
