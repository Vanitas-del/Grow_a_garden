local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- UI Creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PetSpawnerUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 90, 180)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- UI Corner
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Pet Spawner"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

-- TextBox
local petNameBox = Instance.new("TextBox")
petNameBox.Size = UDim2.new(0.9, 0, 0, 35)
petNameBox.Position = UDim2.new(0.05, 0, 0.3, 0)
petNameBox.PlaceholderText = "pet name here"
petNameBox.Font = Enum.Font.SourceSans
petNameBox.TextSize = 18
petNameBox.Text = ""
petNameBox.ClearTextOnFocus = false
petNameBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
petNameBox.TextColor3 = Color3.fromRGB(0, 0, 0)
petNameBox.Parent = frame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 6)
boxCorner.Parent = petNameBox

-- Spawn Button
local spawnButton = Instance.new("TextButton")
spawnButton.Size = UDim2.new(0.9, 0, 0, 35)
spawnButton.Position = UDim2.new(0.05, 0, 0.6, 0)
spawnButton.Text = "Spawn"
spawnButton.Font = Enum.Font.SourceSansBold
spawnButton.TextSize = 20
spawnButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
spawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnButton.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = spawnButton

-- Credits
local credits = Instance.new("TextLabel")
credits.Size = UDim2.new(1, 0, 0, 25)
credits.Position = UDim2.new(0, 0, 1, -25)
credits.BackgroundTransparency = 1
credits.Text = "Credit to Vanitas"
credits.Font = Enum.Font.SourceSansItalic
credits.TextSize = 14
credits.TextColor3 = Color3.fromRGB(200, 200, 200)
credits.Parent = frame

-- Spawn Function
spawnButton.MouseButton1Click:Connect(function()
	local petName = petNameBox.Text
	if petName == "" then return end

	local matchingPets = {}
	for _, item in ipairs(ReplicatedStorage:GetDescendants()) do
		if item:IsA("Tool") or item:IsA("Model") then
			if string.lower(item.Name) == string.lower(petName) then
				table.insert(matchingPets, item)
			end
		end
	end

	if #matchingPets > 0 then
		local chosenPet = matchingPets[math.random(1, #matchingPets)]:Clone()
		if chosenPet:IsA("Tool") then
			chosenPet.Parent = player:WaitForChild("Backpack")
		elseif chosenPet:IsA("Model") then
			chosenPet.Parent = workspace
			chosenPet:MoveTo(player.Character.HumanoidRootPart.Position + Vector3.new(3,0,0))
		end
	else
		warn("No pet found with name: " .. petName)
	end
end)
