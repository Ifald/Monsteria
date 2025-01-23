local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryManager = require(ReplicatedStorage.Modules.InventoryManager)

local SavePetSelectionEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SavePetSelection")

-- Обробка запиту на збереження вибору пета
SavePetSelectionEvent.OnServerEvent:Connect(function(player, selectedPet)
	-- Додаємо пета в інвентар
	local inventory = player:FindFirstChild("Inventory")
	if not inventory:FindFirstChild(selectedPet) then
		local petInstance = Instance.new("StringValue")
		petInstance.Name = selectedPet
		petInstance.Parent = inventory
	end

	-- Зберігаємо інвентар у DataStore
	InventoryManager:SaveInventory(player)
end)
