pet_settings = {
	showMyPetName = 1;
	showMyPetHP = 0;
	showOtherPetNames = 0;
};
	
function UPDATE_COMPANION_TITLE_HOOKED(frame, handle)
	_G["UPDATE_COMPANION_TITLE_OLD"](frame, handle)
	frame = tolua.cast(frame, "ui::CObject");

	local mycompinfoBox = GET_CHILD_RECURSIVELY(frame, "mycompinfo");
	if mycompinfoBox == nil then
		return;
	end
	local otherscompinfo = GET_CHILD_RECURSIVELY(frame, "otherscompinfo");
	
	local mynameRtext = GET_CHILD_RECURSIVELY(frame, "myname");
	local gauge_stamina = GET_CHILD_RECURSIVELY(frame, "StGauge");
	local hp_stamina = GET_CHILD_RECURSIVELY(frame, "HpGauge");
	local pcinfo_bg_L = GET_CHILD_RECURSIVELY(frame, "pcinfo_bg_L");
	local pcinfo_bg_R = GET_CHILD_RECURSIVELY(frame, "pcinfo_bg_R");
	
	local othernameTxt = GET_CHILD_RECURSIVELY(frame, "othername");
	
	gauge_stamina:ShowWindow(pet_settings.showMyPetHP)
	hp_stamina:ShowWindow(pet_settings.showMyPetHP)
	pcinfo_bg_L:ShowWindow(pet_settings.showMyPetHP)
	pcinfo_bg_R:ShowWindow(pet_settings.showMyPetHP)
	mynameRtext:ShowWindow(pet_settings.showMyPetName)
	
	othernameTxt:ShowWindow(pet_settings.showOtherPetNames)

	frame:Invalidate()
end

local updateCompanionTitleHook = "UPDATE_COMPANION_TITLE";

if _G["UPDATE_COMPANION_TITLE_OLD"] == nil then
	_G["UPDATE_COMPANION_TITLE_OLD"] = _G[updateCompanionTitleHook];
	_G[updateCompanionTitleHook] = UPDATE_COMPANION_TITLE_HOOKED;
else
	_G[updateCompanionTitleHook] = UPDATE_COMPANION_TITLE_HOOKED;
end

ui.SysMsg("Pet info settings loaded");
