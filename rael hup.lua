-- ==============================================
--   rael hub
--   UI Style: Find The Master / Find The Markers
-- ==============================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "rael hub",
   Icon = 0,
   LoadingTitle = "rael hub",
   LoadingSubtitle = "by rael-develop3r",
   ShowText = "rael hub",
   Theme = "Default",  -- ปรับให้เข้ากับสไตล์ Find The Master
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "raelhub",
      FileName = "raelhub_FindTheMaster"
   },
})

-- ========== หน้าหลัก — เหมือน Find The Master ==========
local MainTab = Window:CreateTab("🏠 หน้าหลัก", 4483362458)
local Section = MainTab:CreateSection("ฟีเจอร์หลัก")

-- ปุ่มไฮไลท์
local Button1 = MainTab:CreateButton({
   Name = "🔍 ค้นหา Marker",
   Callback = function()
      print("[rael hub] กำลังค้นหา Marker...")
      -- ใส่โค้ดที่นี่
   end,
})

-- ปุ่มวาร์ป
local Button2 = MainTab:CreateButton({
   Name = "⚡ วาร์ปไปจุดต่างๆ",
   Callback = function()
      print("[rael hub] เปิดเมนูวาร์ป")
   end,
})

-- สไลด์เดอร์ ความเร็ว
local Slider1 = MainTab:CreateSlider({
   Name = "🏃 ความเร็วการเดิน",
   Range = {0, 200},
   Increment = 1,
   Default = 16,
   Suffix = " ความเร็ว",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- สไลด์เดอร์ กระโดดสูง
local Slider2 = MainTab:CreateSlider({
   Name = "⬆️ ความสูงกระโดด",
   Range = {0, 200},
   Increment = 1,
   Default = 50,
   Suffix = " ความสูง",
   Callback = function(Value)
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- สวิตช์ อมตะ
local Toggle1 = MainTab:CreateToggle({
   Name = "🛡️ อมตะ",
   CurrentValue = false,
   Callback = function(Value)
       local plr = game.Players.LocalPlayer
       if plr.Character and plr.Character:FindFirstChild("Humanoid") then
           plr.Character.Humanoid.HealthDisplayType = Enum.HealthDisplayType.AlwaysShow
           plr.Character.Humanoid.MaxHealth = math.huge
           plr.Character.Humanoid.Health = math.huge
       end
   end,
})

-- ========== เมนูที่ 2 — อื่นๆ ==========
local SecondTab = Window:CreateTab("📂 อื่นๆ", 4483362458)
local Section2 = SecondTab:CreateSection("ตัวเลือกเพิ่มเติม")

local Button3 = SecondTab:CreateButton({
   Name = "🔄 รีเฟรช",
   Callback = function()
       print("[rael hub] รีเฟรชแล้ว")
   end,
})

local Toggle2 = SecondTab:CreateToggle({
   Name = "🌙 กลางวัน/กลางคืน",
   CurrentValue = false,
   Callback = function(Value)
       game.Lighting.ClockTime = Value and 12 or 24
   end,
})

Rayfield:Notify({
   Title = "rael hub",
   Content = "โหลดเสร็จเรียบร้อย!",
   Duration = 5,
   Image = 14183548964
})
