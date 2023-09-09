-- File is intended as a tool to use in your program files so that you may do things more easily without
-- the need of having to figure it out on your own (or at least referencing something that is already doing it)
-- You should not need to fix anything in here, if you want to add something you may but please do not edit
-- the current functions or code since you run the risk of breaking it. That being said, you may do as you
-- please with this file


-- Global Variable
ret = {}

-- Returns terminal size
function ret.GetTerminalSize()
    return term.getSize()
end

-- Clears screen and resets cursor pos
function ret.Clear()
    term.setCursorPos(1,1)
    term.clear()
end

-- Scroll the terminal in the y-axis
function ret.ScrollTerm(speed)
    local x,y = self:GetTerminalSize()
    for i=1,y do
        term.scroll(speed)
    end
end

-- Same as scroll but in x-axis
function ret.SwipeTerm(speed)

end

-- This function will do some gymnastics for you to change the ENTIRE background color with
-- screen wipe. Currently this LUA provided function will only do it on text background
-- EXCEPTION: If you pass in "False" for wholeScreen (assumed True otherwise) then it will
-- only do new lines instead
function ret.SetTerminalBackgroundColor(color, wholeScreen)

end

-- Will set text color of ALL things on the terminal, some textual gymnastics done for this
-- so entire terminal gets it.
-- EXCEPTION: If wholeScreen is set to FALSE (assumed true otherwise) then it will ONLY do it
-- for new text instead
function ret.SetTextColor(color, wholeScreen)

end

-- Will highlight a section text on mouse click for you to a speciifed color
-- Will also return a boolean if you want to use it
function ret.HighlightTextOnClick(text, highlightColor, some_other_var_here) -- TODO: Maybe can do with Window API?

end

-- This function may be deleted before final implementation
-- Will literally take a line of text on the terminal and then make it bounce
-- along cosine for fun
function ret.TextBounce(text, speed)

end

-- Will make your text clickable and return a boolean on whether or not it was clicked
-- NOTICE: It quite literally will draw a box of pixels from the upper most left to lower bound right
-- No leeway is given or possible
function ret.AddClickable(text)
    return false
end

-- Wrapper on the click event because this class (TerminalMath.lua) needs this information
-- in order to use the other functions. If you do this yourself, it's possible they won't
-- work in the way you'd want them to. ListenForClick() will return a table of information
function ret.ListenForClick()
    return {}
end

function ret.ResetTerminal()
    term.redirect(term.native())
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1,1)
end

return ret