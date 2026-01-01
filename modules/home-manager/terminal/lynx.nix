{ pkgs, ... }: {
  home = {
    packages = [ pkgs.lynx ]; # Текстовый браузер в терминале. Без картинок

    # Чтоб lynx отображал все символы, а не транслит
    file.".lynxrc".text = ''
      accept_all_cookies=on
      force_ssl_cookies_secure=on
    
      case_sensitive_searching=off
      character_set=UNICODE (UTF-8)
    '';
  };
}