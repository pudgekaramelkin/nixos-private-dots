{ pkgs, ... }: { 
  # Оповещения. Бинды можно делать через "dunstctl"
  # https://wiki.archlinux.org/title/Dunst 
  # https://dunst-project.org/documentation/
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Gruvbox-Plus-Dark"; # Имя каталога в /usr/share/icons/
      package = pkgs.gruvbox-plus-icons; # Пакет иконок
      size = "32x32";
    };

    settings = {
      global = {
        ###############
        ### Monitor ###
        ###############

        monitor = 0; # Which monitor should the notifications be displayed on.
        follow = "mouse"; # Display notification on focused monitor. Ignore "monitor" option

        ################
        ### Geometry ###
        ################

        width = 300; # Можно задать динамический размер. Например от 0 до 300 "width = (0, 300)"
        height = 300; # The maximum height of a single notification, excluding the frame.
        origin = "top-right"; # Position the notification in the top right corner
        offset = "20x20"; # Offset from the origin
        scale = 0; # Scale factor. It is auto-detected if value is 0.
        notification_limit = 20; # Maximum number of notification (0 means no limit)

        ####################
        ### Progress bar ###
        ####################

        # Затестить прогресс бар через терминал: dunstify -h int:value:50 "Загрузка" "Процесс загрузки на 50%"
        progress_bar = true; # Turn on the progess bar. It appears when a progress hint is passed with
        progress_bar_height = 10; # This includes the frame, so make sure it's at least twice as big as the frame width.
        progress_bar_frame_width = 1; # Set the frame width of the progress bar
        progress_bar_min_width = 150; # Set the minimum width for the progress bar
        progress_bar_max_width = 300; # Set the maximum width for the progress bar

        indicate_hidden = "yes"; # Show how many messages are currently hidden (because of notification_limit).
        padding = 6; # Padding between text and separator.
        horizontal_padding = 6; # Horizontal padding.
        text_icon_padding = 0; # Padding between text and icon.
        frame_width = 3; # Defines width in pixels of frame around the notification window. Set to 0 to disable.
        sort = "no"; # Sort messages by urgency.
        separator_height = 2; # Draw a line of "separator_height" pixel height between two notifications. Set to 0 to disable.

        # Don't remove messages, if the user is idle (no mouse or keyboard input) for longer than idle_threshold seconds.
        # Set to 0 to disable.
        # A client can set the 'transient' hint to bypass this. See the rules section for how to disable this if necessary
        idle_threshold = 0;


        ############
        ### Text ###
        ############

        # The spacing between lines. 
        # If the height is smaller than the font height, it will get raised to the font height.
        line_height = 3;

        # Possible values are:
        # full: Allow a small subset of html markup in notifications:
        #        <b>bold</b>
        #        <i>italic</i>
        #        <s>strikethrough</s>
        #        <u>underline</u>
        #
        #        For a complete reference see
        #        <https://docs.gtk.org/Pango/pango_markup.html>.
        #
        # strip: This setting is provided for compatibility with some broken
        #        clients that send markup even though it's not enabled on the
        #        server. Dunst will try to strip the markup but the parsing is
        #        simplistic so using this option outside of matching rules for
        #        specific applications *IS GREATLY DISCOURAGED*.
        #
        # no:    Disable markup parsing, incoming notifications will be treated as
        #        plain text. Dunst will not advertise that it has the body-markup
        #        capability if this is set as a global setting.
        #
        # It's important to note that markup inside the format option will be parsed
        # regardless of what this is set to.
        markup = "full";

        # The format of the message.  Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        #   %n  progress value if set without any extra characters
        #   %%  Literal %
        # Markup is allowed
        format = "<b>%s</b>\n%b";

        alignment = "center"; # Alignment of message text. Possible values are "left", "center" and "right".
        vertical_alignment = "center"; # Vertical alignment of message text and icon. Possible values are "top", "center" and "bottom".
        show_age_threshold = -1; # Show age of message if message is older than show_age_threshold seconds. Set to -1 to disable.
        ellipsize = "middle"; # Specify where to make an ellipsis in long lines. Possible values are "start", "middle" and "end".
        ignore_newline = "no"; # Ignore newlines '\n' in notifications.
        stack_duplicates = true; # Stack together notifications with the same content
        hide_duplicate_count = true; # Hide the count of stacked notifications with the same content
        show_indicators = "no"; # Display indicators for URLs (U) and actions (A).
        word_wrap = "yes"; # Split notifications into multiple lines if they don't fit into geometry.

        #############
        ### Icons ###
        #############

        enable_recursive_icon_lookup = true; # Чтоб не надо было указывать icon_path
        # icon_theme = "Gruvbox-Plus-Dark";
        icon_path = "/usr/share/icons/Gruvbox-Plus-Dark/"; # Один хуй требуют указать
        icon_position = "off"; # Align icons left/right/off

        # Не знаю надо ли, когда я указал размер иконок в начале файла
        #min_icon_size = 80; # Scale small icons up to this size, set to 0 to disable.
        #max_icon_size = 80; # Scale larger icons down to this size, set to 0 to disable.

        ###############
        ### History ###
        ###############

        sticky_history = "yes"; # Should a notification popped up from history be sticky or timeout as if it would normally do.
        history_length = 15; # Maximum amount of notifications kept in history

        #####################
        ### Misc/Advanced ###
        #####################

        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst:"; # dmenu path (через что отображать gui)
        browser = "${pkgs.xdg-utils}/bin/xdg-open"; # Browser for opening urls in context menu.
        always_run_script = true; # Always run rule-defined scripts, even if the notification is suppressed
        title = "Dunst"; # Define the title of the windows spawned by dunst
        class = "Dunst"; # Define the class of the windows spawned by dunst
        corner_radius = 0; # Скругление окон?

        # Ignore the dbus closeNotification message.
        # Useful to enforce the timeout set by dunst configuration. 
        # Without this parameter, an application may close the notification sent before the user defined timeout.
        ignore_dbusclose = false;

        ##############
        ### Legacy ###
        ##############

        force_xinerama = false; # Use the Xinerama extension instead of RandR for multi-monitor support.

        #############
        ### Mouse ###
        #############

        # Defines list of actions for each mouse event
        # Possible values are:
        # * none: Don't do anything.
        # * do_action: Invoke the action determined by the action_name rule. If there is no
        #              such action, open the context menu.
        # * open_url: If the notification has exactly one url, open it. If there are multiple
        #             ones, open the context menu.
        # * close_current: Close current notification.
        # * close_all: Close all notifications.
        # * context: Open context menu for the notification.
        # * context_all: Open context menu for all notifications.
        # These values can be strung together for each mouse event, and
        # will be executed in sequence.
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";

        ###############
        ### Wayland ###
        ###############

        # These settings are Wayland-specific. They have no effect when using X11

        # Uncomment this if you want to let notications appear under fullscreen
        # applications (default: overlay)
        # layer = top

        # Set this to true to use X11 output on Wayland.
        # force_xwayland = false

      };

      # Experimental features that may or may not work correctly. 
      # Do not expect them to have a consistent behaviour across releases.
      experimental = {
        # Calculate the dpi to use on a per-monitor basis.
        # If this setting is enabled the Xft.dpi value will be ignored and instead
        # dunst will attempt to calculate an appropriate dpi value for each monitor
        # using the resolution and physical size. This might be useful in setups
        # where there are multiple screens with very different dpi values.
        per_monitor_dpi = false;
      };

      urgency_low = {
        # IMPORTANT: colors have to be defined in quotation marks.
        # Otherwise the "#" and following would be interpreted as a comment.
        timeout = 4;
        # Icon for notifications with low urgency, uncomment to enable
        #default_icon = /path/to/icon;
      };

      urgency_normal = {
        timeout = 6;
        # Icon for notifications with normal urgency, uncomment to enable
        #default_icon = /path/to/icon;
      };

      urgency_critical = {
        timeout = 8;
        # Icon for notifications with critical urgency, uncomment to enable
        #default_icon = /path/to/icon;
      };
    };
  };
}

# Every section that isn't one of the above is interpreted as a rules to
# override settings for certain messages.
#
# Messages can be matched by
#    appname: Имя приложения, отправившего уведомление (не рекомендуется использовать, см. desktop_entry).
#    body: Тело сообщения уведомления.
#    category: Категория уведомления.
#    desktop_entry: Имя записи в меню рабочего стола приложения.
#    icon: Иконка уведомления.
#    match_transient: Сопоставление с временными уведомлениями.
#    msg_urgency: Срочность уведомления.
#    stack_tag: Тег стека уведомлений.
#    summary: Заголовок уведомления.
#
# and you can override the
#    background: Цвет фона.
#    foreground: Цвет текста.
#    format: Форматирование текста.
#    frame_color: Цвет рамки.
#    fullscreen: Поведение при полноэкранных приложениях.
#    new_icon: Новая иконка.
#    set_stack_tag: Установка тега стека.
#    set_transient: Установка временного уведомления.
#    set_category: Установка категории.
#    timeout: Время отображения уведомления.
#    urgency: Срочность.
#    skip_display: Пропуск отображения.
#    history_ignore: Игнорирование истории.
#    action_name: Имя действия.
#    word_wrap: Перенос слов.
#    ellipsize: Укорачивание текста.
#    alignment: Выравнивание текста.
#
# Shell-like globbing will get expanded.
#
# Instead of the appname filter, it's recommended to use the desktop_entry filter.
# GLib based applications export their desktop-entry name. In comparison to the appname,
# the desktop-entry won't get localized.
#
# SCRIPTING
# You can specify a script that gets run when the rule matches by
# setting the "script" option.
# The script will be called as follows:
#   script appname summary body icon urgency
# where urgency can be "LOW", "NORMAL" or "CRITICAL".
#
# NOTE: It might be helpful to run dunst -print in a terminal in order
# to find fitting options for rules.

# Disable the transient hint so that idle_threshold cannot be bypassed from the
# client
#[transient_disable]
#    match_transient = yes
#    set_transient = no
#
# Make the handling of transient notifications more strict by making them not
# be placed in history.
#[transient_history_ignore]
#    match_transient = yes
#    history_ignore = yes

# fullscreen values
# show: show the notifications, regardless if there is a fullscreen window opened
# delay: displays the new notification, if there is no fullscreen window active
#        If the notification is already drawn, it won't get undrawn.
# pushback: same as delay, but when switching into fullscreen, the notification will get
#           withdrawn from screen again and will get delayed like a new notification
#[fullscreen_delay_everything]
#    fullscreen = delay
#[fullscreen_show_critical]
#    msg_urgency = critical
#    fullscreen = show

#[espeak]
#    summary = "*"
#    script = dunst_espeak.sh

#[script-test]
#    summary = "*script*"
#    script = dunst_test.sh

#[ignore]
#    # This notification will not be displayed
#    summary = "foobar"
#    skip_display = true

#[history-ignore]
#    # This notification will not be saved in history
#    summary = "foobar"
#    history_ignore = yes

#[skip-display]
#    # This notification will not be displayed, but will be included in the history
#    summary = "foobar"
#    skip_display = yes

#[signed_on]
#    appname = Pidgin
#    summary = "*signed on*"
#    urgency = low
#
#[signed_off]
#    appname = Pidgin
#    summary = *signed off*
#    urgency = low
#
#[says]
#    appname = Pidgin
#    summary = *says*
#    urgency = critical
#
#[twitter]
#    appname = Pidgin
#    summary = *twitter.com*
#    urgency = normal
#
#[stack-volumes]
#    appname = "some_volume_notifiers"
#    set_stack_tag = "volume"
#
# vim: ft=cfg