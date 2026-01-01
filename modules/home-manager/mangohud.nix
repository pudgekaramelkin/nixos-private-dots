# Vulkan and OpenGL overlay for monitoring FPS, temperatures, CPU/GPU load and more
# https://github.com/flightlessmango/MangoHud/blob/master/data/MangoHud.conf

# To enable the MangoHud overlay layer for Vulkan and OpenGL, run: `mangohud /path/to/app`
# For Lutris games, go to the System options in Lutris (make sure that advanced options are enabled) 
# and add this to the Command prefix setting: `mangohud`
# For Steam games, you can add this as a launch option: `mangohud %command%`
# Or alternatively, add `MANGOHUD=1` to your shell profile (Vulkan only).
# OpenGL games may also need dlsym hooking. Add `--dlsym` to your command like `mangohud --dlsym %command%` for Steam.
# To enable mangohud with gamescope you need to install mangoapp. gamescope --mangoapp %command%
# Using normal mangohud with gamescope is not support.

# Затестить можно в терминале через команду MANGOHUD=1 vkcube    

{
  programs.mangohud = {
    enable = true;
    # enableSessionWide = true; # Sets environment variables so that MangoHud is started on any application that supports it.
  };

  # home.file.".config/MangoHud/MangoHud.conf".text = ''
  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    ### pre defined presets
    # -1 = default
    #  0 = no display
    #  1 = fps only
    #  2 = horizontal view
    #  3 = extended
    #  4 = high detailed information
    # preset=-1

    cpu_temp
    gpu_temp
    gpu_mem_temp
    swap

    toggle_hud=Shift_R+F12
    toggle_hud_position=Shift_R+F11
    toggle_preset=Shift_R+F10
    # toggle_fps_limit=Shift_L+F1
    # toggle_logging=Shift_L+F2
    # reload_cfg=Shift_L+F4
    # upload_log=Shift_L+F3

    background_alpha=0.8 # Hud transparency
    alpha=0.8 # Hud alpfa
    log_duration=300 # Set amount of time the logging will run for (in seconds)

    # gamemode # Display GameMode running status
    # vkbasalt # Display vkBasalt running status
    # fsr # Display the status of FSR (only works in gamescope)
    # throttling_status # Display GPU throttling status. Only shows if throttling is currently happening
    # no_display # Disable / hide the hud by deafult
    # battery = true;

    ### Limit the application FPS. Comma-separated list of one or more FPS values (e.g. 0,30,60). 0 means unlimited (unless VSynced)
    # fps_limit=0

    ### early = wait before present, late = wait after present
    # fps_limit_method=

    ### VSync [0-3] 0 = adaptive; 1 = off; 2 = mailbox; 3 = on
    # vsync=-1

    ### OpenGL VSync [0-N] 0 = off; >=1 = wait for N v-blanks, N > 1 acts as a FPS limiter (FPS = display refresh rate / N)
    # gl_vsync=-2
  '';
}
