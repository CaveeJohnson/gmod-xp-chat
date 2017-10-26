local color_red = Color(225, 0, 0, 255)
local color_greentext = Color(0, 240, 0, 255)
local color_green = Color(0, 200, 0, 255)

chatexp.Devs = {
	--Owners
	["STEAM_0:1:74836666"] = "Trixter",
	["STEAM_0:1:62445445"] = "Q2F2",
	["STEAM_0:0:133411986"] = "CakeShaked", --Trixter alt acc

	--Devs
	["STEAM_0:0:80669850"] = "user4992",
	["STEAM_0:0:42138604"] = "Liquid",
	["STEAM_0:0:62588856"] = "Ghosty",
}

local tagParse
do
	local gray = Color(128,128,128)
	local red, blu, green = Color(225,0,0), Color(80, 200, 255), Color(133,208,142)
	local orange = Color(255,160,30)

	local showranks = CreateConVar("bw_chat_showranks", "1", { FCVAR_ARCHIVE }, "Should we show player ranks when they talk? ex. \"[Owners] Q2F2: imgay\"")

	local function NiceFormat(str)
		local nice = str:lower()
		nice = str:gsub("^%l", string.upper)

		return nice
	end

	local ranks_tags = {
		["some_rank"] = {
			color = red,
			title = "Some Rank",
		},
		["some_other_rank"] = {
			color = blu,
			title = "Some Other Rank",
		},
	}

	-- ported from chitchat2
	function tagParse(tbl, ply)
		if IsValid(ply) and ply:IsPlayer() then
			local ugroup = ply:GetUserGroup()

			if chatexp.Devs[ply:SteamID()] then
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "["
				tbl[#tbl + 1] = orange
				tbl[#tbl + 1] = "GM-Dev"
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "] "
			elseif ranks_tags[ugroup] and showranks:GetBool() then
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "["
				tbl[#tbl + 1] = ranks_tags[ugroup].color
				tbl[#tbl + 1] = ranks_tags[ugroup].title
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "] "
			elseif (ply:IsAdmin() or (ply.IsMod and ply:IsMod())) and showranks:GetBool() then
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "["
				tbl[#tbl + 1] = blu
				tbl[#tbl + 1] = ply.GetUserGroupName and ply:GetUserGroupName() or NiceFormat(ugroup)
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "] "
			end

			if table.HasValue(BaseWars.Config.VIPRanks, ugroup) then
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "["
				tbl[#tbl + 1] = green
				tbl[#tbl + 1] = "$"
				tbl[#tbl + 1] = gray
				tbl[#tbl + 1] = "] "
			end
		end
	end
end

chatexp.Modes[CHATMODE_DEFAULT].Handle = function(tbl, ply, msg, dead, mode_data)
	if dead then
		tbl[#tbl + 1] = color_red
		tbl[#tbl + 1] = "*DEAD* "
	end

	tagParse(tbl, ply)

	tbl[#tbl + 1] = ply -- ChatHUD parses this automaticly
	tbl[#tbl + 1] = color_white
	tbl[#tbl + 1] = ": "
	tbl[#tbl + 1] = color_white

	if msg:StartWith(">") and #msg > 1 then
		tbl[#tbl + 1] = color_greentext
	end

	tbl[#tbl + 1] = msg
end

chatexp.Modes[CHATMODE_TEAM].Handle = function(tbl, ply, msg, dead, mode_data)
	if dead then
		tbl[#tbl + 1] = color_red
		tbl[#tbl + 1] = "*DEAD* "
	end

	tbl[#tbl + 1] = color_green
	tbl[#tbl + 1] = "(TEAM) "

	tagParse(tbl, ply)

	tbl[#tbl + 1] = ply -- ChatHUD parses this automaticly
	tbl[#tbl + 1] = color_white
	tbl[#tbl + 1] = ": "
	tbl[#tbl + 1] = color_white

	if msg:StartWith(">") and #msg > 1 then
		tbl[#tbl + 1] = color_greentext
	end

	tbl[#tbl + 1] = msg
end

if chathud then
	chathud.oldShadow = true
end
