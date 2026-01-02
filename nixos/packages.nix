{ pkgs, pkgs2, spkgs, inputs, ... }: {

  # https://nixos.wiki/wiki/Fonts
  fonts.packages = with pkgs; [
    noto-fonts # Шрифт от гугла, цель которого поддержка всех языков мира
    noto-fonts-cjk-serif # Отображение иероглифов. Версия с засечками
    noto-fonts-cjk-sans # Отображение иероглифов. Версия без засечек
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    nerd-fonts.caskaydia-mono
    carlito # Совместим с Calibri, разработан как его свободная альтернатива. Без засечек
    terminus_font
    inconsolata
    font-awesome
    liberation_ttf
    dejavu_fonts
    cantarell-fonts
    unifont
    unifont_upper
  ];

  systemd = { # Запуск гномовского полкита. Окно ввода пароля для рут доступа
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities for Thunar file manager
    tumbler.enable = true; # Thumbnail support for Thunar file manager
    # unclutter.enable = true; # Hide your mouse cursor when inactive
    # fwupd.enable = true; # DBus service that allows applications to update firmware
    # fstrim.enable = true; # Чистит ssd для норм производительности. Пока не пользуюсь
    flatpak = {
      # flatpak install flathub com.github.tchx84.Flatseal
      enable = true;
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs2; [
        stdenv.cc.cc
        # Nekoray (Throne)
        kdePackages.qtbase
        kdePackages.qttools
        kdePackages.qtwayland
        kdePackages.qtsvg
        kdePackages.qtimageformats
        util-linux
        zlib
        zstd
        mesa
        libGL
        libglvnd
        libxkbcommon
        freetype
        fontconfig
        xorg.libX11
        xorg.libXext
        xorg.libXrandr
        xorg.libXrender
        xorg.libXcursor
        xorg.libXxf86vm
        xorg.libXi
        xorg.libxcb
        xorg.libXfixes
        xorg.xcbutil
        xorg.xcbutilkeysyms
        xorg.xcbutilwm
        xorg.xcbutilimage
        xorg.xcbutilrenderutil
        xcb-util-cursor
        glib
        dbus
        krb5
      ];
    };
    zsh.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-qt; # Окно ввода пароля
    };

    appimage = { # Чтоб .appimage работал
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override { # Зависимости для нужных мне приложений
        extraPkgs = pkgs: with pkgs; [ libpng libpng12 libepoxy pcre2 double-conversion ];
      };
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-media-tags-plugin # Tagging and renaming features for media files
        thunar-archive-plugin # File context menus for archives
        thunar-volman # Automatic management of removable drives and media
      ];
    };
    xfconf.enable = true; # For Thunar configs

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    # Оптимизация для игр. https://github.com/FeralInteractive/gamemode
    gamemode.enable = true;

    # Я хз надо ли оно мне. https://github.com/ValveSoftware/gamescope
    # Подробносни тут https://ventureo.codeberg.page/source/linux-gaming.html#gamescope
    # gamescope.enable = true;

    adb.enable = true; # Android Tools
  };

  environment.systemPackages = with pkgs; [

    ######################
    ## Программирование ##
    ######################

    # Это рекомендуют ставить не на всю систему,
    # а только на nix shell внутри проекта, где нужны эти пакеты
    # Но я хочу на всю систему

    # Python
    python3 # Python last version
    python3Packages.pip # Python package manager (nvim его не видит)
    python3Packages.debugpy # Debug Adapter Protocol for Python
    pyright # Python LSP
    ruff # Extremely fast Python linter

    # C/C++
    # clang-tools # Clangd? LSP
    # ccls # C/C++ LSP
    # clang # Компилятор
    # gcc # Компилятор
    # glibc # GNU C Library
    # gnumake # ?
    # cmake-language-server # CMake LSP
    # cmake # ?
    # bear # Tool that generates a compilation database for clang tooling
    # boost # Collection of C++ libraries

    # Rust
    rust-analyzer # Rust LSP (rustup component add rust-analyzer)

    # Golang
    go # Go programming language
    gopls # Go LSP
    delve # Go debugger
    templ # A language for writing HTML user interfaces in Go.
    golangci-lint # Fast linters Runner for Go

    # Nix
    nixd # Nix LSP. Нет в mason

    # Lua
    lua5_1 # Scripting language
    luajit # JIT compiler for Lua
    luajitPackages.luarocks # Package manager for lua
    lua-language-server # Lua LSP
    stylua # Lua formatter

    # Shell/Bash
    bash-language-server # Basp LSP
    shellcheck # Проверка shell скриптов на ошибки
    shfmt # Shell parser and formatter

    # SQL
    sqls # SQL LSP
    sqlite
    dbeaver-bin

    # Frontend
    nodejs_24 # For npm
    htmx-lsp # HTMX lsp
    emmet-language-server # Emmet.io LSP
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint LSP
    typescript-language-server # TypeScript LSP
    tailwindcss-language-server # Tailwind LSP
    svelte-language-server # Svelte LSP
    tailwindcss

    # Protobuf
    # buf # LSP (крашит некоторые проекты в нвиме)
    protols # LSP
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc

    # Gamedev
    # godot
    # gdtoolkit_4
    # ldtk

    # Kubernetes
    # k3d # k3s in Docker
    # kubectl # Kubernetes CLI
    # kubernetes-helm # Package manager for kubernetes

    # Other
    # hugo # Для моего блога
    yaml-language-server # YAML LSP
    taplo # TOML LSP
    vim-language-server # VimScript LSP
    # go-migrate # Database migrations. CLI and Golang library
    # postman # API Development Environment
    # insomnia

    # Nushell
    # nushell # Modern shell

    # For nvim
    tree-sitter # For nvim
    ripgrep # For nvim
    fd # For nvim

    ############
    ## Архивы ##
    ############

    zip # Архивировать
    unzip # Разархивировать
    unrar # Разархивировать
    gnutar # Для .tar?
    p7zip # Это пакет для 7z?
    bzip2 # .bz2 архивы

    ##############
    ## Terminal ##
    ##############

    openssl
    wget
    curl
    git
    gitui # Git TUI
    xclip # Буфер обмена
    ffmpeg_7 # Обработка видео. Нужен всегда и везде как зависимость
    svt-av1 # Кодек для рендера в av1 на проце
    # imlib2Full # Image manipulation library
    imagemagick # Обработка изображений. Мб тоже нужен всегда
    vips # В 4 раза быстрее imagemagick?
    tree # Структура файлов в терминале
    gnugrep # Поиск в терминале
    gawk # Обработка и анализ текста в терминале
    rsync # Синхронизация файлов
    bat # Аналог cat с подсветкой синтаксиса
    xorg.xwininfo # Команда xprop. Статы окна, по типу класса
    xorg.xrandr # Управление мониторами
    xorg.xev # Узнать айдишник бинда
    xdg-utils # Set of command line tools that assist applications with a variety of desktop integration tasks
    playerctl # Управление медиа. Плей/пауза и тд
    xdotool # Fake keyboard/mouse input. Для rofi-pass
    # zscroll # A text scroller for use with panels and shells https://github.com/noctuid/zscroll
    tokei # Количество строк кода на разных языках в каталоге
    pass # Менеджер паролей в терминале
    amdgpu_top # Tool to display AMD GPU usage
    btop # Монитор ресурсов в терминале
    rocmPackages.rocm-smi # Чтоб в btop было gpu (не работает)
    rocmPackages.rocblas # Для работы hip?
    rocmPackages.hipblas # Для работы hip?
    rocmPackages.clr # Для работы hip?
    pkgs2.yt-dlp # Скачивать и смотреть медиа с разных сайтов
    timer # A "sleep" with progress. Таймер на пельмени "timer 5m"
    libqalculate # Advanced calculator library
    fastfetch # Пишешь в теримнал и кидаешь всем со словами I use nixos btw
    fzf # Нечёткий поиск
    killall # Убить процессы. Мем, что в стоке не стоит
    libnotify # Вызов оповещений через "notify-send"
    pkgs2.gallery-dl # Качать много картинок с кучи разных сайтов
    shellcheck # Проверка shell скриптов на ошибки
    pwgen # Генератор паролей
    lm_sensors # Сенсоры
    httpie # interacting with APIs & HTTP servers
    jq # Cli JSON processor
    libxml2 # XML parsing library for C
    miller # Like awk, sed, cut, join, and sort for data formats such as CSV, TSV, JSON, JSON Lines, and positionally-indexed
    # htmlq # Как jq, но для html. Извлекать конкретные элементы из html
    # mkvtoolnix-cli # Cross-platform tools for Matroska
    usbutils # lsusb
    f2fs-tools # f2fs filesystem
    exfat # exFAT filesystem

    alacritty # Минималистичный терминал. Основной у меня
    kitty # Самый быстрый протокол отображения медиа, но ssh через жопу работает

    #########
    ## GUI ##
    #########

    ksnip # Скрины. Аналоги - Flameshot
    file-roller # Архиватор от gnome
    qbittorrent # Торренты качать
    # thunderbird # Почтовый клиент для своей почты
    # screenkey # A screencast tool to display your keys
    pavucontrol # PulseAudio Volume Control
    # pwvucontrol # Pipewire Volume Control (Не знаю может ли полностью заменить pavucontrol)
    networkmanagerapplet # Tray for network manager
    # brightnessctl # Brightness control for laptop
    # gucharmap # Проверка шрифтов. Какой шрифт какие символы отображает

    ##############
    ## Browsers ##
    ##############

    librewolf
    firefox
    chromium
    #ungoogled-chromium

    ##########
    ## Docs ##
    ##########

    evince # Смотреть документы (так же превью PDF файлов для Thunar) (не читает FB2)
    # papers # Я так понимаю это современная замена для evince под GTK4. Оба от gnome
    libreoffice # Редактировать документы
    hunspell # Проверка орфографии для libreoffice
    hunspellDicts.ru_RU # Словарь для проверки орфографии
    hunspellDicts.en_US # Словарь для проверки орфографии
    calibre # Работа с ebook. Иногда даёт thumbnail в файловом менеджере
    # drawio # Desktop application for creating diagrams. Вроде даёт thumbnail в ranger
    spkgs.xournalpp # Xournal++ is a handwriting Notetaking software with PDF annotation support

    ###################
    ## File managers ##
    ###################

    ranger # Terminal file manager
    xfce.thunar # GUI file manager (допы выше в `programs` и `services`)
    xfce.catfish # File searching (for Thunar)
    xfce4-exo # Мб надо, чтоб терминал открывать в каталоге
    ffmpegthumbnailer # A lightweight video thumbnailer
    gnome-epub-thumbnailer # Thumbnailer for EPub and MOBI books
    # nufraw-thumbnailer # Thumbnailer for .raw images from digital cameras
    # mcomix # Comic book reader and image viewer. Thumbnailer for .crb comicbook archives (требует mupdf, который крашит систему)
    f3d # Fast and minimalist 3D viewer using VTK. Thumbnailer for 3D files, including glTF, stl, step, ply, obj, fbx.
    openscad # 3D model previews (stl, off, dxf, scad, csg). Этот именно для ranger, но мб пригодится и в других местах

    ##################
    ## File support ##
    ##################

    kdePackages.kimageformats # Image format plugins for Qt 6
    spkgs.libsForQt5.kimageformats
    kdePackages.qtimageformats # Plugins for additional image formats: TIFF, MNG, TGA, WBMP
    spkgs.libsForQt5.qt5.qtimageformats
    kdePackages.qtsvg # SVG support
    kdePackages.karchive # Plugin for Krita and OpenRaster images
    webp-pixbuf-loader # .webp support (what's this?)
    gdk-pixbuf.dev # Library for image loading and manipulation
    libwebp # .webp support
    libavif # AVIF format support
    libheif # HEIF format support
    libgsf # .odf support
    libjxl # JPEG-XL format support
    libraw # RAW format support
    librsvg # Small library to render SVG images to Cairo surfaces
    jxrlib # JPEG XR image support
    poppler # PDF support
    freetype # Font rendering engine
    imath # EXR format support
    openexr # High dynamic-range (HDR) image file format

    ###########
    ## Media ##
    ###########

    strawberry # Музыкальный плеер
    obs-studio # Запись видео
    picard # Массовый редактор метаданных музыки
    spek # Спектрограмма аудио.
    mpv # Смотреть видео
    qview # Смотреть картинки. Умеет открывать всё, включая анимированный webp и avif

    ############
    ## Social ##
    ############

    # (pkgs2.discord.override { # Discord
    #   # withOpenASAR = true; # Оптимизатор дискрода
    #   withVencord = true; # Имба плагины
    # })
    pkgs2.telegram-desktop

    ###########
    ## Games ##
    ###########

    lutris # Запускать .exe игры. Не всё через `wine game.exe` работает на nixos нормально

    # Мб зависимости
    protonup-qt # Управлять версиями proton-ge?
    steam-run # Запуск бинарей в окружении, похожем на steam runtime
    mangohud # Фпс и нагрузку на пк показывает в играх
    wineWowPackages.stableFull # support both 32- and 64-bit applications
    # wineWowPackages.staging # Можно назвать бета версией вайна
    winetricks # winetricks (all versions)
    # wineWowPackages.waylandFull # native wayland support (unstable)
    # protontricks # Running Winetricks commands for Proton-enabled games

    ############
    ## Design ##
    ############

    # inputs.affinity-nix.packages.${pkgs.system}.v3 # Бесплатная замена photoshop через wine
    # davinci-resolve # Рендер видео. Проприетарное, бесплатная версия
    # blender-hip # 3д графика и рендер видео
    gcolor3 # GUI color picker
    xcolor # CLI color picker https://github.com/Soft/xcolor

    ##################
    ## Productivity ##
    ##################

    obsidian # Заметки

    #########
    ## IDE ##
    #########

    neovim

    ###########
    ## Icons ##
    ###########

    adwaita-icon-theme
    spkgs.libsForQt5.breeze-icons # qt5
    kdePackages.breeze-icons # qt6
    papirus-icon-theme
    material-icons
    gruvbox-plus-icons

    ############
    ## Vulkan ##
    ############

    # gfxreconstruct
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    vkdisplayinfo
    dxvk # Чтоб wine игры запускались через vulkan, а не opengl (Direct3D 8/9/10/11)
    vkd3d # Чтоб wine игры запускались через vulkan, а не opengl (Direct3D 12)
    vkd3d-proton
    # vkbasalt # Баф Vulkan для улучшения визуальной графики игр https://github.com/DadSchoorse/vkBasalt

    ###########
    ## Other ##
    ###########

    # qmk # Прошивка для моих раздельных клавиатур
    # vial # GUI для qmk, если клавиатура поддерживает
    fontconfig
    zlib
    # google-fonts
    libva-utils # Проверяет работоспособность VAAPI?
    clinfo # Проверяет работоспособность OpenCL?
    libsecret # Хранить и получать аккаунты у приложений. Например для jetbrains toolbox
    alsa-utils # Мне для команды amixer надо
    pamixer # PulseAudio cli (громкость редачу)
    easyeffects # PipeWire settings. Мне для эквалайзера нужен
    # weston # Для запуска wayland only apps на x11 (ещё есть cage, но он крашит систему при ребилде)

    # Для работы некоторых тем sddm
    kdePackages.qt5compat
    spkgs.libsForQt5.qt5.qtgraphicaleffects
    spkgs.libsForQt5.qt5.qtquickcontrols
    spkgs.sddm-chili-theme # Qt5 SDDM Theme
  ];
}
