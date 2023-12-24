-- Specific flavor of monitor use for quarry stuff 

local monAPI = require('MonitorMath')

ret = {}

-- For ease of this func, "size" is x * y. Which means quarry must be a perfect square
function ret.DrawQuarry(size)
    -- Will now draw nxn pixels on the screen of the monitor (attempt will be centered)
    n=math.sqrt(size) -- Gets square of value

    monX, monY = ret.GetMonitorSize()

    -- Size too big!
    if n > monX or n > monY then
        return false
    end

    local centerX, centerY = ret.GetMonitorCenter()
    local tlX, tlY = (centerX - n), (centerY - n) -- "trX/trY" = top left x, top left y
    for i=1,n do -- height
        ret.SetMonitorBackgroundColor(colors.lightBlue, false) -- Uniquely, we just want to change pixel color here. 
        monitor.setCursorPos(tlX, tlY)
        for j=1,n do -- width
            monitor.write(' ')
        end
        tlY = tlY + 1
    end

end

-- Turns Quarry object into a live view of what the turtle is reporting it is doing
-- turtleDataObject should be the location as to where the turtle is live-writing
-- all of its information (a formatted file is provided as example to what this function
-- expects to pull)
-- EXPECTED ARGUMENTS LIST: location to where turtle data object is, accepts multiple in-case
-- multiple turtles are writing
function ret.ConnectQuarryToLAN(...)

end

-- Rednet implementation of ConnectQuarryToLAN except all data is gathered over the network
-- instead (easier implementation, but the other one is cool too! (also more secure if you don't
-- want to just broadcast where your turtles are mining))
function ret.ConnectQuarryLiveFeed()

end