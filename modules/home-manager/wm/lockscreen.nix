# Есть разные варианты блокировки дисплея. Надо выбрать один
# - i3lock и разные бафы для него (https://i3wm.org/i3lock/)
#     В стоке должен нормально работать. Со скриптами на визуал лагает и имеет кд секунды три
# - betterlockscreen (https://github.com/betterlockscreen/betterlockscreen/)
#     Бафнутый i3lock без лагов
# - slock (https://tools.suckless.org/slock/)
#     Suckless soft. Simple X display locker. Минимализм

# Есть разные варианты автоматической блокировки дисплея. Требуют блокировщик, сами им не являются
# - xautolock (https://linux.die.net/man/1/xautolock)
#     Утилита для автоматической блокировки экрана через определенный промежуток времени бездействия.
# - xidlehook (https://github.com/jD91mZM2/xidlehook)
#     Утилита для выполнения команд или скриптов в зависимости от времени бездействия пользователя.


############################################
## Вариант 1. Используем betterlockscreen ##
############################################

# Чтоб задать изображение для локскрина, надо написать это:
# betterlockscreen -u путь
# Путь может быть до изображения или каталога. Если каталог, то рандомит картинку
# betterlockscreen --lock (или -l) блокирует экран и применяет указанные фильтры для картинки

# { 
#   services.betterlockscreen = {
#     enable = true;
#     inactiveInterval = 10; # Value used for {option}services.screen-locker.inactiveInterval.
#     arguments = [ # List of arguments appended to ./betterlockscreen --lock [args]
#       "dimblur"
#     ];
#   };
# }

################################################################
## Вариант 2. Используем betterlockscreen через другой сервис ##
################################################################

# { pkgs, ... }: {
#   services.screen-locker = {
#     enable = true;

#     # Inactive time interval in minutes after which session will be locked.
#     # The minimum is 1 minute, and the maximum is 1 hour.
#     # If {option}xautolock.enable is true, it will use this setting.
#     # Otherwise, this will be used with {command}xset to configure the X server's screensaver timeout.
#     inactiveInterval = 10;

#     # Команда для запуска локсрина. Тут "-c 000000" это чёрный цвет фона
#     lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dimblur";
#   };
# }

########################################################################
## Вариант 3. Используем betterlockscreen через продвинутый xidlehook ##
########################################################################

# { pkgs, ... }: {
#   services.xidlehook = {
#     enable = true;
#     not-when-audio = true;
#     not-when-fullscreen = true;
#     timers = [
#       {
#         delay = 600;
#         command = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dimblur";
#       }
#     ];
#   };
# }

###################################################################################
## Вариант 4. Просто скачать betterlockscreen. Без автолока. Чтоб с биндом юзать ##
###################################################################################

{ pkgs, ... }: {
  home.packages = with pkgs; [
    betterlockscreen
  ];
}
