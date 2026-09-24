--==================================================
-- DIG UI
-- LocalScript
-- วางใน StarterPlayerScripts
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

--========================
-- SETTINGS
--========================
local enabled = false
local clicking = false

--========================
-- GUI
--========================
local gui = Instance.new("ScreenGui")
gui.Name = "DigUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(360, 190)
main.Position = UDim2.new(0.5, -180, 0.5, -95)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

--========================
-- TITLE
--========================
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 0, 45)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "DIG HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

--========================
-- MINIMIZE
--========================
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(40, 35)
minimize.Position = UDim2.new(1, -85, 0, 5)
minimize.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
minimize.Text = "—"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 22
minimize.Font = Enum.Font.GothamBold
minimize.Parent = main

Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 9)

--========================
-- CLOSE
--========================
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40, 35)
close.Position = UDim2.new(1, -45, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
close.Text = "×"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.Parent = main

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 9)

--========================
-- ON/OFF
--========================
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(300, 55)
toggle.Position = UDim2.fromOffset(30, 65)
toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggle.Text = "ขุด : ปิด"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextSize = 20
toggle.Font = Enum.Font.GothamBold
toggle.Parent = main

Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

--========================
-- STATUS
--========================
local status = Instance.new("TextLabel")
status.Size = UDim2.fromOffset(300, 35)
status.Position = UDim2.fromOffset(30, 130)
status.BackgroundTransparency = 1
status.Text = "สถานะ : หยุด"
status.TextColor3 = Color3.fromRGB(180, 180, 180)
status.TextSize = 16
status.Font = Enum.Font.Gotham
status.Parent = main

--========================
-- DRAG SYSTEM
--========================
local dragging = false
local dragStart
local startPos

local function makeDraggable(object)
	object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

			dragging = true
			dragStart = input.Position
			startPos = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if not dragging then return end

		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			object.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

makeDraggable(main)

--========================
-- MINIMIZED BUTTON
--========================
local mini = Instance.new("TextButton")
mini.Size = UDim2.fromOffset(65, 65)
mini.Position = main.Position
mini.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mini.Text = "DIG"
mini.TextColor3 = Color3.new(1, 1, 1)
mini.TextSize = 16
mini.Font = Enum.Font.GothamBold
mini.Visible = false
mini.Parent = gui

Instance.new("UICorner", mini).CornerRadius = UDim.new(0, 15)

makeDraggable(mini)

--========================
-- MINIMIZE
--========================
minimize.MouseButton1Click:Connect(function()
	mini.Position = main.Position
	main.Visible = false
	mini.Visible = true
end)

mini.MouseButton1Click:Connect(function()
	main.Position = mini.Position
	mini.Visible = false
	main.Visible = true
end)

--========================
-- TOGGLE
--========================
toggle.MouseButton1Click:Connect(function()
	enabled = not enabled

	if enabled then
		toggle.Text = "ขุด : เปิด"
		toggle.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
		status.Text = "สถานะ : กำลังทำงาน"
	else
		toggle.Text = "ขุด : ปิด"
		toggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		status.Text = "สถานะ : หยุด"
	end
end)

--==================================================
-- ใส่ระบบขุดของเกมคุณเองตรงนี้
-- ไม่ยิง RemoteEvent รัว ๆ
--==================================================

task.spawn(function()
	while gui.Parent do
		if enabled then
			-- เรียกฟังก์ชันขุดของเกมคุณเองตรงนี้
			-- เช่น:
			-- Dig()
			
			task.wait(0.2)
		else
			task.wait(0.1)
		end
	end
end)

--========================
-- DELETE CONFIRMATION
--========================
close.MouseButton1Click:Connect(function()

	local confirm = Instance.new("Frame")
	confirm.Size = UDim2.fromOffset(330, 150)
	confirm.Position = UDim2.new(0.5, -165, 0.5, -75)
	confirm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	confirm.BorderSizePixel = 0
	confirm.ZIndex = 10
	confirm.Parent = gui

	Instance.new("UICorner", confirm).CornerRadius = UDim.new(0, 14)

	local question = Instance.new("TextLabel")
	question.Size = UDim2.new(1, -20, 0, 60)
	question.Position = UDim2.fromOffset(10, 15)
	question.BackgroundTransparency = 1
	question.Text = "คุณต้องการลบสคริปต์ใช่หรือไม่?"
	question.TextColor3 = Color3.new(1, 1, 1)
	question.TextSize = 18
	question.Font = Enum.Font.GothamBold
	question.ZIndex = 11
	question.Parent = confirm

	local yes = Instance.new("TextButton")
	yes.Size = UDim2.fromOffset(130, 45)
	yes.Position = UDim2.fromOffset(20, 90)
	yes.BackgroundColor3 = Color3.fromRGB(180, 55, 55)
	yes.Text = "ใช่"
	yes.TextColor3 = Color3.new(1, 1, 1)
	yes.TextSize = 18
	yes.Font = Enum.Font.GothamBold
	yes.ZIndex = 11
	yes.Parent = confirm

	Instance.new("UICorner", yes).CornerRadius = UDim.new(0, 10)

	local no = Instance.new("TextButton")
	no.Size = UDim2.fromOffset(130, 45)
	no.Position = UDim2.fromOffset(180, 90)
	no.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	no.Text = "ไม่"
	no.TextColor3 = Color3.new(1, 1, 1)
	no.TextSize = 18
	no.Font = Enum.Font.GothamBold
	no.ZIndex = 11
	no.Parent = confirm

	Instance.new("UICorner", no).CornerRadius = UDim.new(0, 10)

	no.MouseButton1Click:Connect(function()
		confirm:Destroy()
	end)

	yes.MouseButton1Click:Connect(function()
		enabled = false
		gui:Destroy()
	end)
end)
