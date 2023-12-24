-- File API to handle file handling for you in a really neat matter.

ret = {}

-- Creates a file under a specified directory. If no directory specified,
-- will create file in current directory
function ret.CreateFile(name, optional_directory)

end

-- Attempts to create a list of directories
-- Function will do its best to create every directory possible and move same-named prior-existing directories
-- to a backup folder. This is obviously a volatile function with the intention of root running it in this scenario
function ret.CreateDirectory(...)

end

-- First argument is top directory, second is nested in first, third is nested in second, etc...
-- arg[1] is a boolean check to see if you wish to start from root or current directory. Function
-- will ALWAYS assume you wish to start from root unless boolean is turned FALSE (0)
function ret.CreateNestedDirectories(...)

end

-- Easy function call for files not with any
-- certain data type and will simply return
-- a table of a line-by-line. This will be a
-- 2 dimensional array with size# numOfLinesInFile
function ret.ReadSimpleFile(fileLocation)

end

-- Will read a file that's been serialized
-- and return a table.
function ret.ReadComplexFile(fileLocation)

end

-- Finds a file and appends data to end of it
-- Returns false if no file found
function ret.AppendToFile(fileLocation, data)

end

-- Super function: Parses entire complex file (table) and finds a key you are looking for
-- and will do the heavy lifting and modify any key's value you are looking for. The only
-- restriction is that you must provide an entirely new value/subtable for that key. If you
-- wish to remove the key, please specify a fourth argument "true" to delete the key from the
-- file entry. This 4th argument is optional and always assumed false unless otherwise specified
function ret.ModifyComplexFile(fileLocation, key, newValuesForKey, delete_key_and_value)

end

-- Essentially the same thing as calling Read...File() and modifying its data and calling CreateFile()
-- for a brand new file but instead lets you save to a file since CreateFile() will return false if file
-- already exists. 
-- CAUTIONARY NOTICE: This function will WIPE the entire file out and essentially overwrite it with your
-- new data
function ret.SaveFile(fileLocation, data)

end

-- Takes in a number of files to delete. If arg1 is wildcard '*' parameter then it will be
-- assumed all files inside the current directory wish to go. There is no undoing this action! 
function ret.DeleteFiles(...)

end

-- This function will look for ALL files with a specific name (wildcard accepted) for current directory
-- and under. A breadth first-search is applied in this algorithm.
-- NOTE: If disk peripheral is attached; this will also be searched all under the same file system

-- returns: 1d table of all possible locations found for name found or nil if none found
function ret.Search(name)

end

return ret