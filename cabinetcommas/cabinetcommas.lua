function ON_CABINET_ITEM_LIST_HOOKED(frame)
	_G["ON_CABINET_ITEM_LIST_OLD"](frame);
	
	local itemGbox = GET_CHILD(frame, "itemGbox");
	local itemlist = GET_CHILD(itemGbox, "itemlist", "ui::CDetailListBox");
	local cnt = itemlist:GetChildCount();
	
	for i = 0 , cnt - 1 do
		local cabinetItem = session.cabinet.GetCabinetItemByIndex(i);
		local ctrlSet = itemlist:GetChild("DETAIL_ITEM_" .. i .. "_0");
		local totalPrice = ctrlSet:GetChild("totalPrice");
		totalPrice:SetTextByKey("value", GetCommaedText(cabinetItem.count));
	end

end


local onCabinetItemListHook = "ON_CABINET_ITEM_LIST";
if _G["ON_CABINET_ITEM_LIST_OLD"] == nil then
	_G["ON_CABINET_ITEM_LIST_OLD"] = _G[onCabinetItemListHook];
	_G[onCabinetItemListHook] = ON_CABINET_ITEM_LIST_HOOKED;
else
	_G[onCabinetItemListHook] = ON_CABINET_ITEM_LIST_HOOKED;
end
