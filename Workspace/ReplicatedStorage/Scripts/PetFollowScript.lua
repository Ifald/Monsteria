local pet = script.Parent
print("PetFollowScript �������� ��� ���������:", pet.Name)

-- ������� ��� ������ ������
local function getPlayerFromPet()
	local maxAttempts = 100 -- �������� ������� �����
	local attempts = 0

	local character = pet.Parent
	while not character:IsA("Model") or not game.Players:GetPlayerFromCharacter(character) do
		attempts += 1
		if attempts > maxAttempts then
			warn("PetFollowScript: �� ������� ������ ������ ���� 100 �����")
			return nil
		end
		print("������, ���� ���������� ���� ����'������ �� ���������...")
		character = pet.Parent
		task.wait(0.1) -- �������� ��� ��������
	end
	return game.Players:GetPlayerFromCharacter(character)
end

-- �������� ������
local player = getPlayerFromPet()
if not player then
	warn("PetFollowScript: ������� �� ��������� ��� ���������")
	return
end

local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)

if not humanoidRootPart then
	warn("PetFollowScript: HumanoidRootPart �� �������� � ��������� ������")
	return
end

-- ���������� PrimaryPart
if not pet.PrimaryPart then
	warn("PetFollowScript: PrimaryPart �� ����������� ��� ���������")
	return
end

-- ����� ���������
local function followPlayer()
	while pet and character.Parent do
		local playerPosition = humanoidRootPart.Position
		local petPosition = pet.PrimaryPart.Position
		local distance = (playerPosition - petPosition).Magnitude

		if distance > 5 then
			local direction = (playerPosition - petPosition).Unit
			local newPosition = petPosition + direction * 10 * 0.1
			pet:SetPrimaryPartCFrame(CFrame.new(newPosition, playerPosition))
		end

		task.wait(0.1)
	end
end

task.spawn(followPlayer)
