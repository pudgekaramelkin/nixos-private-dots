{
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    # enableFishIntegration = true;
    enableNushellIntegration = true;

    enableTransience = true; # Fish Shell only. Отображает пустую строку при нажатии enter?
  };

  xdg.configFile."starship.toml".source = ./starship.toml;
}
