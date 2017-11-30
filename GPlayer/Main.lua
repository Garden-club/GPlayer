--PJDJ 
--Lots of love, from Grandmaster Pa
--FUN COLOURS

--FUCK OFF GOUDY

colours = 
{
	"00ff00",
	"ac5ce3",
	"01f3ea",
}
sessionColour = colours[math.random(1,3)];

DJPlayList = { }

function pjdj_register(packName, packContents)



for i = 1, table.getn(packContents) do
--soundlist(packContents[i])
table.insert(soundlist, packContents[i])
end

	DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r \124cff"..sessionColour.."\124h"..packName.." pack loaded.")


end

function pjdj_ids()



end


local LogonFrame = CreateFrame("FRAME")
LogonFrame:RegisterEvent("PLAYER_LOGIN")
LogonFrame:SetScript("OnEvent", function(...)

end)

local ChannelFrame = CreateFrame("FRAME")
ChannelFrame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")
ChannelFrame:SetScript("OnEvent", function(self,event,message, sender, language, channel)


--print(channel, DJChan) --FINDING OUT WHY CAPITALS ARE AN ISSUE

if message:match("YOU_CHANGED") then
	SendChatMessage("joined", "CHANNEL", nil, GetChannelName(DJChan))
end

end)

local frame=CreateFrame("Frame");
frame:RegisterEvent("CHAT_MSG_CHANNEL");
frame:SetScript("OnEvent",function(self,event,message, sender, language, channel)



if channel.match(channel, DJChan) then

sender = sender:gsub("-RPH", "")

	if message:match("play") then
	
		
		soundFile = message:match("play (.*)"):gsub("[/\\]+","/"); --Thanks Deramyr
		soundFile = soundFile:gsub("\\","/"):gsub("//","/");
		PlayMusic(soundFile);
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r [\124cff"..sessionColour.."\124h"..sender.."\124r of \124cff"..sessionColour.."\124h"..DJChan.."\124r] played: "..soundFile:gsub("interface/addons/", ""))

	elseif message:match("stop") then
		
		StopMusic(); 
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r [\124cff"..sessionColour.."\124h"..sender.."\124r of \124cff"..sessionColour.."\124h"..DJChan.."\124r] stopped the sound.")
	
	elseif message:match("joined") then
		
		PlaySoundFile("sound\\interface\\ui_cutscene_stinger.ogg");
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r [\124cff"..sessionColour.."\124h"..sender.."\124r of \124cff"..sessionColour.."\124h"..DJChan.."\124r] has joined the channel.")
	
	elseif message:match("leaving") then
		
		PlaySoundFile("sound\\interface\\igquestfailed.ogg")
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r [\124cff"..sessionColour.."\124h"..sender.."\124r of \124cff"..sessionColour.."\124h"..DJChan.."\124r] has left the channel.")
	

	end
end

end);

SLASH_GPlayer1, SLASH_GPlayer2 = '/gp', '/gplayer';
local function handler(message, editBox)

	if message:match("join") then
		
		if DJChan ~= nil then --leave channel before joining another.
			LeaveChannelByName(DJChan)
		end
		
		DJChan = message:match("join (.*)")
		JoinChannelByName(DJChan)
		c = "Sound_EnableMusic"; local s = GetCVar(c) or "0"; if s == "0" then SetCVar(c, "1") end
		c = "Sound_EnableSFX"; local s = GetCVar(c) or "0"; if s == "0" then SetCVar(c, "1") end

		
	elseif message:match("leave") then
		c = "Sound_EnableMusic"; local s = GetCVar(c) or "0"; if s == "1" then SetCVar(c, "0") end
		SendChatMessage("leaving", "CHANNEL", nil, GetChannelName(DJChan))
		LeaveChannelByName(DJChan);
		StopMusic();
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r \124cff"..sessionColour.."\124hLeft channel: \124r\124cff"..sessionColour.."\124h"..DJChan.."\124r and stopped all sounds.")		
		DJChan = nil;

	elseif message:match("play") then
		
		if message:match("add") then
		
		
		table.insert(DJPlayList, message:match("play add (.+)"))
			print("Added: "..message:match("play add (.+)"))
		
		elseif message:match("playlist") then
		
			print("list songs in playlist by name")
		
		end
		
		sound = message:match("play (.*)")
		SendChatMessage("play "..sound, "CHANNEL", nil, GetChannelName(DJChan))

		
	elseif message:match("stop") then
		
		SendChatMessage("stop", "CHANNEL", nil, GetChannelName(DJChan))

	elseif message:match("help") then
	
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r \124cff"..sessionColour.."\124h[PJDJ Help]\n/pj join channel - join a music channel by name.\n/pj leave - leave a music channel.\n/pj stop - stop sounds from playing\n/pj play ID - play a retail sound to the channel.\n/pj help - bring up this help message.\n/pj list - display a list of available audio clips.\nIf you join a channel, but nothing comes up you may need to try a different name - and pay attention to channels that may be case-sensitive.")
	
	elseif message:match("list") then
		
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r \124cff"..sessionColour.."\124hStart of list\124r")	
		listMusic(message)	


	
	end
	


end
SlashCmdList["GPlayer"] = handler;