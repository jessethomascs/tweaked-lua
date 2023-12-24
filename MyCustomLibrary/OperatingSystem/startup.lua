-- Startup script for operating system
-- image printout must be done first

local mm = require('MonitorMath.lua')
local rnet = require("rnet_system")
local files = require("FileHandler.lua")

local menu_dir = "menu/main_menu.lua"
local img_dir = "img/startup_screen.nfp"
local backgroundImage = paintutils.loadImage(img_dir)

function Clear()
    term.clear()
    term.setCursorPos(1, 1)
end

-- Startup essentially wipes the screen and just loads the background image
function Startup()
    Clear()
    -- Create necessary directories first
    files.CreateDirectory("menu", "imgs", "backups")


    -- Load background image for startup (flavour)
    paintutils.drawImage(backgroundImage, 0, 0)
    term.setCursorPos(1,1)
end

-- Initialize is our computer startup and loading libraries necessary before reaching the main menu screen
function Initialize()
    Startup()
    print()
    term.setTextColor(colors.blue)
    textutils.slowPrint("BOOTING KIBBEL SYSTEMS VERSION 1.0", 0.7)
    textutils.slowPrint("Loading rednet libraries...", 0.5)
    rnet.InitializeInternet()
    term.setTextColor(colors.yellow)
    print("\n\n\nBOOTUP FINISHED. SWITCHING TO MAIN MENU CONTEXT")

    shell.run("menu/main_menu.lua")
end