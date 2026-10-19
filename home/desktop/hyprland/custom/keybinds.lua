-- hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )

hl.unbind("SUPER + SUPER_L")
hl.unbind("SUPER + SUPER_R")
hl.bind("SUPER + R", hl.dsp.global("quickshell:overviewWorkspacesToggle"), { description = "Shell: Run program" })

-- Session
hl.bind("CTRL + SHIFT + ALT + SUPER + Backspace", hl.dsp.exec_cmd("systemctl reboot"), { description = "Session: Reboot" })

-- App
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd("firefox -p kazu"), { description = "App: Browser (kazu)" })
hl.bind("SUPER + ALT + W", hl.dsp.exec_cmd("firefox -p cambs"), { description = "App: Browser (cambs)" })

hl.unbind("SUPER + P") -- Pin window
hl.bind("SUPER + P", hl.dsp.exec_cmd("waydroid show-full-ui"), { description = "App: Waydroid" })

hl.unbind("SUPER + O") -- Left sidebar toggle
ods_cmd = "notify-send 'OneDrive' 'Sync started'; onedrive -s && notify-send 'OneDrive' 'Sync finished successfully' || notify-send -u critical 'OneDrive' 'Sync failed'"
hl.bind("SUPER + O", hl.dsp.exec_cmd(ods_cmd), { description = "App: OneDrive sync" })