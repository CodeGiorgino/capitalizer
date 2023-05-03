VERSION = "1.0.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local util = import("micro/util")

function init()
	config.RegisterCommonOption("capitalizer", "enable", true)
	config.TryBindKey("Alt-o", "lua:capitalizer.low", false)
	config.TryBindKey("Alt-p", "lua:capitalizer.up", false)
end
 
function low(bp)
	if bp.Buf.Settings["capitalizer.enable"] == false then
		return true
	end

	if not bp.Buf:GetActiveCursor() then
		return true
	end

	local c = bp.Cursor
	
	if c:HasSelection() == false then
		return true
	end

	local selection = c:GetSelection()
	replaceText(bp, c, selection, false)	
end

function up(bp)
	if bp.Buf.Settings["capitalizer.enable"] == false then
		return true
	end

	if not bp.Buf:GetActiveCursor() then
		return true
	end

	local c = bp.Cursor
	
	if c:HasSelection() == false then
		return true
	end

	local selection = c:GetSelection()
	replaceText(bp, c, selection, true)	
end

function replaceText(bp, c, selection, toUpper)
	local a, b = nil, nil

	if c.CurSelection[1]:GreaterThan(-c.CurSelection[2]) then
        a, b = c.CurSelection[2], c.CurSelection[1]
    else
        a, b = c.CurSelection[1], c.CurSelection[2]
    end

    a = buffer.Loc(a.X, a.Y)
    b = buffer.Loc(b.X, b.Y)
    selection = c:GetSelection()

	selection = util.String(selection)
	local modifiedSelection

	if toUpper == true then
		modifiedSelection = string.upper(selection)
	else
		modifiedSelection = string.lower(selection)
	end

	bp.Buf:Replace(a, b, modifiedSelection)
	micro.InfoBar():Message("Selection modified.")
	
	c:ResetSelection()
end
