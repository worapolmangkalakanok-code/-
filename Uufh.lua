-- ==============================================
-- เห็นโครงสร้างตัว Larry ชัดเจน
-- ==============================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- ชื่อตัวละคร / NPC ที่ต้องการ
local TARGET_NAME = "Larry" -- หรือชื่อที่เกมใช้ เช่น "Mutant"

-- ฟังก์ชันทำให้เห็นตัวชัดเจน
local function showCharacterModel(character)
    if not character then return end
    
    -- ทำให้ทุกส่วนของตัวละครโปร่งใส 0 = เห็นชัดเต็มที่
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 0  -- 0 = ทึบ, 0.5 = ครึ่งโปร่ง
            part.Visible = true
        end
        -- แก้ Humanoid ด้วย ถ้ามีการซ่อน
        if part:IsA("Humanoid") then
            part.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            part.DisplayType = Enum.HumanoidDisplayType.All
        end
    end
    
    -- เพิ่มเส้นขอบให้เด่นชัดขึ้น
    local function addOutline(part)
        if part:FindFirstChild("Outline") then return end
        local outline = Instance.new("SelectionBox")
        outline.Name = "Outline"
        outline.Color3 = Color3.fromRGB(255, 0, 0) -- สีแดง
        outline.LineThickness = 0.05
        outline.Adornee = part
        outline.Parent = part
    end
    
    if character:FindFirstChild("HumanoidRootPart") then
        addOutline(character.HumanoidRootPart)
    end
    
    print("[Larry] แสดงตัวชัดเจนแล้ว!")
end

-- ค้นหาและแสดงตัว Larry
local function findAndShowLarry()
    for _, desc in ipairs(Workspace:GetDescendants()) do
        if desc:IsA("Model") and string.find(string.lower(desc.Name), string.lower(TARGET_NAME)) then
            showCharacterModel(desc)
        end
    end
end

-- ตรวจสอบเรื่อยๆ
RunService.Heartbeat:Connect(function()
    findAndShowLarry()
end)

-- เรียกทำงานทันทีตอนเริ่ม
task.wait(1)
findAndShowLarry()

print("[✅] โหลดเรียบร้อย — เห็นตัว Larry แล้ว")
