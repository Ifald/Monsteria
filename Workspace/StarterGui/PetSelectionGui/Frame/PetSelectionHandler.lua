local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PetManager = require(ReplicatedStorage.Modules.PetManager) -- �������������, �� ���� ����������
local UIManager = require(ReplicatedStorage.Modules.UIManager)

local SavePetSelectionEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SavePetSelection")

local buttons = script.Parent:GetChildren()

for _, button in pairs(buttons) do
	if button:IsA("TextButton") then
		button.MouseButton1Click:Connect(function()
			local player = Players.LocalPlayer
			local selectedPet = button.Name -- ��'� ������ ������� ���� ����

			-- ��������� RemoteEvent ��� ���������� ������ �� ������
			SavePetSelectionEvent:FireServer(selectedPet)

			-- ������ GUI
			UIManager:DisableGuiForever(player)

			-- �������� ����
			PetManager:SpawnPet(player, selectedPet)
		end)
	end
end

