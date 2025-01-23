local pet = script.Parent
print("PetFollowScript запущено дл€ улюбленц€:", pet.Name)

-- ‘ункц≥€ дл€ пошуку гравц€
local function getPlayerFromPet()
	local maxAttempts = 100 -- ќбмежуЇмо к≥льк≥сть спроб
	local attempts = 0

	local character = pet.Parent
	while not character:IsA("Model") or not game.Players:GetPlayerFromCharacter(character) do
		attempts += 1
		if attempts > maxAttempts then
			warn("PetFollowScript: Ќе вдалос€ знайти гравц€ п≥сл€ 100 спроб")
			return nil
		end
		print("„екаЇмо, поки улюбленець буде прив'€заний до персонажа...")
		character = pet.Parent
		task.wait(0.1) -- «атримка дл€ перев≥рки
	end
	return game.Players:GetPlayerFromCharacter(character)
end

-- ќтримуЇмо гравц€
local player = getPlayerFromPet()
if not player then
	warn("PetFollowScript: √равець не знайдений дл€ улюбленц€")
	return
end

local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)

if not humanoidRootPart then
	warn("PetFollowScript: HumanoidRootPart не знайдено у персонажа гравц€")
	return
end

-- ѕерев≥р€Їмо PrimaryPart
if not pet.PrimaryPart then
	warn("PetFollowScript: PrimaryPart не встановлено дл€ улюбленц€")
	return
end

-- Ћог≥ка сл≥дуванн€
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
