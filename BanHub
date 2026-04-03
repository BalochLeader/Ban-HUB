-- Ban Hub [BETA] - Client-Side Prank Tool
-- Developed by @uginkbhai (Scripted by Manus AI)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Configuration
local KEY = "diwas"
local UI_THEME_COLOR = Color3.fromRGB(255, 69, 0) -- Neon Orange
local UI_BACKGROUND_COLOR = Color3.fromRGB(25, 25, 25) -- Dark Grey/Black
local UI_TEXT_COLOR = Color3.fromRGB(255, 255, 255) -- White
local UI_FONT = Enum.Font.SourceSansBold

-- UI Elements (to be created)
local ScreenGui
local MainFrame
local TitleBar
local TitleLabel
local MinimizeButton
local MaximizeButton
local CloseButton
local SystemLogFrame
local SystemLogText
local KeypadFrame
local KeypadInput
local KeypadSubmit
local FeaturesFrame
local BanHammerButton
local PlayerBannerFrame
local PlayerBannerInput
local PlayerBannerButton
local GlobalChatInput
local GlobalChatSendButton
local GhostFlyButton
local VisualNukeButton
local EmotePanelFrame
local EmoteList

-- Local Player
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- State Variables
local UI_VISIBLE = false
local UI_MINIMIZED = false
local UI_MAXIMIZED = false
local KEY_AUTHENTICATED = false
local GHOST_FLY_ACTIVE = false
local SYSTEM_LOG_MESSAGES = {}
local MAX_LOG_MESSAGES = 10

-- Utility Functions
local function createUIElement(elementType, parent, properties)
    local element = Instance.new(elementType)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    element.Parent = parent
    return element
end

local function logSystemMessage(message)
    table.insert(SYSTEM_LOG_MESSAGES, 1, message)
    if #SYSTEM_LOG_MESSAGES > MAX_LOG_MESSAGES then
        table.remove(SYSTEM_LOG_MESSAGES)
    end
    SystemLogText.Text = table.concat(SYSTEM_LOG_MESSAGES, "\n")
end

-- UI Creation
local function createMainUI()
    ScreenGui = createUIElement("ScreenGui", PlayerGui, {Name = "BanHubGui", ZIndexBehavior = Enum.ZIndexBehavior.Sibling})
    
    MainFrame = createUIElement("Frame", ScreenGui, {
        Name = "MainFrame",
        Size = UDim2.new(0, 400, 0, 500),
        Position = UDim2.new(0.5, -200, 0.5, -250),
        BackgroundColor3 = UI_BACKGROUND_COLOR,
        BorderSizePixel = 0,
        Active = true,
        Draggable = true,
        Visible = false
    })
    
    -- Title Bar
    TitleBar = createUIElement("Frame", MainFrame, {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = UI_THEME_COLOR,
        BorderSizePixel = 0,
        Active = true,
        Draggable = true
    })
    
    TitleLabel = createUIElement("TextLabel", TitleBar, {
        Name = "TitleLabel",
        Size = UDim2.new(1, -90, 1, 0),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 1,
        Text = "Ban Hub [BETA]",
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 20,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Control Buttons
    local function createControlButton(name, text, position, callback)
        local button = createUIElement("TextButton", TitleBar, {
            Name = name,
            Size = UDim2.new(0, 30, 1, 0),
            Position = position,
            BackgroundColor3 = UI_THEME_COLOR,
            TextColor3 = UI_TEXT_COLOR,
            Font = UI_FONT,
            TextSize = 20,
            Text = text,
            BorderSizePixel = 0
        })
        button.MouseButton1Click:Connect(callback)
        return button
    end
    
    MinimizeButton = createControlButton("MinimizeButton", "—", UDim2.new(1, -90, 0, 0), function() 
        -- Minimize logic
        UI_MINIMIZED = not UI_MINIMIZED
        if UI_MINIMIZED then
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 30)}):Play()
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 500)}):Play()
        end
    end)
    
    MaximizeButton = createControlButton("MaximizeButton", "▢", UDim2.new(1, -60, 0, 0), function() 
        -- Maximize logic (simple toggle for now)
        UI_MAXIMIZED = not UI_MAXIMIZED
        if UI_MAXIMIZED then
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0,0,0,0)}):Play()
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 500), Position = UDim2.new(0.5, -200, 0.5, -250)}):Play()
        end
    end)
    
    CloseButton = createControlButton("CloseButton", "X", UDim2.new(1, -30, 0, 0), function() 
        -- Close logic
        UI_VISIBLE = false
        MainFrame.Visible = false
    end)
    
    -- System Log
    SystemLogFrame = createUIElement("Frame", MainFrame, {
        Name = "SystemLogFrame",
        Size = UDim2.new(1, -20, 0, 100),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        BorderSizePixel = 0
    })
    
    SystemLogText = createUIElement("TextLabel", SystemLogFrame, {
        Name = "SystemLogText",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 1,
        TextColor3 = UI_THEME_COLOR,
        Font = UI_FONT,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true
    })
    
    -- Keypad (initially visible)
    KeypadFrame = createUIElement("Frame", MainFrame, {
        Name = "KeypadFrame",
        Size = UDim2.new(1, -20, 0, 150),
        Position = UDim2.new(0, 10, 0.5, -75),
        BackgroundColor3 = UI_BACKGROUND_COLOR,
        BorderSizePixel = 0,
        Visible = true
    })
    
    createUIElement("TextLabel", KeypadFrame, {
        Text = "Enter Key:",
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 10),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 1,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 18
    })
    
    KeypadInput = createUIElement("TextBox", KeypadFrame, {
        Name = "KeypadInput",
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 50),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 18,
        Text = "",
        PlaceholderText = "Key",
        ClearTextOnFocus = false
    })
    
    KeypadSubmit = createUIElement("TextButton", KeypadFrame, {
        Name = "KeypadSubmit",
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0, 10, 0, 90),
        BackgroundColor3 = UI_THEME_COLOR,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 20,
        Text = "Submit"
    })
    
    KeypadSubmit.MouseButton1Click:Connect(function()
        if KeypadInput.Text == KEY then
            KEY_AUTHENTICATED = true
            KeypadFrame.Visible = false
            FeaturesFrame.Visible = true
            logSystemMessage("Key Accepted. Access Granted.")
        else
            logSystemMessage("Incorrect Key. Kicking player...")
            LocalPlayer:Kick("Enter Real Key Made By Uginkbhai")
        end
    end)
    
    -- Features Frame (initially hidden)
    FeaturesFrame = createUIElement("Frame", MainFrame, {
        Name = "FeaturesFrame",
        Size = UDim2.new(1, -20, 0, 300),
        Position = UDim2.new(0, 10, 0, 150),
        BackgroundColor3 = UI_BACKGROUND_COLOR,
        BorderSizePixel = 0,
        Visible = false
    })
    
    -- BanHammer
    BanHammerButton = createUIElement("TextButton", FeaturesFrame, {
        Name = "BanHammerButton",
        Size = UDim2.new(0.48, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 10),
        BackgroundColor3 = UI_THEME_COLOR,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 18,
        Text = "#BanHammer"
    })
    BanHammerButton.MouseButton1Click:Connect(function()
        logSystemMessage("Activating #BanHammer...")
        -- Implement BanHammer logic later
    end)
    
    -- PlayerBanner
    PlayerBannerFrame = createUIElement("Frame", FeaturesFrame, {
        Name = "PlayerBannerFrame",
        Size = UDim2.new(1, 0, 0, 80),
        Position = UDim2.new(0, 0, 0, 60),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 1
    })
    
    PlayerBannerInput = createUIElement("TextBox", PlayerBannerFrame, {
        Name = "PlayerBannerInput",
        Size = UDim2.new(0.7, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 16,
        Text = "",
        PlaceholderText = "Username to Ban"
    })
    
    PlayerBannerButton = createUIElement("TextButton", PlayerBannerFrame, {
        Name = "PlayerBannerButton",
        Size = UDim2.new(0.28, 0, 0, 30),
        Position = UDim2.new(0.72, 0, 0, 0),
        BackgroundColor3 = UI_THEME_COLOR,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 16,
        Text = "Ban"
    })
    PlayerBannerButton.MouseButton1Click:Connect(function()
        local targetUsername = PlayerBannerInput.Text
        if targetUsername ~= "" then
            logSystemMessage("Uploading Ban to Roblox Server...")
            -- Simulate loading bar
            task.spawn(function()
                for i = 1, 10 do
                    PlayerBannerButton.Text = "Banning" .. string.rep(".", i %% 4)
                    task.wait(0.2)
                end
                PlayerBannerButton.Text = "Ban"
                logSystemMessage("Fake ban of " .. targetUsername .. " completed.")
            end)
        end
    end)
    
    -- GlobalChat
    GlobalChatInput = createUIElement("TextBox", FeaturesFrame, {
        Name = "GlobalChatInput",
        Size = UDim2.new(0.7, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 150),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 16,
        Text = "",
        PlaceholderText = "Fake System Message"
    })
    
    GlobalChatSendButton = createUIElement("TextButton", FeaturesFrame, {
        Name = "GlobalChatSendButton",
        Size = UDim2.new(0.28, 0, 0, 30),
        Position = UDim2.new(0.72, 0, 0, 150),
        BackgroundColor3 = UI_THEME_COLOR,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 16,
        Text = "Send"
    })
    GlobalChatSendButton.MouseButton1Click:Connect(function()
        local message = GlobalChatInput.Text
        if message ~= "" then
            logSystemMessage("[SYSTEM]: " .. message)
            GlobalChatInput.Text = ""
        end
    end)
    
    -- GhostFly
    GhostFlyButton = createUIElement("TextButton", FeaturesFrame, {
        Name = "GhostFlyButton",
        Size = UDim2.new(0.48, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 200),
        BackgroundColor3 = UI_THEME_COLOR,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 18,
        Text = "#GhostFly"
    })
    GhostFlyButton.MouseButton1Click:Connect(function()
        GHOST_FLY_ACTIVE = not GHOST_FLY_ACTIVE
        if GHOST_FLY_ACTIVE then
            logSystemMessage("#GhostFly Activated.")
            GhostFlyButton.Text = "#GhostFly (Active)"
            -- Implement GhostFly logic later
        else
            logSystemMessage("#GhostFly Deactivated.")
            GhostFlyButton.Text = "#GhostFly"
            -- Deactivate GhostFly logic later
        end
    end)
    
    -- VisualNuke
    VisualNukeButton = createUIElement("TextButton", FeaturesFrame, {
        Name = "VisualNukeButton",
        Size = UDim2.new(0.48, 0, 0, 40),
        Position = UDim2.new(0.52, 0, 0, 200),
        BackgroundColor3 = UI_THEME_COLOR,
        TextColor3 = UI_TEXT_COLOR,
Font = UI_FONT,
        TextSize = 18,
        Text = "#VisualNuke"
    })
    VisualNukeButton.MouseButton1Click:Connect(function()
        logSystemMessage("Initiating #VisualNuke...")
        -- Implement VisualNuke logic later
    end)
    
    -- EmotePanel
    EmotePanelFrame = createUIElement("Frame", FeaturesFrame, {
        Name = "EmotePanelFrame",
        Size = UDim2.new(1, 0, 0, 100),
        Position = UDim2.new(0, 0, 0, 250),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 1
    })
    
    createUIElement("TextLabel", EmotePanelFrame, {
        Text = "Emote Panel:",
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 1,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 16
    })
    
    EmoteList = createUIElement("TextBox", EmotePanelFrame, {
        Name = "EmoteList",
        Size = UDim2.new(1, 0, 0, 60),
        Position = UDim2.new(0, 0, 0, 25),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 14,
        Text = "",
        PlaceholderText = "Type emote name (e.g., Dance)"
    })
    
    local EmotePlayButton = createUIElement("TextButton", EmotePanelFrame, {
        Name = "EmotePlayButton",
        Size = UDim2.new(0.28, 0, 0, 25),
        Position = UDim2.new(0.72, 0, 0, 60),
        BackgroundColor3 = UI_THEME_COLOR,
        TextColor3 = UI_TEXT_COLOR,
        Font = UI_FONT,
        TextSize = 14,
        Text = "Play Emote"
    })
    EmotePlayButton.MouseButton1Click:Connect(function()
        local emoteName = EmoteList.Text
        if emoteName ~= "" then
            logSystemMessage("Playing emote: " .. emoteName)
            -- Implement Emote playing logic later
        end
    end)
    
    -- Add a UIAspectRatioConstraint to maintain aspect ratio of the main frame
    createUIElement("UIAspectRatioConstraint", MainFrame, {
        AspectRatio = 400/500,
        AspectType = Enum.AspectType.FitWithinMaxSize,
        DominantAxis = Enum.DominantAxis.Width
    })
    
    -- Add a UICorner for rounded corners
    createUIElement("UICorner", MainFrame, {CornerRadius = UDim.new(0, 8)})
    createUIElement("UICorner", TitleBar, {CornerRadius = UDim.new(0, 8)})
    createUIElement("UICorner", SystemLogFrame, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", KeypadInput, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", KeypadSubmit, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", BanHammerButton, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", PlayerBannerInput, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", PlayerBannerButton, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", GlobalChatInput, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", GlobalChatSendButton, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", GhostFlyButton, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", VisualNukeButton, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", EmoteList, {CornerRadius = UDim.new(0, 5)})
    createUIElement("UICorner", EmotePlayButton, {CornerRadius = UDim.new(0, 5)})
end

-- Input Handling (to toggle UI visibility)
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.RightControl and not gameProcessedEvent then
        UI_VISIBLE = not UI_VISIBLE
        MainFrame.Visible = UI_VISIBLE
        if UI_VISIBLE then
            logSystemMessage("Ban Hub [BETA] opened.")
        else
            logSystemMessage("Ban Hub [BETA] closed.")
        end
    end
end)

-- Main execution
createMainUI()

-- Fake Log Messages using task.spawn
task.spawn(function()
    while true do
        if not KEY_AUTHENTICATED then
            local startupMessages = {
                "Bypassing Admin...",
                "Connecting to Database...",
                "Establishing secure tunnel...",
                "Fetching latest exploits...",
                "Verifying credentials...",
                "Decrypting firewall...",
                "Accessing mainframe...",
                "Injecting bytecode...",
                "Overriding security protocols...",
                "Establishing peer-to-peer connection..."
            }
            logSystemMessage(startupMessages[math.random(1, #startupMessages)])
            task.wait(math.random(1, 3))
        else
            local postAuthMessages = {
                "Scanning for vulnerabilities...",
                "Encrypting data stream...",
                "Initializing quantum entanglement protocols...",
                "Accessing restricted Roblox APIs...",
                "Injecting client-side modifications...",
                "Monitoring network traffic...",
                "Bypassing anti-cheat signatures...",
                "Optimizing memory allocation...",
                "Updating ban database...",
                "Syncing with global admin network..."
            }
            logSystemMessage(postAuthMessages[math.random(1, #postAuthMessages)])
            task.wait(math.random(5, 15))
        end
    end
end)

-- #BanHammer Logic
local function createBanHammer()
    local hammer = Instance.new("Tool")
    hammer.Name = "BanHammer"
    
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.5, 2, 0.5)
    handle.BrickColor = BrickColor.new("Brown")
    handle.Transparency = 0
    handle.CanCollide = false
    handle.Parent = hammer
    
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1, 1, 3)
    head.BrickColor = BrickColor.new("Dark stone grey")
    head.Transparency = 0
    head.CanCollide = false
    head.Parent = hammer
    head.Position = Vector3.new(0, 0, -1.5) -- Offset from handle
    
    local weld = Instance.new("Weld")
    weld.Part0 = handle
    weld.Part1 = head
    weld.C0 = CFrame.new(0, 0, -1.5)
    weld.Parent = handle
    
    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://1033068"
    mesh.TextureId = "rbxassetid://1033069"
    mesh.Scale = Vector3.new(0.5, 0.5, 0.5)
    mesh.Parent = handle
    
    hammer.Activated:Connect(function()
        logSystemMessage("BanHammer activated. Searching for targets...")
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local raycastParams = RaycastParams.new()
                raycastParams.FilterDescendantsInstances = {character}
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                
                local origin = handle.CFrame.p
                local direction = handle.CFrame.LookVector * 5 -- Raycast forward
                
                local result = workspace:Raycast(origin, direction, raycastParams)
                
                if result and result.Instance then
                    local hitPlayer = Players:GetPlayerFromCharacter(result.Instance.Parent)
                    if hitPlayer and hitPlayer ~= LocalPlayer then
                        logSystemMessage("Player " .. hitPlayer.Name .. " hit by BanHammer. Initiating local ban...")
                        
                        -- Make player invisible locally
                        local targetCharacter = hitPlayer.Character
                        if targetCharacter then
                            for _, part in pairs(targetCharacter:GetDescendants()) do
                                if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("MeshPart") then
                                    part.LocalTransparencyModifier = 1
                                end
                            end
                        end
                        
                        -- Show 'USER BANNED' notification
                        local notificationGui = createUIElement("ScreenGui", PlayerGui, {Name = "BanNotification"})
                        local notificationFrame = createUIElement("Frame", notificationGui, {
                            Size = UDim2.new(0, 300, 0, 100),
                            Position = UDim2.new(0.5, -150, 0.5, -50),
                            BackgroundColor3 = Color3.fromRGB(200, 0, 0),
                            BorderSizePixel = 0,
                            Visible = true
                        })
                        createUIElement("TextLabel", notificationFrame, {
                            Text = "USER BANNED: " .. hitPlayer.Name,
                            Size = UDim2.new(1, 0, 1, 0),
                            BackgroundColor3 = Color3.new(0,0,0),
                            BackgroundTransparency = 1,
                            TextColor3 = UI_TEXT_COLOR,
                            Font = UI_FONT,
                            TextSize = 24
                        })
                        
                        task.spawn(function()
                            task.wait(3)
                            notificationGui:Destroy()
                        end)
                    end
                end
            end
        end
    end)
    
    hammer.Parent = LocalPlayer.Backpack
end

BanHammerButton.MouseButton1Click:Connect(function()
    logSystemMessage("Creating BanHammer tool...")
    createBanHammer()
end)

-- #GhostFly Logic
local originalWalkSpeed
local originalJumpPower
local originalGravity
local originalCollision

local function activateGhostFly()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            originalWalkSpeed = humanoid.WalkSpeed
            originalJumpPower = humanoid.JumpPower
            originalGravity = workspace.Gravity
            originalCollision = character.PrimaryPart.CanCollide
            
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
            workspace.Gravity = 0
            character.PrimaryPart.CanCollide = false
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Velocity = Vector3.new(0,0,0)
            bodyVelocity.Parent = character.PrimaryPart
            
            local camera = workspace.CurrentCamera
            
            RunService.RenderStepped:Connect(function()
                if GHOST_FLY_ACTIVE and character.PrimaryPart and camera then
                    local moveVector = Vector3.new(0,0,0)
                    local speed = 50 -- Fly speed
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector + camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector - camera.CFrame.LookVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector - camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + camera.CFrame.RightVector
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
                        moveVector = moveVector + Vector3.new(0,1,0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
                        moveVector = moveVector - Vector3.new(0,1,0)
                    end
                    
                    bodyVelocity.Velocity = moveVector.unit * speed
                else
                    bodyVelocity:Destroy()
                end
            end)
        end
    end
end

local function deactivateGhostFly()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = originalWalkSpeed
            humanoid.JumpPower = originalJumpPower
            workspace.Gravity = originalGravity
            character.PrimaryPart.CanCollide = originalCollision
            
            local bodyVelocity = character.PrimaryPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
    end
end

GhostFlyButton.MouseButton1Click:Connect(function()
    GHOST_FLY_ACTIVE = not GHOST_FLY_ACTIVE
    if GHOST_FLY_ACTIVE then
        logSystemMessage("#GhostFly Activated.")
        GhostFlyButton.Text = "#GhostFly (Active)"
        activateGhostFly()
    else
        logSystemMessage("#GhostFly Deactivated.")
        GhostFlyButton.Text = "#GhostFly"
        deactivateGhostFly()
    end
end)

-- #VisualNuke Logic
local function visualNukeEffect()
    local camera = workspace.CurrentCamera
    if camera then
        local originalCFrame = camera.CFrame
        local shakeIntensity = 0.5
        local shakeDuration = 2
        local explosionCount = 5
        
        -- Screen shake
        task.spawn(function()
            local startTime = tick()
            while tick() - startTime < shakeDuration do
                camera.CFrame = originalCFrame * CFrame.new(math.random() * shakeIntensity - shakeIntensity/2,
                                                             math.random() * shakeIntensity - shakeIntensity/2,
                                                             math.random() * shakeIntensity - shakeIntensity/2)
                task.wait(0.05)
            end
            camera.CFrame = originalCFrame -- Reset camera
        end)
        
        -- Fake explosions
        for i = 1, explosionCount do
            task.spawn(function()
                local explosionPart = Instance.new("Part")
                explosionPart.Shape = Enum.PartType.Ball
                explosionPart.Size = Vector3.new(5,5,5)
                explosionPart.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-20,20), math.random(5,15), math.random(-20,20))
                explosionPart.BrickColor = BrickColor.new("Really red")
                explosionPart.Transparency = 0.5
                explosionPart.CanCollide = false
                explosionPart.Anchored = true
                explosionPart.Parent = workspace
                
                local fire = Instance.new("Fire")
                fire.Color = Color3.fromRGB(255, 100, 0)
                fire.Size = 10
                fire.Heat = 10
                fire.Parent = explosionPart
                
                local smoke = Instance.new("Smoke")
                smoke.Color = Color3.fromRGB(50,50,50)
                smoke.Size = 10
                smoke.RiseVelocity = 5
                smoke.Parent = explosionPart
                
                task.wait(math.random(0.1, 0.5))
                
                TweenService:Create(explosionPart, TweenInfo.new(1), {Transparency = 1}):Play()
                TweenService:Create(fire, TweenInfo.new(1), {Size = 0, Heat = 0}):Play()
                TweenService:Create(smoke, TweenInfo.new(1), {Size = 0, RiseVelocity = 0}):Play()
                
                task.wait(1)
                explosionPart:Destroy()
            end)
        end
    end
end

VisualNukeButton.MouseButton1Click:Connect(function()
    logSystemMessage("Initiating #VisualNuke...")
    visualNukeEffect()
end)

-- #EmotePanel Logic
local function playEmote(emoteName)
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if animator then
                -- This is a simplified example. Real emotes require AnimationIds.
                -- For a client-side prank, we can use existing animation IDs or just fake it.
                -- For now, we'll just log it.
                logSystemMessage("Attempting to play emote: " .. emoteName .. " (requires valid AnimationId)")
                
                -- Example of playing a built-in animation (requires valid ID)
                -- local animation = Instance.new("Animation")
                -- animation.AnimationId = "rbxassetid://YOUR_EMOTE_ANIMATION_ID"
                -- local track = animator:LoadAnimation(animation)
                -- track:Play()
                -- task.wait(track.Length)
                -- track:Stop()
            else
                logSystemMessage("Animator not found in Humanoid.")
            end
        else
            logSystemMessage("Humanoid not found in Character.")
        end
    else
        logSystemMessage("Character not found.")
    end
end

EmotePlayButton.MouseButton1Click:Connect(function()
    local emoteName = EmoteList.Text
    if emoteName ~= "" then
        logSystemMessage("Playing emote: " .. emoteName)
        playEmote(emoteName)
    end
end)

-- Ensure UI is created after all services are ready
PlayerGui.ChildAdded:Connect(function(child)
    if child.Name == "BanHubGui" then
        -- Ensure the UI is on top
        child.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end
end)

logSystemMessage("Ban Hub [BETA] Initialized. Press RightControl to toggle UI.")
