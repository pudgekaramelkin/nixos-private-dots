# Надо удалить оригинальный файл, прежде чем делать симлинк
# Некоторые проги забивают на симлинки и заменяют их своими файлами (например thunar)
# Тут уж ничего не поделать, придётся руками настраивать
# Если выдаёт ошибку про home-manager сервис при ребилде,
# значит такой файл уже существует и симлинк туда кинуть нельзя 
# Для таких файлов я сделал каталог shit

# Я не уверен надо ли писать "config.lib.file.mkOutOfStoreSymlink"
# Вроде это более простой симлинк, чем просто ссылка на файл
# Типо он напрямую симлинк кидает, а не через 100500 симлинков в nix/store 
# Но мб меня обманули

{ config, ... }: let
  home-dir = "backups"; # Имя каталога для бекапов. Мб захочу поменять
  dir = "${config.home.homeDirectory}/${home-dir}";
in {
  home.file = { # В .config этим нельзя кидать
    "${home-dir}".source = config.lib.file.mkOutOfStoreSymlink "/mnt/${home-dir}"; # Чтоб остальные симлинки были от ~/backups

    # Secrets
    ".password-store".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Backups/.password-store"; # Для утилиты pass
    ".ssh".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Backups/.ssh";

    # Browsers. Мб сделать .force, чтоб удалить сток. А мб руками удалить сток перед этим
    ".mozilla".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Backups/Apps/.mozilla";
    ".librewolf".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Backups/Apps/.librewolf";

    "Downloads/Telegram Desktop".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Telegram Desktop";
  };

  xdg.configFile = { # Это для каталога .config
    # "chromium".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Backups/Apps/chromium";
  };
}
