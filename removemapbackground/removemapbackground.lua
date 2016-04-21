function BG_MAP_OPEN_HOOKED(frame)
	_G["BG_MAP_OPEN_OLD"](frame);
	local mapBg = GET_CHILD(frame, "bg");
	mapBg:ShowWindow(0);
end

local bg_mapOpenHook = "MAP_OPEN";

if _G["BG_MAP_OPEN_OLD"] == nil then
	_G["BG_MAP_OPEN_OLD"] = _G[bg_mapOpenHook];
	_G[bg_mapOpenHook] = BG_MAP_OPEN_HOOKED;
else
	_G[bg_mapOpenHook] = BG_MAP_OPEN_HOOKED;
end