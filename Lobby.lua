local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "vbxdialog",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "",
   LoadingSubtitle = "by hyzh",
   ShowText = "", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Amethyst", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "vbx1"
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


local Tab = Window:CreateTab("Main", "rewind")
local Section = Tab:CreateSection("Hotel elevators.")

local Button = Tab:CreateButton({
   Name = "Solo Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Hotel",
		    FriendsOnly = false,
	    	MaxPlayers = "1"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})

local Button2 = Tab:CreateButton({
   Name = "Duo Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Hotel",
		    FriendsOnly = false,
	    	MaxPlayers = "2"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})

local Button3 = Tab:CreateButton({
   Name = "Trio Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Hotel",
		    FriendsOnly = false,
	    	MaxPlayers = "3"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})

local Button4 = Tab:CreateButton({
   Name = "Squad Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Hotel",
		    FriendsOnly = false,
	    	MaxPlayers = "4"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})
local Divider = Tab:CreateDivider()






local Section2 = Tab:CreateSection("Mines elevators. (works without achivement)")

local Button5 = Tab:CreateButton({
   Name = "Solo Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Mines",
		    FriendsOnly = false,
	    	MaxPlayers = "1"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})

local Button6 = Tab:CreateButton({
   Name = "Duo Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Mines",
		    FriendsOnly = false,
	    	MaxPlayers = "2"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})

local Button7 = Tab:CreateButton({
   Name = "Trio Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Mines",
		    FriendsOnly = false,
	    	MaxPlayers = "3"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})

local Button8 = Tab:CreateButton({
   Name = "Squad Elevator",
   Callback = function()
        local args = {
	        {
		    Mods = {},
		    Settings = {},
		    Destination = "Mines",
		    FriendsOnly = false,
	    	MaxPlayers = "4"
	        }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("CreateElevator"):FireServer(unpack(args))
   end,
})
local Divider2 = Tab:CreateDivider()

