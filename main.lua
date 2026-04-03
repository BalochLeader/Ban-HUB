--!strict

-- Rayfield UI Library Initialization
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/UI-Library-Official/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "Ban Hub [BETA]",
    Description = "Visually Prank Script by @uginkbhai",
    Footer = {
        Text = "Developed by @uginkbhai",
        Color = Color3.fromRGB(255, 0, 0),
        Transparency = 0.5,
    },
    Draggable = true,
    Resizable = true,
    Blocking = false,
    -- Size = Vector2.new(500, 400), -- Default size, can be adjusted
})

-- Dashboard Tab
local DashboardTab = Window:CreateTab("Dashboard", 4483362458)

DashboardTab:CreateLabel("Welcome, @uginkbhai", Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 0, 0))
DashboardTab:CreateLabel("Status: Connected to Roblox Database (Fake)", Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 0))

local GlobalAnnouncements = DashboardTab:CreateParagraph({
    Name = "Global Announcements",
    Content = "",
    Color = Color3.fromRGB(255, 255, 255),
    Transparency = 0.5,
})

local fakeAnnouncements = {
    "[SYSTEM] User 'xX_ProHacker_Xx' has been banned for Exploiting.",
    "[SYSTEM] User 'NoobMaster69' has been banned for Toxicity.",
    "[SYSTEM] User 'AdminAbuser' has been banned for Admin Abuse.",
    "[SYSTEM] User 'Guest_12345' has been banned for bypassing chat filters.",
    "[SYSTEM] User 'RobloxDev' has been banned for unauthorized script injection.",
}

local announcementIndex = 1
local function updateAnnouncements()
    GlobalAnnouncements:Set("Global Announcements:\n" .. fakeAnnouncements[announcementIndex])
    announcementIndex = announcementIndex % #fakeAnnouncements + 1
end

updateAnnouncements()
coroutine.wrap(function()
    while true do
        task.wait(5) -- Update every 5 seconds
        updateAnnouncements()
    end
end)()

-- Ban Panel Tab
local BanPanelTab = Window:CreateTab("Ban Panel", 4483362458)

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
        table.insert(playerNames, player.Name)
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
            Rayfield:Notify("Error", "Please select a player to ban.", 5)
            return
        end

        Rayfield:Notify("Processing", "Connecting to Roblox Admin API...", 3)
        task.wait(2)
        Rayfield:Notify("Processing", "Bypassing 2FA...", 3)
        task.wait(2)
        Rayfield:Notify("Processing", "Injecting Ban Packet...", 3)
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
            Rayfield:Notify("Success", selectedPlayerName .. " has been successfully banned from " .. game.Name .. ". Reason: " .. selectedReason, 5)
        else
            Rayfield:Notify("Error", "Player not found or already 'banned'.", 5)
        end
    end,
})

-- Admin Tools Tab
local AdminToolsTab = Window:CreateTab("Admin Tools", 4483362458)

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
            local target = player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid:GetTarget()
            if target and target.Parent and target.Parent:IsA("Model") then
                local targetPlayer = game:GetService("Players"):GetPlayerFromCharacter(target.Parent)
                if targetPlayer then
                    -- Trigger visual ban sequence for the hit player
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
                    Rayfield:Notify("Success", targetPlayer.Name .. " has been visually banned with the Ban Hammer!", 5)
                end
            end
        end)

        banHammer.Parent = backpack
        Rayfield:Notify("Info", "Ban Hammer added to your backpack!", 3)
    end,
})

AdminToolsTab:CreateButton({
    Name = "Toggle Fly",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if humanoid:GetState() == Enum.HumanoidStateType.Flying then
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                Rayfield:Notify("Info", "Fly disabled.", 3)
            else
                humanoid:ChangeState(Enum.HumanoidStateType.Flying)
                Rayfield:Notify("Info", "Fly enabled.", 3)
            end
        end
    end,
})

AdminToolsTab:CreateButton({
    Name = "Toggle NoClip",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not part.CanCollide
                end
            end
            Rayfield:Notify("Info", "NoClip toggled.", 3)
        end
    end,
})

AdminToolsTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16, -- Default Roblox walkspeed
    Max = 100,
    Current = 16,
    Rounding = 0,
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end,
})

AdminToolsTab:CreateSlider({
    Name = "JumpPower",
    Min = 50, -- Default Roblox jumppower
    Max = 200,
    Current = 50,
    Rounding = 0,
    Callback = function(value)
        local player = game:GetService("Players").LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
    end,
})

-- Visual Pranks Tab
local VisualPranksTab = Window:CreateTab("Visual Pranks", 4483362458)

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
        Rayfield:Notify("Fake Console", randomLog, 5)
    end,
})

VisualPranksTab:CreateButton({
    Name = "Fake Server Message",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        local chatService = game:GetService("Chat")
        chatService:Chat(player.Character.Head, "[SERVER] This server is under maintenance. Expect lag spikes.", Enum.ChatColor.Red)
        Rayfield:Notify("Info", "Fake server message sent to your chat.", 3)
    end,
})

VisualPranksTab:CreateButton({
    Name = "Play Random Emote",
    Callback = function()
        local player = game:GetService("Players").LocalPlayer
        local emotes = game:GetService("Emotes")
        local availableEmotes = emotes:GetEmotes(player)
        if #availableEmotes > 0 then
            local randomEmote = availableEmotes[math.random(1, #availableEmotes)]
            emotes:PlayEmote(player, randomEmote.EmoteId)
            Rayfield:Notify("Info", "Playing random emote: " .. randomEmote.Name, 3)
        else
            Rayfield:Notify("Warning", "No emotes found for your character.", 3)
        end
    end,
})

-- Player Banner (Custom UI)
local PlayerBannerScreenGui = Instance.new("ScreenGui")
PlayerBannerScreenGui.Name = "PlayerBannerGui"
PlayerBannerScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
PlayerBannerScreenGui.Enabled = false -- Hidden by default

local PlayerBannerFrame = Instance.new("Frame")
PlayerBannerFrame.Size = UDim2.new(0, 250, 0, 150)
PlayerBannerFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
PlayerBannerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerBannerFrame.BorderSizePixel = 0
PlayerBannerFrame.Active = true
PlayerBannerFrame.Draggable = true
PlayerBannerFrame.Parent = PlayerBannerScreenGui

local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Size = UDim2.new(1, 0, 0, 30)
PlayerNameLabel.Position = UDim2.new(0, 0, 0, 10)
PlayerNameLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameLabel.Font = Enum.Font.SourceSansBold
PlayerNameLabel.TextSize = 20
PlayerNameLabel.Text = "Player Name"
PlayerNameLabel.Parent = PlayerBannerFrame

local BanPlayerButton = Instance.new("TextButton")
BanPlayerButton.Size = UDim2.new(0.8, 0, 0, 40)
BanPlayerButton.Position = UDim2.new(0.1, 0, 0.6, 0)
BanPlayerButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BanPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BanPlayerButton.Font = Enum.Font.SourceSansBold
BanPlayerButton.TextSize = 24
BanPlayerButton.Text = "BAN"
BanPlayerButton.Parent = PlayerBannerFrame

local CloseBannerButton = Instance.new("TextButton")
CloseBannerButton.Size = UDim2.new(0, 20, 0, 20)
CloseBannerButton.Position = UDim2.new(1, -25, 0, 5)
CloseBannerButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
CloseBannerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseBannerButton.Font = Enum.Font.SourceSansBold
CloseBannerButton.TextSize = 16
CloseBannerButton.Text = "X"
CloseBannerButton.Parent = PlayerBannerFrame

CloseBannerButton.MouseButton1Click:Connect(function()
    PlayerBannerScreenGui.Enabled = false
end)

BanPlayerButton.MouseButton1Click:Connect(function()
    local selectedPlayerName = PlayerNameLabel.Text
    local selectedReason = "Player Banner Ban"

    Rayfield:Notify("Processing", "Connecting to Roblox Admin API...", 3)
    task.wait(2)
    Rayfield:Notify("Processing", "Bypassing 2FA...", 3)
    task.wait(2)
    Rayfield:Notify("Processing", "Injecting Ban Packet...", 3)
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
        Rayfield:Notify("Success", selectedPlayerName .. " has been successfully banned from " .. game.Name .. ". Reason: " .. selectedReason, 5)
    else
        Rayfield:Notify("Error", "Player not found or already 'banned'.", 5)
    end
    PlayerBannerScreenGui.Enabled = false
end)

VisualPranksTab:CreateButton({
    Name = "Show Player Banner",
    Callback = function()
        local selectedPlayerName = targetPlayerDropdown.CurrentOption
        if selectedPlayerName == "" then
            Rayfield:Notify("Error", "Please select a player in the Ban Panel to show banner.", 5)
            return
        end
        PlayerNameLabel.Text = selectedPlayerName
        PlayerBannerScreenGui.Enabled = true
    end,
})

-- Finalize UI
Rayfield:Notify("Ban Hub [BETA]", "Script Loaded Successfully!", 5)
