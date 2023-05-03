VERSION = "1.1.0"

-- Imports
local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local util = import("micro/util")

function init()
	-- Plugin initialization
	config.RegisterCommonOption("capitalizer", "enable", true)

	-- KeyBindings initialization
	config.TryBindKey("Alt-o", "lua:capitalizer.low", false)
	config.TryBindKey("Alt-p", "lua:capitalizer.up", false)
end
 
function low(bp)
	-- Check if the plugin is enabled 
	if bp.Buf.Settings["capitalizer.enable"] == false then
		return true
	end

	-- Check for an active cursor
	if not bp.Buf:GetActiveCursor() then
		return true
	end

	local c = bp.Cursor

	-- Check for an existing selection
	if c:HasSelection() == false then
		return true
	end

	local selection = c:GetSelection()

	-- Call main function
	replaceText(bp, c, false)	
end

function up(bp)
	-- Check if the plugin is enabled
	if bp.Buf.Settings["capitalizer.enable"] == false then
		return true
	end

	-- Check for an active cursor
	if not bp.Buf:GetActiveCursor() then
		return true
	end

	local c = bp.Cursor

	-- Check for an existing selection
	if c:HasSelection() == false then
		return true
	end

	local selection = c:GetSelection()

	-- Call main function
	replaceText(bp, c, true)	
end

-- Main function
function replaceText(bp, c, toUpper)
	local a, b = nil, nil

	-- Cursor position initialization
	if c.CurSelection[1]:GreaterThan(-c.CurSelection[2]) then
        a, b = c.CurSelection[2], c.CurSelection[1] -- Fix for backward selction
    else
        a, b = c.CurSelection[1], c.CurSelection[2]
    end

    a = buffer.Loc(a.X, a.Y)
    b = buffer.Loc(b.X, b.Y)

    local selection = c:GetSelection()
	selection = util.String(selection)

	local modifiedSelection

	if toUpper == true then
		-- Transform text to uppercase
		modifiedSelection = string.upper(selection)
	else
		-- Transform text to lowercase
		modifiedSelection = string.lower(selection)
	end

	-- Replacing selection with the modified one
	bp.Buf:Replace(a, b, modifiedSelection)

	-- Display info message
	micro.InfoBar():Message("Selection modified.")

	-- Reset cursor position
	c:ResetSelection()
end
