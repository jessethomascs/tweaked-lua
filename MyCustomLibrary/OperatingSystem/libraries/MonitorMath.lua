-- Global Variable
ret = {} -- return value to return this file as an object
monitor = nil -- Monitor object (can be static, since only one may exist)
windowArray = {} -- Stores a list of all the window objects in our "scene" ( the entire monitor )

-- Automatically finds the locally attached monitor
function ret.AttachMonitor()
    monitor = peripheral.find("monitor")
end

-- In the case you don't want to use AttachMonitor() to find the monitor automatically
-- you may set it yourself
function ret.SetMonitorSide(monitorObject)
    monitor = monitorObject
end

-- Clears the monitor and resets cursor pos
function ret.Clear()
    monitor.setCursorPos(1,1)
    monitor.clear()
end
-- Returns: x,y
-- monitor size
function ret.GetMonitorSize()
    return monitor.getSize()
end

-- Returns: x,y
-- center of monitor
function ret.GetMonitorCenter()
    x,y = ret.GetMonitorSize()

    -- A bit crude as it will only return the center "pixel" (but for example, a double pixel or 2x2 pixel format is possible to be "true" center)
    -- so this is never going to be true center. Might fix in future to return a table of points that are composed of in the center for more fluidity
    return x / 2, y / 2
end

-- Scroll the monitor in the y-axis
function ret.ScrollMonitor(speed)
    local x,y = GetMonitorSize()
    for i=1,y do
        monitor.scroll(speed)
    end
end

-- Like ScrollMonitor() however will swipe left to right like a book page instead of down like a webpage.
-- NOTICE: Data from using the SwipeMonitor function here is lost THE INSTANT it goes off the screen!
-- Plans for a history buffer are planned to be added in the future *potentially. Use it at your own risk!
function ret.SwipeMonitor(speed)
    subWindowObject = windowArray[windowName] -- Get us our entire window object
    subWindow = subWindowObject[windowName] -- Gets us our actual window object

    local windowHeight,windowWidth = subWindow.getSize() -- windowHeight unused for now

    local x,y = GetMonitorSize()
    local bufferedLines = {}

    -- algorithm: each row must iteratively move back by 1 on the x axis

    -- Get buffered contents of ALL lines into their own subarrays in a larger table
    for i=1,y do
        bufferedLines[i],str,str2 = subWindow.getLine(i) -- Line 1 with line 1 contents, etc.
    end

    -- Now we will remove the first letter from each line and shift the entire line back one.
    for i=1,windowWidth do
        -- algorithm:   Each char on the line (each x) can be looked at as a block, so each block has to become what the
        --              NEXT block on the line is, but stopping short of overflow (off screen). Edge case: last character
        --              must not try to write a character that doesn't exist, so loop stops just prior to that.

        for j=1,#bufferedLines do
            newLine = bufferedLines[j]
            changedLine = newLine:sub(2)

            bufferedLines[j] = changedLine
        end

        -- Redraw phase
        subWindow.clear()
        for j=1,#bufferedLines do
            subWindow.setCursorPos(1,j)
            subWindow.write(bufferedLines[j])
        end
        sleep(speed)
    end
end

-- Writes text to a window, appendBool is assumed FALSE so it will OVERWRITE what is on the screen
-- set to TRUE when calling if you only wish to append text to the monitor
function ret.WriteText(text, windowName, appendBool)
    subWindowObject = windowArray[windowName] -- Get us our entire window object
    subWindow = subWindowObject[windowName] -- Gets us our actual window object

    appendBool = appendBool or false

    if not appendBool then
        -- If false (unset), clear all lines on monitor and write text
        subWindow.clear()
        subWindow.write(text)
    else
        -- Append onto where cursor position is
        subWindow.write(text)
    end
end

-- This function will do some gymnastics for you to change the ENTIRE background color with
-- screen wipe. Currently this LUA provided function will only do it on text background
-- EXCEPTION: If you pass in "False" for wholeScreen (assumed True otherwise) then it will
-- only do new lines instead
function ret.SetMonitorBackgroundColor(colorChoice, windowName, updateWholeWindow)
    subWindowObject = windowArray[windowName] -- Get us our entire window object
    subWindow = subWindowObject[windowName] -- Gets us our actual window object

    subWindow.setBackgroundColor(colorChoice)

    if updateWholeWindow then
        subWindow.redraw()
    end
end

-- Will set text color of a window object
-- updateWholeWindow is automatically assumed FALSE. If TRUE, all text will be refreshed to be that color
function ret.SetTextColor(colorChoice, windowName, updateWholeWindow)
    subWindowObject = windowArray[windowName] -- Get us our entire window object
    subWindow = subWindowObject[windowName] -- Gets us our actual window object

    subWindow.setTextColor(colorChoice)

    if updateWholeWindow then
        subWindow.redraw()
    end
end

-- Makes a new window object in the scene. No arguments are required, but here is a list of valid ones:
-- Accepted arguments (in this order):
-- window_name, topLeftX, topLeftY, boolean (make clickable?), boolean (put on top?)
-- defaults we assume if you don't fill in:
-- windowArrayIndex, monitor center x, monitor center y, true, true
function ret.AddWindowObject(...)
    windowName = arg[1] or ("defaultWindow" .. #windowArray)
    topLeftX, topLeftY = (arg[2] or GetMonitorCenter())
    makeClickable = true or arg[3]
    makeForeground = true or arg[4]
    -- windowSize = arg[5] -- Will implement in future

    -- Steps to create window object:
    window.create(term.current(), 1, 1, 20, 5)
    local newWindow = window.create(term.current(), topLeftX, topLeftY, 15, 15) -- 15x15 is default size. Use resize function to change
    newWindow.setBackgroundColor()
    newWindow.SetTextColor()
    newWindow.clear()

    windowObject = {}
    windowObject[windowName] = newWindow -- Store subtable in this overall object that has the general window object
    windowObject[isClickable] = makeClickable -- Tells us if this object should be clickable or not
    windowObject[isForeground] = makeForeground -- Tells us if this object should be in the foreground or not

    -- Idea: windowArray = { "windowName1": { "windowObject": {window object here}, "isClickable": bool, ... }, "windowName2": {}, ...}
    windowArray[windowName] = windowObject

    return windowName   -- Return the name of the window object we just created. This will be helpful for other functions here when they want
                        -- to update the window they just made. Users must keep track of the windows they create
end