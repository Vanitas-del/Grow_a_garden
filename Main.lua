local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local clipboard = setclipboard or toclipboard

-- SETTINGS
local validKeys = {
	"VhLMzqXeNOywbHKFutQGxMPASvjdRlWc",
	"QWpFXtynCEouZavRJgMbKiLsdTqNxhYB",
	"jXpVrWYLTusQDAmHZCgbkNleMNqfwXIo",
	"mHTXeYkBznOLGAcwdJURvFpqStxKMbQi",
	"YzVsoWJmbPClghErNqUXAfTdkRyMtKLB"
}

local keyLinks = {
	"https://direct-link.net/1363274/lNSYQUe3Ahkk",
	"https://link-center.net/1363274/AV7FEK4DozHv",
	"https://link-hub.net/1363274/fKCPCa1ZYI5x",
	"https://link-target.net/1363274/ZHR23tdSR4IY",
	"https://direct-link.net/1363274/1ILwMH4t4t6I"
}

local scriptUrl = "https://raw.githubusercontent.com/Vanitas-del/Grow_a_garden/refs/heads/main/ui.lua"
local unlockAttribute = "VanitasKeyUnlockTime"
local oneHour = 60 * 60

-- Check if previously unlocked
local now = tick()
local lastUnlock = Player:GetAttribute(unlockAttribute)

if lastUnlock and (now - lastUnlock) < oneHour then
	loadstring(game:HttpGet(scriptUrl))()
	return
end

-- UI CREATION
local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "VanitasKeySystem"
screenGui.ResetOnSpawn = false

local main = Instance.new("Frame", screenGui)
main.Size = UDim2.new(0, 400, 0, 230)
main.Position = UDim2.new(0.5, -200, 0.5, -115)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 60)
main.Active = true
main.Draggable = true
main.AnchorPoint = Vector2.new(0.5, 0.5)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local title = Instance.new("TextLabel", main)
title.Text = "Vanitas Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(100, 200, 255)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0, 10, 0, 10)
title.Size = UDim2.new(0, 300, 0, 25)
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", main)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

local label = Instance.new("TextLabel", main)
label.Text = "Put Key:"
label.Font = Enum.Font.Gotham
label.TextSize = 16
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.Position = UDim2.new(0, 20, 0, 60)
label.Size = UDim2.new(0, 200, 0, 25)
label.TextXAlignment = Enum.TextXAlignment.Left

local textBox = Instance.new("TextBox", main)
textBox.PlaceholderText = "Enter key here..."
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.BackgroundColor3 = Color3.fromRGB(50, 80, 130)
textBox.Position = UDim2.new(0, 20, 0, 95)
textBox.Size = UDim2.new(1, -40, 0, 35)
textBox.ClearTextOnFocus = false
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local getKeyBtn = Instance.new("TextButton", main)
getKeyBtn.Text = "Get Key"
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 16
getKeyBtn.TextColor3 = Color3.new(1, 1, 1)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
getKeyBtn.Position = UDim2.new(0, 20, 0, 145)
getKeyBtn.Size = UDim2.new(1, -40, 0, 35)
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 6)

-- Logic
local index = 1

getKeyBtn.MouseButton1Click:Connect(function()
	local key = textBox.Text
	local matched = false

	for _, v in validKeys do
		if v == key then
			matched = true
			break
		end
	end

	if matched then
		-- Store unlock time and load main script
		Player:SetAttribute(unlockAttribute, tick())
		screenGui:Destroy()
		loadstring(game:HttpGet(scriptUrl))()
	else
		if clipboard then clipboard(keyLinks[index]) end
		textBox.Text = ""
		textBox.PlaceholderText = "❌ Invalid key. Try again!"
		index += 1
		if index > #keyLinks then index = 1 end
	end
end)
