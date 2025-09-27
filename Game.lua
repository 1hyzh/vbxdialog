local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local PlayerESPOutlineColor = Color3.fromRGB(255, 255, 0)
local PlayerESPFillColor = Color3.fromRGB(255, 255, 0)

local DoorESPOutlineColor = Color3.fromRGB(0, 255, 0)
local DoorESPFillColor = Color3.fromRGB(0, 255, 0)

local LeverESPFillColor = Color3.fromRGB(0, 255, 0)  -- Default Fill Color for Gate Levers
local LeverESPOutlineColor = Color3.fromRGB(0, 0, 255)

local WardrobeESPFillColor = Color3.fromRGB(120, 0, 255)  -- Default Fill Color for Wardrobes
local WardrobeESPOutlineColor = Color3.fromRGB(120, 0, 255)  -- Default Outline Color for Wardrobes

local KeyESPFillColor = Color3.fromRGB(255, 215, 0)  -- Default Fill Color for Keys
local KeyESPOutlineColor = Color3.fromRGB(255, 215, 0)  -- Default Outline Color for Keys

local ChestESPFillColor = Color3.fromRGB(255, 140, 0)  -- Default Fill Color for Chests
local ChestESPOutlineColor = Color3.fromRGB(255, 140, 0)

local EntityESPColor = Color3.fromRGB(255, 0, 0)

local BookESPColorFill = Color3.fromRGB(0, 100, 255)
local BookESPColorOutline = Color3.fromRGB(0, 100, 255)

local GoldESPFillColor = Color3.fromRGB(255, 215, 0)  -- Default Fill Color for Keys
local GoldESPOutlineColor = Color3.fromRGB(255, 215, 0)

local ItemESPFillColor = Color3.fromRGB(0, 255, 0)  -- Default Fill Color for Keys
local ItemESPOutlineColor = Color3.fromRGB(0, 0, 0)

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")


local Window = Rayfield:CreateWindow({
    Name = "cool script",
    Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
    LoadingTitle = "",
    LoadingSubtitle = "by vbxdialog",
    Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "xdial", -- Create a custom folder for your hub/game
       FileName = "vxcb"
    },
 
    Discord = {
       Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
 
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })

 local Tab = Window:CreateTab("Visual", 4483362458) -- Title, Image
 local Toggle1 = Tab:CreateToggle({
    Name = "Player ESP",
    CurrentValue = false,
    Flag = "Toggle1", -- A flag is the identifier for the configuration file
    Callback = function(Value)
        print(Value)
        
        -- Get Services
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        
        -- Define the function to adorn a player's character
        local function adornCharacter(character)
            local player = Players:GetPlayerFromCharacter(character)
            if player == LocalPlayer then return end
            
            local hrp = character:WaitForChild("HumanoidRootPart", 5)
            if not hrp then return end

            -- 1) Highlight
            local highlight = Instance.new("Highlight")
            highlight.Name             = "PlayerHighlight"
            highlight.FillColor        = PlayerESPFillColor    -- yellow
            highlight.FillTransparency = 0.5
            highlight.OutlineColor     = PlayerESPOutlineColor
            highlight.OutlineTransparency = 0.5
            highlight.DepthMode        = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Adornee          = character
            highlight.Parent           = character  -- Parent it to the character, not PlayerGui

            -- NameTag
            local billboard = Instance.new("BillboardGui")
            billboard.Name         = "NameTag"
            billboard.Adornee      = hrp
            billboard.Parent       = character  -- Parent it to the character
            billboard.AlwaysOnTop  = true
            billboard.StudsOffset  = Vector3.new(0, 2.5, 0)
            billboard.Size         = UDim2.new(0, 120, 0, 40)

            local label = Instance.new("TextLabel")
            label.Size               = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text               = player.Name
            label.TextColor3         = Color3.new(1, 1, 1)
            label.TextStrokeColor3   = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextScaled         = true
            label.Font               = Enum.Font.GothamBold
            label.Parent             = billboard
        end

        -- Function to remove the highlights and name tags
        local function disablePlayerHighlights(player)
            local character = player.Character
            if not character then return end

            -- Remove Highlight
            local highlight = character:FindFirstChild("PlayerHighlight")
            if highlight then
                highlight:Destroy()
            end

            -- Remove BillboardGui with name tag
            local billboard = character:FindFirstChild("NameTag")
            if billboard then
                billboard:Destroy()
            end
        end

        -- Toggle logic
        if Value then  -- When the toggle is ON
            -- Adorn players when they join
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(adornCharacter)
            end)

            -- Apply to players already in the game
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    adornCharacter(player.Character)
                end
                player.CharacterAdded:Connect(adornCharacter)
            end
        else  -- When the toggle is OFF
            -- Disable highlights for the local player
            disablePlayerHighlights(LocalPlayer)

            -- Remove highlights for all players when they join or when their character is added
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    disablePlayerHighlights(player)
                end)
            end)

            -- Disable for players already in the game
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    disablePlayerHighlights(player)
                end
                player.CharacterAdded:Connect(function()
                    disablePlayerHighlights(player)
                end)
            end
        end
    end,
})

local Toggle2 = Tab:CreateToggle({
    Name = "Notify Entities",
    CurrentValue = false,
    Flag = "Toggle2",
    Callback = function(Value)
        ToggleActive = Value
        print("Toggle2:", Value)

        local Workspace = game:GetService("Workspace")
        local RunService = game:GetService("RunService")

        local entityNames = {
            "RushMoving",
            "AmbushMoving",
            "SeekMovingNewClone",
            "Halt",
            "Eyes",
            "NDA5OiBDT05GTElDVA==",
            "GlitchRush"
        }

        if Value == true then
            -- Listen for entities spawning in Workspace
            RemoteConnection = Workspace.ChildAdded:Connect(function(child)
                if table.find(entityNames, child.Name) then
                    print("Entity Detected:", child.Name)
                    local sound = Instance.new("Sound", workspace)
                    sound.SoundId = "rbxassetid://4590662766"
                    sound.Volume = _G.VolumeTime or 2
                    sound.PlayOnRemove = true
                    sound:Destroy()
                    Rayfield:Notify({
                        Title = "Entity Spawned!",
                        Content = child.Name .. " has spawned.",
                        Duration = 6.5,
                        Image = 4483362458, -- You can customize this image
                    })      
                end
            end)

            -- Optional heartbeat loop (can be used for future logic)
            LoopConnection = RunService.Heartbeat:Connect(function()
                if not ToggleActive then return end
                -- No active loop logic needed
            end)
        else
            -- Turn OFF: disconnect listeners
            if RemoteConnection then
                RemoteConnection:Disconnect()
                RemoteConnection = nil
            end
            if LoopConnection then
                LoopConnection:Disconnect()
                LoopConnection = nil
            end
        end
    end
})



local Toggle3 = Tab:CreateToggle({
    Name = "FullBright",
    CurrentValue = false,
    Flag = "Toggle3",
    Callback = function(Value)
        local Lighting = game:GetService("Lighting")

        if Value == true then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
            Lighting.ExposureCompensation = 0
            Lighting.GeographicLatitude = 0
            Lighting.TimeOfDay = "14:00:00"
            Lighting.FogStart = 100000
            Lighting.FogEnd = 1000000
            Lighting.GlobalShadows = false
        else
            -- Reset to more natural/default lighting
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            Lighting.Brightness = 1
            Lighting.ExposureCompensation = 0
            Lighting.GeographicLatitude = 41.733
            Lighting.TimeOfDay = "07:00:00"
            Lighting.FogStart = 0
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
        end
    end,
})
local ESPSection = Tab:CreateSection("ESPs")
local ToggleDoorESP = Tab:CreateToggle({
    Name = "Door ESP",
    CurrentValue = false,
    Flag = "ToggleDoorESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local RunService = game:GetService("RunService")

        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local connections = {}

        -- Function to add ESP to a Door
        local function adornDoor(door, roomIndex)
            if door:FindFirstChild("DoorESPHighlight") then return end

            -- Highlight
            local highlight = Instance.new("Highlight")
            highlight.Name = "DoorESPHighlight"
            highlight.FillColor = DoorESPFillColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = DoorESPOutlineColor
            highlight.OutlineTransparency = 0
            highlight.Adornee = door
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = door

            -- Billboard name tag
            local rootPart = door:FindFirstChild("DoorHitbox") or door:FindFirstChildWhichIsA("BasePart")
            if rootPart then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "DoorESPName"
                billboard.Adornee = rootPart
                billboard.Size = UDim2.new(0, 100, 0, 30)
                billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = door

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = "Room " .. tostring(tonumber(roomIndex) + 1) .. " Door"
                label.TextColor3 = Color3.new(1, 1, 1)
                label.TextStrokeColor3 = Color3.new(0, 0, 0)
                label.TextStrokeTransparency = 0
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                label.Parent = billboard
            end
        end

        -- Function to remove ESP from all doors
        local function removeESP()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local door = room:FindFirstChild("Door")
                if door then
                    local hl = door:FindFirstChild("DoorESPHighlight")
                    if hl then hl:Destroy() end
                    local tag = door:FindFirstChild("DoorESPName")
                    if tag then tag:Destroy() end
                end
            end
        end

        if Value then
            -- Add ESP to all current doors
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local door = room:FindFirstChild("Door")
                if door then
                    adornDoor(door, room.Name)
                end
            end

            -- Watch for new rooms/doors
            local roomAddedConn = CurrentRooms.ChildAdded:Connect(function(newRoom)
                local door = newRoom:WaitForChild("Door", 5)
                if door then
                    adornDoor(door, newRoom.Name)
                end
            end)

            table.insert(connections, roomAddedConn)
        else
            -- Turn off ESP and clean up
            removeESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end
    end,
})


local ToggleEntityESP = Tab:CreateToggle({
    Name = "Entity ESP",
    CurrentValue = false,
    Flag = "ToggleEntityESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local RunService = game:GetService("RunService")
        local player = game.Players.LocalPlayer
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local entityNames = {
            "RushMoving",
            "AmbushMoving",
            "SeekMovingNewClone",
            "Halt",
            "Eyes",
            "NDA5OiBDT05GTElDVA==",
            "GlitchRush"
        }

        local connections = {}

        -- Function to adorn an entity (or any model with a root part)
        local function adornEntity(entity, labelText)
            if entity:FindFirstChild("EntityESPHighlight") then return end

            -- Highlight for the entire entity (model) and its children
            local highlight = Instance.new("Highlight")
            highlight.Name = "EntityESPHighlight"
            highlight.FillColor = EntityESPColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = EntityESPColor
            highlight.OutlineTransparency = 0
            highlight.Adornee = entity
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = entity

            -- Apply highlights to all children of the entity (model)
            for _, part in ipairs(entity:GetDescendants()) do
                if part:IsA("BasePart") then
                    local childHighlight = Instance.new("Highlight")
                    childHighlight.Name = "ChildESPHighlight"
                    childHighlight.FillColor = EntityESPColor
                    childHighlight.FillTransparency = 0.5
                    childHighlight.OutlineColor = EntityESPColor
                    childHighlight.OutlineTransparency = 0
                    childHighlight.Adornee = part
                    childHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    childHighlight.Parent = part
                end
            end

            -- Billboard name tag
            local rootPart = entity:FindFirstChildWhichIsA("BasePart") or entity:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "EntityESPName"
                billboard.Adornee = rootPart
                billboard.Size = UDim2.new(0, 150, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 3, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = entity

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = labelText or entity.Name
                label.TextColor3 = EntityESPColor
                label.TextStrokeColor3 = Color3.new(0, 0, 0)
                label.TextStrokeTransparency = 0
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                label.Parent = billboard

                -- Add a distance label on top
                local distanceLabel = Instance.new("TextLabel")
                distanceLabel.Name = "DistanceLabel"
                distanceLabel.Size = UDim2.new(1, 0, 0.5, 0)
                distanceLabel.BackgroundTransparency = 1
                distanceLabel.Position = UDim2.new(0, 0, 1, 0)
                distanceLabel.TextColor3 = Color3.new(1, 0, 0) -- Red color for distance
                distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
                distanceLabel.TextStrokeTransparency = 0.5
                distanceLabel.TextScaled = true
                distanceLabel.Font = Enum.Font.GothamBold
                distanceLabel.Parent = billboard

                -- Function to update the distance label
                local function updateDistance()
                    local distance = (rootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    distanceLabel.Text = string.format("Distance: %.2f studs", distance)
                end

                -- Update the distance every frame
                RunService.RenderStepped:Connect(function()
                    updateDistance()
                end)
            end
        end

        -- Function to check for Figure in Room 50
        local function tryFindFigure(room)
            if room.Name == "50" then
                local hitbox = room:FindFirstChild("FigureSetup", true)
                if hitbox then
                    local figureRig = hitbox:FindFirstChild("FigureRig", true)
                    if figureRig and figureRig:FindFirstChild("Hitbox") then
                        adornEntity(figureRig, "Figure")
                    end
                end
            end
        end

        -- Function to remove all ESPs
        local function removeEntityESP()
            for _, child in ipairs(Workspace:GetChildren()) do
                if table.find(entityNames, child.Name) then
                    local hl = child:FindFirstChild("EntityESPHighlight")
                    if hl then hl:Destroy() end
                    -- Remove child highlights as well
                    for _, part in ipairs(child:GetDescendants()) do
                        if part:IsA("BasePart") then
                            local childHl = part:FindFirstChild("ChildESPHighlight")
                            if childHl then childHl:Destroy() end
                        end
                    end
                    local tag = child:FindFirstChild("EntityESPName")
                    if tag then tag:Destroy() end
                end
            end
            -- Also try to clean up Figure ESP
            local room50 = CurrentRooms:FindFirstChild("50")
            if room50 then
                local figure = room50:FindFirstChild("FigureSetup", true)
                if figure then
                    local rig = figure:FindFirstChild("FigureRig", true)
                    if rig then
                        local hl = rig:FindFirstChild("EntityESPHighlight")
                        if hl then hl:Destroy() end
                        local tag = rig:FindFirstChild("EntityESPName")
                        if tag then tag:Destroy() end
                    end
                end
            end
        end

        if Value then
            -- Existing entities
            for _, entity in ipairs(Workspace:GetChildren()) do
                if table.find(entityNames, entity.Name) then
                    adornEntity(entity)
                end
            end

            -- Listen for future entities
            local entityConn = Workspace.ChildAdded:Connect(function(child)
                if table.find(entityNames, child.Name) then
                    adornEntity(child)
                end
            end)

            -- Check if Room 50 is already loaded
            local room50 = CurrentRooms:FindFirstChild("50")
            if room50 then tryFindFigure(room50) end

            -- Watch for Room 50 being added
            local roomConn = CurrentRooms.ChildAdded:Connect(function(room)
                tryFindFigure(room)
            end)

            table.insert(connections, entityConn)
            table.insert(connections, roomConn)
        else
            removeEntityESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end
    end,
})




local ToggleBookESP = Tab:CreateToggle({
    Name = "Book ESP",
    CurrentValue = false,
    Flag = "ToggleBookESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local connections = {}

        -- Helper function to adorn a book
        local function adornBook(bookModel)
            if bookModel:FindFirstChild("BookESPHighlight") then return end

            local base = bookModel:FindFirstChild("Base")
            if not base or not base:IsA("BasePart") then return end

            -- Highlight
            local highlight = Instance.new("Highlight")
            highlight.Name = "BookESPHighlight"
            highlight.FillColor = BookESPColorFill
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = BookESPColorOutline
            highlight.OutlineTransparency = 0
            highlight.Adornee = bookModel
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = bookModel

            -- Billboard tag
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "BookESPName"
            billboard.Adornee = base
            billboard.Size = UDim2.new(0, 80, 0, 25)
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = bookModel

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "Book"
            label.TextColor3 = BookESPColorFill
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
        end

        -- Function to search and tag books in Room 50
        local function findBooksInRoom50(room)
            if room.Name ~= "50" then return end

            local assets = room:FindFirstChild("Assets")
            if not assets then return end

            local shelves = assets:FindFirstChild("Bookshelves1")
            if not shelves then return end

            for _, shelf in ipairs(shelves:GetChildren()) do
                if shelf.Name:find("Modular_Bookshelf") then
                    for _, book in ipairs(shelf:GetChildren()) do
                        if book.Name == "LiveHintBook" then
                            adornBook(book)
                        end
                    end
                end
            end
        end

        -- Function to clean all ESP
        local function removeBookESP()
            local room50 = CurrentRooms:FindFirstChild("50")
            if not room50 then return end

            local assets = room50:FindFirstChild("Assets")
            if not assets then return end

            local shelves = assets:FindFirstChild("Bookshelves1")
            if not shelves then return end

            for _, shelf in ipairs(shelves:GetChildren()) do
                if shelf.Name:find("Modular_Bookshelf") then
                    for _, book in ipairs(shelf:GetChildren()) do
                        if book.Name == "LiveHintBook" then
                            local hl = book:FindFirstChild("BookESPHighlight")
                            if hl then hl:Destroy() end
                            local tag = book:FindFirstChild("BookESPName")
                            if tag then tag:Destroy() end
                        end
                    end
                end
            end
        end

        if Value then
            -- If room 50 is already there
            local room50 = CurrentRooms:FindFirstChild("50")
            if room50 then
                findBooksInRoom50(room50)
            end

            -- If room 50 loads later
            local roomConn = CurrentRooms.ChildAdded:Connect(function(room)
                findBooksInRoom50(room)
            end)
            table.insert(connections, roomConn)

        else
            removeBookESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end
    end
})


local ToggleWardrobeESP = Tab:CreateToggle({
    Name = "Wardrobe ESP",
    CurrentValue = false,
    Flag = "ToggleWardrobeESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local RunService = game:GetService("RunService")
        local connections = {}
        local running = true

        -- Function to add ESP to a wardrobe's Main part
        local function adornWardrobe(mainPart, roomName)
            if mainPart:FindFirstChild("WardrobeESPHighlight") then return end

            local highlight = Instance.new("Highlight")
            highlight.Name = "WardrobeESPHighlight"
            highlight.FillColor = WardrobeESPFillColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = WardrobeESPOutlineColor
            highlight.OutlineTransparency = 0
            highlight.Adornee = mainPart
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = mainPart

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "WardrobeESPName"
            billboard.Adornee = mainPart
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = mainPart

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "Wardrobe (Room " .. roomName .. ")"
            label.TextColor3 = WardrobeESPFillColor
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
        end

        -- Find and highlight every "Wardrobe" model in a room
        local function findWardrobes(room)
            local assets = room:FindFirstChild("Assets")
            if not assets then return end

            for _, obj in ipairs(assets:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "Wardrobe" then
                    local mainPart = obj:FindFirstChild("Main")
                    if mainPart and mainPart:IsA("BasePart") then
                        adornWardrobe(mainPart, room.Name)
                    end
                end
            end
        end

        -- Remove ESP from all wardrobes
        local function removeWardrobeESP()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if not assets then continue end

                for _, obj in ipairs(assets:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name == "Wardrobe" then
                        local mainPart = obj:FindFirstChild("Main")
                        if mainPart then
                            local hl = mainPart:FindFirstChild("WardrobeESPHighlight")
                            if hl then hl:Destroy() end
                            local tag = mainPart:FindFirstChild("WardrobeESPName")
                            if tag then tag:Destroy() end
                        end
                    end
                end
            end
        end

        -- ESP toggle logic
        if Value then
            running = true

            -- Initial scan
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                findWardrobes(room)
            end

            -- Hook into new rooms
            local conn = CurrentRooms.ChildAdded:Connect(function(room)
                room:WaitForChild("Assets", 3)
                findWardrobes(room)
            end)
            table.insert(connections, conn)

            -- Background loop to recheck every 5 seconds
            task.spawn(function()
                while running do
                    for _, room in ipairs(CurrentRooms:GetChildren()) do
                        findWardrobes(room)
                    end
                    task.wait(5)
                end
            end)

        else
            -- Stop loop and clean up
            running = false
            removeWardrobeESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
        end
    end,
})

local ToggleKeyESP = Tab:CreateToggle({
    Name = "Key ESP",
    CurrentValue = false,
    Flag = "ToggleKeyESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local connections = {}

        -- Function to add ESP to the key
        local function adornKey(keyModel, roomName)
            if keyModel:FindFirstChild("KeyESPHighlight") then return end

            local highlight = Instance.new("Highlight")
            highlight.Name = "KeyESPHighlight"
            highlight.FillColor = KeyESPFillColor
            highlight.FillTransparency = 0.3
            highlight.OutlineColor = KeyESPOutlineColor
            highlight.OutlineTransparency = 0
            highlight.Adornee = keyModel
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = keyModel

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "KeyESPName"
            billboard.Adornee = keyModel
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = keyModel

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "Key (Room " .. roomName .. ")"
            label.TextColor3 = KeyESPOutlineColor
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
        end

        -- Function to find all keys in a room and apply ESP
        local function findKeys(room)
            local assets = room:FindFirstChild("Assets")
            if not assets then return end

            for _, descendant in ipairs(assets:GetDescendants()) do
                if descendant:IsA("Model") and descendant.Name == "KeyObtain" then
                    adornKey(descendant, room.Name)
                end
            end
        end

        -- Function to remove all Key ESPs
        local function removeKeyESP()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if assets then
                    for _, descendant in ipairs(assets:GetDescendants()) do
                        if descendant:IsA("Model") and descendant.Name == "KeyObtain" then
                            local hl = descendant:FindFirstChild("KeyESPHighlight")
                            if hl then hl:Destroy() end
                            local tag = descendant:FindFirstChild("KeyESPName")
                            if tag then tag:Destroy() end
                        end
                    end
                end
            end
        end

        -- Callback logic
        if Value then
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                findKeys(room)
            end

            local conn = CurrentRooms.ChildAdded:Connect(function(room)
                room:WaitForChild("Assets", 3)
                findKeys(room)
            end)

            table.insert(connections, conn)
        else
            removeKeyESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
        end
    end,
})

local ToggleChestESP = Tab:CreateToggle({
    Name = "Chest ESP",
    CurrentValue = false,
    Flag = "ToggleChestESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local connections = {}

        local function adornChest(chestModel, roomName)
            if chestModel:FindFirstChild("ChestESPHighlight") then return end

            local highlight = Instance.new("Highlight")
            highlight.Name = "ChestESPHighlight"
            highlight.FillColor = ChestESPFillColor
            highlight.FillTransparency = 0.3
            highlight.OutlineColor = ChestESPOutlineColor
            highlight.OutlineTransparency = 0
            highlight.Adornee = chestModel
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = chestModel

            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ChestESPName"
            billboard.Adornee = chestModel
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = chestModel

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "Chest (Room " .. roomName .. ")"
            label.TextColor3 = ChestESPFillColor
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
        end

        local function findChests(room)
            for _, chestBox in ipairs(room:GetDescendants()) do
                if chestBox:IsA("Model") and chestBox.Name == "ChestBox" then
                    for _, chest in ipairs(chestBox:GetChildren()) do
                        if chest:IsA("Model") then
                            adornChest(chest, room.Name)
                        end
                    end
                end
            end
        end

        local function removeChestESP()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                for _, chestBox in ipairs(room:GetDescendants()) do
                    if chestBox:IsA("Model") and chestBox.Name == "ChestBox" then
                        for _, chest in ipairs(chestBox:GetChildren()) do
                            if chest:IsA("Model") then
                                local hl = chest:FindFirstChild("ChestESPHighlight")
                                if hl then hl:Destroy() end
                                local tag = chest:FindFirstChild("ChestESPName")
                                if tag then tag:Destroy() end
                            end
                        end
                    end
                end
            end
        end

        if Value then
            -- Existing rooms
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                findChests(room)
            end

            -- Future rooms
            local conn = CurrentRooms.ChildAdded:Connect(function(room)
                room:WaitForChild("Assets", 3)
                findChests(room)
            end)
            table.insert(connections, conn)
        else
            removeChestESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
        end
    end,
})


local ToggleGateLeverESP = Tab:CreateToggle({
    Name = "Gate Lever ESP",
    CurrentValue = false,
    Flag = "ToggleGateLeverESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local connections = {}

        -- Function to add ESP to a Gate Lever
        local function adornGateLever(lever, roomIndex)
            if lever:FindFirstChild("GateLeverESPHighlight") then return end

            -- Highlight
            local highlight = Instance.new("Highlight")
            highlight.Name = "GateLeverESPHighlight"
            highlight.FillColor = LeverESPFillColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = LeverESPOutlineColor
            highlight.OutlineTransparency = 0
            highlight.Adornee = lever
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = lever

            -- Billboard name tag
            local rootPart = lever:FindFirstChild("Handle") or lever:FindFirstChildWhichIsA("BasePart")
            if rootPart then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "GateLeverESPName"
                billboard.Adornee = rootPart
                billboard.Size = UDim2.new(0, 100, 0, 30)
                billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = lever

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = "Gate Lever (Room " .. tostring(tonumber(roomIndex) + 1) .. ")"
                label.TextColor3 = Color3.new(1, 1, 1)
                label.TextStrokeColor3 = Color3.new(0, 0, 0)
                label.TextStrokeTransparency = 0
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                label.Parent = billboard
            end
        end

        -- Function to remove ESP from all Gate Levers
        local function removeGateLeverESP()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if assets then
                    local leverForGateFolder = assets:FindFirstChild("LeverForGate")
                    if leverForGateFolder then
                        for _, lever in ipairs(leverForGateFolder:GetChildren()) do
                            if lever:IsA("Model") then
                                local hl = lever:FindFirstChild("GateLeverESPHighlight")
                                if hl then hl:Destroy() end
                                local tag = lever:FindFirstChild("GateLeverESPName")
                                if tag then tag:Destroy() end
                            end
                        end
                    end
                end
            end
        end

        if Value then
            -- Add ESP to all current Gate Levers
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if assets then
                    local leverForGateFolder = assets:FindFirstChild("LeverForGate")
                    if leverForGateFolder then
                        for _, lever in ipairs(leverForGateFolder:GetChildren()) do
                            if lever:IsA("Model") then
                                adornGateLever(lever, room.Name)
                            end
                        end
                    end
                end
            end

            -- Watch for new rooms/levers
            local roomAddedConn = CurrentRooms.ChildAdded:Connect(function(newRoom)
                local assets = newRoom:WaitForChild("Assets", 3)
                if assets then
                    local leverForGateFolder = assets:FindFirstChild("LeverForGate")
                    if leverForGateFolder then
                        for _, lever in ipairs(leverForGateFolder:GetChildren()) do
                            if lever:IsA("Model") then
                                adornGateLever(lever, newRoom.Name)
                            end
                        end
                    end
                end
            end)

            table.insert(connections, roomAddedConn)
        else
            -- Turn off ESP and clean up
            removeGateLeverESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end
    end,
})

local ToggleGoldESP = Tab:CreateToggle({
    Name = "Gold ESP",
    CurrentValue = false,
    Flag = "ToggleGoldESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local connections = {}
        local goldIndex = 1  -- Counter for gold piles

        -- Function to add ESP to a gold pile
        local function adornGold(goldPile, roomName, index)
            if goldPile:FindFirstChild("GoldESPHighlight") then return end

            -- Highlight for the gold pile
            local highlight = Instance.new("Highlight")
            highlight.Name = "GoldESPHighlight"
            highlight.FillColor = GoldESPFillColor  -- Customize the color as needed
            highlight.FillTransparency = 0.3
            highlight.OutlineColor = GoldESPOutlineColor  -- Customize outline color
            highlight.OutlineTransparency = 0
            highlight.Adornee = goldPile
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = goldPile

            -- Billboard label for the gold pile
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "GoldESPName"
            billboard.Adornee = goldPile
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = goldPile

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = "Gold " .. tostring(index)
            label.TextColor3 = GoldESPOutlineColor
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
        end

        -- Function to search for gold piles in a room and apply ESP
        local function findGoldPiles(room)
            local assets = room:FindFirstChild("Assets")
            if not assets then return end

            -- Search for "GoldPile" models inside assets
            for _, obj in ipairs(assets:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == "GoldPile" then
                    adornGold(obj, room.Name, goldIndex)
                    goldIndex = goldIndex + 1  -- Increment the index for the next gold pile
                end
            end
        end

        -- Function to remove ESP from all gold piles
        local function removeGoldESP()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if not assets then continue end

                for _, obj in ipairs(assets:GetDescendants()) do
                    if obj:IsA("Model") and obj.Name == "GoldPile" then
                        local hl = obj:FindFirstChild("GoldESPHighlight")
                        if hl then hl:Destroy() end
                        local tag = obj:FindFirstChild("GoldESPName")
                        if tag then tag:Destroy() end
                    end
                end
            end
        end

        -- ESP toggle logic
        if Value then
            goldIndex = 1  -- Reset the gold index each time ESP is toggled on

            -- Initial scan of existing rooms
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                findGoldPiles(room)
            end

            -- Hook into new rooms
            local conn = CurrentRooms.ChildAdded:Connect(function(room)
                room:WaitForChild("Assets", 3)
                findGoldPiles(room)
            end)
            table.insert(connections, conn)

            -- Background loop to recheck every 5 seconds
            task.spawn(function()
                while Value do
                    for _, room in ipairs(CurrentRooms:GetChildren()) do
                        findGoldPiles(room)
                    end
                    task.wait(5)  -- Check every 5 seconds
                end
            end)

        else
            -- Stop loop and clean up
            removeGoldESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
        end
    end,
})

local ToggleItemESP = Tab:CreateToggle({
    Name = "Item ESP",
    CurrentValue = false,
    Flag = "ToggleItemESP",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        local connections = {}

        local itemNames = { "Vitamins", "Flashlight" }

        -- Highlight and label function
        local function adornItem(itemModel, itemType)
            if itemModel:FindFirstChild("ItemESPHighlight") then return end

            local base = itemModel:FindFirstChildWhichIsA("BasePart", true)
            if not base then return end

            -- Highlight
            local highlight = Instance.new("Highlight")
            highlight.Name = "ItemESPHighlight"
            highlight.FillColor = ItemESPFillColor
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = ItemESPOutlineColor
            highlight.OutlineTransparency = 0
            highlight.Adornee = itemModel
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = itemModel

            -- Billboard label
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ItemESPName"
            billboard.Adornee = base
            billboard.Size = UDim2.new(0, 100, 0, 25)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = itemModel

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = itemType
            label.TextColor3 = Color3.new(0, 1, 0)
            label.TextStrokeColor3 = Color3.new(0, 0, 0)
            label.TextStrokeTransparency = 0
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
        end

        -- Search and tag items
        local function findItemsInRoom(room)
            local assets = room:FindFirstChild("Assets")
            if not assets then return end

            for _, model in ipairs(assets:GetDescendants()) do
                if model:IsA("Model") then
                    for _, itemName in ipairs(itemNames) do
                        local found = model:FindFirstChild(itemName, true)
                        if found then
                            adornItem(model, itemName)
                            break
                        end
                    end
                end
            end
        end

        -- Cleanup
        local function removeItemESP()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                local assets = room:FindFirstChild("Assets")
                if assets then
                    for _, model in ipairs(assets:GetDescendants()) do
                        if model:IsA("Model") then
                            local hl = model:FindFirstChild("ItemESPHighlight")
                            if hl then hl:Destroy() end
                            local tag = model:FindFirstChild("ItemESPName")
                            if tag then tag:Destroy() end
                        end
                    end
                end
            end
        end

        if Value then
            -- For rooms that already exist
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                findItemsInRoom(room)
            end

            -- For rooms added later
            local roomConn = CurrentRooms.ChildAdded:Connect(function(room)
                findItemsInRoom(room)
            end)
            table.insert(connections, roomConn)
        else
            removeItemESP()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
            connections = {}
        end
    end
})


local ColorESPSection = Tab:CreateSection("ESP Settings")

local PlayerESPCF = Tab:CreateColorPicker({
    Name = "Player ESP Fill",
    Color = Color3.fromRGB(255, 255, 0),
    Flag = "ColorPicker1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        PlayerESPFillColor = Value
    end
})
local PlayerESPCO = Tab:CreateColorPicker({
    Name = "Player ESP Outline",
    Color = Color3.fromRGB(255, 255, 0),
    Flag = "ColorPicker2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
       PlayerESPOutlineColor = Value
    end
})

local DoorESPCF = Tab:CreateColorPicker({
    Name = "Door ESP Fill",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "ColorPicker3", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        DoorESPFillColor = Value
    end
})
local DoorESPCO = Tab:CreateColorPicker({
    Name = "Door ESP Outline",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "ColorPicker4", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
       DoorESPOutlineColor = Value
    end
})

local EntityESPCF = Tab:CreateColorPicker({
    Name = "Entity ESP Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ColorPicker5", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        EntityESPColor = Value
    end
})

local BookESPCF = Tab:CreateColorPicker({
    Name = "Book ESP Fill",
    Color = Color3.fromRGB(0, 100, 255),
    Flag = "ColorPicker6", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        BookESPColorFill = Value
    end
})
local BookESPCO = Tab:CreateColorPicker({
    Name = "Book ESP Outline",
    Color = Color3.fromRGB(0, 100, 255),
    Flag = "ColorPicker7", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
       BookESPColorOutline = Value
    end
})

local WardrobeESPCF = Tab:CreateColorPicker({
    Name = "Wardrobe ESP Fill",
    Color = Color3.fromRGB(120, 0, 255),
    Flag = "ColorPicker8", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        WardrobeESPFillColor = Value
    end
})
local WardrobeESPCO = Tab:CreateColorPicker({
    Name = "Wardrobe ESP Outline",
    Color = Color3.fromRGB(120, 0, 255),
    Flag = "ColorPicker9", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
       WardrobeESPOutlineColor = Value
    end
})

local KeyESPCF = Tab:CreateColorPicker({
    Name = "Key ESP Fill",
    Color = Color3.fromRGB(255, 215, 0),
    Flag = "ColorPicker10", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        KeyESPFillColor = Value
    end
})
local KeyESPCO = Tab:CreateColorPicker({
    Name = "Key ESP Outline",
    Color = Color3.fromRGB(255, 215, 0),
    Flag = "ColorPicker11", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
       KeyESPOutlineColor = Value
    end
})

local GoldESPCF = Tab:CreateColorPicker({
    Name = "Gold ESP Fill",
    Color = Color3.fromRGB(255, 215, 0),
    Flag = "ColorPicker12", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        GoldESPFillColor = Value
    end
})
local GoldESPCO = Tab:CreateColorPicker({
    Name = "Gold ESP Outline",
    Color = Color3.fromRGB(255, 215, 0),
    Flag = "ColorPicker13", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
       GoldESPOutlineColor = Value
    end
})

local ItemESPCF = Tab:CreateColorPicker({
    Name = "Item ESP Fill",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "ColorPicker14", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        ItemESPFillColor = Value
    end
})
local ItemESPCO = Tab:CreateColorPicker({
    Name = "Item ESP Outline",
    Color = Color3.fromRGB(0, 0, 0),
    Flag = "ColorPicker15", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
       ItemESPOutlineColor = Value
    end
})








 local Tab3 = Window:CreateTab("Attempt of exploits", 4483362458)

 local Toggle1 = Tab3:CreateToggle({
    Name = "Door reach",
    CurrentValue = false,
    Flag = "door reach",
    Callback = function(Value)
        local RunService = game:GetService("RunService")
        local Workspace = game:GetService("Workspace")
        local toggleActive = true  -- Local flag to help stop the loop when toggled off

        if Value then
            toggleActive = true
            task.spawn(function()
                while toggleActive and Toggle1.CurrentValue do
                    local door = Workspace:FindFirstChild("CurrentRooms") and Workspace.CurrentRooms:FindFirstChild("0")
                    if door and door:FindFirstChild("Door") and door.Door:FindFirstChild("ClientOpen") then
                        door.Door.ClientOpen:FireServer()
                    end
                    task.wait(0.01)
                end
            end)
        else
            toggleActive = false
        end
    end,
})

local pl = "0"
local Input = Tab3:CreateInput({
    Name = "Library Code",
    CurrentValue = "",
    PlaceholderText = "Library Code",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
    Text = pl
    end,
 })

 local Button = Tab3:CreateButton({
    Name = "Open Libary",
    Callback = function()
        game:GetService("ReplicatedStorage").RemotesFolder.PL:FireServer(pl)
    end,
 })

 local InstaInteractLoop = nil
local ThruInteractLoop = nil

local InstaToggle = Tab3:CreateToggle({
    Name = "Instant Interact",
    CurrentValue = false,
    Flag = "InstantInteractToggle",
    Callback = function(Value)
        if Value then
            InstaInteractLoop = coroutine.create(function()
                while true do
                    for _, prompt in pairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            if not prompt:GetAttribute("OriginalHold") then
                                prompt:SetAttribute("OriginalHold", prompt.HoldDuration)
                            end
                            prompt.HoldDuration = 0
                        end
                    end
                    task.wait(2)
                end
            end)
            coroutine.resume(InstaInteractLoop)
        else
            if InstaInteractLoop then
                InstaInteractLoop = nil -- kill the loop
            end
            -- Restore HoldDuration
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    local original = prompt:GetAttribute("OriginalHold")
                    if original then
                        prompt.HoldDuration = original
                        prompt:SetAttribute("OriginalHold", nil)
                    end
                end
            end
        end
    end,
})

local ThruToggle = Tab3:CreateToggle({
    Name = "Interact Through Objects",
    CurrentValue = false,
    Flag = "InteractThroughObjects",
    Callback = function(Value)
        if Value then
            ThruInteractLoop = coroutine.create(function()
                while true do
                    for _, prompt in pairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            prompt.RequiresLineOfSight = false
                        end
                    end
                    task.wait(2)
                end
            end)
            coroutine.resume(ThruInteractLoop)
        else
            if ThruInteractLoop then
                ThruInteractLoop = nil -- stop loop
            end
            -- Reset to default
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    prompt.RequiresLineOfSight = true
                end
            end
        end
    end,
})

local DistanceToggle = Tab3:CreateToggle({
    Name = "Increased Interaction Distance",
    CurrentValue = false,
    Flag = "IncreasedDistanceToggle",
    Callback = function(Value)
        if Value then
            -- Increase the interaction distance for all ProximityPrompts
            IncreaseDistanceLoop = coroutine.create(function()
                while true do
                    for _, prompt in pairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") then
                            -- Set the MaxActivationDistance to 20 studs
                            prompt.MaxActivationDistance = 20
                        end
                    end
                    task.wait(2)  -- Check every 2 seconds
                end
            end)
            coroutine.resume(IncreaseDistanceLoop)
        else
            -- Restore the default MaxActivationDistance
            if IncreaseDistanceLoop then
                IncreaseDistanceLoop = nil  -- stop loop
            end
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    prompt.MaxActivationDistance = 10  -- Reset to default (or any other desired distance)
                end
            end
        end
    end,
})

local ahSection = Tab3:CreateSection("AutoHide")
local teleportDirection = "Under"  -- Default selection (can be "Under" or "Above")
local teleportDirectionv2 = "Under"
-- Dropdown to choose the teleportation direction
local Dropdown = Tab3:CreateDropdown({
    Name = "Autohide",
    Options = {"Under", "Above"},
    CurrentOption = {"Under"},  -- Default is "Under"
    MultipleOptions = false,
    Flag = "Dropdown1",  -- Flag for configuration saving
    Callback = function(Options)
        -- Set the teleport direction based on dropdown selection
        teleportDirection = Options[1]  -- "Under" or "Above"
    end,
})

local ToggleAutoHide = Tab3:CreateToggle({
    Name = "AutoHide (risky)",
    CurrentValue = false,
    Flag = "ToggleAutoHide",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local RunService = game:GetService("RunService")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        local entityNames = {
            "RushMoving",
            "AmbushMoving",
            "GlitchRush"
        }

        local RemoteConnection

        if Value == true then
            -- Play initial sound and notification
            local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://4590662766"
            sound.Volume = _G.VolumeTime or 2
            sound.PlayOnRemove = true
            sound:Destroy()

            Rayfield:Notify({
                Title = "AutoHide",
                Content = "You will need to get glitch to get back on track.",
                Duration = 6.5,
                Image = 4483362458, -- Customize this image
            })

            -- Listen for entities spawning in Workspace
            RemoteConnection = Workspace.ChildAdded:Connect(function(child)
                if table.find(entityNames, child.Name) then
                    print("Entity Detected:", child.Name)

                    -- Play sound and show notification upon entity spawn
                    local sound = Instance.new("Sound", workspace)
                    sound.SoundId = "rbxassetid://4590662766"
                    sound.Volume = _G.VolumeTime or 2
                    sound.PlayOnRemove = true
                    sound:Destroy()

                    Rayfield:Notify({
                        Title = "AutoHide",
                        Content = "Trying to teleport...",
                        Duration = 6.5,
                        Image = 4483362458, -- Customize this image
                    })

                    -- Teleporting logic (teleport every frame while the entity is present)
                    local originalCFrame = character.HumanoidRootPart.CFrame
                    local targetPosition

                    -- Determine target position based on the dropdown selection
                    if teleportDirection == "Under" then
                        targetPosition = originalCFrame.Position - Vector3.new(0, 50, 0) -- 50 studs below
                    elseif teleportDirection == "Above" then
                        targetPosition = originalCFrame.Position + Vector3.new(0, 50, 0) -- 50 studs above
                    end

                    -- Start the loop to teleport continuously
                    local entityGone = false
                    local teleportLoop
                    teleportLoop = coroutine.create(function()
                        while true do
                            -- Teleport the player every frame to prevent being caught by the entity
                            character:SetPrimaryPartCFrame(CFrame.new(targetPosition))

                            -- Check if the entity is still present in the workspace
                            if not Workspace:FindFirstChild(child.Name) then
                                entityGone = true
                            end

                            -- If the entity is no longer in the workspace, teleport back to the original position
                            if entityGone then
                                character:SetPrimaryPartCFrame(originalCFrame)  -- Use the original CFrame (position + rotation)
                                break  -- Exit the loop once teleportation is done
                            end

                            wait(0.01)  -- Small wait to avoid locking up the game while continuously teleporting
                        end
                    end)

                    -- Start the teleportation coroutine
                    coroutine.resume(teleportLoop)
                end
            end)
        else
            -- Turn OFF: disconnect listeners
            if RemoteConnection then
                RemoteConnection:Disconnect()
                RemoteConnection = nil
            end
        end
    end
})

local ToggleAutoHide2 = Tab3:CreateToggle({
    Name = "AutoHide 2",
    CurrentValue = false,
    Flag = "ToggleAutoHide",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local camera = Workspace.CurrentCamera
        local teleportDirection = camera.CFrame.LookVector
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")  -- Direction the player is looking

        local entityNames = {
            "RushMoving",
            "AmbushMoving",
            "GlitchRush"
        }

        local RemoteConnection

        if Value == true then
            -- Play initial sound and notification
            local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://4590662766"
            sound.Volume = _G.VolumeTime or 2
            sound.PlayOnRemove = true
            sound:Destroy()

            Rayfield:Notify({
                Title = "AutoHide",
                Content = "You will be teleported continuously to avoid detection.",
                Duration = 6.5,
                Image = 4483362458, -- Customize this image
            })

            -- Listen for entities spawning in Workspace
            RemoteConnection = Workspace.ChildAdded:Connect(function(child)
                if table.find(entityNames, child.Name) then
                    print("Entity Detected:", child.Name)

                    -- Play sound and show notification upon entity spawn
                    local sound = Instance.new("Sound", workspace)
                    sound.SoundId = "rbxassetid://4590662766"
                    sound.Volume = _G.VolumeTime or 2
                    sound.PlayOnRemove = true
                    sound:Destroy()

                    Rayfield:Notify({
                        Title = "AutoHide",
                        Content = "Teleporting to avoid the entity.",
                        Duration = 6.5,
                        Image = 4483362458, -- Customize this image
                    })

                    -- Teleporting logic (teleport every frame while the entity is present)
                    local originalCFrame = character.HumanoidRootPart.CFrame
                    local targetPosition

                    -- Determine target position based on the dropdown selection
                    targetPosition = originalCFrame.Position - Vector3.new(0, 50, 0)  -- 50 studs below by default

                    -- Start the loop to teleport continuously while the entity is present
                    local teleportLoop
                    teleportLoop = coroutine.create(function()
                        while Workspace:FindFirstChild(child.Name) do
                            -- Teleport the player every frame to prevent being caught by the entity
                            character:SetPrimaryPartCFrame(CFrame.new(targetPosition))

                            wait(0.001)  -- Very short wait to keep teleporting smoothly
                        end

                        -- Once the entity is gone, teleport back to the original position
                        character:SetPrimaryPartCFrame(originalCFrame)
                        wait(2)
                        local newPosition = humanoidRootPart.Position + teleportDirection * 30
                        character:SetPrimaryPartCFrame(CFrame.new(newPosition))
                        wait(.5)
                        character:SetPrimaryPartCFrame(CFrame.new(newPosition))                      
                    end)

                    -- Start the teleportation loop
                    coroutine.resume(teleportLoop)
                end
            end)
        else
            -- Turn OFF: disconnect listeners
            if RemoteConnection then
                RemoteConnection:Disconnect()
                RemoteConnection = nil
            end
        end
    end
})


local Button = Tab3:CreateButton({
    Name = "Gate Bypass",
    Callback = function()
        local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://4590662766"
            sound.Volume = _G.VolumeTime or 2
            sound.PlayOnRemove = true
            sound:Destroy()

            Rayfield:Notify({
                Title = "Gate Bypass",
                Content = "Trying to open the door do not move!",
                Duration = 6.5,
                Image = "triangle-alert",
            })
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local camera = game.Workspace.CurrentCamera
        local teleportDirection = camera.CFrame.LookVector  -- Direction the player is looking

        -- Teleport the player 10 times, 5 studs forward each time
        for i = 1, 10 do
            local newPosition = humanoidRootPart.Position + teleportDirection * 30
            character:SetPrimaryPartCFrame(CFrame.new(newPosition))
            wait(0.01)  -- Small wait to make sure the teleportation happens smoothly
        end

        -- Teleport the player 50 studs below, 20 times
        for i = 1, 50 do
            local newPosition = humanoidRootPart.Position + Vector3.new(0, 50, 0)
            character:SetPrimaryPartCFrame(CFrame.new(newPosition))
            wait(0.01)  -- Small wait for smooth teleportation
        end

        local sound = Instance.new("Sound", workspace)
            sound.SoundId = "rbxassetid://4590662766"
            sound.Volume = _G.VolumeTime or 2
            sound.PlayOnRemove = true
            sound:Destroy()

            Rayfield:Notify({
                Title = "Gate Bypass",
                Content = "Now you need to get glitch",
                Duration = 6.5,
                Image = "info",
            })
    end,
})
local ButtonDisableSeek = Tab3:CreateButton({
    Name = "Disable Seek in All Rooms",
    Callback = function()
        local Workspace = game:GetService("Workspace")
        local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
        
        -- Function to disable TriggerSeek and delete the TriggerSeek remote event for the client
        local function disableTriggersInRoom(room)
            -- Find the TriggerSeek remote and prevent client from firing it
            local triggerSeek = room:FindFirstChild("TriggerSeek")
            if triggerSeek and triggerSeek:IsA("RemoteEvent") then
                -- Prevent the client from firing the RemoteEvent by intercepting its OnClientEvent
                triggerSeek.OnClientEvent:Connect(function()
                    return nil -- Ignore the event to prevent firing
                end)

                -- Delete the TriggerSeek remote event
                triggerSeek:Destroy()

                -- Play sound to notify user
                local sound = Instance.new("Sound", workspace)
                sound.SoundId = "rbxassetid://4590662766"
                sound.Volume = _G.VolumeTime or 2
                sound.PlayOnRemove = true
                sound:Destroy()

                -- Notify the user that the TriggerSeek has been disabled and deleted
                Rayfield:Notify({
                    Title = "Disable Seek",
                    Content = "TriggerSeek has been disabled and deleted.",
                    Duration = 6.5,
                    Image = "info",
                })
            end
        end

        -- Function to scan all rooms and disable triggers/remove models
        local function scanAndDisableTriggers()
            for _, room in ipairs(CurrentRooms:GetChildren()) do
                -- Disable triggers in each room
                disableTriggersInRoom(room)
            end
        end

        -- Run the function to scan all rooms immediately when the button is pressed (only once)
        scanAndDisableTriggers()

        -- Notify that the action was completed
        Rayfield:Notify({
            Title = "Action Completed",
            Content = "All rooms have been scanned, and TriggerSeek has been disabled and deleted.",
            Duration = 6.5,
            Image = "check-circle",
        })
    end,
})

local Tab5 = Window:CreateTab("Main", 4483362458) -- Title, Image
local ws = 16
local Slider = Tab5:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 30},
    Increment = 1,
    Suffix = "ws",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        ws = Value
    end,
 })

 local Toggle = Tab5:CreateToggle({
    Name = "Toggle WalkSpeed",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local toggleActive = true

        if Value then
            toggleActive = true
            task.spawn(function()
                while toggleActive and Toggle.CurrentValue do
                    local character = Players.LocalPlayer.Character
                    local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = ws
                    end
                    task.wait(1)
                end
            end)
        else
            toggleActive = false
        end
    end,
})

local NoclipLoop = nil

local Toggle1 = Tab5:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- Function to enable or disable noclip mode
        local function toggleNoclip(enabled)
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not enabled
                end
            end
        end

        -- Continuous loop for toggling noclip every 2 seconds
        if Value then
            NoclipLoop = coroutine.create(function()
                while true do
                    toggleNoclip(true)  -- Enable noclip
                    task.wait(2)
                end
            end)
            coroutine.resume(NoclipLoop)
        else
            if NoclipLoop then
                NoclipLoop = nil  -- stop the loop
            end
            toggleNoclip(false)  -- Disable noclip immediately
        end
    end,
})


local Toggle2 = Tab5:CreateToggle({
    Name = "Anti-Lag (Destroy Lights)",
    CurrentValue = false,
    Flag = "AntiLagToggle",
    Callback = function(Value)
        local Workspace = game:GetService("Workspace")
        
        -- Function to destroy all lights in the workspace
        local function destroyLights()
            for _, light in pairs(Workspace:GetDescendants()) do
                -- Check if the object is a type of light
                if light:IsA("PointLight") or light:IsA("SpotLight") or light:IsA("SurfaceLight") then
                    light:Destroy()  -- Destroy the light object
                end
            end
        end

        -- Enable or disable the anti-lag effect based on the toggle value
        if Value then
            -- Destroy lights when the toggle is enabled
            destroyLights()
        else
            
        end
    end,
})

