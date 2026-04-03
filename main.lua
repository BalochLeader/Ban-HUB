--[[
    Ban Hub [BETA] - Ultimate Visual Prank Script
    Developer: @uginkbhai
    UI: Premium Rayfield (Modern & Categorized)
    Features: Realistic Ban Hammer, Player Banner, Global Announcements, Hacking Animations
]]

-- Initialization & Anti-Re-execution
if getgenv().BanHubLoaded then
    return
end
getgenv().BanHubLoaded = true

-- Rayfield UI Library Loading (Reliable Source)
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)

if not success or not Rayfield then
    warn("Ban Hub: Critical Error - UI Library failed to load.")
    return
end

-- Window Creation
local Window = Rayfield:CreateWindow({
    Name = "Ban Hub [BETA]",
    LoadingTitle = "Ban Hub [BETA]",
    LoadingSubtitle = "by @uginkbhai",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BanHubConfig",
        FileName = "BanHub"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Dashboard Tab
local DashboardTab = Window:CreateTab("Dashboard", 4483362458)
local DashboardSection = DashboardTab:CreateSection("Main Dashboard")

DashboardTab:CreateLabel("Welcome, @uginkbhai", Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 0, 0))
DashboardTab:CreateLabel("Status: Connected to Roblox Admin API (Fake)", Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 0))

local GlobalAnnouncements = DashboardTab:CreateParagraph({
    Name = "Global Announcements",
    Content = "Initializing fake ban feed...",
})

local fakeAnnouncements = {
    "[SYSTEM] User 'xX_ProHacker_Xx' has been banned for Exploiting.",
    "[SYSTEM] User 'NoobMaster69' has been banned for Toxicity.",
    "[SYSTEM] User 'AdminAbuser' has been banned for Admin Abuse.",
    "[SYSTEM] User 'Guest_12345' has been banned for bypassing chat filters.",
    "[SYSTEM] User 'RobloxDev' has been banned for unauthorized script injection.",
}

local announcementIndex = 1
task.spawn(function()
    while true do
        if not getgenv().BanHubLoaded then break end
        GlobalAnnouncements:Set("Global Announcements:\n" .. fakeAnnouncements[announcementIndex])
        announcementIndex = announcementIndex % #fakeAnnouncements + 1
        task.wait(5)
    end
end)

-- Ban Panel Tab
local BanPanelTab = Window:CreateTab("Ban Panel", 4483362458)
local BanSection = BanPanelTab:CreateSection("Player Banning (Visual)")

local selectedPlayerName = ""
local targetPlayerDropdown = BanPanelTab:CreateDropdown({
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

local banReasonDropdown = BanPanelTab:CreateDropdown({
    Name = "Ban Reason",
    Options = {"Exploiting", "Toxicity", "Admin Abuse", "Other"},
    CurrentOption = "Exploiting",
    Callback = function(reason)
        -- Handle reason selection
    end,
})

-- Realistic Ban Animation Logic
local function triggerVisualBan(targetName, reason)
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
        
        -- Fake Global Announcement
        GlobalAnnouncements:Set("Global Announcements:\n[SYSTEM] User '" .. targetName .. "' has been banned for " .. reason .. ".")
    else
        Rayfield:Notify({Title = "Error", Content = "Player not found or already banned.", Duration = 5})
    end
end

BanPanelTab:CreateButton({
    Name = "Ban Player",
    Callback = function()
        triggerVisualBan(selectedPlayerName, banReasonDropdown.CurrentOption)
    end,
})

-- Ban Hammer Tab
local BanHammerTab = Window:CreateTab("Ban Hammer", 4483362458)
local HammerSection = BanHammerTab:CreateSection("Admin Tools")

BanHammerTab:CreateButton({
    Name = "Give Ban Hammer",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        local backpack = player:FindFirstChildOfClass("Backpack") or Instance.new("Backpack", player)

        local banHammer = Instance.new("Tool")
        banHammer.Name = "Ban Hammer"
        banHammer.RequiresHandle = true

        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(1, 1, 3)
        handle.BrickColor = BrickColor.new("Really red")
        handle.Parent = banHammer

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://1039097"
        mesh.TextureId = "rbxassetid://1039098"
        mesh.Scale = Vector3.new(1, 1, 1)
        mesh.Parent = handle

        banHammer.Activated:Connect(function()
            local mouse = player:GetMouse()
            local target = mouse.Target
            if target and target.Parent and target.Parent:FindFirstChild("Humanoid") then
                local targetPlayer = game:GetService("Players"):GetPlayerFromCharacter(target.Parent)
                if targetPlayer then
                    triggerVisualBan(targetPlayer.Name, "Ban Hammer Strike")
                end
            end
        end)

        banHammer.Parent = backpack
        Rayfield:Notify({Title = "Info", Content = "Ban Hammer added to your backpack!", Duration = 3})
    end,
})

-- Player Banner (Custom UI)
local PlayerBannerTab = Window:CreateTab("Player Banner", 4483362458)
local BannerSection = PlayerBannerTab:CreateSection("Visual Banner")

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
    triggerVisualBan(PlayerNameLabel.Text, "Player Banner Ban")
    PlayerBannerScreenGui.Enabled = false
end)

PlayerBannerTab:CreateButton({
    Name = "Show Player Banner",
    Callback = function()
        if selectedPlayerName == "" then
            Rayfield:Notify({Title = "Error", Content = "Please select a player in the Ban Panel first.", Duration = 5})
            return
        end
        PlayerNameLabel.Text = selectedPlayerName
        PlayerBannerScreenGui.Enabled = true
    end,
})

-- Extra Features Tab
local ExtraTab = Window:CreateTab("Extra Features", 4483362458)
local ExtraSection = ExtraTab:CreateSection("Admin Utilities")

ExtraTab:CreateButton({
    Name = "Toggle Fly",
    Callback = function()
        -- Fly logic
        Rayfield:Notify({Title = "Info", Content = "Fly toggled (Visual).", Duration = 3})
    end,
})

ExtraTab:CreateButton({
    Name = "Toggle NoClip",
    Callback = function()
        -- NoClip logic
        Rayfield:Notify({Title = "Info", Content = "NoClip toggled (Visual).", Duration = 3})
    end,
})

-- Finalize UI
Rayfield:Notify({
    Title = "Ban Hub [BETA]",
    Content = "Script Loaded Successfully!",
    Duration = 5,
    Image = 4483362458,
})
