{ config, lib, ... }: {
  # xsession.enable = true; # Хз надо ли
  xsession.windowManager.bspwm = {
    enable = true;
    # alwaysResetDesktops = false;

    # Как я понял, эти команды выполняются в начале bspwmrc
    # Ниже настройки для основного монитора. Мб вместе с --primary надо
    # И настройки для второго (правого) монитора
    extraConfigEarly = ''
      xrandr --output Virtual-1 --mode 1920x1080
    '';

    # Эти команды выполняются в конце bspwmrc
    extraConfig = ''
      for m in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$m polybar --reload bspwm &
      done
    '';

    startupPrograms = [
      # "lxqt-policykit-agent" # Заменил на гномовский
      "sxhkd"
      "nm-applet" # Нетворк манагер
      "ksnip"
      "xset s off -dpms" # Отменить затухание экрана через X минут
      "spice-vdagent" # Для виртуалки
      "systemctl --user import-environment PATH" # Фикс портала, мб надо ребут портала тоже добавить
      "systemctl --user restart xdg-desktop-portal xdg-desktop-portal-gtk"
    ];

    monitors = let
      workspaces = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
    in {
      "^1" = workspaces;
      "^2" = workspaces;
    };

    rules = let # Это переменные
      floating1600x900 = {
        state = "floating";
        center = true;
        focus = true;
        rectangle = "1600x900+0+0";
      };
      floating1200x800 = {
        state = "floating";
        center = true;
        focus = true;
        rectangle = "1200x800+0+0";
      };
      floating900x600 = {
        state = "floating";
        center = true;
        focus = true;
        rectangle = "900x600+0+0";
      };
      floating = {
        state = "floating";
      };
    in { # А тут правила окон
      # "Screenkey" = { manage = false; };
      # "Screenkey" = floating;
      "gcolor3" = floating;
      "obs" = floating;
      "steam" = floating;
      "steam:steamwebhelper:Steam" = { state = "tiled"; };
      "krita:krita:Krita - Edit Text" = floating;
      "krita:krita:Create new document" = floating;
      "librewolf:librewolf:Save Image" = floating;
      "SshAskpass" = floating;
      "Nm-connection-editor" = floating;
      "Kvantum Manager" = floating;
      "qt5ct" = floating;
      "qt6ct" = floating;
      "ksnip" = floating1600x900;
      "file-roller" = floating;
      "floating-terminal" = floating1200x800;
      "pavucontrol" = floating900x600;
      # blueman-манагер надо флоатинг
    };

    settings = {
      # Цвет бордера для не активного окна
      normal_border_color = lib.mkForce "#${config.lib.stylix.colors.base0B}"; # #b8bb26

      # Цвет бордера для фокусед окна на анфокусед мониторе (считаей не активное окно)
      active_border_color = lib.mkForce "#${config.lib.stylix.colors.base0B}"; # #b8bb26

      # Цвет бордера для окна в фокусе
      focused_border_color = lib.mkForce "#${config.lib.stylix.colors.base09}"; # #fe8019

      # Устанавливает ширину границ окон в 2 пикселя.
      border_width = 2;

      # Задаёт расстояние между окнами (отступ) в 5 пикселей.
      window_gap = 5;

      # Коэффициент разделения окон. 0.5 означает, что при разделении окно будет занимать 50% доступного пространства.
      split_ratio = 0.5;

      # В режиме monocle (максимизация окна на весь экран) границы окон будут скрыты.
      borderless_monocle = true;

      # В режиме monocle будет отсутствовать отступ между окнами.
      gapless_monocle = true;

      # Eсли вы активируете режим "monocle" на одном мониторе, другие мониторы остаются в обычном режиме
      single_monocle = false;

      # Фокусировка следует за курсором
      focus_follows_pointer = true;

      # When focusing a window, put the pointer at its center.
      # pointer_follows_focus = true;

      # Какую кнопку надо зажать, чтоб кнопки мыши меняли окно?
      pointer_modifier = "mod4"; # control lock mod1 mod2 mod3 mod4 mod5 shift

      # Действия с кнопками мыши 1, 2 и 3
      pointer_action1 = "move";
      pointer_action2 = "resize_side";
      pointer_action3 = "resize_corner";
    };
  };
}
