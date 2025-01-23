local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PetManager = require(ReplicatedStorage.Modules.PetManager) -- Переконайтеся, що шлях правильний
local UIManager = require(ReplicatedStorage.Modules.UIManager)

local SavePetSelectionEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SavePetSelection")

local buttons = script.Parent:GetChildren()

for _, button in pairs(buttons) do
	if button:IsA("TextButton") then
		button.MouseButton1Click:Connect(function()
			local player = Players.LocalPlayer
			local selectedPet = button.Name -- Ім'я кнопки відповідає імені пета

			-- Викликаємо RemoteEvent для збереження вибору на сервері
			SavePetSelectionEvent:FireServer(selectedPet)

			-- Ховаємо GUI
			UIManager:DisableGuiForever(player)

			-- Спавнимо пета
			PetManager:SpawnPet(player, selectedPet)
		end)
	end
end

