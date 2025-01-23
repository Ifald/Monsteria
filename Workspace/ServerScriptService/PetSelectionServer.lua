local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryManager = require(ReplicatedStorage.Modules.InventoryManager)

local SavePetSelectionEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SavePetSelection")

-- ������� ������ �� ���������� ������ ����
SavePetSelectionEvent.OnServerEvent:Connect(function(player, selectedPet)
	-- ������ ���� � ��������
	local inventory = player:FindFirstChild("Inventory")
	if not inventory:FindFirstChild(selectedPet) then
		local petInstance = Instance.new("StringValue")
		petInstance.Name = selectedPet
		petInstance.Parent = inventory
	end

	-- �������� �������� � DataStore
	InventoryManager:SaveInventory(player)
end)
