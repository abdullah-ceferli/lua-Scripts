-- Fixed Cool Exploit GUI for Delta Executor - Mobile Optimized!
-- Uses Rayfield via RAW GitHub (works on Delta, no key needed for lib)
-- Educational Only - Don't get banned! 🚫

local loadstring = loadstring or getfenv(0).loadstring  -- Delta fallback
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()  -- RAW mirror, Delta-approved

local Window = Rayfield:CreateWindow({
   Name = "Cool Exploit GUI v2.0 (Delta Fix)",
   LoadingTitle = "Booting Hacks...",
   LoadingSubtitle = "Mobile-Ready by Grok",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "DeltaCoolExploit",
      FileName = "config"
   },
   Discord = {
      Enabled = false,
      Invite = "nope",
      RememberJoins = true
   },
   KeySystem = false  -- No key for demo
})

-- Main Tab
local MainTab = Window:CreateTab("🔥 Main Hacks", 4483362458)

-- Speed Slider (Touch-friendly on mobile)
local SpeedSlider = MainTab:CreateSlider({
   Name = "Walk Speed ⚡",
   Range = {16, 300},  -- Lower max for mobile stability
   Increment = 5,
   Suffix = " SPD",
   CurrentValue = 16,
   Flag = "DeltaSpeed",
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value
      end
   end,
})

-- Jump Slider
local JumpSlider = MainTab:CreateSlider({
   Name = "Jump Power 🚀",
   Range = {50, 300},
   Increment = 5,
   Suffix = " JMP",
   CurrentValue = 50,
   Flag = "DeltaJump",
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.JumpPower = Value
         char.Humanoid.JumpHeight = Value / 2.5  -- Delta tweak for smooth mobile jumps
      end
   end,
})

-- Fly Toggle (WASD/Space on PC, Touch-drag on mobile via Delta)
local Flying = false
local FlyToggle = MainTab:CreateToggle({
   Name = "Fly ✈️",
   CurrentValue = false,
   Flag = "DeltaFly",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      local char = player.Character
      if not char then return end
      local root = char:FindFirstChild("HumanoidRootPart")
      if not root then return end

      Flying = Value
      if Value then
         local bv = Instance.new("BodyVelocity")
         bv.MaxForce = Vector3.new(4000, 4000, 4000)
         bv.Velocity = Vector3.new(0, 0, 0)
         bv.Parent = root
         
         -- Mobile/PC fly loop (Delta handles input)
         spawn(function()
            while Flying do
               wait(0.05)  -- Faster for mobile responsiveness
               local cam = workspace.CurrentCamera
               local uis = game:GetService("UserInputService")
               local move = root.CFrame:VectorToWorldSpace(
                  (uis:IsKeyDown(Enum.KeyCode.W) and Vector3.new(0,0,-1) or Vector3.new()) +
                  (uis:IsKeyDown(Enum.KeyCode.S) and Vector3.new(0,0,1) or Vector3.new()) +
                  (uis:IsKeyDown(Enum.KeyCode.A) and Vector3.new(-1,0,0) or Vector3.new()) +
                  (uis:IsKeyDown(Enum.KeyCode.D) and Vector3.new(1,0,0) or Vector3.new()) +
                  (uis:IsKeyDown(Enum.KeyCode.Space) and Vector3.new(0,1,0) or Vector3.new()) +
                  (uis:IsKeyDown(Enum.KeyCode.LeftShift) and Vector3.new(0,-1,0) or Vector3.new())
               )
               bv.Velocity = move * 40  -- Slower for mobile control
            end
            if bv then bv:Destroy() end
         end)
      else
         if root:FindFirstChild("BodyVelocity") then
            root.BodyVelocity:Destroy()
         end
      end
   end,
})

-- Noclip (Mobile-optimized loop)
local NoclipToggle = MainTab:CreateToggle({
   Name = "Noclip 👻",
   CurrentValue = false,
   Flag = "DeltaNoclip",
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if not char then return end
      
      spawn(function()
         while Value do
            for _, part in pairs(char:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = false
               end
            end
            wait(0.1)
         end
         -- Reset collisions
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
               part.CanCollide = true
            end
         end
      end)
   end,
})

-- Teleport Button
local TeleportButton = MainTab:CreateButton({
   Name = "Random Teleport 🌪️",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("HumanoidRootPart") then
         char.HumanoidRootPart.CFrame = CFrame.new(
            math.random(-200, 200), 
            50, 
            math.random(-200, 200)
         )
      end
      Rayfield:Notify({Title = "Teleported! ✨", Content = "Zoom zoom!", Duration = 2})
   end,
})

-- Fun Tab
local FunTab = Window:CreateTab("🎉 Fun", 4483362458)

local ESPToggle = FunTab:CreateToggle({
   Name = "Player ESP 👁️",
   CurrentValue = false,
   Flag = "DeltaESP",
   Callback = function(Value)
      for _, p in pairs(game.Players:GetPlayers()) do
         if p ~= game.Players.LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("ESPHighlight")
            if Value then
               if not h then
                  h = Instance.new("Highlight")
                  h.Name = "ESPHighlight"
                  h.FillColor = Color3.fromRGB(0, 255, 0)  -- Green for visibility
                  h.OutlineColor = Color3.fromRGB(255, 255, 0)
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
   Title = "Delta Cool GUI Loaded! 📱",
   Content = "RAW fetch worked - Hacks active! (Educational vibes only)",
   Duration = 4,
   Image = 4483362458
})

print("Delta-Fixed Exploit GUI Ready - Fly safe!")