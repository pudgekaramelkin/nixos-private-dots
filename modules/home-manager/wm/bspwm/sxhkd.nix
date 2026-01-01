# Бинды системы https://manpages.org/sxhkd

# Можно запускать софт через "${pkgs.betterlockscreen}/bin/betterlockscreen -l dimblur";
# Но мне лень столько текста делать. И так сойдёт
# Стандартный конфиг https://github.com/baskerville/bspwm/blob/master/examples/sxhkdrc

{ pkgs, config, ... }: let
  muteText = ''then echo "  Muted"; else echo "  Unmuted"; fi)" -r 91190 -t 8000'';
  notifyMute = ''dunstify "$(if [ "$(pamixer --get-mute)" = "true" ]; ${muteText}'';
  notifyMicMute = ''dunstify "$(if [ "$(pamixer --default-source --get-mute)" = "true" ]; ${muteText}'';
  notifyVolume = ''dunstify " Volume: $(pamixer --get-volume)" -r 91190 -t 800'';
  # -r 91190: Это идентификатор уведомления (notification ID). Уведомления с одинаковым ID будут заменять друг друга.
  # -t 800: Это время в миллисекундах, через которое уведомление будет автоматически закрыто.

  terminalFirst = "alacritty";
  terminalSecond = "kitty";

  rofiDir = "${config.home.homeDirectory}/.config/rofi";
in {
  home.packages = with pkgs; [ sxhkd ];

  xdg.configFile."sxhkd/sxhkdrc" = {
    # executable = true;
    text = ''
      #########################################################
      ## bspwm (описание параметров есть в файле "bspwm.md") ##
      #########################################################

      # Make sxhkd reload its config files
      super + shift + ctrl + r
        pkill -USR1 -x sxhkd; dunstify "t2" -a "󰑓 Sxhkd reloaded"

      # Quit/Restart bspwm
      super + shift + ctrl + alt + {q,r}
        bspc {quit,wm -r}

      # Fullscreen toggle (немного не тот)
      # super + Return
      #   bspc desktop -l next

      # Set the node flags
      # super + ctrl + {m,x,y,z}
      #   bspc node -g {marked,locked,sticky,private}

      # Lock screen
      super + l
        betterlockscreen -l dimblur --show-layout

      # Quit. Закрыть приложение
      super + q
        bspc node -c

      # Kill. Убить приложение, если оно не отвечает
      super + shift + q
        bspc node -k

      # Floating toggle
      super + f
        bspc node -t ~floating

      # Tiled toggle
      super + shift + f
        bspc node -t ~tiled

      # Fullscreen toggle
      super + Return
        bspc node -t ~fullscreen

      # Перекидывает активное окно на предыдущий/следующий воркспейс и следует за ним
      super + ctrl + alt + {Left,Right}
        bspc node -d {prev,next}.local --follow

      # Менять фокус приложения в указанном направлении
      super + {Left,Down,Up,Right}
        bspc node -f {west,south,north,east}

      # Move a floating window
      super + alt + {Left,Down,Up,Right}
        bspc node -v {-30 0,0 30,0 -30,30 0}

      # Свапает активное окно с самым большим на экране
      super + ctrl + alt + Down
        bspc node -s biggest.window --follow

      # Перемещает активное окно в указанном направлении (либо -s, чтоб менять соседние окна местами)
      super + shift + ctrl + {Left,Down,Up,Right}
        bspc node -n {west,south,north,east}.window --follow

      # Expand a window by moving one of its side outward
      super + shift + {Left,Down,Up,Right}
        bspc node -z {left -30 0,bottom 0 30,top 0 -30,right 30 0}

      # Contract a window by moving one of its side inward
      super + shift + alt + {Left,Down,Up,Right}
        bspc node -z {right -30 0,top 0 30,bottom 0 -30,left 30 0}

      # Переключает на предыдущий/следующий воркспейс внутри одного монитора.
      super + ctrl + {Left,Right}
        bspc desktop -f {prev,next}.local

      # Прошлый воркспейс внутри одного монитора.
      super + Escape
        bspc desktop -f last.local

      # Focus or send to the given desktop
      super + {_,shift + }{1-9,0}
        bspc {desktop -f,node -d} {1-9,10}.local

      # Переключает на первый пустой воркспейс
      super + ctrl + Down
        bspc desktop -f next.!occupied

      # Меняет позиционирование с горизонтального на вертикальный и обратно. Мб надо -R
      # (и то и то требует аргументы, а не делает toggle, и даже с аргументами не работает)
      # super + s
      #   bspc node -F


      ##########
      ## rofi ##
      ##########
      
      # Applications. Запускатор софта
      super + a
        rofi -show drun -theme ${rofiDir}/launcher.rasi

      # Calculator имбовый. Можно даже написать `5600 USD to BTC` или `500 + 25%`.
      super + c
        rofi -show calc -modi calc -no-show-match -no-sort -theme ${rofiDir}/launcher.rasi

      # Passwords. Пароли из утилиты pass
      super + p
        rofi-pass

      # История буфера обмена. Как ctrl+v, но через win.
      super + v
        clipmenu

      # Как alt+tab, переключение окон. На нужный воркспейс само перекинет
      super + Tab
        rofi -show window -theme ${rofiDir}/launcher.rasi

      # PowerMenu. Выключение пк
      super + BackSpace
        rofi -show powermenu -modi powermenu:${pkgs.rofi-power-menu}/bin/rofi-power-menu -theme ${rofiDir}/power.rasi

      # Timer. Думаю сделать через утилиту timer
      # super + alt + t
      #   команда

      # Notification history. История оповещений. Мб не делать
      # super + shift + n
      #   команда

      ##################
      ## applications ##
      ##################

      # Browser LibreWolf. Основа
      super + b
        librewolf

      # Browser Firefox. Паблик активность
      super + shift + b
        firefox

      # Browser Chromium. Пусть будет
      super + shift + ctrl + b
        chromium

      # Note taking app (obsidian)
      super + n
        obsidian

      # Explorer. Thunar file manager
      super + e
        thunar

      # IDE, text editor
      super + i
        code

      # Monitor of resources (btop)
      super + m
        ${terminalFirst} -e btop

      # Goals. Todo manager. Task tracker
      super + g
        io.github.alainm23.planify

      # Color picker. Получить hex в буфер обмена
      super + shift + c
        xcolor -s

      # Color picker. Получить rgb в буфер обмена
      super + ctrl + c
        xcolor -s -f rgb


      ##############
      ## terminal ##
      ##############

      # Терминал alacritty
      super + t
        ${terminalFirst}

      # Floating терминал alacritty в центре экрана
      super + shift + t
        ${terminalFirst} --class floating-terminal

      # Терминал kitty
      super + ctrl + t
        ${terminalSecond}

      # Floating терминал kitty в центре экрана
      super + ctrl + shift + t
        ${terminalSecond} --class floating-terminal


      #######################
      ## Колдунские кнопки ##
      #######################
      # В pamixer для настроек микро надо добавлять "--default-source"
      
      # Toggle mute
      XF86AudioMute
        pamixer -t; ${notifyMute}

      # Toggle microphone mute
      XF86AudioMicMute
        pamixer --default-source -t; ${notifyMicMute}

      # Decrease/Increase volume
      XF86Audio{Lower,Raise}Volume
        pamixer -{d,i} 5; ${notifyVolume}

      # Play/Pause
      XF86Audio{Play,Pause}
        playerctl play-pause

      # Next/Previous track
      XF86Audio{Next,Prev}
        playerctl {next,previous}

      # Простое редактирование яркости будет менять на 1% (Символ _ означает ничего, просто бинд яркости)
      # С зажатым шифтом будет редактировать яркость на 10%
      # С зажатой клавишей win будет менять между минимальным и максимальным значениями
      # Не знаю работает ли эта команда, у меня не ноут. Добавил как написано в "man sxhkd"
      # Increase/Decrease brightness
      {_,shift + ,super + }XF86MonBrightness{Down,Up}
        bright {-1,-10,min,+1,+10,max}
    '';
  };
}

