local DoorsLobby = 6516141723
local DoorsGame = 6839171747    
local player = game.Players.LocalPlayer
local gui = game:GetService("StarterGui")


local function createNotification(title, text)
    gui:SetCore("SendNotification", {
        Title = title,          -- The title of the notification
        Text = text,            -- The body text of the notification
        Duration = 5            -- How long the notification will be visible (in seconds)
    })
end


if game.PlaceId == DoorsLobby then
 loadstring()()
 createNotification("Script Loaded", "The script for the lobby has loaded!")
end

if game.PlaceId == DoorsGame then
    loadstring()()
    createNotification("Script Loaded", "The script for the game has loaded!")
end

