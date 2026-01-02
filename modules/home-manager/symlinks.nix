# Надо удалить оригинальный файл, прежде чем делать симлинк
# Некоторые проги забивают на симлинки и заменяют их своими файлами (например thunar)
# Тут уж ничего не поделать, придётся руками настраивать
# Если выдаёт ошибку про home-manager сервис при ребилде,
# значит такой файл уже существует и симлинк туда кинуть нельзя 
# Для таких файлов я сделал каталог shit

# Я не уверен надо ли писать "config.lib.file.mkOutOfStoreSymlink"
# Он работает только с абсолютными путями

{ config, ... }: let
  home-dir = "backups"; # Имя каталога для бекапов. Мб захочу поменять
  dir = "${config.home.homeDirectory}/${home-dir}";
in {
  home.file = { # В .config этим нельзя кидать
    "${home-dir}".source = config.lib.file.mkOutOfStoreSymlink "/mnt/${home-dir}"; # Чтоб остальные симлинки были от ~/backups

    # Secrets
    ".ssh".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Backups/.ssh";
  };

  xdg.configFile = { # Это для каталога .config
    # "vesktop/themes/my-vesktop_theme.css".source = config.lib.file.mkOutOfStoreSymlink "${dir}/Backups/Apps/my-vesktop_theme.css"
  };
}
