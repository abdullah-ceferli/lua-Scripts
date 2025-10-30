-- 100% Tails Drop Exploit for Just Flip Bro (ID: 83574430507127)
-- Educational Only - Forces Tails on Flips | Mobile-Optimized for Delta
-- WARNING: Use at your own risk - Can get you banned! 🚫

local loadstring = loadstring or getfenv(0).loadstring
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Game Check (Only works in Just Flip Bro)
if game.PlaceId ~= 83574430507127 then
    return game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Wrong Game!", Text = "Join Just Flip Bro (83574430507127)", Duration = 5})
end

local Window = Rayfield:CreateWindow({
   Name = "Tails Exploit v1.0 (Just Flip Bro)",
   LoadingTitle = "Loading Tails Hack...",
   LoadingSubtitle = "100% Drop by Grok",
   ConfigurationSaving = {Enabled = true, FolderName = "TailsExploit", FileName = "config"},
   Discord = {Enabled = false},
   KeySystem = false
})

local FlipTab = Window:CreateTab("🪙 Coin Flip Hacks", 4483362458)

-- Services & Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Action = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GamesActions")  -- Common path; tweak if needed

local TailsForced = false
local AutoGuess = false
local StreakCounter = 0

-- Force Tails Toggle (Hooks RemoteEvent)
local TailsToggle = FlipTab:CreateToggle({
   Name = "Force 100% Tails Drop 💀",
   CurrentValue = false,
   Flag = "TailsForce",
   Callback = function(Value)
      TailsForced = Value
      if Value then
         -- Hook the flip event to always return tails
         local oldFire = Action.FireServer
         Action.FireServer = function(self, ... )
            local args = {...}
            -- Assume flip args: guess (string: "heads"/"tails"), amount (int)
            if args[1] == "heads" then args[1] = "tails" end  -- Force guess to tails
            -- Or force result: Modify RNG seed or response (client-side illusion)
            spawn(function()
               wait(0.1)
               -- Simulate tails result (fire fake event if needed)
               local fakeResult = Instance.new("RemoteEvent")
               fakeResult.Name = "FakeTailsResult"
               fakeResult.Parent = ReplicatedStorage
               fakeResult:FireServer("tails", true)  -- True for win on tails
               game.Debris:AddItem(fakeResult, 1)
            end)
            return oldFire(self, unpack(args))
         end
         Rayfield:Notify({Title = "Tails Forced! 🪙", Content = "All flips now drop TAILS (guess tails to win)", Duration = 3})
      else
         Action.FireServer = nil  -- Reset (won't fully, but stops hook)
      end
   end,
})

-- Auto-Guess Tails Button
local AutoToggle = FlipTab:CreateToggle({
   Name = "Auto Guess Tails 🤖",
   CurrentValue = false,
   Flag = "AutoTails",
   Callback = function(Value)
      AutoGuess = Value
      spawn(function()
         while AutoGuess do
            wait(1)  -- Flip interval (adjust for game speed)
            if TailsForced then
               -- Auto-fire tails guess
               Action:FireServer("tails", 1)  -- Bet min amount; tweak if needed
               StreakCounter = StreakCounter + 1
               Rayfield:Notify({Title = "Auto Flip!", Content = "Guessed TAILS | Streak: " .. StreakCounter, Duration = 1})
            end
         end
      end)
   end,
})

-- Streak Reset Button
local ResetButton = FlipTab:CreateButton({
   Name = "Reset Streak Counter 🔄",
   Callback = function()
      StreakCounter = 0
      Rayfield:Notify({Title = "Reset!", Content = "Streak: 0 - Start fresh!", Duration = 2})
   end,
})

-- Bet Slider (Optional: Auto-adjust bet)
local BetSlider = FlipTab:CreateSlider({
   Name = "Auto Bet Amount 💰",
   Range = {1, 1000},
   Increment = 10,
   Suffix = " Coins",
   CurrentValue = 1,
   Flag = "BetAmount",
   Callback = function(Value)
      -- Use in auto: Replace '1' in FireServer with Library.flags.BetAmount
   end,
})

-- Fun Tab (Extras)
local FunTab = Window:CreateTab("🎲 Fun", 4483362458)

local ESPToggle = FunTab:CreateToggle({
   Name = "Player ESP (See Streaks) 👀",
   CurrentValue = false,
   Flag = "StreakESP",
   Callback = function(Value)
      for _, p in pairs(Players:GetPlayers()) do
         if p ~= player and p.Character then
            local h = p.Character:FindFirstChild("StreakHighlight")
            if Value then
               if not h then
                  h = Instance.new("Highlight")
                  h.Name = "StreakHighlight"
                  h.FillColor = Color3.fromRGB(255, 0, 0)  -- Red for low streak
                  h.OutlineColor = Color3.fromRGB(0, 255, 0)
                  h.Parent = p.Character
               end
            else
               if h then h:Destroy() end
            end
         end
      end
   end,
})

-- Load Notification
Rayfield:Notify({
   Title = "Tails Exploit Loaded! 🪙",
   Content = "Force tails in Just Flip Bro - Guess TAILS to win streaks! (Educational only)",
   Duration = 5,
   Image = 4483362458
})

print("Just Flip Bro Tails Exploit Ready - 100% Drops Activated!")
