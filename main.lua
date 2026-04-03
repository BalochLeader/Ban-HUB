--[[
    Ban Hub [BETA]
    Developer: @uginkbhai
    Focus: Realistic Ban Hammer & Ban Player Prank
    UI: Modern & Clean
]]

-- Ensure the script only runs once
if getgenv().BanHubLoaded then
    return
end
getgenv().BanHubLoaded = true

-- UI Library Loading (Using a more reliable and modern library)
local success, OrionLib = pcall(function()
    return loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
end)

if not success or not OrionLib then
    warn("Ban Hub: Failed to load UI Library.")
    return
end

local Window = OrionLib:MakeWindow({
    Name = "Ban Hub [BETA]",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BanHubConfig",
    IntroText = "Ban Hub [BETA] by @uginkbhai"
})

-- Dashboard Tab
local DashboardTab = Window:MakeTab({
    Name = "Dashboard",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

DashboardTab:AddLabel("Welcome, @uginkbhai")
DashboardTab:AddLabel("Status: Connected to Roblox Admin API (Fake)")

local LogParagraph = DashboardTab:AddParagraph("System Logs", "Initializing...")

local function updateLogs(message)
    LogParagraph:Set("System Logs:\n" .. message)
end

-- Ban Panel Tab
local BanPanelTab = Window:MakeTab({
    Name = "Ban Panel",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local selectedPlayer = ""
local playerDropdown = BanPanelTab:AddDropdown({
    Name = "Select Player",
    Default = "",
    Options = {},
    Callback = function(Value)
        selectedPlayer = Value
    end
})

local function updatePlayerList()
    local players = game:GetService("Players"):GetPlayers()
    local playerNames = {}
    for _, player in ipairs(players) do
        if player ~= game:GetService("Players").LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    playerDropdown:Refresh(playerNames, true)
end

updatePlayerList()
game:GetService("Players").PlayerAdded:Connect(updatePlayerList)
game:GetService("Players").PlayerRemoving:Connect(updatePlayerList)

BanPanelTab:AddButton({
    Name = "Ban Player (Visual)",
    Callback = function()
        if selectedPlayer == "" then
            OrionLib:MakeNotification({
                Name = "Error",
                Content = "Please select a player first!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            return
        end

        updateLogs("Connecting to Roblox Database...")
        task.wait(1.5)
        updateLogs("Bypassing 2FA for " .. selectedPlayer .. "...")
        task.wait(2)
        updateLogs("Injecting Ban Packet into Server...")
        task.wait(2.5)

        local targetPlayer = game:GetService("Players"):FindFirstChild(selectedPlayer)
        if targetPlayer and targetPlayer.Character then
            for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                    part.CanCollide = false
                end
            end
            updateLogs("Successfully Banned " .. selectedPlayer .. "!")
            OrionLib:MakeNotification({
                Name = "Success",
                Content = selectedPlayer .. " has been visually banned!",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            updateLogs("Error: Player not found or already banned.")
        end
    end
})

-- Ban Hammer Tab
local BanHammerTab = Window:MakeTab({
    Name = "Ban Hammer",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

BanHammerTab:AddButton({
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
                    for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                            part.CanCollide = false
                        end
                    end
                    OrionLib:MakeNotification({
                        Name = "Ban Hammer",
                        Content = "Visually banned " .. targetPlayer.Name .. "!",
                        Image = "rbxassetid://4483345998",
                        Time = 5
                    })
                end
            end
        end)

        banHammer.Parent = backpack
        OrionLib:MakeNotification({
            Name = "Info",
            Content = "Ban Hammer added to your backpack!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

OrionLib:Init()
