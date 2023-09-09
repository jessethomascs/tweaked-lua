-- A more fleshed out debug file for helpful debugging of files in a file

-- Example use case:
-- function TestFunc(arg1, arg2)
--     debug("SomeFile.lua:TestFunc:77, (arg1 + arg2), nil, 0") -- would not write to console yet until 1
-- end
-- debug(nil, nil, nil, 1) -- tells debug to print

ret = {}
local strBuilder
local fileLocation = ""

-- Our bread and butter function with optional arguments
-- Will be using a table to unpack and read keys from that
function ret.debug(...)
    -- so expecting several args, example:
    -- enable debugging should ONLY be set to true in your FINAL debug message!
    -- debug.lua:155, "value is 3", "debug.txt"
    local where_descriptor, value_descriptor, debugFile, enableDebugging = table.unpack(args)

    where_descriptor = where_descriptor or "DEBUG_PUBLICIZE_CALL"
    value_descriptor = value_descriptor or "DEBUG_PUBLICIZE_CALL"
    fileLocation = debugFile or fs.getDir() .. "debug.log" -- Spits out a debug log in current dir
    enableDebugging = enableDebugging or 0

    local str = where_descriptor .. ": " .. value_descriptor
    stringBuilder(str)

    if enableDebugging then
        publish()
    end
end

function ret.stringBuilder(textIncrement)
    strBuilder = strBuilder or "" -- if not initialized yet

    local append = tostring(textIncrement) .. "\n" -- on separate line to make it obvious what we are doing

    local buffer = strBuilder .. append -- because lua strings are immutable
    strBuilder = buffer
end

function ret.publish()
    -- Go ahead to nuke old debug text file and establish new file
    if fs.exists(fileLocation) then
        fs.delete(fileLocation) -- adios
    end

    local file = fs.open(fileLocation, "w")
    file.write(strBuilder)
    file.close()
end

return ret