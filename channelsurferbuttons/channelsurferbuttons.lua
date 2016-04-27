function CHSURF_MOVE_CHANNEL(channelID)
	local mapName = session.GetMapName();
	local mapCls = GetClass("Map", mapName);
	local zoneInsts = session.serverState.GetMap(mapCls.ClassID);
	if zoneInsts.pcCount == -1 then
		ui.SysMsg(ClMsg("ChannelIsClosed"));
		return;
	end

	app.ChangeChannel(channelID);
end

function CHSURF_CHANGE_CHANNEL(nextchannel)
	local mapName = session.GetMapName()
	local mapCls = GetClass("Map", mapName);
	local zoneInsts = session.serverState.GetMap(mapCls.ClassID);
	local numberOfChannels = zoneInsts:GetZoneInstCount();
	local currentChannel = session.loginInfo.GetChannel();
	if nextchannel == 1 then
		if currentChannel+1 == numberOfChannels then
			CHSURF_MOVE_CHANNEL(0)
		else
			CHSURF_MOVE_CHANNEL(currentChannel+1)
		end
	else
		if currentChannel-1 == -1 then
			CHSURF_MOVE_CHANNEL(numberOfChannels-1)
		else
			CHSURF_MOVE_CHANNEL(currentChannel-1)
		end
	end
end

function CHSURF_CREATE_BUTTONS()
	local frame = ui.GetFrame("minimap");
	local btnsize = 30;
	local nextbutton = frame:CreateOrGetControl('button', "nextbutton", 5+34, 5, btnsize, btnsize);
	tolua.cast(nextbutton, "ui::CButton");
	nextbutton:SetText("{s22}>");
	nextbutton:SetEventScript(ui.LBUTTONUP, "CHSURF_CHANGE_CHANNEL(1)");
	
	local prevbutton = frame:CreateOrGetControl('button', "prevbutton", 5, 5, btnsize, btnsize);
	tolua.cast(prevbutton, "ui::CButton");
	prevbutton:SetText("{s22}<");
	prevbutton:SetEventScript(ui.LBUTTONUP, "CHSURF_CHANGE_CHANNEL(0)");
end

function MINIMAP_ON_INIT_HOOKED(addon, frame)
	_G["MINIMAP_ON_INIT_OLD"](addon, frame);
	CHSURF_CREATE_BUTTONS();
end


local minimapOnInitHook = "MINIMAP_ON_INIT";

if _G["MINIMAP_ON_INIT_OLD"] == nil then
    _G["MINIMAP_ON_INIT_OLD"] = _G[minimapOnInitHook];
    _G[minimapOnInitHook] = MINIMAP_ON_INIT_HOOKED;
else
    _G[minimapOnInitHook] = MINIMAP_ON_INIT_HOOKED;
end

CHSURF_CREATE_BUTTONS();