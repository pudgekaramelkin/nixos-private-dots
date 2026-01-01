{ pkgs, ... }: {
  programs.alacritty = { # Минимализм
    enable = true;
    settings = { # https://alacritty.org/config-alacritty.html
      window.padding = {
        x = 5;
        y = 5;
      };
    };
  };

  home.packages = with pkgs; [
    ueberzugpp # Отображение медиа в терминале
  ];
}