hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )

-- Session
hl.bind("CTRL + SHIFT + ALT + SUPER + Backspace", hl.dsp.exec_cmd("systemctl reboot"),
    { description = "Session: Reboot" })
