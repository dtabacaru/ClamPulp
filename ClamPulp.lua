local clamList = {
	["Big-mouth Clam"] = true,
	["Thick-shelled Clam"] = true,
	["Small Barnacled Clam"] = true,
	["Soft-shelled Clam"] = true,
};

local clamFrame = CreateFrame('Frame');
clamFrame:RegisterEvent("BAG_UPDATE")
clamFrame:SetScript('OnEvent', function(self, event)
	if not GetCVarBool("autoLootDefault") then
		return
	end
	for i = 0, 4 do
		local numSlots = C_Container.GetContainerNumSlots(i);
		
		for j = 1, numSlots do
		    local containerInfo = C_Container.GetContainerItemInfo(i, j)

			local itemLink
			if containerInfo then 
			  itemLink = containerInfo.hyperlink;
			end
		
			if itemLink then
				local name = strsub(itemLink, strfind(itemLink, "%[") + 1, strfind(itemLink, "]") - 1);
			
				if clamList[name] then
					C_Container.UseContainerItem(i, j);
				end
			end
		end
	end
end)