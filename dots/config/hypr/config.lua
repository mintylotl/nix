-- Hyprland 0.55+ Lua configuration, ported from hyprland-conf.nix.
-- Dispatcher bindings use hl.dsp.* instead of shelling out to hyprctl.

------------------------------------------------------------
-- Variables
------------------------------------------------------------
local HOME = os.getenv("HOME")
local SCRIPTS = HOME .. "/.scripts"
local EMACS_DIR = HOME .. "/.doom.d"
local mainMod = "SUPER"
local shortcut_dir = HOME .. "/.programs/musicbee/shortcuts"
local player = "tauon"

local accent = {
    pink = "rgb(f5c2e7)",
    mauve = "rgb(cba6f7)",
    inactive = "rgb(45475a)",
}
------------------------------------------------------------
-- Monitor / workspace
------------------------------------------------------------
hl.monitor({
    output = "",
    mode = "1920x1080@100",
    position = "0x0",
    scale = 1,
})

hl.workspace_rule({
    workspace = "1",
    monitor = "HDMI-A-1",
    default = true,
})

------------------------------------------------------------
-- Environment
------------------------------------------------------------
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "BreezeX-RosePineDawn-Linux")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "rosepine-cursor")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

------------------------------------------------------------
-- Input / compositor settings
------------------------------------------------------------
hl.config({
    cursor = {
        no_hardware_cursors = 2,
    },
    input = {
        kb_layout = "us",
        touchpad = {
            natural_scroll = false,
        },
        sensitivity = 0.5,
        follow_mouse = 1,
        numlock_by_default = true,
    },
    general = {
      gaps_in = 3,
      gaps_out = 5,
      border_size = 2,

      col = {
        active_border = {
          colors = { accent.pink, accent.mauve },
          angle = 45,
        },
        inactive_border = accent.inactive,
      },

      layout = "master",
      allow_tearing = true,
    },
    decoration = {
        rounding = 3,
        blur = {
            enabled = true,
            size = 2,
            passes = 1,
        },
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        orientation = "top",
        new_on_top = false,
    },
    misc = {
        enable_anr_dialog = false,
    },
})

------------------------------------------------------------
-- Animations
------------------------------------------------------------
hl.curve("myBezier", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1, 1.05 },
    },
})

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

------------------------------------------------------------
-- Startup
------------------------------------------------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 10s && systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd(HOME .. "/.config/hypr/sink.sh")
    hl.exec_cmd(HOME .. "/.config/hypr/shuffle_bg.sh")
    hl.exec_cmd("sudo -E " .. SCRIPTS .. "/system/leds.sh &")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd([[dconf write /org/gnome/desktop/interface/cursor-theme "'BreezeX-RosePineDawn-Linux'"]])
    hl.exec_cmd([[dconf write /org/gnome/desktop/interface/gtk-theme "'Breeze-Dark'"]])
    hl.exec_cmd("GDK_BACKEND=wayland GTK_ICON_THEME=Papirus-Dark thunar --daemon")
end)

------------------------------------------------------------
-- Window rules
-- Use regex escapes in Lua strings: long-bracket strings preserve '\.'
------------------------------------------------------------
hl.window_rule({
    match = { class = [[^org\.qbittorrent\.qBittorrent$]] },
    workspace = "8 silent",
})

hl.window_rule({
    match = { class = "emacs" },
    float = true,
    size = "1400 850",
})

hl.window_rule({
    match = { class = "Alacritty" },
    float = true,
    size = "1000 300",
})

hl.window_rule({
    match = { class = [[org\.telegram\.desktop]] },
    float = true,
    size = "1120 750",
    center = true,
})

hl.window_rule({
    match = { class = "qimgv" },
    float = true,
    size = "950 950",
    center = true,
})

hl.window_rule({
    match = { class = [[org\.pulseaudio\.pavucontrol]] },
    float = true,
    size = "1220 700",
    center = true,
})

hl.window_rule({
    match = { class = "thunar", title = [[Rename.+]] },
    float = true,
    size = "650 150",
    center = true,
})

hl.window_rule({
    match = { class = "thunar", title = "File Operation Progress" },
    float = true,
    size = "550 180",
    move = "715 800",
})

hl.window_rule({
    match = { class = "tauonmb" },
    fullscreen = true,
})

hl.window_rule({
    match = { class = "mpv" },
    float = true,
    size = "900 700",
    center = true,
})

hl.window_rule({
    match = { class = [[org\.kde\.ark]] },
    float = true,
    size = "1000 700",
})

hl.window_rule({
    match = { class = [[org\.speedcrunch.*]] },
    float = true,
    size = "1000 700",
})

------------------------------------------------------------
-- Keybind helpers
------------------------------------------------------------
local function exec(command)
    return hl.dsp.exec_cmd(command)
end

local function focus_workspace(id)
    return hl.dsp.focus({ workspace = id })
end

local function move_to_workspace(id, follow)
    return hl.dsp.window.move({
        workspace = id,
        follow = follow,
    })
end

------------------------------------------------------------
-- Screenshots
------------------------------------------------------------
hl.bind("Print", exec([[grim -l 4 -g "0,0 1920x1080"]]))
hl.bind(mainMod .. " + Print", exec([[grim -l 8 -g "$(slurp)"]]))

------------------------------------------------------------
-- Editors / clipboard
------------------------------------------------------------
hl.bind(mainMod .. " + O", exec("alacritty -e nvim ./"))
hl.bind(mainMod .. " + I", exec("alacritty -e nvim ./newfilevim"))
hl.bind(mainMod .. " + A", exec("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + Z", exec('emacsclient -c -s "' .. EMACS_DIR .. '/emacflurry/mcflurry"'))

------------------------------------------------------------
-- Hyprland utilities
------------------------------------------------------------
hl.bind(mainMod .. " + N", hl.dsp.layout("orientationtop"))
-- Preserve the old 'hyprctl kill' behavior (interactive window kill mode).
hl.bind(mainMod .. " + K", exec("hyprctl kill"))
hl.bind(mainMod .. " + Q", hl.dsp.window.set_prop({ prop = "pin", value = "toggle" }))
hl.bind(mainMod .. " + W", hl.dsp.window.float())
hl.bind(mainMod .. " + B", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + D", hl.dsp.window.center())
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.layout("swapwithmaster"))
hl.bind(mainMod .. " + L", exec("pidof hyprlock && hyprlock || hyprlock"))

------------------------------------------------------------
-- Miscellaneous
------------------------------------------------------------
hl.bind(mainMod .. " + M", exec([[bash -c 'umount ~/.orgnotes; loginctl terminate-session ""']]))
hl.bind(mainMod .. " + CTRL + Down", exec("archwiki-offline"))
hl.bind(mainMod .. " + T", exec("cliphist wipe"))
hl.bind(mainMod .. " + SPACE", exec("rofi -show drun -width 65 -lines 15"))

------------------------------------------------------------
-- Audio
------------------------------------------------------------
hl.bind("F7", exec("wpctl set-volume 33 5%-"))
hl.bind("F8", exec("wpctl set-volume 33 5%+"))

------------------------------------------------------------
-- Programs
------------------------------------------------------------
hl.bind(mainMod .. " + P", exec(shortcut_dir .. "/../launcher.sh"))
hl.bind(mainMod .. " + G", exec("firefox-devedition"))
hl.bind(mainMod .. " + Return", exec("alacritty"))
hl.bind(mainMod .. " + S", exec("speedcrunch"))
hl.bind(mainMod .. " + E", exec([[GDK_BACKEND="wayland" GTK_ICON_THEME="Papirus-Dark" thunar]]))

------------------------------------------------------------
-- Tauon media controls
------------------------------------------------------------
hl.bind("End", exec("playerctl -p " .. player .. " play-pause"))
hl.bind("Pause", exec('playerctl -p ' .. player .. ' shuffle "On"'))
hl.bind("Home", exec("playerctl -p " .. player .. " next"))
hl.bind("Next", exec('playerctl -p ' .. player .. ' shuffle "Off"'))
hl.bind("Scroll_Lock", exec("playerctl -p " .. player .. " previous"))

------------------------------------------------------------
-- Workspace / window focus
------------------------------------------------------------
hl.bind(mainMod .. " + R", move_to_workspace(7, false))
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.layout("orientationleft"))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.layout("orientationright"))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + X", hl.dsp.window.bring_to_top())

------------------------------------------------------------
-- Workspace switching
------------------------------------------------------------
local workspaceKeys = {
    { key = "1", id = 1 },
    { key = "2", id = 2 },
    { key = "3", id = 3 },
    { key = "4", id = 4 },
    { key = "5", id = 5 },
    { key = "6", id = 6 },
    { key = "7", id = 7 },
    { key = "8", id = 8 },
    { key = "9", id = 9 },
    { key = "0", id = 10 },
}

for _, ws in ipairs(workspaceKeys) do
    hl.bind(mainMod .. " + " .. ws.key, focus_workspace(ws.id))
end

------------------------------------------------------------
-- Move windows to workspace using physical number-row keycodes
------------------------------------------------------------
local physicalWorkspaceKeys = {
    { code = 87, id = 1 },
    { code = 88, id = 2 },
    { code = 89, id = 3 },
    { code = 83, id = 4 },
    { code = 84, id = 5 },
    { code = 85, id = 6 },
    { code = 79, id = 7 },
    { code = 80, id = 8 },
    { code = 81, id = 9 },
    { code = 90, id = 10 },
}

for _, ws in ipairs(physicalWorkspaceKeys) do
    hl.bind(mainMod .. " + code:" .. ws.code, move_to_workspace(ws.id, false))
    hl.bind(mainMod .. " + SHIFT + code:" .. ws.code, move_to_workspace(ws.id, true))
end

hl.bind(mainMod .. " + mouse_down", focus_workspace("e+1"))
hl.bind(mainMod .. " + mouse_up", focus_workspace("e-1"))

------------------------------------------------------------
-- Mouse window control
------------------------------------------------------------
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
