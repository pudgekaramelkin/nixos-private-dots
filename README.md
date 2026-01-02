## Навигация

- [Другие README файлы в этих дотсах](#другие-readme-файлы-в-этих-дотсах)
- [TODO](#todo)
- [Мини гайд по NixOS](#мини-гайд-по-nixos)
- [Процесс установки](#процесс-установки)
  - [Первый способ](#первый-способ)
  - [Второй способ](#второй-способ)
- [После установки надо](#после-установки-надо)
- [Изменения для виртуалок](#изменения-для-виртуалок)

## Другие README файлы в этих дотсах

- [Бинды системы](./BINDINGS.md)
- [Список базового софта в системе и доп информация](./NOTES.md)
- [Цвета и иконки тем, храню для себя](./THEMES.md)
- [Список известных проблем при настройке системы](./PROBLEMS.md)
- [Копия man page для bspwm с доп инфой](./modules/home-manager/wm/bspwm/bspwm.md)
- [Описание плагинов для mpv](./modules/home-manager/mpv/README.md)
- [NeoVim config](./nvim/README.md)

## Мини гайд по NixOS

- Одинаковые вещи могут делаться разными способами. Это норма, ведь nix считается языком програмимрования. По началу меня это бесило, когда читал чужие дотсы
- Нюансы работы NixOS в [этом](https://www.youtube.com/watch?v=7f19R8BWUnU&t=960s) видео. Мне понравилось
- [Плейлист](https://www.youtube.com/playlist?list=PLko9chwSoP-15ZtZxu64k_CuTzXrFpxPE) с английскими видео. Мне больше всего понравились видео под номерами [16](https://youtu.be/a67Sv4Mbxmc), [18](https://youtu.be/b641h63lqy0), [21](https://youtu.be/rEovNpg7J0M), [27](https://youtu.be/ljHkWgBaQWU) и [28](https://youtu.be/JCeYq72Sko0).
- Пакеты искать [тут](https://search.nixos.org/packages). Параметры для сток NixOS [тут](https://search.nixos.org/options). Параметры для home-manager [тут](https://home-manager-options.extranix.com/?query=&release=master). Для моих конфигов надо обязательно искать в unstable ветке, ибо параметры могут отличаться.
- Для системной темы тут используется stylix. Все его параметры можно найти [тут](https://stylix.danth.me/options/nixos.html).

## Процесс установки

Сначала качаем NixOS GUI вариант и устанавливаем систему через визуальный установщик. При установке выбираем минимальный вариант, без DE.

Кто-то говорит, что потом достаточно просто забилдить одной командой чужой конфиг, но это не так. Будет ошибка, что нет гита. Если использовать nix-shell для гита, то скажет, что нет экспериментальной функции. Либо писать огромную команду, либо, как советую сделать я, изменить стоковый конфиг никса. Для этого пишем следующее:

```sh
sudo nano /etc/nixos/configuration.nix
```

Я добавил туда `nix.settings.experimental-features = [ "nix-command" "flakes" ];` сразу после настроек `boot`. Ниже, почти в самом конце, в `environment.systemPackages = with pkgs;` я добавил пакеты `wget, git, curl`. В итоге получился такой конфиг (написал лишь его часть):

```nix
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    curl
    fastfetch
  ];
}
```

После этого сохраняем и пишем в терминале это:

```sh
sudo nixos-rebuild switch
```

Дальше есть два способа. Перед использованием любого из них я рекомендую сделать форк и внести следующие изменения в конфиг перед установкой (либо можно сделать гит клон и через nano/vim внести изменения для первых трёх пунктов, остальное менять на готовой системе):

- Переменную `username` в `nixos/configuration.nix`.
- `username` и `homeDirectory` в `nixos/home.nix`.
- `userName` и `userEmail` в `modules/home-manager/terminal/git.nix`.

Если видеокарта не от AMD, то надо сделать это. Если видеокарта от AMD, то стоит убедиться, что сделано наоборот, то есть включены нужные параметры.
- Удалить `rocmSupport = true;` в файле `flake.nix`
- Удалить `videoDrivers = [ "amdgpu" ];` и `deviceSection = ''Option "TearFree" "True"'';` в конце файла `modules/nixos/xserver.nix`. Возможно надо включить `videoDrivers = [ "nvidia" ];`, если видеокарта от Nvidia. Но лучше почитать https://nixos.wiki/wiki/Nvidia. Для графики Intel читать это https://nixos.wiki/wiki/Intel_Graphics. Мб для Nvidia и Intel не обязательно добавлять настройки и удалить amd конфиги будет достаточно для запуска.
- Удалить всю категорию настроек `amdgpu = {}`, удалить `boot.initrd.kernelModules`, и удалить всю категорию настроек `systemd.tmpfiles.rules = let` в файле `modules/nixos/hardware.nix`

А это можно донастроить уже в готовой системе
- Путь до `home` в `shit/qt5ct/qt5ct.conf` и `shit/qt6ct/qt6ct.conf`.
- Параметры мониторов закомментированы в файле `modules/home-manager/wm/bspwm/bspwm.nix`. Можно указать по желанию. Команда xrandr покажет доступные значения и имена мониторов.
- Если надо задать симлинки, то для этого есть файл `modules/home-manager/symlinks.nix`. Там сейчас мои симлинки, их лучше удалить. Чтоб файл заработал, надо раскомментировать `./symlinks.nix` в файле `modules/home-manager/bundle.nix`.
- Если надо монтировать другие диски, то для этого есть файл `modules/nixos/filesystems.nix`. Там сейчас мой второй ссд. Чтоб файл заработал, надо раскомментировать `./filesystems.nix` в файле `modules/nixos/bundle.nix`.
- Если нужна гибернация, то её можно настроить в `modules/nixos/hibernate.nix`. Там надо указать uuid и офсет для swap файла. Чтоб файл заработал, надо раскомментировать `./hibernate.nix` в файле `modules/nixos/bundle.nix`.

С гитом есть нюанс. Если захочешь потом создать свои конфиги или добавить новые файлы, на которые надо ссылаться из nix, то надо указывать либо полный путь до файла, либо добавлять файл в гит. Если указывать относительный путь, как сделано в моих `bundle.nix`, то все эти файлы должны находиться в гите, либо каталог дотсов должен быть без гита вовсе. Если в каталоге дотсов инициализирован репозиторий гита, то в относительных путях он не видит файлы из `gitignore` или просто не отслеживаемые гитом файлы.

### Первый способ

Установить систему одной командой (я написал пример для github, но сейчас мои дотсы есть лишь на forgejo, не знаю как с него использовать такой синтаксис):
```sh
sudo nixos-rebuild boot --flake github:Buliway/nixos-private-dots --impure
```

Чтоб использовать с репой forgejo, можно попробовать такой синтаксис `git@git.buliway.ru:Buliway/nixos-private-dots`.

Параметр `boot` делает так, что настройки не применяются сразу. После установки надо будет перезапустить пк. Если хочешь проверить как оно заработает без ребута пк, то используй `switch` вместо `boot`.

### Второй способ

Клонировать репозиторий и ребилдить систему с указанием пути:
```sh
git clone https://git.buliway.ru/buliway/nixos-private-dots
sudo nixos-rebuild boot --impure --flake ~/nixos-private-dots
```
Параметр `boot` делает так, что настройки не применяются сразу. После установки надо будет перезапустить пк. Если хочешь проверить как оно заработает без ребута пк, то используй `switch` вместо `boot`.

## После установки надо

Эта заметка частично для меня. Каждый ставит то, что ему надо

- Включить подкачку на 64 гига в `/etc/nixos/hardware-configuration.nix` через такой синтаксис:
```nix
  swapDevices = [ {
    device = "/swapfile";
    size = 64*1024; # В мегабайтах
  } ];
```
- Настроить гибренацию в `modules/nixos/hibernate.nix`
- Активировать скрипт в `shit` каталоге, чтоб скопировать нужные конфиги в нужные каталоги. Симлинки не работают
- Настроить приложения `Qt5 Settings`, `Qt6 Settings` и `Kvantum`. Там надо выбрать свою системную тему. Вроде всё интуитивно понятно будет. Можно попробовать обновить систему, в надежде, что системная тема `stylix` начнёт работать с приложениями `qt`. Для этого надо будет закомментить настройки `qt` в конфиге `stylix`.
- Руками настроить `thunar`, `discord`, `telegram`, `steam`, `strawberry` и бинды для `ksnip`
- Добавить gpg ключи
```sh
gpg --import /path/to/your-key.gpg
```
Если не работает, то смотришь список ключей. Копируешь ID нужного и используешь во второй команде.
```sh
gpg --list-keys
gpg --edit-key ID-ключа
```
В этом режиме надо написать trust и выбрать степень доверия. Например 5 для своих ключей можно задать, это прям самое максимально доверие. Потом Ctrl + D чтоб выйти.

## Изменения для виртуалок

Виртуалка требует минимум 100гб памяти. Если хочешь меньше, то удали огромную кучу софта из конфигов, который тебе не нужен на виртуалке.

Это надо, чтоб включить коннект по ssh к виртуалке и сделать с ней общий буфер обмена. Ну и ещё параметры экрана меняю на один 1080p монитор на 60 герц.

В файле `modules/nixos/virtualisation.nix` раскомментировать эти строки:
```diff
+  services = {
+    openssh.enable = true; # Это ставится на виртуалку, чтоб к ней конект по ssh работал.
+    spice-vdagentd.enable = true; # Clipboard sharing
+    qemuGuest = {
+      enable = true; # Fix resolution
+      package = pkgs.qemu_full;
+    };
+  };
```
В файле `modules/home-manager/wm/bspwm/bspwm.nix` изменить эти строки:
```diff
   extraConfigEarly = ''
-     xrandr --output DisplayPort-2 --mode 1920x1080 --rate 165
-     xrandr --output HDMI-A-0 --mode 1920x1080 --rate 100 --right-of DisplayPort-2
+     xrandr --output Virtual-1 --mode 1920x1080 --rate 60
   '';
```
В файле `modules/nixos/xserver.nix` закомментировать эти строки, даже если amd gpu на хосте:
```diff
-    videoDrivers = [ "amdgpu" ]; # https://nixos.wiki/wiki/AMD_GPU
-    deviceSection = ''Option "TearFree" "True"'';
+    # videoDrivers = [ "amdgpu" ]; # https://nixos.wiki/wiki/AMD_GPU
+    # deviceSection = ''Option "TearFree" "True"'';
```
