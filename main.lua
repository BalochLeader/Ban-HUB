--[[
    Player Banner [BETA]
    Developer: @uginkbhai
    Focus: Realistic Player Banner & Visual Ban Prank
    UI: Modern, Clean, and Professional
]]

-- Initialization & Anti-Re-execution
if getgenv().PlayerBannerLoaded then
    return
end
getgenv().PlayerBannerLoaded = true

-- UI Library Loading (Using a reliable and modern library)
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)

if not success or not Rayfield then
    warn("Player Banner: Critical Error - UI Library failed to load.")
    return
end

-- Window Creation
local Window = Rayfield:CreateWindow({
    Name = "Player Banner [BETA]",
    LoadingTitle = "Player Banner [BETA]",
    LoadingSubtitle = "by @uginkbhai",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PlayerBannerConfig",
        FileName = "PlayerBanner"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Main Tab
local MainTab = Window:CreateTab("Banner Panel", 4483362458)
local BannerSection = MainTab:CreateSection("Player Selection")

local selectedPlayerName = ""
local targetPlayerDropdown = MainTab:CreateDropdown({
    Name = "Select Player",
    Options = {},
    CurrentOption = "",
    Callback = function(player)
        selectedPlayerName = player
    end,
})

local function updatePlayerList()
    local players = game:GetService("Players"):GetPlayers()
    local playerNames = {}
    for _, player in ipairs(players) do
        if player ~= game:GetService("Players").LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    targetPlayerDropdown:SetOptions(playerNames)
end

updatePlayerList()
game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
game:GetService("Players").PlayerRemoving:Connect(updatePlayerList)

-- Realistic Ban Animation Logic
local function triggerVisualBan(targetName)
    if targetName == "" then
        Rayfield:Notify({Title = "Error", Content = "Please select a player first!", Duration = 5})
        return
    end

    Rayfield:Notify({Title = "Hacking Admin", Content = "Connecting to Roblox Database...", Duration = 2})
    task.wait(1.5)
    Rayfield:Notify({Title = "Hacking Admin", Content = "Bypassing 2FA for " .. targetName .. "...", Duration = 2})
    task.wait(2)
    Rayfield:Notify({Title = "Hacking Admin", Content = "Injecting Ban Packet into Server...", Duration = 2.5})
    task.wait(2.5)

    local targetPlayer = game:GetService("Players"):FindFirstChild(targetName)
    if targetPlayer and targetPlayer.Character then
        -- Visual ban effect (client-side only)
        for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
                part.Transparency = 1
                part.CanCollide = false
                part.CastShadow = false
            end
        end
        
        Rayfield:Notify({
            Title = "Success",
            Content = "You have successfully banned " .. targetName .. " from " .. game.Name .. "!",
            Duration = 5,
            Image = 4483362458,
        })
    else
        Rayfield:Notify({Title = "Error", Content = "Player not found or already banned.", Duration = 5})
    end
end

-- Player Banner (Custom UI)
local PlayerBannerScreenGui = Instance.new("ScreenGui")
PlayerBannerScreenGui.Name = "PlayerBannerGui"
PlayerBannerScreenGui.Parent = game:GetService("CoreGui")
PlayerBannerScreenGui.Enabled = false

local PlayerBannerFrame = Instance.new("Frame")
PlayerBannerFrame.Size = UDim2.new(0, 350, 0, 250)
PlayerBannerFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
PlayerBannerFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PlayerBannerFrame.BorderSizePixel = 2
PlayerBannerFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
PlayerBannerFrame.Active = true
PlayerBannerFrame.Draggable = true
PlayerBannerFrame.Parent = PlayerBannerScreenGui

local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Size = UDim2.new(1, 0, 0, 50)
PlayerNameLabel.Position = UDim2.new(0, 0, 0, 30)
PlayerNameLabel.BackgroundTransparency = 1
PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameLabel.Font = Enum.Font.SourceSansBold
PlayerNameLabel.TextSize = 28
PlayerNameLabel.Text = "Player Name"
PlayerNameLabel.Parent = PlayerBannerFrame

local BanPlayerButton = Instance.new("TextButton")
BanPlayerButton.Size = UDim2.new(0.8, 0, 0, 60)
BanPlayerButton.Position = UDim2.new(0.1, 0, 0.6, 0)
BanPlayerButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
BanPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BanPlayerButton.Font = Enum.Font.SourceSansBold
BanPlayerButton.TextSize = 32
BanPlayerButton.Text = "BAN PLAYER"
BanPlayerButton.Parent = PlayerBannerFrame

local CloseBannerButton = Instance.new("TextButton")
CloseBannerButton.Size = UDim2.new(0, 40, 0, 40)
CloseBannerButton.Position = UDim2.new(1, -45, 0, 5)
CloseBannerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CloseBannerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBannerButton.Font = Enum.Font.SourceSansBold
CloseBannerButton.TextSize = 24
CloseBannerButton.Text = "X"
CloseBannerButton.Parent = PlayerBannerFrame

CloseBannerButton.MouseButton1Click:Connect(function()
    PlayerBannerScreenGui.Enabled = false
end)

BanPlayerButton.MouseButton1Click:Connect(function()
    triggerVisualBan(PlayerNameLabel.Text)
    PlayerBannerScreenGui.Enabled = false
end)

MainTab:CreateButton({
    Name = "Show Player Banner",
    Callback = function()
        if selectedPlayerName == "" then
            Rayfield:Notify({Title = "Error", Content = "Please select a player first.", Duration = 5})
            return
        end
        PlayerNameLabel.Text = selectedPlayerName
        PlayerBannerScreenGui.Enabled = true
    end,
})

-- Finalize UI
Rayfield:Notify({
    Title = "Player Banner [BETA]",
    Content = "Script Loaded Successfully!",
    Duration = 5,
    Image = 4483362458,
})
