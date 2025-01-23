local PetManager = {}

function PetManager:SpawnPet(player, petName)
	local replicatedStorage = game:GetService("ReplicatedStorage")
	local petModels = replicatedStorage:WaitForChild("PetModels")
	local petFollowScript = replicatedStorage:WaitForChild("Scripts"):WaitForChild("PetFollowScript")

	-- ��������� ������ ���������
	local pet = petModels:FindFirstChild(petName)
	if not pet then
		warn("PetManager: ������ ��������� " .. petName .. " �� ��������.")
		return
	end

	-- ������� ������ � ������ �� �� ��������� ������
	local clonedPet = pet:Clone()
	clonedPet.Name = "Pet"
	clonedPet.Parent = player.Character -- ������ �������� �� ���������

	-- ������ ������ ��� ���������
	local clonedScript = petFollowScript:Clone()
	clonedScript.Parent = clonedPet

	-- ������������ ��������� ������� ���������
	local characterPrimaryPart = player.Character:WaitForChild("HumanoidRootPart")
	if clonedPet.PrimaryPart then
		clonedPet:SetPrimaryPartCFrame(characterPrimaryPart.CFrame * CFrame.new(0, 0, -5))
	else
		warn("PrimaryPart �� ����������� ��� ���������")
	end

	print(player.Name .. " ������ ���������: " .. petName)
end

return PetManager
