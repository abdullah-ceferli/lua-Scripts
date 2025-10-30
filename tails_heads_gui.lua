-- 100% TAILS or HEADS Exploit GUI - Just Flip Bro (83574430507127)
-- Delta Mobile/PC Ready - Educational Only! (Bans Possible)
-- Click to Force Tails or Heads - Auto Guess + Streak Tracker

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Game Check
if game.PlaceId ~= 83574430507127 then
    return game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Wrong Game!",
        Text = "Join Just Flip Bro (ID: 83574430507127)",
        Duration = 6
    })
end

-- Services
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Action = RS:WaitForChild("Events"):WaitForChild("GamesActions")  -- Flip Remote

-- Variables
local ForceMode = nil  -- "tails", "heads", or nil
local AutoGuess = false
local Streak = 0

-- GUI
local Window = Rayfield:CreateWindow({
    Name = "Flip Control GUI",
    LoadingTitle = "Loading Flip Hack...",
    LoadingSubtitle = "Just Flip Bro - 100% Control",
    ConfigurationSaving = {Enabled = true, FolderName = "FlipBro", FileName = "config"},
    KeySystem = false
})

local Tab = Window:CreateTab("Coin Control", 4483362458)

-- 100% TAILS Button
Tab:CreateButton({
    Name = "100% TAILS",
    Callback = function()
        ForceMode = "tails"
        Rayfield:Notify({Title = "TAILS LOCKED", Content = "All flips will drop TAILS!", Duration = 3})
        HookFlip()
    end,
})

-- 100% HEADS Button
Tab:CreateButton({
    Name = "100% HEADS",
    Callback = function()
        ForceMode = "heads"
        Rayfield:Notify({Title = "HEADS LOCKED", Content = "All flips will drop HEADS!", Duration = 3})
        HookFlip()
    end,
})

-- Auto Guess Toggle
Tab:CreateToggle({
    Name = "Auto Guess (Uses Current Mode)",
    CurrentValue = false,
    Callback = function(v)
        AutoGuess = v
        if v and ForceMode then
            spawn(AutoFlipLoop)
        end
    end
})

-- Streak Display
local StreakLabel = Tab:CreateLabel("Streak: 0")

-- Reset Streak
Tab:CreateButton({
    Name = "Reset Streak",
    Callback = function()
        Streak = 0
        StreakLabel:Set("Streak: 0")
    end
})

-- Hook RemoteEvent
function HookFlip()
    local old = Action.FireServer
    Action.FireServer = function(self, guess, bet)
        if ForceMode then
            guess = ForceMode  -- Force server to get our choice
            spawn(function()
                wait(0.1)
                local fake = Instance.new("RemoteEvent")
                fake.Parent = RS
                fake:FireServer(ForceMode, true)  -- Simulate win
                game.Debris:AddItem(fake, 1)
            end)
        end
        return old(self, guess, bet)
    end
end

-- Auto Flip Loop
function AutoFlipLoop()
    while AutoGuess and ForceMode do
        Action:FireServer(ForceMode, 1)  -- Bet 1 coin
        Streak += 1
        StreakLabel:Set("Streak: " .. Streak)
        wait(1.2)  -- Safe delay
    end
end

-- Load Success
Rayfield:Notify({
    Title = "Flip Control Loaded!",
    Content = "Click 100% TAILS or HEADS to start!",
    Duration = 5
})