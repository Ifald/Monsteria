local UIManager = {}

function UIManager:ShowPetSelectionGui(player)
	local gui = player:WaitForChild("PlayerGui"):WaitForChild("PetSelectionGui")
	gui.Enabled = true
end

function UIManager:HidePetSelectionGui(player)
	local gui = player:WaitForChild("PlayerGui"):WaitForChild("PetSelectionGui")
	gui.Enabled = false
end

function UIManager:DisableGuiForever(player)
	local gui = player:WaitForChild("PlayerGui"):WaitForChild("PetSelectionGui")
	gui:Destroy() -- ��������� GUI, ��� �� ����� �� �����������
end

return UIManager
