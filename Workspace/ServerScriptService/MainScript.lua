local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InventoryManager = require(ReplicatedStorage.Modules.InventoryManager)
local PetManager = require(ReplicatedStorage.Modules.PetManager)
local UIManager = require(ReplicatedStorage.Modules.UIManager)

Players.PlayerAdded:Connect(function(player)
	-- Завантажуємо інвентар
	local inventory = InventoryManager:LoadInventory(player)

	-- Перевіряємо, чи гравець уже має вибраного пета
	if #inventory:GetChildren() == 0 then
		-- Показуємо GUI для вибору пета
		UIManager:ShowPetSelectionGui(player)
	else
		-- Спавнимо пета з інвентаря
		player.CharacterAdded:Connect(function(character)
			for _, pet in pairs(inventory:GetChildren()) do
				PetManager:SpawnPet(player, pet.Name)
			end
		end)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	-- Зберігаємо інвентар перед виходом
	InventoryManager:SaveInventory(player)
end)
