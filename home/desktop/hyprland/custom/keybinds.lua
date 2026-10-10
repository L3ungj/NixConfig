-- hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )

hl.unbind("SUPER + SUPER_L")
hl.unbind("SUPER + SUPER_R")

-- Session
hl.bind("CTRL + SHIFT + ALT + SUPER + Backspace", hl.dsp.exec_cmd("systemctl reboot"),
    { description = "Session: Reboot" })

-- App
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("firefox -p kazu"), { description = "App: Browser (kazu)" })
hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd("firefox -p cambs"), { description = "App: Browser (cambs)" })
