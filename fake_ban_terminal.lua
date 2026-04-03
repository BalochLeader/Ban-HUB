--[[
    FAKE VISUAL BAN BANNER SCRIPT (TERMINAL EDITION)
    Developer: @uginkbhai
    Repository: Ban-HUB
    
    Description: A high-quality fake visual ban script for Roblox.
    Features:
    - Hacking Terminal Style GUI
    - Player Selection List
    - Fake Injection & Firewall Bypass Messages
    - Character Disappear Animation (Visual Only)
    - Realistic Ban Banner
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BanHubTerminal"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Terminal Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -10, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BAN-HUB TERMINAL v2.0 | Dev: @uginkbhai"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextSize = 14
TitleLabel.Parent = TitleBar

-- Terminal Output Area
local TerminalOutput = Instance.new("ScrollingFrame")
TerminalOutput.Name = "TerminalOutput"
TerminalOutput.Size = UDim2.new(1, -20, 0.6, 0)
TerminalOutput.Position = UDim2.new(0, 10, 0, 35)
TerminalOutput.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
TerminalOutput.BorderSizePixel = 1
TerminalOutput.BorderColor3 = Color3.fromRGB(0, 100, 0)
TerminalOutput.ScrollBarThickness = 4
TerminalOutput.CanvasSize = UDim2.new(0, 0, 0, 0)
TerminalOutput.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = TerminalOutput

local function addLog(text, color)
    local log = Instance.new("TextLabel")
    log.Size = UDim2.new(1, 0, 0, 18)
    log.BackgroundTransparency = 1
    log.Text = "> " .. text
    log.TextColor3 = color or Color3.fromRGB(0, 255, 0)
    log.Font = Enum.Font.Code
    log.TextSize = 14
    log.TextXAlignment = Enum.TextXAlignment.Left
    log.Parent = TerminalOutput
    TerminalOutput.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    TerminalOutput.CanvasPosition = Vector2.new(0, UIListLayout.AbsoluteContentSize.Y)
end

-- Player Selection Area
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Name = "PlayerList"
PlayerList.Size = UDim2.new(1, -20, 0.25, 0)
PlayerList.Position = UDim2.new(0, 10, 0.65, 10)
PlayerList.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
PlayerList.BorderSizePixel = 1
PlayerList.BorderColor3 = Color3.fromRGB(0, 150, 0)
PlayerList.ScrollBarThickness = 4
PlayerList.Parent = MainFrame

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Parent = PlayerList

local function updatePlayerList()
    for _, child in ipairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 25)
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

-- Fake Ban Logic
function startFakeBan(targetPlayer)
    MainFrame.Visible = true
    addLog("Target Selected: " .. targetPlayer.Name, Color3.fromRGB(255, 255, 0))
    wait(0.5)
    addLog("Initializing Injection Protocol...", Color3.fromRGB(0, 255, 255))
    wait(1)
    addLog("Hacking Roblox Servers...", Color3.fromRGB(255, 0, 0))
    wait(1.2)
    addLog("Bypassing Firewall...", Color3.fromRGB(255, 0, 255))
    wait(0.8)
    addLog("Injecting Malicious Code into " .. targetPlayer.Name .. "'s Client...", Color3.fromRGB(255, 165, 0))
    wait(1.5)
    addLog("SUCCESS: Connection Established.", Color3.fromRGB(0, 255, 0))
    wait(0.5)
    addLog("Executing BAN Command...", Color3.fromRGB(255, 0, 0))
    
    -- Visual Disappear Animation
    if targetPlayer.Character then
        for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
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
        particles.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
        particles.Size = NumberSequence.new(0.5, 0)
        particles.Rate = 100
        particles.Lifetime = NumberRange.new(1, 2)
        particles.Speed = NumberRange.new(5, 10)
        particles.SpreadAngle = Vector2.new(0, 360)
        
        wait(1.5)
        particles.Enabled = false
        game:GetService("Debris"):AddItem(p, 2)
        
        -- Hide Character locally
        targetPlayer.Character.Parent = nil
    end
    
    addLog("PLAYER " .. targetPlayer.Name .. " HAS BEEN VISUALLY BANNED.", Color3.fromRGB(255, 0, 0))
    
    -- Show Fake Ban Banner
    local Banner = Instance.new("Frame")
    Banner.Size = UDim2.new(0, 400, 0, 150)
    Banner.Position = UDim2.new(0.5, -200, 0.2, 0)
    Banner.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Banner.BorderSizePixel = 3
    Banner.BorderColor3 = Color3.fromRGB(255, 0, 0)
    Banner.Parent = ScreenGui
    
    local BannerText = Instance.new("TextLabel")
    BannerText.Size = UDim2.new(1, 0, 1, 0)
    BannerText.BackgroundTransparency = 1
    BannerText.Text = "SYSTEM NOTIFICATION\n\nPlayer " .. targetPlayer.Name .. " has been banned from the server.\nReason: Exploiting/Hacking\n\n[ BAN-HUB BY @uginkbhai ]"
    BannerText.TextColor3 = Color3.fromRGB(255, 255, 255)
    BannerText.Font = Enum.Font.SourceSansBold
    BannerText.TextSize = 18
    BannerText.Parent = Banner
    
    wait(5)
    Banner:Destroy()
end

-- Initial Setup
addLog("BAN-HUB TERMINAL LOADED.", Color3.fromRGB(0, 255, 0))
addLog("Waiting for user input...", Color3.fromRGB(200, 200, 200))
updatePlayerList()

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

-- Toggle Key (Insert)
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
