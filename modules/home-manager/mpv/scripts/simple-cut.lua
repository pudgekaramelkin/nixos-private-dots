-- Simple cut script for mpv. Only for local files.

local start_time = nil
local end_time = nil
local format_start_time = nil
local format_end_time = nil
local duration = nil

-- Function to format the timecode into a readable format (hh:mm:ss.ms)
local function format_time(seconds)
	local ms = math.floor((seconds - math.floor(seconds)) * 1000)
	local secs = math.floor(seconds)
	local mins = math.floor(secs / 60)
	secs = secs % 60
	local hours = math.floor(mins / 60)
	mins = mins % 60
    if hours > 0 then
        return string.format("%02d:%02d:%02d.%03d", hours, mins, secs, ms)
    else
        return string.format("%02d:%02d.%03d", mins, secs, ms)
    end
end

-- Function to create the clip using ffmpeg
local function create_clip(action)
    if start_time and end_time then

        if end_time <= start_time then
            mp.osd_message("End time must be greater than start time.", 2)
            return
        end

        duration = end_time - start_time
        local input_file = mp.get_property("path")
        local args = {}
        local output_file = input_file:gsub("%.%w+$", "") .. string.format(" - %s - %s", format_start_time, format_end_time)

        if action == "mp4" then
            local extension = ".mp4"
            args = {
                "ffmpeg",
                "-nostdin", "-y",            -- Не ожидать ввода, перезаписать файл, если уже существует
                "-loglevel", "error",        -- Уровень логирования ffmpeg (только ошибки)
                "-ss", tostring(start_time), -- Начальное время для копирования
                "-t", tostring(duration),    -- Длительность копируемого сегмента
                "-i", input_file,            -- Путь к исходному файлу
                "-vf", "scale=-1:720",       -- Масштабирование видео до 720p, сохраняя соотнешение сторон исходного видео
                "-pix_fmt", "yuv420p",       -- Формат пикселей для выходного видео
                "-crf", "26",                -- Качество видео (чем меньше значение, тем выше качество) (В стоке было 16)
                "-preset", "superfast",      -- Предустановленный уровень скорости кодирования
                output_file .. extension     -- Путь к выходному файлу
            }
        elseif action == "copy" then    -- Sometimes it sucks.
            local extension = mp.get_property("filename"):match("^.+(%..+)$") or ".mp4"
            args = {
                "ffmpeg",
                "-nostdin", "-y",            -- Не ожидать ввода, перезаписать файл, если уже существует
                "-loglevel", "error",        -- Уровень логирования ffmpeg (только ошибки)
                "-ss", tostring(start_time), -- Начальное время для копирования
                "-t", tostring(duration),    -- Длительность копируемого сегмента
                "-i", input_file,            -- Путь к исходному файлу
                "-c", "copy",                -- Использовать копирование без перекодировки
                "-map", "0",                 -- Скопировать все потоки (аудио, видео, субтитры и т.д.) с первого входного файла
                "-dn",                       -- Игнорирует потоки данных (если они есть), что полезно для копирования частей видео без необходимости в данных.
                "-avoid_negative_ts", "make_zero",  -- Избежать отрицательных меток времени, делая их равными нулю
                output_file .. extension     -- Путь к выходному файлу
            }
        else
            mp.osd_message("Unsupported action: " .. action, 2)
            return
        end

        mp.osd_message("Creating clip from " .. format_start_time .. " to " .. format_end_time, 2)

        mp.command_native_async({
            name = "subprocess",
            args = args,
            playback_only = false,  -- Проигрывание может быть приостановлено во время выполнения команды ffmpeg
        }, function() mp.osd_message("Clip created successfully", 2) end)  -- Обратный вызов, который будет вызван после завершения команды ffmpeg

    else
        mp.osd_message("Start time or end time is not set.", 2)
    end
end

-- Function to handle key bindings
local function handle_key_binding(key)
    if key == "g" then
        start_time = mp.get_property_number("time-pos")
        format_start_time = format_time(start_time)
        mp.osd_message("Start time set to: " .. format_start_time, 2)
    elseif key == "G" then
        start_time = 0
        format_start_time = format_time(start_time)
        mp.osd_message("Start time set to the beginning of the video", 2)
    elseif key == "h" then
        end_time = mp.get_property_number("time-pos")
        format_end_time = format_time(end_time)
        mp.osd_message("End time set to: " .. format_end_time, 2)
    elseif key == "H" then
        end_time = mp.get_property_number("duration")
        format_end_time = format_time(end_time)
        mp.osd_message("End time set to the end of the video", 2)
    elseif key == "alt+r" then
        create_clip("copy")
    elseif key == "ctrl+r" then
        create_clip("mp4")
    end
end

-- Binding the keys
mp.add_forced_key_binding("g",      "set_start_time",           function() handle_key_binding("g")      end)
mp.add_forced_key_binding("G",      "set_start_time_beginning", function() handle_key_binding("G")      end)
mp.add_forced_key_binding("h",      "set_end_time",             function() handle_key_binding("h")      end)
mp.add_forced_key_binding("H",      "set_end_time_end",         function() handle_key_binding("H")      end)
mp.add_forced_key_binding("ctrl+r", "create_mp4_clip",          function() handle_key_binding("ctrl+r") end)
mp.add_forced_key_binding("alt+r",  "create_clip",              function() handle_key_binding("alt+r")  end)
