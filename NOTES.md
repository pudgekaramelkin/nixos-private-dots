Тут будут всякие заметки и доп информация по работе с NixOS

Если не хочешь обновлять систему, но надо скачать пакеты последней версии, то используй `upd nixpkgs2` и перед именем пакета добавь `pkgs2.`. Команда в терминале обновить второй unstable репозиторий. А префикс `pkgs2.пакет` говорит "скачай `пакет` из репозитория `pkgs2`".

Если ты обновил всю систему, но некоторые программы сломались, то можно не откатывать всю систему, а попробовать добавить к ним префикс `spkgs.`. Это скачает их из стабильной ветки репозитория

В стоке используется браузер `LibreWolf`, который имеет неприятные настройки безопасности. Мне проще выключить некоторые настройки безопасности в нём, чем выключить лишний шлак в `Firefox`. `Chromium` стоит как запаска для некоторых сайтов, как основа он мне не нравится. Написать какие настройки безопасности я выключил в `LibreWolf` мне лень. Как минимум офнул удаление истории при каждом ребуте. Но могу сказать какие настройки я использую в `Firefox` и `LibreWolf`, связанные просто с удобством. Они в таблице ниже.

| Настройка about:config                  | Значение | Описание                                              |
| --------------------------------------- | -------- | ----------------------------------------------------- |
| browser.bookmarks.openInTabClosesMenu   | false    | Не закрывать меню закладок при открытии ссылки        |
| browser.tabs.loadBookmarksInBackground  | true     | Не перекидывать на закладку, открытую в новой вкладке |
| layout.css.has-selector.enabled         | true     | Для кастом стилей                                     |
| accessibility.typeaheadfind.enablesound | false    | Чтоб не булькало на ухо                               |
| full-screen-api.warning.timeout         | 0        | Чтоб фулскрин popup не вылазил                        |
| browser.tabs.insertAfterCurrent         | true     | Чтоб новые вкладки были справа от нынешней            |

Если хочешь сменить стоковый браузер, то мб надо поменять переменную в `./nixos/home.nix`. Если не помогает, то допом команда в терминале (замени `librewolf` на нужный браузер):
```sh
xdg-settings set default-web-browser librewolf.desktop
```


Смена тем сейчас работает криво для qt приложений. Можно автоматизировать gtk темы, но qt придётся руками добавлять/менять. Возможно фикс уже вышел, но мне лень проверять. У меня везде `gruvbox` и менять не планирую.

Чтоб задать аватарку юзера в SDDM (это меню ввода пароля при запуске пк), надо отправить png файл такой командой:
```sh
sudo cp image.png /var/lib/AccountsService/icons/username
```
То есть именно `username`, без `.png` в конце

Настройки смены языка, тачпада и мыши можно найти в файле `./modules/nixos/xserver.nix`. У меня там стоит необычный скрол мышкой. Я не использую колесо мыши. Я зажимаю дальнюю боковую кнопку мыши и двигаю мышку по столу. В какую сторону двигаешь мышку, в ту сторону и будет скрол. Так можно удобно регулировать скорость скрола и быстро оказываться где надо. Язык я меняю на капслок. Для активации капса надо жать шифт капслок. В этом же файле есть **настройка для amd видеокарт, которую надо выключить, если у тебя nvidia**. Не знаю надо ли что-то настраивать для nvidia после этого.

В стоке выключены следующие конфиги (их можно включить в `bundle.nix` в разных каталогах):
- `filesystem.nix` - Конектить внешние диски автоматически. В стоке выкл, потому что у каждого свои айдишники дисков.
- `hibernate.nix` -  Настройки гибернации. В стоке выкл, потому что у каждого свои айдишники файла подкачки.
- `vr.nix` - Пакеты для работы виара на linux. Нужно очень мало кому, потому выкл
- `vscode.nix` - Настройки vscode. Большинство предпочтёт настраивать его по старинке руками, а не через геморный конфиг
- `symlinks.nix` - Настройки симлинков. Не всем надо, плюс у каждого свои симлинки. Потому выкл в стоке
- Файл подкачки - У меня он в `/etc/nixos/hardware-configuration.nix`, который у каждого свой. Потом вынесу это в дотсы.

Хоть тут и установлен `i3wm`, но он не настроен. Можешь удалить его из конфига, чтоб место не занимал. Я потом займусь его настройкой.

Если обновил систему и спустя время с ней всё окей, всё стабильно, то советую запускать сборщик мусора. При обновлении nixos не удаляет старые пакеты, чтоб ты мог откатиться назад, в случае поломок, даже если нет интернета. Чтоб удалить пакеты, которые больше не используются, можно использовать команду `grb` (это мой алиас в zsh).

Баш скрипты требуют другой шебанг в начале. Обязательно используй `#!/usr/bin/env bash` вместо `#!/bin/bash`. Первый вариант будет работать на любой OS с bash, а вот второй вариант ломается.

Не юзай ИИ для поиска информации по NixOS, он всегда выдумывает параметры. Сколько бы я не тестил разные ИИ для настройки NixOS, они даже базовые вещи не могут дать, тут слишком часто всё меняется и в интернете слишком мало информации по данной OS, чтоб ИИ давал хоть что-то рабочее



## TODO

Надо сделать декларативную QT тему. Сейчас у меня есть файлы в каталоге `shit`. Их я могу скопировать в `~/.config`, нужная переменная окружения в `home.nix` стоит и всё заработает. Но это не то, что я хочу. Другой человек не сможет это юзать мб. Потому что там в коде написан путь `/home/buliway`. Не всем же быть буливеями. Хотя это изи исправляется, потом сделаю. Но пока что я не хочу тратить время на настройку QT, который нормально настроить невозможно.

Надо добавить в polybar отображение:
- Заряд аккума. Сейчас проверить негде. Мб взять готовый вариант [тут](https://github.com/Zproger/bspwm-dotfiles/blob/main/config/polybar/modules.ini#L148)
- Яркость экрана. Тоже ноуты. Хз надо ли
- Температура и нагрузка на гп
- Температура цп
- Блютуз. Не знаю отображается ли он сейчас. Не могу проверить, негде

Установить и настроить:
- i3wm с его экосистемой софта. Чтоб тот же polybar был лишь на bspwm, а на i3 работал i3bar
- Sway. Для тестов wayland на nixos
- Hyprland. Для тестов wayland на nixos

## Описание

Железо, на котором работают мои дотсы:
- CPU: i5 10400f
- GPU: AMD RX6600
- RAM: 32gb (2x16) ddr4 3200
- Motherboard: MSI Z590-A PRO
- Два монитора 1920x1080 на 165 и 100 герц

Основной набор софта

Изначально я написал конфиги для `bspwm` + `polybar`. Но потом хочу затестить другию WM. В теории между ними можно переключаться при запуске пк, так что проблем быть не должно. Если какой-то WM надо выключить, чтоб не засирать систему, то это можно делать в `modules/home-manager/bundle.nix`

|   Software   |             Name                 |
| ------------ | -------------------------------- |
| WM           | bspwm                            |
| Hotkeys      | sxhkd                            |
| Terminal     | Alacritty, Kitty                 |
| Multiplexer  | Zellij                           |
| Shell        | oh-my-zsh with many plugins      |
| Shell Prompt | Starship                         |
| Apps/Menus   | Rofi                             |
| Bar          | Polybar                          |
| ScreenLock   | betterlockscreen                 |
| Notification | Dunst                            |
| Files        | Thunar, Ranger                   |
| Images       | qView, imv, feh                  |
| Video        | mpv with plugins                 |
| Music        | Strawberry, mpv                  |
| Browsers     | Librewolf, Firefox, Chromium     |
| Social       | Discord, Telegram, Steam         |
| Audio        | PipeWire, pavucontrol            |
| Color Theme  | Gruvbox Dark Medium              |
| Icons        | Papirus Dark                     |
| DM           | SDDM                             |
| Compositor   | Нет. Мне не нужны анимации и прозрачность |
| Screenshare  | OBS, Screenkey, ksnip            |
| Code Editor  | Neovim, VSCode                   |
| Video Editor | Blender                          |
| Fetch        | fastfetch                        |
| Torrent      | qBittorrent                      |
| Email client | Thunderbird                      |
| Color picker | xcolor, gcolor3                  |
| Docs/eBook   | Evince, LibreOffice, Calibre     |
| Design       | Gimp, Krita                      |
| Productivity | Obsidian, Planify                |

Чтоб узнать sha256 для гитхаб репы, пишем в терминал эту команду:
```sh
nix-prefetch-git link
```

Если хочется поменять цвета или шрифты в конфиге какой-то программы, но при ребилде получается конфликт, то дело в Stylix, который управляет системной темой и сам везде ставит шрифты и цвета. Если хочется заменить, не трогая stylix, то надо добавить `lib.mkForce` перед значением. Например так:
```nix
font = lib.mkForce "JetBrainsMono Nerd Font 11";
```

Узнать localhost виртуалки, чтоб конектиться по ssh:
```sh
ip a
```

В бутменю биоса надо ставить не ссд диск, а `nixos boot`. У меня иначе не работало

## Нюансы с JetBrains Toolbox

В стоке тулбокс может всегда разлогинивать. Я не проверял, сразу сделал как просили на вики, чтоб это исправить.

Надо скачать тулбокс (уже стоит), запустить его один раз, а потом:
- Изменить `~/.local/share/JetBrains/Toolbox/.storage.json` и добавить строку `"preferredKeychain": "linux-fallback"` (у меня было в стоке)
- Залогиниться как обычно, но остановиться после того, как JetBrains вебсайт откроется
- Перезапустить JetBrains Toolbox, открыть настройки и нажать `"Troubleshoot..."`
- Следуй инструкциям по ручному входу в систему, как указано в руководстве

После выполнения этих действий JetBrains Toolbox сохранит учетные данные пользователя в зашифрованном файле (со статическим ключом) по адресу `~/.local/share/JetBrains/Toolbox/.securestorage`. Если этого не сделать, JetBrains Toolbox не сможет получить учетные данные через `libsecret` (из-за bwrap sandboxing?) и постоянно уведомляет пользователя о необходимости повторной авторизации.

Если что-то не работает, то мб помогут эти ссылки:
- https://nixos.wiki/wiki/Jetbrains_Tools
- https://github.com/NixOS/nixpkgs/issues/240444

## Настройки для игр

Я установил `MangoHud`, `gamemode` и `gamescope`. Ещё есть `proton-ge` в steam. Всё это можно по разному комбинировать между собой.

### MangoHud 

Мониторинг ресурсов для vulkan и opengl приложений. Показывает fps и нагрузку на пк, включая температуры цп и гп. Можно использовать как полноценные бенчмарки, логируя всю его инфу и визуализируя данные другой утилитой. Чтоб использовать, надо написать `mangehud приложение`, если запускать через терминал, или `mangohud %command%`, если использовать через steam. Если используется вместе с `gamescope`, то надо писать `gamescope --mangoapp`.

### gamemode

Оптимизатор линукса для игр. В параметры запуска игры в стиме пишешь `gamemoderun %command%` и всё работает.

### gamescope

SteamOS session compositing window manager. Можно назвать мини wm внутри wm (хотя можно и в tty запустить, без стороннего wm). Не совсем понимаю когда его надо использовать. Иногда, если у игры есть проблемы с обычным linux, то она может нормально запускаться через `gamescope`

### Параметры запуска Steam

Если в параметры запуска захочется добавить что-то помимо того, что я напишу, то надо учитывать порядок написания. Как я понял, если надо используется переменная, то её надо писать в начале. Например, если в игре не работает печать на русском языке, то надо в начало добавить `LC_ALL="ru_RU.UTF-8"`. Если же речь про стандартные параметры запуска стима, по типу `-dev` или `-novid`, то их надо писать после `%command%`. Слово `%command%` скорее всего является игрой, то есть команда для запуска игры. То есть синтаксис как в обычном терминале. Сначала переменные окружения, потом команда, потом параметры запуска через `-параметр`.

Параметры запуска для игр, чтоб использовать все доступные бафы, что я сделал:
Параметр запуска без использования gamescope - `mangohud gamemoderun %command%`.
Параметр запуска с использованием gamescope `gamescope --mangoapp gamemoderun %command%`.

Вот пример параметров запуска для Apex Legends: `mangohud gamemoderun %command% +exec autoexec.cfg -dev`

FSR в `proton-ge` включается только в фулскрине через `WINE_FULLSCREEN_FSR=1`. Регулировать резкость можно через переменную окружения `WINE_FULLSCREEN_FSR_STRENGTH=N`, где N - это уровень резкости изображения от 0 до 5. Чем выше значение, тем меньше резкость. По умолчанию установлено значение "2", рекомендуют использовать значение "3".

## Настройка мониторов

На иксах второй монитор может не работать или все мониторы могут сидеть на 60 герц. Изменить это один раз недостаточно, после ребута сбросится. Не знаю нормального способа, кроме как добавить настройки в автозапуск. Ниже пример того, как произвести начальную настройкy:

```sh
# Увидеть список мониторов
xrandr
# Изменить настройки для основного монитора. Мб вместе с --primary для основного монитора
xrandr --output DisplayPort-2 --mode 1920x1080 --rate 165
# Изменить настройки для второго (правого) монитора
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 100 --right-of DisplayPort-2
```

Есть ещё такая штука - https://github.com/phillipberndt/autorandr . Но мне лень с ней разбираться


## Системная тема на всех вебсайтах

Если используется популярная системная тема, то, скорее всего, её можно выбрать в браузерном расширении DarkReader, чтоб все сайты в интернете выглядели как системная тема. Может быть я потом займусь синхронизацией темы stylix с настройками DarkReader

## Запуск Waydroid на X11

Один раз написать в терминале `waydroid init`

- Запустить `weston`
- В его терминале написать `waydroid session start &`
- Потом `waydroid show-full-ui`

На weston всё работает сразу как надо. Но стоит изменить размеры окна, как waydroid ui пропадает. Приходится стопать и по новой запускать отображение

## Как я тестирую разный новый софт

Для этого создаю каталог, а в нём файл `flake.nix` с таким содержимым:
```nix
{
  description = "Development shell for my project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    config = {
      allowUnfree = true;
      rocmSupport = true;
      permittedInsecurePackages = [
        "python-2.7.18.8"
        "electron-25.9.0"
      ];
    };
    pkgs = import nixpkgs {
      inherit system;
      inherit config;
    };
    spkgs = import inputs.nixpkgs-stable {
      inherit system;
      inherit config;
    };
  in {
    devShells.${system}.default =
      pkgs.mkShell {
        buildInputs = with pkgs; [
          planify
        ];

        shellHook = ''
          echo "Welcome to Dev Shell"
        '';
      };
    };
}
```
Сюда можно ставить разный софт из нужной версии репы. Чтоб зайти в этот шел, заходишь в каталог с этим файлом и пишешь `nix develop`. Теперь весь софт из этого `flake.nix` будет доступен именно в этом терминале. Если хочется обновить весь софт в этом шеле до последней версии, то я просто удаляю файл `flake.lock` и снова пишу `nix develop`. Чтоб выйти из шела, можно написать `exit`. Если shell использует стандартный bash, то зайти в zsh можно командой `zsh`.

Например, я разрабатывал GUI на fyne. Это либа для golang, чтоб GUI приложения делать. Она на nixos требует пробрасывть зависимости через nix shell, который в конечном итоге выглядел так:
```nix
{
  description = "Development shell for my project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system}.default =
      pkgs.mkShell {
        buildInputs = with pkgs; [
          # Fyne
          libGL
          pkg-config
          xorg.libX11.dev
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXrandr
          xorg.libXxf86vm
          fyne

          # Avif
          libaom

          # Video
          glib
          glib.dev
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-plugins-good
          gst_all_1.gst-plugins-bad
          gst_all_1.gst-plugins-ugly
          gst_all_1.gst-libav
        ];

        # Чтобы pkg-config видел .pc-файлы, и GStreamer загружал плагины
        PKG_CONFIG_PATH = pkgs.lib.concatStringsSep ":" [
          "${pkgs.glib.dev}/lib/pkgconfig"
          "${pkgs.gst_all_1.gstreamer}/lib/pkgconfig"
          "${pkgs.gst_all_1.gst-plugins-base}/lib/pkgconfig"
          "${pkgs.gst_all_1.gst-plugins-good}/lib/pkgconfig"
          "${pkgs.gst_all_1.gst-plugins-bad}/lib/pkgconfig"
          "${pkgs.gst_all_1.gst-plugins-ugly}/lib/pkgconfig"
          "${pkgs.gst_all_1.gst-libav}/lib/pkgconfig"
        ];

        NIX_CFLAGS_COMPILE = [ "-I${pkgs.glib.dev}/include" ];
        NIX_LDFLAGS = [ "-L${pkgs.glib.out}/lib" ];

        shellHook = ''
          zsh
          echo "Welcome to Dev Shell"
          export LD_LIBRARY_PATH=${pkgs.wayland}/lib:${pkgs.lib.getLib pkgs.libGL}/lib:$LD_LIBRARY_PATH
        '';

      };
    };
}
```
Необходимые пакеты я подбирал методом тыка, читая ошибки при попытке компилировать
