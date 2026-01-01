# Много готовых дизайнов для rofi https://github.com/adi1090x/rofi
# Там разделены launchers и applets. Я не сразу понял в чём разница
# Launchers просто запускает приложение и ничего больше
# Applets это кнопка, которой задаёшь своё имя и скрипт, который будет выполнен при нажатии
# Через applets можно запускать скрипты, проги от рута или отображать информацию по типу заряда акума
# Описание и генератор стилей https://comfoxx.github.io/rofi-old-generator/old.html
# Полезная инфа https://wiki.archlinux.org/title/Rofi
# Готовые скрипты https://github.com/davatorium/rofi/wiki/User-scripts

{ pkgs, config, ... }: { # Запускатор софта и не только
  programs.rofi = { # https://github.com/davatorium/rofi
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty"; # Path to the terminal which will be used to run console applications
    location = "center"; # The location rofi appears on the screen.
    # cycle = true; # Whether to cycle through the results list.

    pass = {
      enable = true; # https://github.com/carnager/rofi-pass
      extraConfig = ''
        _rofi () {
          rofi -i -no-auto-select -theme ${config.home.homeDirectory}/.config/rofi/launcher.rasi "$@"
        }
      '';
    };

    plugins = with pkgs; [
      rofi-calc # https://github.com/svenstaro/rofi-calc
      rofi-power-menu # https://github.com/jluttine/rofi-power-menu
      # rofi-bluetooth # https://github.com/nickclyde/rofi-bluetooth
    ];

    # extraConfig = {};
  };

  # Мб заменю на greenclip, который включается как сервис в packages.nix
  services.clipmenu = { # https://github.com/cdown/clipmenu
    enable = true;
    launcher = "rofi";
  };

  xdg.configFile = {
    "rofi/launcher.rasi".source = ./launcher.rasi;
    "rofi/power.rasi".source = ./power.rasi;
    "rofi/colors.rasi".text = ''
      * {
        background:     #${config.lib.stylix.colors.base00};
        background-alt: #${config.lib.stylix.colors.base01};
        foreground:     #${config.lib.stylix.colors.base06};
        selected:       #${config.lib.stylix.colors.base0D};
        active:         #${config.lib.stylix.colors.base0B};
        urgent:         #${config.lib.stylix.colors.base08};
      }
    '';
  };
}

# background:     #${config.lib.stylix.colors.base00}; #282828
# background-alt: #${config.lib.stylix.colors.base01}; #3c3836
# foreground:     #${config.lib.stylix.colors.base06}; #ebdbb2
# selected:       #${config.lib.stylix.colors.base0D}; #83a598
# active:         #${config.lib.stylix.colors.base0B}; #b8bb26
# urgent:         #${config.lib.stylix.colors.base08}; #fb4934
