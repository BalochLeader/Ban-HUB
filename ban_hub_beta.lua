--[[
    Ban Hub [BETA]
    Created by: @uginkbhai
    Theme: Fire & Hacker (Black/Neon Orange)
    Type: Client-Side Visual Admin Tool
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Constants
local THEME_COLOR = Color3.fromRGB(255, 100, 0) -- Neon Orange
local BG_COLOR = Color3.fromRGB(15, 15, 15) -- Black
local KEY = "diwas"

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BanHubBeta"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

-- Key System
local function CreateKeySystem()
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Size = UDim2.new(0, 300, 0, 150)
    KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    KeyFrame.BackgroundColor3 = BG_COLOR
    KeyFrame.BorderSizePixel = 2
    KeyFrame.BorderColor3 = THEME_COLOR
    KeyFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = "Ban Hub [BETA] - Login"
    Title.TextColor3 = THEME_COLOR
    Title.TextSize = 18
    Title.Font = Enum.Font.Code
    Title.Parent = KeyFrame

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
    KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0)
    KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.PlaceholderText = "Enter Key..."
    KeyInput.Text = ""
    KeyInput.Parent = KeyFrame

    local Submit = Instance.new("TextButton")
    Submit.Size = UDim2.new(0.4, 0, 0, 30)
    Submit.Position = UDim2.new(0.3, 0, 0.7, 0)
    Submit.BackgroundColor3 = THEME_COLOR
    Submit.Text = "Login"
    Submit.TextColor3 = BG_COLOR
    Submit.Font = Enum.Font.Code
    Submit.Parent = KeyFrame

    Submit.MouseButton1Click:Connect(function()
        if KeyInput.Text == KEY then
            KeyFrame:Destroy()
            MainUI()
        else
            LocalPlayer:Kick("Enter Real Key Made By Uginkbhai")
        end
    end)
end

-- Main UI Function
function MainUI()
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = BG_COLOR
    MainFrame.BorderSizePixel = 2
    MainFrame.BorderColor3 = THEME_COLOR
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Ban Hub [BETA] | @uginkbhai"
    Title.TextColor3 = THEME_COLOR
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.Code
    Title.TextSize = 16
    Title.Parent = TitleBar

    -- Buttons (Close, Max, Min)
    local function CreateControlBtn(text, pos, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 25, 0, 25)
        btn.Position = pos
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.Text = text
        btn.TextColor3 = color
        btn.BorderSizePixel = 0
        btn.Parent = TitleBar
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    CreateControlBtn("X", UDim2.new(1, -30, 0, 2), Color3.fromRGB(255, 50, 50), function() ScreenGui:Destroy() end)
    CreateControlBtn("▢", UDim2.new(1, -60, 0, 2), Color3.fromRGB(255, 255, 255), function() end)
    CreateControlBtn("—", UDim2.new(1, -90, 0, 2), Color3.fromRGB(255, 255, 255), function() 
        MainFrame.Visible = not MainFrame.Visible 
    end)

    -- System Log
    local LogFrame = Instance.new("ScrollingFrame")
    LogFrame.Size = UDim2.new(1, -20, 0, 80)
    LogFrame.Position = UDim2.new(0, 10, 1, -90)
    LogFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    LogFrame.BorderSizePixel = 1
    LogFrame.BorderColor3 = THEME_COLOR
    LogFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    LogFrame.ScrollBarThickness = 4
    LogFrame.Parent = MainFrame

    local LogList = Instance.new("UIListLayout")
    LogList.Parent = LogFrame

    local function AddLog(text)
        task.spawn(function()
            local log = Instance.new("TextLabel")
            log.Size = UDim2.new(1, 0, 0, 20)
            log.BackgroundTransparency = 1
            log.Text = "> " .. text
            log.TextColor3 = THEME_COLOR
            log.TextSize = 14
            log.Font = Enum.Font.Code
            log.TextXAlignment = Enum.TextXAlignment.Left
            log.Parent = LogFrame
            LogFrame.CanvasSize = UDim2.new(0, 0, 0, LogList.AbsoluteContentSize.Y)
            LogFrame.CanvasPosition = Vector2.new(0, LogList.AbsoluteContentSize.Y)
        end)
    end

    -- Initial Logs
    AddLog("Initializing Ban Hub [BETA]...")
    task.wait(0.5)
    AddLog("Bypassing Admin...")
    task.wait(0.8)
    AddLog("Connecting to Database...")
    task.wait(1)
    AddLog("Welcome, @uginkbhai")

    -- Tabs/Content Area
    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, -20, 1, -130)
    Content.Position = UDim2.new(0, 10, 0, 40)
    Content.BackgroundTransparency = 1
    Content.Parent = MainFrame

    -- Tab System
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(0, 100, 1, -130)
    TabFrame.Position = UDim2.new(0, 0, 0, 40)
    TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabFrame.BorderSizePixel = 1
    TabFrame.BorderColor3 = THEME_COLOR
    TabFrame.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.FillDirection = Enum.FillDirection.Vertical
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.Parent = TabFrame

    local CurrentTabContent = nil

    local function CreateTab(name, contentCreator)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.BorderSizePixel = 1
        TabButton.BorderColor3 = THEME_COLOR
        TabButton.Text = name
        TabButton.TextColor3 = THEME_COLOR
        TabButton.Font = Enum.Font.Code
        TabButton.TextSize = 14
        TabButton.Parent = TabFrame

        TabButton.MouseButton1Click:Connect(function()
            if CurrentTabContent then
                CurrentTabContent:Destroy()
            end
            CurrentTabContent = contentCreator()
            CurrentTabContent.Parent = Content
        end)
        return TabButton
    end

    -- Content Area for Tabs
    Content.Size = UDim2.new(1, -120, 1, -130)
    Content.Position = UDim2.new(0, 110, 0, 40)
    Content.BackgroundTransparency = 1
    Content.Parent = MainFrame

    -- Tab Content Frames
    local function CreateBanModerationTab()
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.BackgroundTransparency = 1
        local Grid = Instance.new("UIGridLayout")
        Grid.CellSize = UDim2.new(0, 150, 0, 40)
        Grid.CellPadding = UDim2.new(0, 10, 0, 10)
        Grid.Parent = Frame

        -- #BanHammer
        local BanHammerBtn = Instance.new("TextButton")
        BanHammerBtn.Size = UDim2.new(0, 150, 0, 40)
        BanHammerBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        BanHammerBtn.BorderSizePixel = 1
        BanHammerBtn.BorderColor3 = THEME_COLOR
        BanHammerBtn.Text = "#BanHammer"
        BanHammerBtn.TextColor3 = THEME_COLOR
        BanHammerBtn.Font = Enum.Font.Code
        BanHammerBtn.TextSize = 14
        BanHammerBtn.Parent = Frame
        BanHammerBtn.MouseButton1Click:Connect(function()
            AddLog("Equipping Ban Hammer...")
            local Hammer = Instance.new("Tool")
            Hammer.Name = "Ban Hammer"
            Hammer.RequiresHandle = true
            local Handle = Instance.new("Part")
            Handle.Name = "Handle"
            Handle.Size = Vector3.new(1, 4, 1)
            Handle.Color = THEME_COLOR
            Handle.Parent = Hammer
            Hammer.Parent = LocalPlayer.Backpack

            Hammer.Activated:Connect(function()
                local target = Mouse.Target
                if target and target.Parent:FindFirstChild("Humanoid") then
                    local char = target.Parent
                    AddLog("Banning " .. char.Name .. "...")
                    char:SetAttribute("Banned", true)
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("BasePart") or v:IsA("Decal") then
                            v.Transparency = 1
                        end
                    end
                    -- Fake Notification
                    local Notif = Instance.new("TextLabel")
                    Notif.Size = UDim2.new(0, 300, 0, 50)
                    Notif.Position = UDim2.new(0.5, -150, 0.2, 0)
                    Notif.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    Notif.Text = "USER BANNED: " .. char.Name
                    Notif.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Notif.Font = Enum.Font.Code
                    Notif.TextSize = 20
                    Notif.Parent = ScreenGui

                    -- Red overlay effect
                    local Overlay = Instance.new("Frame")
                    Overlay.Size = UDim2.new(1, 0, 1, 0)
                    Overlay.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    Overlay.BackgroundTransparency = 0.8
                    Overlay.ZIndex = 10
                    Overlay.Parent = ScreenGui

                    task.wait(0.1)
                    TweenService:Create(Overlay, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.0}):Play()
                    task.wait(1)
                    TweenService:Create(Overlay, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 0.8}):Play()
                    task.wait(0.5)
                    Overlay:Destroy()

                    Notif:Destroy()
                end
            end)
        end)

        -- #PlayerBanner
        local PlayerBannerBtn = Instance.new("TextButton")
        PlayerBannerBtn.Size = UDim2.new(0, 150, 0, 40)
        PlayerBannerBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        PlayerBannerBtn.BorderSizePixel = 1
        PlayerBannerBtn.BorderColor3 = THEME_COLOR
        PlayerBannerBtn.Text = "#PlayerBanner"
        PlayerBannerBtn.TextColor3 = THEME_COLOR
        PlayerBannerBtn.Font = Enum.Font.Code
        PlayerBannerBtn.TextSize = 14
        PlayerBannerBtn.Parent = Frame
        PlayerBannerBtn.MouseButton1Click:Connect(function()
            local BanFrame = Instance.new("Frame")
            BanFrame.Size = UDim2.new(0, 300, 0, 200)
            BanFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
            BanFrame.BackgroundColor3 = BG_COLOR
            BanFrame.BorderSizePixel = 2
            BanFrame.BorderColor3 = THEME_COLOR
            BanFrame.Parent = ScreenGui

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, 0, 0, 30)
            Title.BackgroundTransparency = 1
            Title.Text = "Player Ban System"
            Title.TextColor3 = THEME_COLOR
            Title.TextSize = 18
            Title.Font = Enum.Font.Code
            Title.Parent = BanFrame

            local Input = Instance.new("TextBox")
            Input.Size = UDim2.new(0.8, 0, 0, 30)
            Input.Position = UDim2.new(0.1, 0, 0.2, 0)
            Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Input.TextColor3 = Color3.fromRGB(255, 255, 255)
            Input.PlaceholderText = "Username..."
            Input.Text = ""
            Input.Parent = BanFrame

            local ReasonInput = Instance.new("TextBox")
            ReasonInput.Size = UDim2.new(0.8, 0, 0, 30)
            ReasonInput.Position = UDim2.new(0.1, 0, 0.4, 0)
            ReasonInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            ReasonInput.TextColor3 = Color3.fromRGB(255, 255, 255)
            ReasonInput.PlaceholderText = "Reason (Optional)..."
            ReasonInput.Text = ""
            ReasonInput.Parent = BanFrame

            local BanBtn = Instance.new("TextButton")
            BanBtn.Size = UDim2.new(0.4, 0, 0, 30)
            BanBtn.Position = UDim2.new(0.3, 0, 0.7, 0)
            BanBtn.BackgroundColor3 = THEME_COLOR
            BanBtn.Text = "Ban Player"
            BanBtn.TextColor3 = BG_COLOR
            BanBtn.Font = Enum.Font.Code
            BanBtn.Parent = BanFrame

            BanBtn.MouseButton1Click:Connect(function()
                local name = Input.Text
                local reason = ReasonInput.Text
                if name == "" then return end
                BanFrame:Destroy()
                AddLog("Initiating ban sequence for " .. name .. (reason ~= "" and " (Reason: " .. reason .. ")" or "") .. "...")
                local Bar = Instance.new("Frame")
                Bar.Size = UDim2.new(0, 0, 0, 10)
                Bar.Position = UDim2.new(0.5, -100, 0.8, 0)
                Bar.BackgroundColor3 = THEME_COLOR
                Bar.Parent = ScreenGui
                local BarBG = Instance.new("Frame")
                BarBG.Size = UDim2.new(0, 200, 0, 10)
                BarBG.Position = UDim2.new(0.5, -100, 0.8, 0)
                BarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                BarBG.ZIndex = 0
                BarBG.Parent = ScreenGui
                
                TweenService:Create(Bar, TweenInfo.new(3), {Size = UDim2.new(0, 200, 0, 10)}):Play()
                task.wait(3)
                Bar:Destroy()
                BarBG:Destroy()
                AddLog("Ban request for " .. name .. " processed. Status: Success.")
                local FakeChatMsg = "[SYSTEM]: " .. name .. " has been permanently removed from the game by Admin @uginkbhai."
                if reason ~= "" then
                    FakeChatMsg = FakeChatMsg .. " Reason: " .. reason .. "."
                end
                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                    Text = FakeChatMsg,
                    Color = Color3.fromRGB(255, 0, 0),
                    Font = Enum.Font.SourceSansBold,
                    FontSize = Enum.FontSize.Size18
                })
            end)
        end)

        -- #GlobalChat
        local GlobalChatBtn = Instance.new("TextButton")
        GlobalChatBtn.Size = UDim2.new(0, 150, 0, 40)
        GlobalChatBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        GlobalChatBtn.BorderSizePixel = 1
        GlobalChatBtn.BorderColor3 = THEME_COLOR
        GlobalChatBtn.Text = "#GlobalChat"
        GlobalChatBtn.TextColor3 = THEME_COLOR
        GlobalChatBtn.Font = Enum.Font.Code
        GlobalChatBtn.TextSize = 14
        GlobalChatBtn.Parent = Frame
        GlobalChatBtn.MouseButton1Click:Connect(function()
            local ChatFrame = Instance.new("Frame")
            ChatFrame.Size = UDim2.new(0, 300, 0, 150)
            ChatFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
            ChatFrame.BackgroundColor3 = BG_COLOR
            ChatFrame.BorderSizePixel = 2
            ChatFrame.BorderColor3 = THEME_COLOR
            ChatFrame.Parent = ScreenGui

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, 0, 0, 30)
            Title.BackgroundTransparency = 1
            Title.Text = "Send System Message"
            Title.TextColor3 = THEME_COLOR
            Title.TextSize = 18
            Title.Font = Enum.Font.Code
            Title.Parent = ChatFrame

            local MessageInput = Instance.new("TextBox")
            MessageInput.Size = UDim2.new(0.8, 0, 0, 30)
            MessageInput.Position = UDim2.new(0.1, 0, 0.4, 0)
            MessageInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            MessageInput.TextColor3 = Color3.fromRGB(255, 255, 255)
            MessageInput.PlaceholderText = "System message..."
            MessageInput.Text = ""
            MessageInput.Parent = ChatFrame

            local SendBtn = Instance.new("TextButton")
            SendBtn.Size = UDim2.new(0.4, 0, 0, 30)
            SendBtn.Position = UDim2.new(0.3, 0, 0.7, 0)
            SendBtn.BackgroundColor3 = THEME_COLOR
            SendBtn.Text = "Send"
            SendBtn.TextColor3 = BG_COLOR
            SendBtn.Font = Enum.Font.Code
            SendBtn.Parent = ChatFrame

            SendBtn.MouseButton1Click:Connect(function()
                local msg = MessageInput.Text
                if msg == "" then return end
                ChatFrame:Destroy()
                local function FakeChat(messageText)
                    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                        Text = messageText,
                        Color = Color3.fromRGB(255, 0, 0),
                        Font = Enum.Font.SourceSansBold,
                        FontSize = Enum.FontSize.Size18
                    })
                end
                FakeChat("[SYSTEM]: " .. msg)
                AddLog("Sent fake system message: " .. msg)
            end)
        end)
        -- Player List (Fake)
        local PlayerListFrame = Instance.new("Frame")
        PlayerListFrame.Size = UDim2.new(1, 0, 0.5, 0)
        PlayerListFrame.Position = UDim2.new(0, 0, 0.5, 0)
        PlayerListFrame.BackgroundTransparency = 1
        PlayerListFrame.Parent = Frame

        local PlayerListLabel = Instance.new("TextLabel")
        PlayerListLabel.Size = UDim2.new(1, 0, 0, 20)
        PlayerListLabel.BackgroundTransparency = 1
        PlayerListLabel.Text = "Online Players (Fake)"
        PlayerListLabel.TextColor3 = THEME_COLOR
        PlayerListLabel.TextSize = 16
        PlayerListLabel.Font = Enum.Font.Code
        PlayerListLabel.Parent = PlayerListFrame

        local PlayerScrollingFrame = Instance.new("ScrollingFrame")
        PlayerScrollingFrame.Size = UDim2.new(1, 0, 1, -20)
        PlayerScrollingFrame.Position = UDim2.new(0, 0, 0, 20)
        PlayerScrollingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        PlayerScrollingFrame.BorderSizePixel = 1
        PlayerScrollingFrame.BorderColor3 = THEME_COLOR
        PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        PlayerScrollingFrame.ScrollBarThickness = 4
        PlayerScrollingFrame.Parent = PlayerListFrame

        local PlayerListLayout = Instance.new("UIListLayout")
        PlayerListLayout.Parent = PlayerScrollingFrame

        local function AddFakePlayer(name)
            local playerText = Instance.new("TextLabel")
            playerText.Size = UDim2.new(1, 0, 0, 20)
            playerText.BackgroundTransparency = 1
            playerText.Text = "- " .. name
            playerText.TextColor3 = Color3.fromRGB(200, 200, 200)
            playerText.TextSize = 14
            playerText.Font = Enum.Font.Code
            playerText.TextXAlignment = Enum.TextXAlignment.Left
            playerText.Parent = PlayerScrollingFrame
            PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
        end

        -- Populate with fake players
        AddFakePlayer("Guest_12345")
        AddFakePlayer("NoobMaster69")
        AddFakePlayer("ProGamerX")
        AddFakePlayer("Robloxian_Fan")
        AddFakePlayer("EpicPlayer777")
        AddFakePlayer("Admin_Bot")
        AddFakePlayer("ShadowHunter")
        AddFakePlayer("PixelKnight")
        AddFakePlayer("CodeWizard")
        AddFakePlayer("VirtualHero")



        return Frame
    end

    local function CreateAdminFeaturesTab()
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.BackgroundTransparency = 1
        local Grid = Instance.new("UIGridLayout")
        Grid.CellSize = UDim2.new(0, 150, 0, 40)
        Grid.CellPadding = UDim2.new(0, 10, 0, 10)
        Grid.Parent = Frame

        -- #VisualNuke
        local VisualNukeBtn = Instance.new("TextButton")
        VisualNukeBtn.Size = UDim2.new(0, 150, 0, 40)
        VisualNukeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        VisualNukeBtn.BorderSizePixel = 1
        VisualNukeBtn.BorderColor3 = THEME_COLOR
        VisualNukeBtn.Text = "#VisualNuke"
        VisualNukeBtn.TextColor3 = THEME_COLOR
        VisualNukeBtn.Font = Enum.Font.Code
        VisualNukeBtn.TextSize = 14
        VisualNukeBtn.Parent = Frame
        VisualNukeBtn.MouseButton1Click:Connect(function()
            AddLog("Initiating Visual Nuke...")
            task.spawn(function()
                for i = 1, 20 do
                    local shake = Vector3.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
                    LocalPlayer.Character.Humanoid.CameraOffset = shake
                    local exp = Instance.new("Explosion")
                    exp.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
                    exp.BlastRadius = 0
                    exp.Parent = workspace
                    task.wait(0.1)
                end
                LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
                AddLog("Server Crash Simulation Complete.")
            end)
        end)

        -- #EmotePanel
        local EmotePanelBtn = Instance.new("TextButton")
        EmotePanelBtn.Size = UDim2.new(0, 150, 0, 40)
        EmotePanelBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        EmotePanelBtn.BorderSizePixel = 1
        EmotePanelBtn.BorderColor3 = THEME_COLOR
        EmotePanelBtn.Text = "#EmotePanel"
        EmotePanelBtn.TextColor3 = THEME_COLOR
        EmotePanelBtn.Font = Enum.Font.Code
        EmotePanelBtn.TextSize = 14
        EmotePanelBtn.Parent = Frame
        EmotePanelBtn.MouseButton1Click:Connect(function()
            AddLog("Playing Random Animation...")
            local anims = {"3333499508", "3333272702", "3333432454", "507766846", "507766846", "507766846"} -- Added more animation IDs
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://" .. anims[math.random(1, #anims)]
            local load = LocalPlayer.Character.Humanoid:LoadAnimation(anim)
            load:Play()
            task.wait(load.Length)
            load:Stop()
            load:Destroy()
        end)

        -- #ForceField (New Feature)
        local ForceFieldBtn = Instance.new("TextButton")
        ForceFieldBtn.Size = UDim2.new(0, 150, 0, 40)
        ForceFieldBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ForceFieldBtn.BorderSizePixel = 1
        ForceFieldBtn.BorderColor3 = THEME_COLOR
        ForceFieldBtn.Text = "#ForceField"
        ForceFieldBtn.TextColor3 = THEME_COLOR
        ForceFieldBtn.Font = Enum.Font.Code
        ForceFieldBtn.TextSize = 14
        ForceFieldBtn.Parent = Frame
        ForceFieldBtn.MouseButton1Click:Connect(function()
            local ff = LocalPlayer.Character:FindFirstChildOfClass("ForceField")
            if ff then
                ff:Destroy()
                AddLog("ForceField Deactivated.")
            else
                Instance.new("ForceField", LocalPlayer.Character)
                AddLog("ForceField Activated.")
            end
        end)

        -- #GodMode (New Feature)
        local GodModeBtn = Instance.new("TextButton")
        GodModeBtn.Size = UDim2.new(0, 150, 0, 40)
        GodModeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        GodModeBtn.BorderSizePixel = 1
        GodModeBtn.BorderColor3 = THEME_COLOR
        GodModeBtn.Text = "#GodMode"
        GodModeBtn.TextColor3 = THEME_COLOR
        GodModeBtn.Font = Enum.Font.Code
        GodModeBtn.TextSize = 14
        GodModeBtn.Parent = Frame
        GodModeBtn.MouseButton1Click:Connect(function()
            LocalPlayer.Character.Humanoid.MaxHealth = math.huge
            LocalPlayer.Character.Humanoid.Health = math.huge
            AddLog("GodMode Activated.")
        end)

        -- Player List (Fake)
        local PlayerListFrame = Instance.new("Frame")
        PlayerListFrame.Size = UDim2.new(1, 0, 0.5, 0)
        PlayerListFrame.Position = UDim2.new(0, 0, 0.5, 0)
        PlayerListFrame.BackgroundTransparency = 1
        PlayerListFrame.Parent = Frame

        local PlayerListLabel = Instance.new("TextLabel")
        PlayerListLabel.Size = UDim2.new(1, 0, 0, 20)
        PlayerListLabel.BackgroundTransparency = 1
        PlayerListLabel.Text = "Online Players (Fake)"
        PlayerListLabel.TextColor3 = THEME_COLOR
        PlayerListLabel.TextSize = 16
        PlayerListLabel.Font = Enum.Font.Code
        PlayerListLabel.Parent = PlayerListFrame

        local PlayerScrollingFrame = Instance.new("ScrollingFrame")
        PlayerScrollingFrame.Size = UDim2.new(1, 0, 1, -20)
        PlayerScrollingFrame.Position = UDim2.new(0, 0, 0, 20)
        PlayerScrollingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        PlayerScrollingFrame.BorderSizePixel = 1
        PlayerScrollingFrame.BorderColor3 = THEME_COLOR
        PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        PlayerScrollingFrame.ScrollBarThickness = 4
        PlayerScrollingFrame.Parent = PlayerListFrame

        local PlayerListLayout = Instance.new("UIListLayout")
        PlayerListLayout.Parent = PlayerScrollingFrame

        local function AddFakePlayer(name)
            local playerText = Instance.new("TextLabel")
            playerText.Size = UDim2.new(1, 0, 0, 20)
            playerText.BackgroundTransparency = 1
            playerText.Text = "- " .. name
            playerText.TextColor3 = Color3.fromRGB(200, 200, 200)
            playerText.TextSize = 14
            playerText.Font = Enum.Font.Code
            playerText.TextXAlignment = Enum.TextXAlignment.Left
            playerText.Parent = PlayerScrollingFrame
            PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
        end

        -- Populate with fake players
        AddFakePlayer("Guest_12345")
        AddFakePlayer("NoobMaster69")
        AddFakePlayer("ProGamerX")
        AddFakePlayer("Robloxian_Fan")
        AddFakePlayer("EpicPlayer777")
        AddFakePlayer("Admin_Bot")
        AddFakePlayer("ShadowHunter")
        AddFakePlayer("PixelKnight")
        AddFakePlayer("CodeWizard")
        AddFakePlayer("VirtualHero")



        return Frame
    end

    local function CreateMovementTab()
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.BackgroundTransparency = 1
        local Grid = Instance.new("UIGridLayout")
        Grid.CellSize = UDim2.new(0, 150, 0, 40)
        Grid.CellPadding = UDim2.new(0, 10, 0, 10)
        Grid.Parent = Frame

        -- #GhostFly
        local flying = false
        local GhostFlyBtn = Instance.new("TextButton")
        GhostFlyBtn.Size = UDim2.new(0, 150, 0, 40)
        GhostFlyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        GhostFlyBtn.BorderSizePixel = 1
        GhostFlyBtn.BorderColor3 = THEME_COLOR
        GhostFlyBtn.Text = "#GhostFly"
        GhostFlyBtn.TextColor3 = THEME_COLOR
        GhostFlyBtn.Font = Enum.Font.Code
        GhostFlyBtn.TextSize = 14
        GhostFlyBtn.Parent = Frame
        GhostFlyBtn.MouseButton1Click:Connect(function()
            flying = not flying
            AddLog("GhostFly: " .. (flying and "ON" or "OFF"))
            if flying then
                local bv = Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 0, 0)
                bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bv.Parent = LocalPlayer.Character.HumanoidRootPart
                local bg = Instance.new("BodyGyro")
                bg.P = 9e4
                bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                bg.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                bg.Parent = LocalPlayer.Character.HumanoidRootPart
                
                task.spawn(function()
                    while flying do
                        RunService.RenderStepped:Wait()
                        local cam = workspace.CurrentCamera.CFrame
                        local move = Vector3.new(0, 0, 0)
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
                        bv.Velocity = move * 50
                        bg.CFrame = cam
                    end
                    bv:Destroy()
                    bg:Destroy()
                end)
            end
        end)
        -- Player List (Fake)
        local PlayerListFrame = Instance.new("Frame")
        PlayerListFrame.Size = UDim2.new(1, 0, 0.5, 0)
        PlayerListFrame.Position = UDim2.new(0, 0, 0.5, 0)
        PlayerListFrame.BackgroundTransparency = 1
        PlayerListFrame.Parent = Frame

        local PlayerListLabel = Instance.new("TextLabel")
        PlayerListLabel.Size = UDim2.new(1, 0, 0, 20)
        PlayerListLabel.BackgroundTransparency = 1
        PlayerListLabel.Text = "Online Players (Fake)"
        PlayerListLabel.TextColor3 = THEME_COLOR
        PlayerListLabel.TextSize = 16
        PlayerListLabel.Font = Enum.Font.Code
        PlayerListLabel.Parent = PlayerListFrame

        local PlayerScrollingFrame = Instance.new("ScrollingFrame")
        PlayerScrollingFrame.Size = UDim2.new(1, 0, 1, -20)
        PlayerScrollingFrame.Position = UDim2.new(0, 0, 0, 20)
        PlayerScrollingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        PlayerScrollingFrame.BorderSizePixel = 1
        PlayerScrollingFrame.BorderColor3 = THEME_COLOR
        PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        PlayerScrollingFrame.ScrollBarThickness = 4
        PlayerScrollingFrame.Parent = PlayerListFrame

        local PlayerListLayout = Instance.new("UIListLayout")
        PlayerListLayout.Parent = PlayerScrollingFrame

        local function AddFakePlayer(name)
            local playerText = Instance.new("TextLabel")
            playerText.Size = UDim2.new(1, 0, 0, 20)
            playerText.BackgroundTransparency = 1
            playerText.Text = "- " .. name
            playerText.TextColor3 = Color3.fromRGB(200, 200, 200)
            playerText.TextSize = 14
            playerText.Font = Enum.Font.Code
            playerText.TextXAlignment = Enum.TextXAlignment.Left
            playerText.Parent = PlayerScrollingFrame
            PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
        end

        -- Populate with fake players
        AddFakePlayer("Guest_12345")
        AddFakePlayer("NoobMaster69")
        AddFakePlayer("ProGamerX")
        AddFakePlayer("Robloxian_Fan")
        AddFakePlayer("EpicPlayer777")
        AddFakePlayer("Admin_Bot")
        AddFakePlayer("ShadowHunter")
        AddFakePlayer("PixelKnight")
        AddFakePlayer("CodeWizard")
        AddFakePlayer("VirtualHero")



        return Frame
    end

    local function CreateSettingsTab()
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(1, 0, 1, 0)
        Frame.BackgroundTransparency = 1
        local ListLayout = Instance.new("UIListLayout")
        ListLayout.FillDirection = Enum.FillDirection.Vertical
        ListLayout.Padding = UDim.new(0, 10)
        ListLayout.Parent = Frame

        local ThemeLabel = Instance.new("TextLabel")
        ThemeLabel.Size = UDim2.new(1, 0, 0, 30)
        ThemeLabel.BackgroundTransparency = 1
        ThemeLabel.Text = "UI Theme Settings"
        ThemeLabel.TextColor3 = THEME_COLOR
        ThemeLabel.TextSize = 16
        ThemeLabel.Font = Enum.Font.Code
        ThemeLabel.Parent = Frame

        local ColorPickerBtn = Instance.new("TextButton")
        ColorPickerBtn.Size = UDim2.new(0, 150, 0, 40)
        ColorPickerBtn.BackgroundColor3 = THEME_COLOR
        ColorPickerBtn.BorderSizePixel = 1
        ColorPickerBtn.BorderColor3 = THEME_COLOR
        ColorPickerBtn.Text = "Change Accent Color"
        ColorPickerBtn.TextColor3 = BG_COLOR
        ColorPickerBtn.Font = Enum.Font.Code
        ColorPickerBtn.TextSize = 14
        ColorPickerBtn.Parent = Frame
        ColorPickerBtn.MouseButton1Click:Connect(function()
            AddLog("Color picker not implemented yet.")
        end)

        -- Player List (Fake)
        local PlayerListFrame = Instance.new("Frame")
        PlayerListFrame.Size = UDim2.new(1, 0, 0.5, 0)
        PlayerListFrame.Position = UDim2.new(0, 0, 0.5, 0)
        PlayerListFrame.BackgroundTransparency = 1
        PlayerListFrame.Parent = Frame

        local PlayerListLabel = Instance.new("TextLabel")
        PlayerListLabel.Size = UDim2.new(1, 0, 0, 20)
        PlayerListLabel.BackgroundTransparency = 1
        PlayerListLabel.Text = "Online Players (Fake)"
        PlayerListLabel.TextColor3 = THEME_COLOR
        PlayerListLabel.TextSize = 16
        PlayerListLabel.Font = Enum.Font.Code
        PlayerListLabel.Parent = PlayerListFrame

        local PlayerScrollingFrame = Instance.new("ScrollingFrame")
        PlayerScrollingFrame.Size = UDim2.new(1, 0, 1, -20)
        PlayerScrollingFrame.Position = UDim2.new(0, 0, 0, 20)
        PlayerScrollingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        PlayerScrollingFrame.BorderSizePixel = 1
        PlayerScrollingFrame.BorderColor3 = THEME_COLOR
        PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        PlayerScrollingFrame.ScrollBarThickness = 4
        PlayerScrollingFrame.Parent = PlayerListFrame

        local PlayerListLayout = Instance.new("UIListLayout")
        PlayerListLayout.Parent = PlayerScrollingFrame

        local function AddFakePlayer(name)
            local playerText = Instance.new("TextLabel")
            playerText.Size = UDim2.new(1, 0, 0, 20)
            playerText.BackgroundTransparency = 1
            playerText.Text = "- " .. name
            playerText.TextColor3 = Color3.fromRGB(200, 200, 200)
            playerText.TextSize = 14
            playerText.Font = Enum.Font.Code
            playerText.TextXAlignment = Enum.TextXAlignment.Left
            playerText.Parent = PlayerScrollingFrame
            PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
        end

        -- Populate with fake players
        AddFakePlayer("Guest_12345")
        AddFakePlayer("NoobMaster69")
        AddFakePlayer("ProGamerX")
        AddFakePlayer("Robloxian_Fan")
        AddFakePlayer("EpicPlayer777")
        AddFakePlayer("Admin_Bot")
        AddFakePlayer("ShadowHunter")
        AddFakePlayer("PixelKnight")
        AddFakePlayer("CodeWizard")
        AddFakePlayer("VirtualHero")



        return Frame
    end

    CreateTab("Moderation", CreateBanModerationTab)
    CreateTab("Admin", CreateAdminFeaturesTab)
    CreateTab("Movement", CreateMovementTab)
    CreateTab("Settings", CreateSettingsTab)

    -- Select initial tab
    TabFrame:FindFirstChild("Moderation").MouseButton1Click:Fire()

CreateKeySystem()
            BarBG.Parent = ScreenGui
            
            TweenService:Create(Bar, TweenInfo.new(3), {Size = UDim2.new(0, 200, 0, 10)}):Play()
            task.wait(3)
            Bar:Destroy()
            BarBG:Destroy()
            AddLog("Ban successfully uploaded for " .. name)
        end)
    end)

    -- #GlobalChat
    CreateFeatureBtn("#GlobalChat", function()
        local function FakeChat(msg)
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                Text = msg,
                Color = Color3.fromRGB(255, 0, 0),
                Font = Enum.Font.SourceSansBold,
                FontSize = Enum.FontSize.Size18
            })
        end
        local target = "Player" .. math.random(1000, 9999)
        FakeChat("[SYSTEM]: " .. target .. " has been banned by Admin @uginkbhai.")
        AddLog("Sent fake system message.")
    end)

    -- #GhostFly
    local flying = false
    CreateFeatureBtn("#GhostFly", function()
        flying = not flying
        AddLog("GhostFly: " .. (flying and "ON" or "OFF"))
        if flying then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Parent = LocalPlayer.Character.HumanoidRootPart
            local bg = Instance.new("BodyGyro")
            bg.P = 9e4
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            bg.Parent = LocalPlayer.Character.HumanoidRootPart
            
            task.spawn(function()
                while flying do
                    RunService.RenderStepped:Wait()
                    local cam = workspace.CurrentCamera.CFrame
                    local move = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
                    bv.Velocity = move * 50
                    bg.CFrame = cam
                end
                bv:Destroy()
                bg:Destroy()
            end)
        end
    end)

    -- #VisualNuke
    CreateFeatureBtn("#VisualNuke", function()
        AddLog("Initiating Visual Nuke...")
        task.spawn(function()
            for i = 1, 20 do
                local shake = Vector3.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
                LocalPlayer.Character.Humanoid.CameraOffset = shake
                local exp = Instance.new("Explosion")
                exp.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
                exp.BlastRadius = 0
                exp.Parent = workspace
                task.wait(0.1)
            end
            LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
            AddLog("Server Crash Simulation Complete.")
        end)
    end)

    -- #EmotePanel
    CreateFeatureBtn("#EmotePanel", function()
        AddLog("Playing Random Animation...")
        local anims = {"3333499508", "3333272702", "3333432454"}
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. anims[math.random(1, #anims)]
        local load = LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        load:Play()
    end)
end

CreateKeySystem()

    -- Feature Buttons
    local function CreateFeatureBtn(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 150, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.BorderSizePixel = 1
        btn.BorderColor3 = THEME_COLOR
        btn.Text = text
        btn.TextColor3 = THEME_COLOR
        btn.Font = Enum.Font.Code
        btn.TextSize = 14
        btn.Parent = Content
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    -- #BanHammer
    CreateFeatureBtn("#BanHammer", function()
        AddLog("Equipping Ban Hammer...")
        local Hammer = Instance.new("Tool")
        Hammer.Name = "Ban Hammer"
        Hammer.RequiresHandle = true
        local Handle = Instance.new("Part")
        Handle.Name = "Handle"
        Handle.Size = Vector3.new(1, 4, 1)
        Handle.Color = THEME_COLOR
        Handle.Parent = Hammer
        Hammer.Parent = LocalPlayer.Backpack

        Hammer.Activated:Connect(function()
            local target = Mouse.Target
            if target and target.Parent:FindFirstChild("Humanoid") then
                local char = target.Parent
                AddLog("Banning " .. char.Name .. "...")
                char:SetAttribute("Banned", true)
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") or v:IsA("Decal") then
                        v.Transparency = 1
                    end
                end
                -- Fake Notification
                local Notif = Instance.new("TextLabel")
                Notif.Size = UDim2.new(0, 300, 0, 50)
                Notif.Position = UDim2.new(0.5, -150, 0.2, 0)
                Notif.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                Notif.Text = "USER BANNED: " .. char.Name
                Notif.TextColor3 = Color3.fromRGB(255, 255, 255)
                Notif.Font = Enum.Font.Code
                Notif.TextSize = 20
                Notif.Parent = ScreenGui
                task.wait(2)
                Notif:Destroy()
            end
        end)
    end)

    -- #PlayerBanner
    CreateFeatureBtn("#PlayerBanner", function()
        local BanFrame = Instance.new("Frame")
        BanFrame.Size = UDim2.new(0, 250, 0, 120)
        BanFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
        BanFrame.BackgroundColor3 = BG_COLOR
        BanFrame.BorderSizePixel = 2
        BanFrame.BorderColor3 = THEME_COLOR
        BanFrame.Parent = ScreenGui

        local Input = Instance.new("TextBox")
        Input.Size = UDim2.new(0.8, 0, 0, 30)
        Input.Position = UDim2.new(0.1, 0, 0.2, 0)
        Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Input.TextColor3 = Color3.fromRGB(255, 255, 255)
        Input.PlaceholderText = "Username..."
        Input.Parent = BanFrame

        local BanBtn = Instance.new("TextButton")
        BanBtn.Size = UDim2.new(0.4, 0, 0, 30)
        BanBtn.Position = UDim2.new(0.3, 0, 0.6, 0)
        BanBtn.BackgroundColor3 = THEME_COLOR
        BanBtn.Text = "Ban"
        BanBtn.TextColor3 = BG_COLOR
        BanBtn.Parent = BanFrame

        BanBtn.MouseButton1Click:Connect(function()
            local name = Input.Text
            BanFrame:Destroy()
            AddLog("Uploading Ban to Roblox Server for " .. name .. "...")
            local Bar = Instance.new("Frame")
            Bar.Size = UDim2.new(0, 0, 0, 10)
            Bar.Position = UDim2.new(0.5, -100, 0.8, 0)
            Bar.BackgroundColor3 = THEME_COLOR
            Bar.Parent = ScreenGui
            local BarBG = Instance.new("Frame")
            BarBG.Size = UDim2.new(0, 200, 0, 10)
            BarBG.Position = UDim2.new(0.5, -100, 0.8, 0)
            BarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            BarBG.ZIndex = 0
            BarBG.Parent = ScreenGui
            
            TweenService:Create(Bar, TweenInfo.new(3), {Size = UDim2.new(0, 200, 0, 10)}):Play()
            task.wait(3)
            Bar:Destroy()
            BarBG:Destroy()
            AddLog("Ban successfully uploaded for " .. name)
        end)
    end)

    -- #GlobalChat
    CreateFeatureBtn("#GlobalChat", function()
        local function FakeChat(msg)
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                Text = msg,
                Color = Color3.fromRGB(255, 0, 0),
                Font = Enum.Font.SourceSansBold,
                FontSize = Enum.FontSize.Size18
            })
        end
        local target = "Player" .. math.random(1000, 9999)
        FakeChat("[SYSTEM]: " .. target .. " has been banned by Admin @uginkbhai.")
        AddLog("Sent fake system message.")
    end)

    -- #GhostFly
    local flying = false
    CreateFeatureBtn("#GhostFly", function()
        flying = not flying
        AddLog("GhostFly: " .. (flying and "ON" or "OFF"))
        if flying then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Parent = LocalPlayer.Character.HumanoidRootPart
            local bg = Instance.new("BodyGyro")
            bg.P = 9e4
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            bg.Parent = LocalPlayer.Character.HumanoidRootPart
            
            task.spawn(function()
                while flying do
                    RunService.RenderStepped:Wait()
                    local cam = workspace.CurrentCamera.CFrame
                    local move = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
                    bv.Velocity = move * 50
                    bg.CFrame = cam
                end
                bv:Destroy()
                bg:Destroy()
            end)
        end
    end)

    -- #VisualNuke
    CreateFeatureBtn("#VisualNuke", function()
        AddLog("Initiating Visual Nuke...")
        task.spawn(function()
            for i = 1, 20 do
                local shake = Vector3.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
                LocalPlayer.Character.Humanoid.CameraOffset = shake
                local exp = Instance.new("Explosion")
                exp.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
                exp.BlastRadius = 0
                exp.Parent = workspace
                task.wait(0.1)
            end
            LocalPlayer.Character.Humanoid.CameraOffset = Vector3.new(0, 0, 0)
            AddLog("Server Crash Simulation Complete.")
        end)
    end)

    -- #EmotePanel
    CreateFeatureBtn("#EmotePanel", function()
        AddLog("Playing Random Animation...")
        local anims = {"3333499508", "3333272702", "3333432454"}
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://" .. anims[math.random(1, #anims)]
        local load = LocalPlayer.Character.Humanoid:LoadAnimation(anim)
        load:Play()
    end)
