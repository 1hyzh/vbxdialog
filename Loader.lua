local DoorsLobby = 6516141723
local DoorsGame = 6839171747
local HotelMinus = 110258689672367
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
 loadstring(game:HttpGet("https://raw.githubusercontent.com/1hyzh/vbxdialog/refs/heads/main/Lobby.lua"))()
 createNotification("vbxdialog", "The script for the lobby has loaded!")
end    

if game.PlaceId == DoorsGame then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1hyzh/vbxdialog/refs/heads/main/Game.lua"))()
    createNotification("vbxdialog", "The script for the game has loaded!")       
end

if game.PlaceId == HotelMinus then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/1hyzh/vbxdialog/refs/heads/main/Game.lua"))()
    createNotification("vbxdialog", "The script for the game has loaded!")       
end

if game.PlaceId ~= DoorsLobby or DoorsGame or HotelMinus then
    createNotification("vbxdialog", "The script isn't compatible with this game!")  
end








