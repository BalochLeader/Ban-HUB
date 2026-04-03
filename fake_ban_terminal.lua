--[[
    ROBLOX BAN TERMINAL (v4.0)
    Developer: @uginkbhai
    Repository: Ban-HUB
    
    Description: A highly realistic ban terminal for Roblox with advanced features.
    Features:
    - Professional Hacking Terminal Style GUI with functional Minimize/Maximize
    - Key System: 'diwas' to activate, kicks user on wrong key
    - Player Selection List
    - Detailed Injection & Firewall Bypass Messages with 1-2 minute delay
    - "BANNED" overhead text above target player
    - Custom Ban Reason: "Destroyed By Uginkbhai"
    - Global Announcement: "Uginkbhai Banned Player {player username}"
    - Character Disappear Animation
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local ACCESS_KEY = "diwas"
local BAN_DELAY_SECONDS = 90 -- 1.5 minutes

-- Create a RemoteEvent for global announcements (if not already existing)
local AnnounceEvent = ReplicatedStorage:FindFirstChild("BanHubAnnounce")
if not AnnounceEvent then
    AnnounceEvent = Instance.new("RemoteEvent")
    AnnounceEvent.Name = "BanHubAnnounce"
    AnnounceEvent.Parent = ReplicatedStorage
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BanHubTerminal"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Key Input Frame
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 300, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyFrame.BorderSizePixel = 2
KeyFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
KeyFrame.Parent = ScreenGui

local KeyLabel = Instance.new("TextLabel")
KeyLabel.Size = UDim2.new(1, 0, 0.3, 0)
KeyLabel.BackgroundTransparency = 1
KeyLabel.Text = "ENTER ACCESS KEY"
KeyLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
KeyLabel.Font = Enum.Font.Code
KeyLabel.TextSize = 20
KeyLabel.Parent = KeyFrame

local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(0.8, 0, 0.2, 0)
KeyTextBox.Position = UDim2.new(0.5, -KeyTextBox.Size.X.Offset/2, 0.5, -KeyTextBox.Size.Y.Offset/2)
KeyTextBox.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
KeyTextBox.BorderSizePixel = 1
KeyTextBox.BorderColor3 = Color3.fromRGB(0, 150, 0)
KeyTextBox.TextColor3 = Color3.fromRGB(0, 255, 0)
KeyTextBox.Font = Enum.Font.Code
KeyTextBox.TextSize = 16
KeyTextBox.TextXAlignment = Enum.TextXAlignment.Center
KeyTextBox.PlaceholderText = "Key..."
KeyTextBox.Parent = KeyFrame

local SubmitKeyButton = Instance.new("TextButton")
SubmitKeyButton.Size = UDim2.new(0.4, 0, 0.2, 0)
SubmitKeyButton.Position = UDim2.new(0.5, -SubmitKeyButton.Size.X.Offset/2, 0.75, 0)
SubmitKeyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
SubmitKeyButton.Text = "SUBMIT"
SubmitKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitKeyButton.Font = Enum.Font.Code
SubmitKeyButton.TextSize = 16
SubmitKeyButton.Parent = KeyFrame

local InvalidKeyLabel = Instance.new("TextLabel")
InvalidKeyLabel.Size = UDim2.new(1, 0, 0.2, 0)
InvalidKeyLabel.Position = UDim2.new(0, 0, 0.9, 0)
InvalidKeyLabel.BackgroundTransparency = 1
InvalidKeyLabel.Text = ""
InvalidKeyLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
InvalidKeyLabel.Font = Enum.Font.Code
InvalidKeyLabel.TextSize = 14
InvalidKeyLabel.Parent = KeyFrame

-- Main Terminal Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 450)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Hidden until key is entered
MainFrame.Parent = ScreenGui

-- UI Corner for rounded edges
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -100, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BAN-HUB TERMINAL v4.0 | Dev: @uginkbhai"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextSize = 16
TitleLabel.Parent = TitleBar

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 1, 0)
MinimizeButton.Position = UDim2.new(1, -90, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.Code
MinimizeButton.TextSize = 18
MinimizeButton.Parent = TitleBar
MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Maximize Button (Toggle visibility)
local MaximizeButton = Instance.new("TextButton")
MaximizeButton.Size = UDim2.new(0, 30, 1, 0)
MaximizeButton.Position = UDim2.new(1, -60, 0, 0)
MaximizeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
MaximizeButton.Text = "[]"
MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeButton.Font = Enum.Font.Code
MaximizeButton.TextSize = 18
MaximizeButton.Parent = TitleBar
MaximizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
end)

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Code
CloseButton.TextSize = 18
CloseButton.Parent = TitleBar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Terminal Output Area
local TerminalOutput = Instance.new("ScrollingFrame")
TerminalOutput.Name = "TerminalOutput"
TerminalOutput.Size = UDim2.new(1, -20, 0.6, 0)
TerminalOutput.Position = UDim2.new(0, 10, 0, 40)
TerminalOutput.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
TerminalOutput.BorderSizePixel = 1
TerminalOutput.BorderColor3 = Color3.fromRGB(0, 100, 0)
TerminalOutput.ScrollBarThickness = 6
TerminalOutput.CanvasSize = UDim2.new(0, 0, 0, 0)
TerminalOutput.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 4)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
UIListLayout.Parent = TerminalOutput

local function addLog(text, color, delay)
    local log = Instance.new("TextLabel")
    log.Size = UDim2.new(1, 0, 0, 20)
    log.BackgroundTransparency = 1
    log.Text = "> " .. text
    log.TextColor3 = color or Color3.fromRGB(0, 255, 0)
    log.TextXAlignment = Enum.TextXAlignment.Left
    log.Font = Enum.Font.Code
    log.TextSize = 14
    log.Parent = TerminalOutput
    TerminalOutput.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    TerminalOutput.CanvasPosition = Vector2.new(0, UIListLayout.AbsoluteContentSize.Y)
    if delay then wait(delay) end
end

-- Player Selection Area
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Name = "PlayerListFrame"
PlayerListFrame.Size = UDim2.new(1, -20, 0.25, 0)
PlayerListFrame.Position = UDim2.new(0, 10, 0.65, 10)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
PlayerListFrame.BorderSizePixel = 1
PlayerListFrame.BorderColor3 = Color3.fromRGB(0, 150, 0)
PlayerListFrame.Parent = MainFrame

local PlayerListLabel = Instance.new("TextLabel")
PlayerListLabel.Size = UDim2.new(1, 0, 0, 20)
PlayerListLabel.BackgroundTransparency = 1
PlayerListLabel.Text = "-- SELECT TARGET PLAYER --"
PlayerListLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
PlayerListLabel.Font = Enum.Font.Code
PlayerListLabel.TextSize = 14
PlayerListLabel.Parent = PlayerListFrame

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Name = "PlayerList"
PlayerList.Size = UDim2.new(1, 0, 1, -20)
PlayerList.Position = UDim2.new(0, 0, 0, 20)
PlayerList.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 6
PlayerList.Parent = PlayerListFrame

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Padding = UDim.new(0, 2)
PlayerListLayout.FillDirection = Enum.FillDirection.Vertical
PlayerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
PlayerListLayout.Parent = PlayerList

local function updatePlayerList()
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 25)
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            btn.Text = player.Name
            btn.TextColor3 = Color3.fromRGB(0, 255, 0)
            btn.Font = Enum.Font.Code
            btn.TextSize = 14
            btn.Parent = PlayerList
            
            btn.MouseButton1Click:Connect(function()
                startFakeBan(player)
            end)
        end
    end
end

-- Global Announcement Listener (for other clients running the script)
AnnounceEvent.OnClientEvent:Connect(function(bannedPlayerName)
    local chatService = game:GetService("Chat")
    if chatService then
        chatService:Chat(LocalPlayer.Character.Head, "Uginkbhai Banned Player " .. bannedPlayerName, Enum.ChatColor.Red)
    end
end)

-- Fake Ban Logic
function startFakeBan(targetPlayer)
    MainFrame.Visible = false -- Hide terminal during ban process
    addLog("Target Selected: " .. targetPlayer.Name, Color3.fromRGB(255, 255, 0), 0.5)
    addLog("Initiating secure connection to Roblox servers...", Color3.fromRGB(0, 255, 255), 1)
    addLog("Bypassing anti-cheat systems... [█████-----] 50%", Color3.fromRGB(0, 255, 255), 1.5)
    addLog("Injecting advanced exploit payload...", Color3.fromRGB(255, 0, 0), 1)
    addLog("Establishing root access... [████████--] 80%", Color3.fromRGB(255, 0, 0), 1.5)
    addLog("Firewall penetration successful. Access granted.", Color3.fromRGB(255, 0, 255), 1)
    addLog("Analyzing player data for vulnerabilities...", Color3.fromRGB(255, 165, 0), 1.2)
    addLog("Compiling ban command for " .. targetPlayer.Name .. "...", Color3.fromRGB(255, 165, 0), 1.5)
    addLog("Executing BAN command in " .. BAN_DELAY_SECONDS .. " seconds...", Color3.fromRGB(255, 255, 0), 1)
    
    -- 1-2 minute delay with more logs
    for i = 1, BAN_DELAY_SECONDS / 10 do -- Log every 10 seconds
        addLog("Processing... " .. (BAN_DELAY_SECONDS - i*10) .. " seconds remaining.", Color3.fromRGB(0, 200, 0), 10)
    end
    
    addLog("Finalizing ban sequence...", Color3.fromRGB(255, 0, 0), 1)
    addLog("BAN COMMAND EXECUTED.", Color3.fromRGB(255, 0, 0), 0.5)
    
    -- Overhead "BANNED" text
    if targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
        local head = targetPlayer.Character.Head
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.AdornGuiToPart = head
        billboardGui.AlwaysOnTop = true
        billboardGui.ExtentsOffset = Vector3.new(0, 2, 0)
        billboardGui.Parent = head
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "BANNED"
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.Font = Enum.Font.Code
        textLabel.TextSize = 30
        textLabel.TextScaled = true
        textLabel.Parent = billboardGui
        
        game:GetService("Debris"):AddItem(billboardGui, 5) -- Remove after 5 seconds
    end

    -- Character Disappear Animation
    if targetPlayer.Character then
        for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
                TweenService:Create(part, TweenInfo.new(1.5), {Transparency = 1}):Play()
            end
        end
        
        -- Particle Effect
        local p = Instance.new("Part")
        p.Anchored = true
        p.CanCollide = false
        p.Transparency = 1
        p.Position = targetPlayer.Character:GetPrimaryPartCFrame().Position
        p.Parent = workspace
        
        local attachment = Instance.new("Attachment", p)
        local particles = Instance.new("ParticleEmitter", attachment)
        particles.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 100, 0))
        particles.Size = NumberSequence.new(0.5, 0)
        particles.Rate = 100
        particles.Lifetime = NumberRange.new(1, 2)
        particles.Speed = NumberRange.new(5, 10)
        particles.SpreadAngle = Vector2.new(0, 360)
        particles.EmissionDirection = Enum.ParticleEmissionDirection.Outward
        
        wait(1.5)
        particles.Enabled = false
        game:GetService("Debris"):AddItem(p, 2)
        
        -- Hide Character locally
        targetPlayer.Character.Parent = nil
    end
    
    addLog("PLAYER " .. targetPlayer.Name .. " HAS BEEN BANNED.", Color3.fromRGB(255, 0, 0), 0.5)
    
    -- Global Announcement (local client triggers this)
    AnnounceEvent:FireServer(targetPlayer.Name)

    -- Show Fake Ban Banner
    local Banner = Instance.new("Frame")
    Banner.Size = UDim2.new(0, 500, 0, 200)
    Banner.Position = UDim2.new(0.5, -250, 0.2, 0)
    Banner.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Banner.BorderSizePixel = 3
    Banner.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Banner.Parent = ScreenGui
    
    local BannerText = Instance.new("TextLabel")
    BannerText.Size = UDim2.new(1, 0, 1, 0)
    BannerText.BackgroundTransparency = 1
    BannerText.Text = "SYSTEM NOTIFICATION\n\nPlayer " .. targetPlayer.Name .. " has been banned from the server.\nReason: Destroyed By Uginkbhai\n\n[ BAN-HUB BY @uginkbhai ]"
    BannerText.TextColor3 = Color3.fromRGB(255, 255, 255)
    BannerText.Font = Enum.Font.Code
    BannerText.TextSize = 20
    BannerText.TextWrapped = true
    BannerText.Parent = Banner
    
    wait(5)
    Banner:Destroy()
    MainFrame.Visible = true -- Show terminal again
end

-- Initial Setup
-- Intro Sequence
local IntroLabel = Instance.new("TextLabel")
IntroLabel.Size = UDim2.new(1, 0, 1, 0)
IntroLabel.BackgroundTransparency = 1
IntroLabel.Text = "Made By @uginkbhai"
IntroLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
IntroLabel.Font = Enum.Font.Code
IntroLabel.TextSize = 30
IntroLabel.Parent = ScreenGui
wait(3)
IntroLabel:Destroy()

KeyFrame.Visible = true

SubmitKeyButton.MouseButton1Click:Connect(function()
    if KeyTextBox.Text == ACCESS_KEY then
        KeyFrame.Visible = false
        MainFrame.Visible = true
        addLog("Connecting to secure database...", Color3.fromRGB(0, 255, 255), 1)
        addLog("Database connection established. Authenticating...", Color3.fromRGB(0, 255, 0), 1)
        addLog("Authentication successful. Loading terminal...", Color3.fromRGB(0, 255, 0), 1)
        addLog("BAN-HUB TERMINAL LOADED.", Color3.fromRGB(0, 255, 0), 0.5)
        addLog("Waiting for target selection...", Color3.fromRGB(200, 200, 200), 0.5)
        updatePlayerList()
    else
        InvalidKeyLabel.Text = "INVALID KEY! KICKING..."
        wait(2)
        LocalPlayer:Kick("Invalid Access Key. Connection Terminated.")
    end
end)

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Toggle Key (Insert)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        if MainFrame.Visible then
            MainFrame.Visible = false
        elseif not KeyFrame.Visible then -- Only show if key is already entered
            MainFrame.Visible = true
        end
    end
end)

-- Server-side part for global announcement (This part needs to be in a Server Script)
-- This client script will fire the event, and a server script will handle the announcement.
-- To make it truly global, a server script is required to listen to AnnounceEvent.OnServerEvent
-- and then use game:GetService("Chat"):Chat() to all players.

-- Example Server Script (place in ServerScriptService):
-- local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local AnnounceEvent = ReplicatedStorage:FindFirstChild("BanHubAnnounce")
-- if AnnounceEvent then
--     AnnounceEvent.OnServerEvent:Connect(function(player, bannedPlayerName)
--         for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
--             game:GetService("Chat"):Chat(p.Character.Head, "Uginkbhai Banned Player " .. bannedPlayerName, Enum.ChatColor.Red)
--         end
--     end)
-- end
