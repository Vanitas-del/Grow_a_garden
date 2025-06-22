-- Load Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Persistent setting
getgenv().AutoBondsINF_Enabled = getgenv().AutoBondsINF_Enabled or false

-- Create the main Fluent UI window
local Window = Fluent:CreateWindow({
    Title = "Vanitas Hub",
    SubTitle = "Auto Bonds INF",
    TabWidth = 120,
    Size = UDim2.fromOffset(400, 300),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightAlt
})

-- Create a Farm tab
local FarmTab = Window:AddTab({ Title = "Farm", Icon = "rbxassetid://121302760641013" })

-- Add AutoBondsINF toggle
local bondToggle = FarmTab:AddToggle("AutoBondsINFToggle", {
    Title = "Auto Farm Bonds (INF)",
    Description = "Loads AutoBondsINF script",
    Default = getgenv().AutoBondsINF_Enabled
})

bondToggle:OnChanged(function(state)
    getgenv().AutoBondsINF_Enabled = state
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanitas-del/gag/refs/heads/main/Main.lua?token=GHSAT0AAAAAADF2WOXG5KGGTO3HJK6SED7A2CXYYTQ"))()
    end
end)

-- Auto-run if toggle was previously ON
if getgenv().AutoBondsINF_Enabled then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Vanitas-del/gag/refs/heads/main/Main.lua?token=GHSAT0AAAAAADF2WOXG5KGGTO3HJK6SED7A2CXYYTQ"))()
end
