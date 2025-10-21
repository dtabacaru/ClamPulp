local CLAM_LIST = {
  [ 7973] = true, -- Big-mouth Clam
  [ 5524] = true, -- Thick-shelled Clam
  [ 5523] = true, -- Small Barnacled Clam
  [15874] = true, -- Soft-shelled Clam
}

local function HasFreeSlots()
  local freeSlots = 0
  for bagNum = 0, 4 do
    local numFreeSlots = C_Container.GetContainerNumFreeSlots(bagNum) or 0
    freeSlots = freeSlots + numFreeSlots
  end
  return freeSlots > 0
end

local function OpenClams()
  for bagNum = 0, 4 do
    local numSlots = C_Container.GetContainerNumSlots(bagNum) or 0
    for slotNum = 1, numSlots do
      local itemId = C_Container.GetContainerItemID(bagNum, slotNum)
      if itemId and CLAM_LIST[itemId] then
        C_Container.UseContainerItem(bagNum, slotNum)
        return -- open only one per event; next event will handle more
      end
    end
  end
end

local clamFrame = CreateFrame("Frame")
clamFrame:RegisterEvent("BAG_UPDATE_DELAYED")

clamFrame:SetScript("OnEvent", function(self, event)
  if not GetCVarBool("autoLootDefault") then 
    return 
  end
  
  if HasFreeSlots() then
    OpenClams()
  end
end)
