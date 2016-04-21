function FPS_ON_INIT_HOOKED(addon, frame)
	_G["FPS_ON_INIT_OLD"](addon, frame);
	frame:ShowWindow(0);
end

local fpsOnInitHook = "FPS_ON_INIT";

if _G["FPS_ON_INIT_OLD"] == nil then
	_G["FPS_ON_INIT_OLD"] = _G[fpsOnInitHook];
	_G[fpsOnInitHook] = FPS_ON_INIT_HOOKED;
else
	_G[fpsOnInitHook] = FPS_ON_INIT_HOOKED;
end

local frame = ui.GetFrame("fps");
frame:ShowWindow(0);

ui.SysMsg("FPS Counter Disabled");
