local InventoryManager = {}

local DataStoreService = game:GetService("DataStoreService")
local PetDataStore = DataStoreService:GetDataStore("PetInventory")

-- Завантаження інвентаря гравця
function InventoryManager:LoadInventory(player)
	local success, data = pcall(function()
		return PetDataStore:GetAsync(player.UserId)
	end)

	local inventory = Instance.new("Folder")
	inventory.Name = "Inventory"
	inventory.Parent = player

	if success and data then
		for _, petName in pairs(data) do
			local pet = Instance.new("StringValue")
			pet.Name = petName
			pet.Parent = inventory
		end
	end

	return inventory
end

-- Збереження інвентаря гравця
function InventoryManager:SaveInventory(player)
	local inventory = player:FindFirstChild("Inventory")
	if inventory then
		local petNames = {}
		for _, pet in pairs(inventory:GetChildren()) do
			table.insert(petNames, pet.Name)
		end

		pcall(function()
			PetDataStore:SetAsync(player.UserId, petNames)
		end)
	end
end

return InventoryManager
