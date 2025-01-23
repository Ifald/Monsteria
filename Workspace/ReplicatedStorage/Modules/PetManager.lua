local PetManager = {}

function PetManager:SpawnPet(player, petName)
	local replicatedStorage = game:GetService("ReplicatedStorage")
	local petModels = replicatedStorage:WaitForChild("PetModels")
	local petFollowScript = replicatedStorage:WaitForChild("Scripts"):WaitForChild("PetFollowScript")

	-- Знаходимо модель улюбленця
	local pet = petModels:FindFirstChild(petName)
	if not pet then
		warn("PetManager: Модель улюбленця " .. petName .. " не знайдена.")
		return
	end

	-- Копіюємо модель і додаємо її до персонажа гравця
	local clonedPet = pet:Clone()
	clonedPet.Name = "Pet"
	clonedPet.Parent = player.Character -- Модель додається до персонажа

	-- Додаємо скрипт для слідування
	local clonedScript = petFollowScript:Clone()
	clonedScript.Parent = clonedPet

	-- Встановлюємо початкову позицію улюбленця
	local characterPrimaryPart = player.Character:WaitForChild("HumanoidRootPart")
	if clonedPet.PrimaryPart then
		clonedPet:SetPrimaryPartCFrame(characterPrimaryPart.CFrame * CFrame.new(0, 0, -5))
	else
		warn("PrimaryPart не встановлено для улюбленця")
	end

	print(player.Name .. " отримує улюбленця: " .. petName)
end

return PetManager
