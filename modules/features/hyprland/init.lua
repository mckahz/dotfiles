-- See https://wiki.hypr.land/Configuring/Start/
nix = require("nix")
require("~/.config/hypr/monitors.lua")

-- settings.animation
hl.animation({
    enabled = true,
    leaf = "workspaces",
    speed = 10,
    spring = "default",
    style = "slidevert"
})

-- settings.config
hl.config({
    decoration = {
        rounding = 10,
        shadow = {
            color = "rgba(1f243099)"
        }
    },
    general = {
        border_size = 2,
        ["col.active_border"] = "rgb(73d0ff)",
        ["col.inactive_border"] = "rgb(4a5059)",
        gaps_in = 8,
        gaps_out = 16,
        layout = "master"
    },
    group = {
        ["col.border_active"] = "rgb(73d0ff)",
        ["col.border_inactive"] = "rgb(4a5059)",
        ["col.border_locked_active"] = "rgb(95e6cb)",
        groupbar = {
            ["col.active"] = "rgb(73d0ff)",
            ["col.inactive"] = "rgb(4a5059)",
            text_color = "rgb(cccac2)"
        }
    },
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        touchpad = {
            natural_scroll = true
        }
    },
    master = {
        drop_at_cursor = true,
        mfact = 0.67,
        new_on_active = "after",
        new_status = "master",
        orientation = "left",
        smart_resizing = true,
        special_scale_factor = 0.5
    },
    misc = {
        background_color = "rgb(1f2430)",
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        force_default_wallpaper = 0
    }
})

-- settings.gesture
hl.gesture({
    action = "workspace",
    direction = "vertical",
    fingers = 3
})

-- settings.on
hl.on("hyprland.start", (function()
    hl.exec_cmd(nix.noctalia .. ' -d')
end
))

hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0, rounding = 0 })

-- startup
hl.on("hyprland.start", function()
    hl.exec_cmd(
    "/nix/store/js1l0300gj2sypwwbm67sma9c7al0p6d-dbus-1.16.2/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user stop hyprland-session.target && systemctl --user start hyprland-session.target")
end)

-- shutdown
hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)
