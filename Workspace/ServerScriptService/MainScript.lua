local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryManager = require(ReplicatedStorage.Modules.InventoryManager)
local PetManager = require(ReplicatedStorage.Modules.PetManager)
local UIManager = require(ReplicatedStorage.Modules.UIManager)

Players.PlayerAdded:Connect(function(player)
	-- ����������� ��������
	local inventory = InventoryManager:LoadInventory(player)

	-- ����������, �� ������� ��� �� ��������� ����
	if #inventory:GetChildren() == 0 then
		-- �������� GUI ��� ������ ����
		UIManager:ShowPetSelectionGui(player)
	else
		-- �������� ���� � ���������
		player.CharacterAdded:Connect(function(character)
			for _, pet in pairs(inventory:GetChildren()) do
				PetManager:SpawnPet(player, pet.Name)
			end
		end)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	-- �������� �������� ����� �������
	InventoryManager:SaveInventory(player)
end)
