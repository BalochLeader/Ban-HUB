--[[
    Ban Hub [BETA]
    Developer: @uginkbhai
    Type: Visual Prank Script
    UI: Rayfield (Modern & Categorized)
]]

-- Ensure the script only runs once
if getgenv().BanHubLoaded then
    return
end
getgenv().BanHubLoaded = true

-- Rayfield UI Library Loading with Error Handling
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)

if not success or not Rayfield then
    -- Fallback to another source if the first one fails
    success, Rayfield = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/UI-Library-Official/Rayfield/main/source"))()
    end)
end

if not success or not Rayfield then
    warn("Ban Hub: Failed to load Rayfield UI Library.")
    return
end

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
    KeySystem = false, -- Set to true if you want a key system
})

-- Dashboard Tab
local DashboardTab = Window:CreateTab("Dashboard", 4483362458)
local DashboardSection = DashboardTab:CreateSection("Main Dashboard")

DashboardTab:CreateLabel("Welcome, @uginkbhai", Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 0, 0))
DashboardTab:CreateLabel("Status: Connected to Roblox Database (Fake)", Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 0))

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

local targetPlayerDropdown = BanPanelTab:CreateDropdown({
    Name = "Select Player",
    Options = {},
    CurrentOption = "",
    Callback = function(player)
        -- Handle player selection
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

BanPanelTab:CreateButton({
    Name = "Ban Player",
    Callback = function()
        local selectedPlayerName = targetPlayerDropdown.CurrentOption
        local selectedReason = banReasonDropdown.CurrentOption

        if selectedPlayerName == "" then
            Rayfield:Notify({
                Title = "Error",
                Content = "Please select a player to ban.",
                Duration = 5,
                Image = 4483362458,
            })
            return
        end

        Rayfield:Notify({Title = "Processing", Content = "Connecting to Roblox Admin API...", Duration = 2})
        task.wait(2)
        Rayfield:Notify({Title = "Processing", Content = "Bypassing 2FA...", Duration = 2})
        task.wait(2)
        Rayfield:Notify({Title = "Processing", Content = "Injecting Ban Packet...", Duration = 2})
        task.wait(3)

        local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayerName)
        if targetPlayer then
            -- Visual ban effect (client-side only)
            local character = targetPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
                        part.Transparency = 1
                        part.CanCollide = false
                        part.CastShadow = false
                    end
                end
            end
            Rayfield:Notify({
                Title = "Success",
                Content = selectedPlayerName .. " has been successfully banned from " .. game.Name .. ". Reason: " .. selectedReason,
                Duration = 5,
                Image = 4483362458,
            })
        else
            Rayfield:Notify({Title = "Error", Content = "Player not found or already 'banned'.", Duration = 5})
        end
    end,
})

-- Admin Tools Tab
local AdminToolsTab = Window:CreateTab("Admin Tools", 4483362458)
local ToolsSection = AdminToolsTab:CreateSection("Functional Tools")

AdminToolsTab:CreateButton({
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
        handle.Transparency = 0
        handle.CanCollide = false
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
                    local character = targetPlayer.Character
                    if character then
                        for _, part in ipairs(character:GetDescendants()) do
                            if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
                                part.Transparency = 1
                                part.CanCollide = false
                                part.CastShadow = false
                            end
                        end
                    end
                    Rayfield:Notify({Title = "Success", Content = targetPlayer.Name .. " has been visually banned with the Ban Hammer!", Duration = 5})
                end
            end
        end)

        banHammer.Parent = backpack
        Rayfield:Notify({Title = "Info", Content = "Ban Hammer added to your backpack!", Duration = 3})
    end,
})

local flying = false
AdminToolsTab:CreateButton({
    Name = "Toggle Fly",
    Callback = function()
        flying = not flying
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if flying then
            Rayfield:Notify({Title = "Info", Content = "Fly enabled.", Duration = 3})
            task.spawn(function()
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
                
                while flying do
                    bodyVelocity.Velocity = humanoid.MoveDirection * 50
                    task.wait()
                end
                bodyVelocity:Destroy()
            end)
        else
            Rayfield:Notify({Title = "Info", Content = "Fly disabled.", Duration = 3})
        end
    end,
})

AdminToolsTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end,
})

-- Visual Pranks Tab
local VisualPranksTab = Window:CreateTab("Visual Pranks", 4483362458)
local PrankSection = VisualPranksTab:CreateSection("Extra Pranks")

VisualPranksTab:CreateButton({
    Name = "Fake Console Log",
    Callback = function()
        local consoleOutput = {
            "[HACKING] Initiating backdoor protocol...",
            "[HACKING] Bypassing server-side anti-cheat...",
            "[HACKING] Injecting malicious payload...",
            "[HACKING] Accessing restricted memory regions...",
            "[HACKING] Data exfiltration in progress...",
        }
        local randomLog = consoleOutput[math.random(1, #consoleOutput)]
        Rayfield:Notify({Title = "Fake Console", Content = randomLog, Duration = 5})
    end,
})

-- Player Banner (Custom UI)
local PlayerBannerScreenGui = Instance.new("ScreenGui")
PlayerBannerScreenGui.Name = "PlayerBannerGui"
PlayerBannerScreenGui.Parent = game:GetService("CoreGui") -- Use CoreGui for better visibility
PlayerBannerScreenGui.Enabled = false

local PlayerBannerFrame = Instance.new("Frame")
PlayerBannerFrame.Size = UDim2.new(0, 300, 0, 200)
PlayerBannerFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
PlayerBannerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PlayerBannerFrame.BorderSizePixel = 2
PlayerBannerFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
PlayerBannerFrame.Active = true
PlayerBannerFrame.Draggable = true
PlayerBannerFrame.Parent = PlayerBannerScreenGui

local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Size = UDim2.new(1, 0, 0, 40)
PlayerNameLabel.Position = UDim2.new(0, 0, 0, 20)
PlayerNameLabel.BackgroundTransparency = 1
PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameLabel.Font = Enum.Font.SourceSansBold
PlayerNameLabel.TextSize = 24
PlayerNameLabel.Text = "Player Name"
PlayerNameLabel.Parent = PlayerBannerFrame

local BanPlayerButton = Instance.new("TextButton")
BanPlayerButton.Size = UDim2.new(0.8, 0, 0, 50)
BanPlayerButton.Position = UDim2.new(0.1, 0, 0.6, 0)
BanPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
BanPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BanPlayerButton.Font = Enum.Font.SourceSansBold
BanPlayerButton.TextSize = 28
BanPlayerButton.Text = "BAN PLAYER"
BanPlayerButton.Parent = PlayerBannerFrame

local CloseBannerButton = Instance.new("TextButton")
CloseBannerButton.Size = UDim2.new(0, 30, 0, 30)
CloseBannerButton.Position = UDim2.new(1, -35, 0, 5)
CloseBannerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CloseBannerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBannerButton.Font = Enum.Font.SourceSansBold
CloseBannerButton.TextSize = 20
CloseBannerButton.Text = "X"
CloseBannerButton.Parent = PlayerBannerFrame

CloseBannerButton.MouseButton1Click:Connect(function()
    PlayerBannerScreenGui.Enabled = false
end)

BanPlayerButton.MouseButton1Click:Connect(function()
    local selectedPlayerName = PlayerNameLabel.Text
    Rayfield:Notify({Title = "Processing", Content = "Connecting to Roblox Admin API...", Duration = 2})
    task.wait(2)
    local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayerName)
    if targetPlayer and targetPlayer.Character then
        for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.Transparency = 1 part.CanCollide = false end
        end
        Rayfield:Notify({Title = "Success", Content = selectedPlayerName .. " has been visually banned!", Duration = 5})
    end
    PlayerBannerScreenGui.Enabled = false
end)

VisualPranksTab:CreateButton({
    Name = "Show Player Banner",
    Callback = function()
        local selectedPlayerName = targetPlayerDropdown.CurrentOption
        if selectedPlayerName == "" then
            Rayfield:Notify({Title = "Error", Content = "Please select a player first.", Duration = 5})
            return
        end
        PlayerNameLabel.Text = selectedPlayerName
        PlayerBannerScreenGui.Enabled = true
    end,
})

Rayfield:Notify({
    Title = "Ban Hub [BETA]",
    Content = "Script Loaded Successfully!",
    Duration = 5,
    Image = 4483362458,
})
