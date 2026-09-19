local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local NORMAL_SPEED = 16
local FAST_SPEED = 100

local speedEnabled = false
local infiniteJumpEnabled = false
local autoJumpEnabled = false
local npcVisionEnabled = false

local highlights = {}

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "GameMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 500, 0, 360)
frame.Position = UDim2.new(0.5, -250, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 15)
frameCorner.Parent = frame

--==================================================
-- TITLE
--==================================================

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 48)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Active = true
titleBar.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚙ เมนูหลัก"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 38, 0, 38)
closeButton.Position = UDim2.new(1, -44, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 9)
closeCorner.Parent = closeButton

--==================================================
-- CATEGORY PANEL
--==================================================

local categoryPanel = Instance.new("Frame")
categoryPanel.Size = UDim2.new(0, 150, 1, -58)
categoryPanel.Position = UDim2.new(0, 8, 0, 55)
categoryPanel.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
categoryPanel.BorderSizePixel = 0
categoryPanel.Parent = frame

local categoryCorner = Instance.new("UICorner")
categoryCorner.CornerRadius = UDim.new(0, 10)
categoryCorner.Parent = categoryPanel

local categoryTitle = Instance.new("TextLabel")
categoryTitle.Size = UDim2.new(1, -20, 0, 35)
categoryTitle.Position = UDim2.new(0, 10, 0, 5)
categoryTitle.BackgroundTransparency = 1
categoryTitle.Text = "หมวดหมู่"
categoryTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
categoryTitle.TextSize = 16
categoryTitle.Font = Enum.Font.GothamBold
categoryTitle.Parent = categoryPanel

--==================================================
-- FUNCTION PANEL
--==================================================

local functionPanel = Instance.new("Frame")
functionPanel.Size = UDim2.new(1, -175, 1, -58)
functionPanel.Position = UDim2.new(0, 167, 0, 55)
functionPanel.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
functionPanel.BorderSizePixel = 0
functionPanel.Parent = frame

local functionCorner = Instance.new("UICorner")
functionCorner.CornerRadius = UDim.new(0, 10)
functionCorner.Parent = functionPanel

local functionTitle = Instance.new("TextLabel")
functionTitle.Size = UDim2.new(1, -20, 0, 35)
functionTitle.Position = UDim2.new(0, 10, 0, 5)
functionTitle.BackgroundTransparency = 1
functionTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
functionTitle.TextSize = 16
functionTitle.Font = Enum.Font.GothamBold
functionTitle.TextXAlignment = Enum.TextXAlignment.Left
functionTitle.Parent = functionPanel

--==================================================
-- OPEN BUTTON
--==================================================

local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 65, 0, 65)
openButton.Position = frame.Position
openButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
openButton.Text = "☰"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 27
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 15)
openCorner.Parent = openButton

--==================================================
-- BUTTON FUNCTIONS
--==================================================

local function clearFunctions()
	for _, object in ipairs(functionPanel:GetChildren()) do
		if object:IsA("TextButton") or object.Name == "InfoLabel" then
			object:Destroy()
		end
	end
end

local function createFunctionButton(text, y, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -20, 0, 48)
	button.Position = UDim2.new(0, 10, 0, y)
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Text = text
	button.TextSize = 16
	button.Font = Enum.Font.GothamBold
	button.Parent = functionPanel

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 9)
	corner.Parent = button

	button.Activated:Connect(callback)

	return button
end

--==================================================
-- SPEED
--==================================================

local function updateSpeed()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = speedEnabled and FAST_SPEED or NORMAL_SPEED
	end
end

--==================================================
-- INFINITE JUMP
-- แยกจาก AUTO JUMP
--==================================================

UserInputService.JumpRequest:Connect(function()
	if not infiniteJumpEnabled then
		return
	end

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid and humanoid.Health > 0 then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

--==================================================
-- AUTO JUMP
-- ไม่เกี่ยวกับ INFINITE JUMP
--==================================================

local autoJumpTimer = 0

RunService.Heartbeat:Connect(function(dt)

	if not autoJumpEnabled then
		autoJumpTimer = 0
		return
	end

	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end

	autoJumpTimer += dt

	-- กระโดดเมื่ออยู่บนพื้นเท่านั้น
	if humanoid.FloorMaterial ~= Enum.Material.Air then

		if autoJumpTimer >= 0.25 then
			autoJumpTimer = 0

			-- สั่งกระโดดเอง
			humanoid.Jump = true
		end
	end
end)

--==================================================
-- NPC VISION
--==================================================

local function isNPC(model)

	if not model:IsA("Model") then
		return false
	end

	if not model:FindFirstChildOfClass("Humanoid") then
		return false
	end

	if Players:GetPlayerFromCharacter(model) then
		return false
	end

	return true
end

local function addNPC(model)

	if not npcVisionEnabled then return end
	if not isNPC(model) then return end
	if highlights[model] then return end

	local highlight = Instance.new("Highlight")

	highlight.Name = "NPCVision"
	highlight.Adornee = model
	highlight.FillColor = Color3.fromRGB(255, 60, 60)
	highlight.FillTransparency = 0.55
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

	highlight.Parent = model

	highlights[model] = highlight
end

local function scanNPCs()

	for _, object in ipairs(workspace:GetDescendants()) do
		if object:IsA("Model") then
			addNPC(object)
		end
	end
end

local function removeNPCVision()

	for model, highlight in pairs(highlights) do

		if highlight then
			highlight:Destroy()
		end

		highlights[model] = nil
	end
end

workspace.DescendantAdded:Connect(function(object)

	if npcVisionEnabled and object:IsA("Model") then
		task.wait(0.1)
		addNPC(object)
	end
end)

--==================================================
-- MAIN PAGE
--==================================================

local function showMain()

	functionTitle.Text = "ฟังก์ชัน • 🏠 หน้าหลัก"
	clearFunctions()

	-- วิ่งเร็ว
	local speedButton = createFunctionButton(
		speedEnabled
			and "⚡ วิ่งเร็ว 100   [ เปิด ]"
			or "⚡ วิ่งเร็ว 100   [ ปิด ]",
		50,
		function()
			speedEnabled = not speedEnabled
			updateSpeed()
			showMain()
		end
	)

	if speedEnabled then
		speedButton.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
	end

	-- กระโดดไม่จำกัด
	local infiniteButton = createFunctionButton(
		infiniteJumpEnabled
			and "🦘 กระโดดไม่จำกัด   [ เปิด ]"
			or "🦘 กระโดดไม่จำกัด   [ ปิด ]",
		108,
		function()
			infiniteJumpEnabled = not infiniteJumpEnabled
			showMain()
		end
	)

	if infiniteJumpEnabled then
		infiniteButton.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
	end

	-- ออโต้กระโดด
	local autoButton = createFunctionButton(
		autoJumpEnabled
			and "🤖 ออโต้กระโดด   [ เปิด ]"
			or "🤖 ออโต้กระโดด   [ ปิด ]",
		166,
		function()
			autoJumpEnabled = not autoJumpEnabled
			autoJumpTimer = 0
			showMain()
		end
	)

	if autoJumpEnabled then
		autoButton.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
	end
end

--==================================================
-- GOD EYE PAGE
--==================================================

local function showGodEye()

	functionTitle.Text = "ฟังก์ชัน • 👁 ตาเทพ"
	clearFunctions()

	local npcButton = createFunctionButton(
		npcVisionEnabled
			and "👁 มอง NPC   [ เปิด ]"
			or "👁 มอง NPC   [ ปิด ]",
		50,
		function()

			npcVisionEnabled = not npcVisionEnabled

			if npcVisionEnabled then
				scanNPCs()
			else
				removeNPCVision()
			end

			showGodEye()
		end
	)

	if npcVisionEnabled then
		npcButton.BackgroundColor3 = Color3.fromRGB(0, 170, 80)
	end
end

--==================================================
-- CATEGORY BUTTONS
--==================================================

local mainCategoryButton = Instance.new("TextButton")
mainCategoryButton.Size = UDim2.new(1, -15, 0, 50)
mainCategoryButton.Position = UDim2.new(0, 7, 0, 45)
mainCategoryButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
mainCategoryButton.Text = "🏠  หน้าหลัก"
mainCategoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainCategoryButton.TextSize = 15
mainCategoryButton.Font = Enum.Font.GothamBold
mainCategoryButton.Parent = categoryPanel

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainCategoryButton

local godEyeButton = Instance.new("TextButton")
godEyeButton.Size = UDim2.new(1, -15, 0, 50)
godEyeButton.Position = UDim2.new(0, 7, 0, 103)
godEyeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
godEyeButton.Text = "👁  ตาเทพ"
godEyeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
godEyeButton.TextSize = 15
godEyeButton.Font = Enum.Font.GothamBold
godEyeButton.Parent = categoryPanel

local godCorner = Instance.new("UICorner")
godCorner.CornerRadius = UDim.new(0, 8)
godCorner.Parent = godEyeButton

mainCategoryButton.Activated:Connect(function()

	mainCategoryButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
	godEyeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

	showMain()
end)

godEyeButton.Activated:Connect(function()

	godEyeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
	mainCategoryButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

	showGodEye()
end)

--==================================================
-- CLOSE / OPEN
--==================================================

closeButton.Activated:Connect(function()

	openButton.Position = frame.Position

	frame.Visible = false
	openButton.Visible = true
end)

openButton.Activated:Connect(function()

	frame.Position = openButton.Position

	frame.Visible = true
	openButton.Visible = false
end)

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart
local startPosition

titleBar.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = frame.Position

		input.Changed:Connect(function()

			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end

		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then return end

	if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

		local delta = input.Position - dragStart

		frame.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

--==================================================
-- RESPAWN
--==================================================

player.CharacterAdded:Connect(function()

	task.wait(0.5)

	updateSpeed()
end)

--==================================================
-- START
--==================================================

showMain()
