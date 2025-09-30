mp.register_event("file-loaded", function()
    local hasvid = mp.get_property_osd("video") ~= "no"
    mp.commandv("script-message", "osc-visibility", (hasvid and "auto" or "always"), "no-osd")
end)