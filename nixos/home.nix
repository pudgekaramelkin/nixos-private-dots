{ config, pkgs, inputs, lib, ... }: {

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../modules/home-manager/bundle.nix
  ];

  home = {
    username = "pudgekaramelka";
    homeDirectory = "/home/pudgekaramelka";

    # Если с каким-то софтом будут проблемы, то можно перенести из "packages.nix" сюда
    # Например, я читал, что если ставить vscode через configuration.nix, а не через пакеты юзера,
    # то не получится ставить расширения. Потому что там софт ставится от рута и vscode
    # будет пытаться установить расширения в каталог nix store, куда нельзя что либо ставить даже с рутом.
    packages = with pkgs; [
      vscode # Надо в home.packages писать, чтоб расширения ставились
    ];

    sessionVariables = {
      EDITOR = "nvim";
      # VISUAL = "nvim";
      BROWSER = "librewolf";
      TERMINAL = "alacritty";
      TERM = "alacritty";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      # QT_STYLE_OVERRIDE = "kvantum";
      PATH = "$PATH:${config.home.homeDirectory}/go/bin";
    };

    stateVersion = "24.05"; # Don't change it
  };

  gtk = lib.mkIf (pkgs.stdenv.hostPlatform.isLinux) {
    # enable = true;
    iconTheme = {
      name = "Papirus-Dark"; # Имя каталога в /usr/share/icons/
      # package = pkgs.papirus-icon-theme; # Пакет иконок
    };
  };

  stylix = { # Выключить стили у конкретного таргета походу можно лишь в home-manager
    targets = {
      vscode.enable = false; # Руками ставлю. Не нравится stylix вариант
      firefox.enable = false; # Руками ставлю и бекаплю каталог браузера
    };
    # iconTheme = {
    #   enable = true;
    #   package = pkgs.papirus-icon-theme;
    #   dark = "Papirus-Dark";
    # };
  };

  ##############################################
  ## Ниже включаю проги для Stylix            ##
  ## Потому что не все из них вкл в стоке     ##
  ##############################################

  # programs = {
  #   btop.enable = true;
  # };
}
