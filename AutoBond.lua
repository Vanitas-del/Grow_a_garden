-- Vanitas Hub - Auto Bonds UI with Player Kill Feature

if getgenv().SkullHubDrBond then return end
getgenv().SkullHubDrBond = true

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Blur Effect
local blur = Instance.new("BlurEffect")
blur.Size = 20
blur.Parent = Lighting

-- Main UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VanitasHubUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundTransparency = 1
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.Parent = screenGui

local compactButton = Instance.new("TextButton")
compactButton.Size = UDim2.new(0, 60, 0, 60)
compactButton.Position = UDim2.new(0.5, -30, 0, -80)
compactButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
compactButton.Text = "▲"
compactButton.TextColor3 = Color3.fromRGB(255, 255, 255)
compactButton.Font = Enum.Font.FredokaOne
compactButton.TextSize = 24
compactButton.Visible = false
compactButton.Parent = mainFrame

local compactCorner = Instance.new("UICorner")
compactCorner.CornerRadius = UDim.new(1, 0)
compactCorner.Parent = compactButton

local compactStroke = Instance.new("UIStroke")
compactStroke.Thickness = 2
compactStroke.Color = Color3.fromRGB(72, 138, 182)
compactStroke.Transparency = 0.3
compactStroke.Parent = compactButton

local uiContainer = Instance.new("Frame")
uiContainer.Size = UDim2.new(0, 450, 0, 240)
uiContainer.Position = UDim2.new(0.5, -225, 1, 100)
uiContainer.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
uiContainer.BackgroundTransparency = 0.1
uiContainer.Parent = mainFrame

Instance.new("UICorner", uiContainer).CornerRadius = UDim.new(0, 16)
Instance.new("UIStroke", uiContainer).Color = Color3.fromRGB(72, 138, 182)
Instance.new("UIGradient", uiContainer).Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(72, 138, 182)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
})

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -40, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.FredokaOne
minimizeButton.TextSize = 20
minimizeButton.Parent = uiContainer
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 8)

Instance.new("ImageLabel", uiContainer).Image = "rbxassetid://121302760641013"

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 90)
title.BackgroundTransparency = 1
title.Text = "Vanitas Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 32
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = uiContainer

local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -40, 0, 60)
desc.Position = UDim2.new(0, 20, 0, 140)
desc.BackgroundTransparency = 1
desc.Text = "Auto Bonds Free Version" 
desc.TextColor3 = Color3.fromRGB(180, 180, 180)
desc.Font = Enum.Font.FredokaOne
desc.TextSize = 16
desc.TextWrapped = true
desc.TextYAlignment = Enum.TextYAlignment.Top
desc.TextXAlignment = Enum.TextXAlignment.Center
desc.Parent = uiContainer

local isMinimized = false

local function toggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(uiContainer, TweenInfo.new(0.4), {
            Position = UDim2.new(0.5, -225, 0, -300), Size = UDim2.new(0, 450, 0, 0)
        }):Play()
        TweenService:Create(mainFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        task.wait(0.2)
        compactButton.Visible = true
        TweenService:Create(compactButton, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -30, 0, 10)
        }):Play()
        blur.Size = 0
        minimizeButton.Text = "+"
    else
        TweenService:Create(compactButton, TweenInfo.new(0.3), {
            Position = UDim2.new(0.5, -30, 0, -80)
        }):Play()
        task.wait(0.2)
        compactButton.Visible = false
        TweenService:Create(uiContainer, TweenInfo.new(0.6), {
            Position = UDim2.new(0.5, -225, 0.5, -120), Size = UDim2.new(0, 450, 0, 240)
        }):Play()
        TweenService:Create(mainFrame, TweenInfo.new(0.4), {BackgroundTransparency = 0.4}):Play()
        blur.Size = 20
        minimizeButton.Text = "-"
    end
end

minimizeButton.MouseButton1Click:Connect(toggleMinimize)
compactButton.MouseButton1Click:Connect(toggleMinimize)

-- Open UI with animation
TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0.4}):Play()
TweenService:Create(uiContainer, TweenInfo.new(0.6), {
    Position = UDim2.new(0.5, -225, 0.5, -120)
}):Play()

-- Notification
local notify = function(titleText, messageText, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = titleText,
        Text = messageText,
        Duration = duration or 5
    })
end

notify("Vanitas Hub", "This's just beta version, so there may be some errors/bugs.", 10)

-- Start Script + Auto Kill Player in 60s
local Notif = loadstring(game:HttpGet("https://raw.githubusercontent.com/hungquan99/Interface/main/Notify.lua"))()
if game.PlaceId == 70876832253163 or game.PlaceId == 98018823628597 then
    Notif.New("[Vanitas Hub] Auto Bond Loaded!", 5)
    toggleMinimize()

    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Shade-vex/DeadRails/refs/heads/main/Viet-Nam-Number-One.txt"))(
    end)

    if not success then warn("[Vanitas Hub] Auto Bond script failed to load:", err) end

    task.delay(180, function()
        local player = Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Health = 0 end
    end)
end
