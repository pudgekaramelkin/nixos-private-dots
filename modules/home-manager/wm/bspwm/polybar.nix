# Про единицы измерения
# Если просто написать число, то это будет количество пробелом в прямом смысле. Размер зависит от шрифта
# Если указать pt (points), то это 1/72 часть дюйма, которая преобразуется в количество пикселей в зависимости от DPI монитора
# Если указывать px, то это пиксели, логично
# Интересные готовые скрипты для polybar https://github.com/polybar/polybar-scripts

# Если в трее не отображаются иконки, то вот вариант решения:
# Put `export XDG_DATA_DIRS=~/.nix-profile/share:$XDG_DATA_DIRS` in `/etc/profile`
# Взято отсюда https://www.reddit.com/r/voidlinux/comments/1apb5d0/comment/kqzabg6

# При наведении на имя окна сделать скрол фул имени через zscroll
# Если лень не будет, то потом сделаю

# Варианты кликов мыши
# click-left 
# click-middle 
# click-right
# scroll-up
# scroll-down
# double-click-left
# double-click-middle
# double-click-right

{ pkgs, config, ... }: let
  rofiApps = "${config.home.homeDirectory}/.config/rofi/launcher.rasi";
  rofiPower = "${config.home.homeDirectory}/.config/rofi/power.rasi";
  # monitor = "$\{env:MONITOR:\}";
in { # Статус бар внизу
  services.polybar = {
    enable = true;

    # Скрипт запуска polybar. Выключил. Включаю в bspwm.nix
    script = ''
      sleep 0
    '';

    settings = { # Или переимeнoвать в "config"? Не понял в чём разница
      "bar/bspwm" = {
        monitor = "\${env:MONITOR:}";

        bottom = true;
        fixed-center = true;
        enable-ipc = true;
        double-click-interval = 400;
        offset-x = 0;
        offset-y = 0;

        width = "100%";
        height = "16pt";
        radius = 0;
        dpi = 0;
        background = config.lib.stylix.colors.base00;
        foreground = config.lib.stylix.colors.base07;
        border-color = config.lib.stylix.colors.base00;
        border-size = "4pt";
        module-margin = "4pt";
        separator = "|";
        separator-foreground = config.lib.stylix.colors.base0F;

        modules-left = "bspwm title";
        modules-center = "time";
        modules-right = "cpu memory alsa tray xkeyboard rofi power";
        wm-restack = "bspwm";

        font-0 = "NotoSans Nerd Font:style=Regular:size=12;3";

        # Polybar не может юзать все Noto Sans при указании одного шрифта
        # А ещё оно не может отображать смайлики нормально, залупа на пол экрана
        font-1 = "Noto Sans:size=12;3";
        font-2 = "Noto Sans CJK HK:size=12;3";
        font-3 = "Noto Sans CJK JP:size=12;3";
        font-4 = "Noto Sans CJK KR:size=12;3";
        font-5 = "Noto Sans CJK SC:size=12;3";
        font-6 = "Noto Sans CJK TC:size=12;3";
        font-7 = "Unifont:style=Regular:size=12;3";
        font-8 = "Noto Sans Balinese:size=12;3";
        font-9 = "Noto Sans Bamum:size=12;3";
        font-10 = "Noto Sans Zanabazar Square:size=12;3";
        font-11 = "Noto Sans Bassa Vah:size=12;3";
        font-12 = "Noto Sans Batak:size=12;3";
        font-13 = "Noto Sans Bengali:size=12;3";
        font-14 = "Noto Sans Bhaiksuki:size=12;3";
        font-15 = "Noto Sans Brahmi:size=12;3";
        font-16 = "Noto Sans Buginese:size=12;3";
        font-17 = "Noto Sans Buhid:size=12;3";
        font-18 = "Noto Sans Canadian Aboriginal:size=12;3";
        font-19 = "Noto Sans Carian:size=12;3";
        font-20 = "Noto Sans Caucasian Albanian:size=12;3";
        font-21 = "Noto Sans Chakma:size=12;3";
        font-22 = "Noto Sans Cham:size=12;3";
        font-23 = "Noto Sans Cherokee:size=12;3";
        font-24 = "Noto Sans Chorasmian:size=12;3";
        font-25 = "Noto Sans Adlam:size=12;3";
        font-26 = "Noto Sans Anatolian Hieroglyphs:size=12;3";
        font-27 = "Noto Sans Arabic:size=12;3";
        font-28 = "Noto Sans Armenian:size=12;3";
        font-29 = "Noto Sans Avestan:size=12;3";
        font-30 = "Noto Sans Elymaic:size=12;3";
        font-31 = "Noto Sans Coptic:size=12;3";
        font-32 = "Noto Sans Cuneiform:size=12;3";
        font-33 = "Noto Sans Cypriot:size=12;3";
        font-34 = "Noto Sans Cypro Minoan:size=12;3";
        font-35 = "Noto Sans Deseret:size=12;3";
        font-36 = "Noto Sans Devanagari:size=12;3";
        font-37 = "Noto Sans Duployan:size=12;3";
        font-38 = "Noto Sans Egyptian Hieroglyphs:size=12;3";
        font-39 = "Noto Sans Elbasan:size=12;3";
        font-40 = "Noto Sans Hanunoo:size=12;3";
        font-41 = "Noto Sans Ethiopic:size=12;3";
        font-42 = "Noto Sans Georgian:size=12;3";
        font-43 = "Noto Sans Glagolitic:size=12;3";
        font-44 = "Noto Sans Gothic:size=12;3";
        font-45 = "Noto Sans Grantha:size=12;3";
        font-46 = "Noto Sans Gujarati:size=12;3";
        font-47 = "Noto Sans Gunjala Gondi:size=12;3";
        font-48 = "Noto Sans Gurmukhi:size=12;3";
        font-49 = "Noto Sans Hanifi Rohingya:size=12;3";
        font-50 = "Noto Sans Kawi:size=12;3";
        font-51 = "Noto Sans Hatran:size=12;3";
        font-52 = "Noto Sans Hebrew:size=12;3";
        font-53 = "Noto Sans Imperial Aramaic:size=12;3";
        font-54 = "Noto Sans Indic Siyaq Numbers:size=12;3";
        font-55 = "Noto Sans Inscriptional Pahlavi:size=12;3";
        font-56 = "Noto Sans Inscriptional Parthian:size=12;3";
        font-57 = "Noto Sans Javanese:size=12;3";
        font-58 = "Noto Sans Kaithi:size=12;3";
        font-59 = "Noto Sans Kannada:size=12;3";
        font-60 = "Noto Sans Linear B:size=12;3";
        font-61 = "Noto Sans Kayah Li:size=12;3";
        font-62 = "Noto Sans Kharoshthi:size=12;3";
        font-63 = "Noto Sans Khmer:size=12;3";
        font-64 = "Noto Sans Khojki:size=12;3";
        font-65 = "Noto Sans Khudawadi:size=12;3";
        font-66 = "Noto Sans Lao:size=12;3";
        font-67 = "Noto Sans Lepcha:size=12;3";
        font-68 = "Noto Sans Limbu:size=12;3";
        font-69 = "Noto Sans Linear A:size=12;3";
        font-70 = "Noto Sans Math:size=12;3";
        font-71 = "Noto Sans Lisu:size=12;3";
        font-72 = "Noto Sans Lycian:size=12;3";
        font-73 = "Noto Sans Lydian:size=12;3";
        font-74 = "Noto Sans Mahajani:size=12;3";
        font-75 = "Noto Sans Malayalam:size=12;3";
        font-76 = "Noto Sans Mandaic:size=12;3";
        font-77 = "Noto Sans Manichaean:size=12;3";
        font-78 = "Noto Sans Marchen:size=12;3";
        font-79 = "Noto Sans Masaram Gondi:size=12;3";
        font-80 = "Noto Sans Mono CJK HK:size=12;3";
        font-81 = "Noto Sans Mayan Numerals:size=12;3";
        font-82 = "Noto Sans Medefaidrin:size=12;3";
        font-83 = "Noto Sans Meetei Mayek:size=12;3";
        font-84 = "Noto Sans Mende Kikakui:size=12;3";
        font-85 = "Noto Sans Meroitic:size=12;3";
        font-86 = "Noto Sans Miao:size=12;3";
        font-87 = "Noto Sans Modi:size=12;3";
        font-88 = "Noto Sans Mongolian:size=12;3";
        font-89 = "Noto Sans Mono:size=12;3";
        font-90 = "Noto Sans Nandinagari:size=12;3";
        font-91 = "Noto Sans Mono CJK JP:size=12;3";
        font-92 = "Noto Sans Mono CJK KR:size=12;3";
        font-93 = "Noto Sans Mono CJK SC:size=12;3";
        font-94 = "Noto Sans Mono CJK TC:size=12;3";
        font-95 = "Noto Sans Mro:size=12;3";
        font-96 = "Noto Sans Multani:size=12;3";
        font-97 = "Noto Sans Myanmar:size=12;3";
        font-98 = "Noto Sans Nabataean:size=12;3";
        font-99 = "Noto Sans Nag Mundari:size=12;3";
        font-100 = "Noto Sans Old Permic:size=12;3";
        font-101 = "Noto Sans Newa:size=12;3";
        font-102 = "Noto Sans New Tai Lue:size=12;3";
        font-103 = "Noto Sans NKo:size=12;3";
        font-104 = "Noto Sans Nushu:size=12;3";
        font-105 = "Noto Sans Ogham:size=12;3";
        font-106 = "Noto Sans Ol Chiki:size=12;3";
        font-107 = "Noto Sans Old Hungarian:size=12;3";
        font-108 = "Noto Sans Old Italic:size=12;3";
        font-109 = "Noto Sans Old North Arabian:size=12;3";
        font-110 = "Noto Sans Pau Cin Hau:size=12;3";
        font-111 = "Noto Sans Old Persian:size=12;3";
        font-112 = "Noto Sans Old Sogdian:size=12;3";
        font-113 = "Noto Sans Old South Arabian:size=12;3";
        font-114 = "Noto Sans Old Turkic:size=12;3";
        font-115 = "Noto Sans Oriya:size=12;3";
        font-116 = "Noto Sans Osage:size=12;3";
        font-117 = "Noto Sans Osmanya:size=12;3";
        font-118 = "Noto Sans Pahawh Hmong:size=12;3";
        font-119 = "Noto Sans Palmyrene:size=12;3";
        font-120 = "Noto Sans Shavian:size=12;3";
        font-121 = "Noto Sans Phags-Pa:size=12;3";
        font-122 = "Noto Sans PhagsPa:size=12;3";
        font-123 = "Noto Sans Phoenician:size=12;3";
        font-124 = "Noto Sans Psalter Pahlavi:size=12;3";
        font-125 = "Noto Sans Rejang:size=12;3";
        font-126 = "Noto Sans Runic:size=12;3";
        font-127 = "Noto Sans Samaritan:size=12;3";
        font-128 = "Noto Sans Saurashtra:size=12;3";
        font-129 = "Noto Sans Sharada:size=12;3";
        font-130 = "Noto Sans Symbols 2:size=12;3";
        font-131 = "Noto Sans Siddham:size=12;3";
        font-132 = "Noto Sans SignWriting:size=12;3";
        font-133 = "Noto Sans Sinhala:size=12;3";
        font-134 = "Noto Sans Sogdian:size=12;3";
        font-135 = "Noto Sans Sora Sompeng:size=12;3";
        font-136 = "Noto Sans Soyombo:size=12;3";
        font-137 = "Noto Sans Sundanese:size=12;3";
        font-138 = "Noto Sans Syloti Nagri:size=12;3";
        font-139 = "Noto Sans Symbols:size=12;3";
        font-140 = "Noto Sans Telugu:size=12;3";
        font-141 = "Noto Sans Syriac:size=12;3";
        font-142 = "Noto Sans Tagalog:size=12;3";
        font-143 = "Noto Sans Tagbanwa:size=12;3";
        font-144 = "Noto Sans Tai Le:size=12;3";
        font-145 = "Noto Sans Tai Tham:size=12;3";
        font-146 = "Noto Sans Tai Viet:size=12;3";
        font-147 = "Noto Sans Takri:size=12;3";
        font-148 = "Noto Sans Tamil:size=12;3";
        font-149 = "Noto Sans Tangsa:size=12;3";
        font-150 = "Noto Sans Warang Citi:size=12;3";
        font-151 = "Noto Sans Test:size=12;3";
        font-152 = "Noto Sans Thaana:size=12;3";
        font-153 = "Noto Sans Thai:size=12;3";
        font-154 = "Noto Sans Tifinagh:size=12;3";
        font-155 = "Noto Sans Tirhuta:size=12;3";
        font-156 = "Noto Sans Ugaritic:size=12;3";
        font-157 = "Noto Sans Vai:size=12;3";
        font-158 = "Noto Sans Vithkuqi:size=12;3";
        font-159 = "Noto Sans Wancho:size=12;3";
        font-160 = "Noto Sans Yi:size=12;3";
      };

      "module/rofi" = {
        type = "custom/text";
        click-left = "exec rofi -show drun -show-icons -theme ${rofiApps}";
        label = " ";
      };

      "module/power" = {
        type = "custom/text";
        click-left = "exec rofi -show powermenu -modi powermenu:${pkgs.rofi-power-menu}/bin/rofi-power-menu -theme ${rofiPower}";
        label = " ";
      };

      "module/bspwm" = {
        type = "internal/bspwm";
        pin-workspaces = true;
        inline-mode = true;
        enable-click = true;
        enable-scroll = false;
        # reverse-scroll = false;
        # occupied-scroll = true;

        ws-icon-1 = "1;1";
        ws-icon-2 = "2;2";
        ws-icon-3 = "3;3";
        ws-icon-4 = "4;4";
        ws-icon-5 = "5;5";
        ws-icon-6 = "6;6";
        ws-icon-7 = "7;7";
        ws-icon-8 = "8;8";
        ws-icon-9 = "9;9";
        ws-icon-10 = "10;10";

        format = "<label-state>";

        label-empty = "%name%";
        label-empty-foreground = config.lib.stylix.colors.base00;
        label-empty-background= config.lib.stylix.colors.base03;
        label-empty-padding = "5pt";

        label-focused = "%name%";
        label-focused-foreground = config.lib.stylix.colors.base00;
        label-focused-background= config.lib.stylix.colors.base09;
        label-focused-padding = "5pt";

        label-occupied = "%name%";
        label-occupied-foreground = config.lib.stylix.colors.base00;
        label-occupied-background= config.lib.stylix.colors.base04;
        label-occupied-padding = "5pt";

        label-urgent = "%name%";
        label-urgent-foreground = config.lib.stylix.colors.base00;
        label-urgent-background= config.lib.stylix.colors.base08;
        label-urgent-padding = "5pt";

        label-separator = " ";
        label-separator-padding = 0;
        label-separator-foreground = config.lib.stylix.colors.base00;
      };

      "module/title" = {
        type = "internal/xwindow";
        label = "%title%";
        label-maxlen = 35;
        label-foreground = config.lib.stylix.colors.base07;
      };

      "module/time" = {
        type = "internal/date";
        interval = 1;
        date = "%d %B %Y";
        date-alt = "%d-%m-%Y";
        time = "%H:%M:%S";
        time-alt = "%H:%M";
        label = "%date% %time%";
      };  

      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        format = "<label-layout>";
        label-layout = "%icon%";
        layout-icon-0 = "ru;RU";
        layout-icon-1 = "us;EN";
        };

        "module/tray" = {
        type = "internal/tray";
        format = "<tray>";
        tray-spacing = "8px";
        tray-size = "90%";
      };

      "module/alsa" = {
        type = "internal/alsa";
        master-soundcard = "default";
        speaker-soundcard = "default";
        headphone-soundcard = "default";
        master-mixer = "Master";
        interval = 5;
        format-volume = "<label-volume>";
        format-muted = "<label-muted>";
        label-volume = "  %percentage%";
        label-muted = "  %percentage%";
        click-right = "exec pavucontrol";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 5;
        label = "RAM: %gb_used% + %gb_swap_used%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 1;
        warn-percentage = 95;
        label = "CPU %percentage%%";
        label-warn = "CPU %percentage%%";
      };
    };
  };
}
