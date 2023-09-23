-- Dedicated file for handling GUI graphs on monitors in LUA. Requires MonitorMath.lua to work

local monAPI = require('MonitorMath') -- Our lovely monitor library to handle stuff for us

ret = {}

function ParseDataFile(dataLocation)
    -- Internal function to allow us to parse text files with usable data and then return that as a readable
    -- dataset for these internal graph functions

    formulatedData = {} -- notation: {{col_names}, {{x: y col data1}, {...}, {...}}}
end

function NormalizeValue(value, min, max, maxBarHeight)
    -- Will return a normalized version of a value to fit within contraints
    -- eq: normalizedValue = (value - min) / (max - min)

    return ((value - min) / (max - min)) * maxBarHeight -- Multiply by 50 to give normalized version of up to 50
end

-- Will create a bar graph of information specified (or well, attempt to)
-- This function runs once and creates the initial graph and draws to screen. Call
-- UpdateGraph in a loop if you wish to constantly get an updated graph drawn
-- to screen
function ret.BarGraphCreate(windowName, dataLocation, windowHeight, windowWidth)
    -- Alright let's think about this. We're going to basically use an entire window for a bar graph.
    -- In the future we may be able to let partial graphs on windows but that could get really hacky and honestly makes
    -- more sense as a pop up GUI graph sort of like how Matlab operates with its graphs/plotting functionality.

    -- Initial assumption: will assume a 1xn length bar graph. Will allow resizing later
    win = windowName

    -- hacky setup with initial values before we dynamically parse a file
    columnNames = {"Column A", "Column B", "Column C", "Column D"}
    columnValues = {30, 50, 10, 5}
    windowHeightMax = windowHeight -- this will act as our theoretical max height

    maxValue = math.max(columnValues[1], columnValues[2], columnValues[3], columnValues[4])
    minvalue = math.min(columnValues[1], columnValues[2], columnValues[3], columnValues[4])
    if maxValue > windowHeightMax then
        -- Uh oh, we can't just display all the pixels for 1px = 1pt. Must scale down
        for i=1,#columnValues do
            -- Normalize values to fit within our window
            columnValue[i] = NormalizeValue(columnValue[i], minValue, maxValue, windowHeightMax)
        end
    end

    -- Now that we have our dataset normalized (the above code will honestly probably get moved into the Normalize function entirely)
    -- we may now begin to draw the graph

    -- We will not be labeling at the bottom of the bar graph, but instead color with a key and stuff key on the side of the screen

    maxGraphWidth = windowWidth - (windowWidth / 4) -- Will take 1 quarter of the screen for the Legend

    -- Let's draw the graph from top left down
    win.setTextColor(colors.gray)

    winX,winY = win.getSize()
    
    for i=1,winY do
        win.setCursorPos(1,i)
        for j=1,maxGraphWidth do
            win.write(" ")
        end
    end

    -- By here we have drawn our blank canvas, now to write our bars in

    -- We need to divide our windowWidth by our labels to get the spacing between our bars
    barSpacing = (windowWidth / #columnNames) - 3 -- Magic number: Some small padding between bars so we can start 3 off 0
    win.setCursorPos(3,winY)

    -- now we will change the color going bottom up of this column for the normalized value
    for i=1,#columnNames do
        -- Now begins the primary loop of drawing out the data itself
        -- Draw, then space out cursor pos after
        for j=1,columnValue[i] do
            -- columnValue[i] should just be a flat number
            win.setTextColor(colors.blue) -- will alternate colors later (TODO)
            win.write("X")
            --win.setCursorPos(3,winY-1) -- Why do I even have this here? REMOVE REDUNDANT
        end
        -- In theory, that's a column done
        win.setCursorPos(3 + barSpacing)
    end

    -- now we must draw out legend
    win.setCursorPos(maxGraphWidth, 1)
    for i=1,windowWidth-maxGraphWidth do

        for j=1,windowWidth-maxGraphWidth do
            win.setTextColor(colors.white)
            win.write(" ")
        end
        win.setCursorPos(maxGraphWidth, i + 1)
    end

    -- write legend
    win.setCursorPos(maxGraphWidth + 3, 2) -- +3 is a buffer, y=2 is also buffer
    for i=1,#columnNames do
        win.setTextColor(colors.black) -- There needs to be a legend color system here
        win.write(columnNames[i])
        win.setCursorPos(maxGraphWidth + 3, (i+1) + 3) -- (i+1) + 3 wil always be 2 + 3 or +3 gap between each legend write
    end
end

-- Will update the specified bar graph with the dataset at proper location
-- If dataset is found to not exist, will instead return false as to not
-- break the static graph
function ret.BarGraphUpdate(graphName, dataLocation)

end