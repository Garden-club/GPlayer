--list

soundlist = {}


function listMusic(message)

	searchTerm = message:gsub("list ", "")
	for i = 1, table.getn(soundlist) do
	
	if searchTerm == "list" then
		DEFAULT_CHAT_FRAME:AddMessage(soundlist[i]:gsub("interface/addons/", "").." - |cff"..sessionColour.."|HSOUND:"..soundlist[i].."|h[Play]|h|r - |cff"..sessionColour.."|h[Add]|h|r")
		
	elseif soundlist[i]:match(searchTerm) then
		DEFAULT_CHAT_FRAME:AddMessage(soundlist[i]:gsub("interface/addons/", "").." - |cff"..sessionColour.."|HSOUND:"..soundlist[i].."|h[Play]|h|r - |cff"..sessionColour.."|h[Add]|h|r")

	end
end
		DEFAULT_CHAT_FRAME:AddMessage("\124TINTERFACE\\ICONS\\trade_archaeology_delicatemusicbox:20:20\124t\124h\124r \124cff"..sessionColour.."\124hEnd of list\124r")
		return false;
end

local	origChatFrame_OnHyperlinkShow = ChatFrame_OnHyperlinkShow;
	ChatFrame_OnHyperlinkShow = function(...)
	local chatFrame, link, text, button = ...;
		if type(text) == "string" and text:match("HSOUND:") and not IsModifiedClick() then
			
			soundID = string.match(link, "SOUND:(.*)");
			
			if text:match("%[Play%]") then
			

				return playSound();
			end
			if text:match("%[Add%]") then
			
			print("add")
			
			end
		end		
	return origChatFrame_OnHyperlinkShow(...); 
end

function playSound()

		SendChatMessage("play "..soundID, "CHANNEL", nil, GetChannelName(DJChan))
end