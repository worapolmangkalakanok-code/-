--// NIULAI HUB | DORA UI
--// LocalScript > StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local MPS = game:GetService("MarketplaceService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local speedOn = false
local jumpOn = false
local noclipOn = false
local espPlayer = false
local espNPC = false
local deleted = false

local Character
local Humanoid

local function LoadCharacter()
	Character = LP.Character or LP.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
end

LoadCharacter()

LP.CharacterAdded:Connect(function()
	task.wait(.3)
	if not deleted then
		LoadCharacter()
	end
end)

--==================================================
-- GUI
--==================================================

local GUI = Instance.new("ScreenGui")
GUI.Name = "NIULAI_HUB"
GUI.ResetOnSpawn = false
GUI.Parent = LP:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(680,430)
Main.Position = UDim2.new(.5,-340,.5,-215)
Main.BackgroundColor3 = Color3.fromRGB(18,18,22)
Main.BorderSizePixel = 0
Main.Parent = GUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,14)
MainCorner.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,50)
Top.BackgroundColor3 = Color3.fromRGB(12,12,15)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0,14)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-100,1,0)
Title.Position = UDim2.fromOffset(52,0)
Title.BackgroundTransparency = 1
Title.Text = "NIULAI HUB | DORA UI"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Delete = Instance.new("TextButton")
Delete.Size = UDim2.fromOffset(36,32)
Delete.Position = UDim2.fromOffset(8,9)
Delete.Text = "×"
Delete.TextSize = 22
Delete.TextColor3 = Color3.new(1,1,1)
Delete.BackgroundColor3 = Color3.fromRGB(35,35,42)
Delete.BorderSizePixel = 0
Delete.Parent = Top

Instance.new("UICorner",Delete).CornerRadius = UDim.new(0,8)

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(36,32)
Minimize.Position = UDim2.new(1,-44,0,9)
Minimize.Text = "—"
Minimize.TextSize = 20
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.BackgroundColor3 = Color3.fromRGB(35,35,42)
Minimize.BorderSizePixel = 0
Minimize.Parent = Top

Instance.new("UICorner",Minimize).CornerRadius = UDim.new(0,8)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,145,1,-65)
Sidebar.Position = UDim2.fromOffset(10,58)
Sidebar.BackgroundColor3 = Color3.fromRGB(13,13,17)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

Instance.new("UICorner",Sidebar).CornerRadius = UDim.new(0,10)

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0,7)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-170,1,-65)
Content.Position = UDim2.fromOffset(160,58)
Content.BackgroundColor3 = Color3.fromRGB(23,23,28)
Content.BorderSizePixel = 0
Content.Parent = Main

Instance.new("UICorner",Content).CornerRadius = UDim.new(0,10)

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0,8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = Content

local function ClearContent()
	for _,v in ipairs(Content:GetChildren()) do
		if v ~= ContentLayout and not v:IsA("UICorner") then
			v:Destroy()
		end
	end
end

local function AddLabel(text)
	local L = Instance.new("TextLabel")
	L.Size = UDim2.new(1,-20,0,34)
	L.BackgroundTransparency = 1
	L.Text = text
	L.TextColor3 = Color3.new(1,1,1)
	L.TextSize = 14
	L.Font = Enum.Font.GothamMedium
	L.TextXAlignment = Enum.TextXAlignment.Left
	L.Parent = Content
	return L
end

local function AddButton(parent,text)
	local B = Instance.new("TextButton")
	B.Size = UDim2.new(1,-14,0,42)
	B.BackgroundColor3 = Color3.fromRGB(35,35,42)
	B.BorderSizePixel = 0
	B.Text = text
	B.TextColor3 = Color3.new(1,1,1)
	B.TextSize = 14
	B.Font = Enum.Font.GothamMedium
	B.Parent = parent

	Instance.new("UICorner",B).CornerRadius = UDim.new(0,8)

	return B
end

local function AddToggle(text,getValue,setValue)
	local B = AddButton(Content,text.." : "..(getValue() and "เปิด" or "ปิด"))

	B.MouseButton1Click:Connect(function()
		if deleted then return end

		setValue(not getValue())
		B.Text = text.." : "..(getValue() and "เปิด" or "ปิด")
	end)

	return B
end

--==================================================
-- HOME
--==================================================

local function Home()
	ClearContent()

	AddLabel("หน้าหลัก")

	AddToggle(
		"วิ่งเร็ว 100",
		function()
			return speedOn
		end,
		function(v)
			speedOn = v

			if Humanoid then
				Humanoid.WalkSpeed = v and 100 or 16
			end
		end
	)

	AddToggle(
		"กระโดดไม่จำกัด",
		function()
			return jumpOn
		end,
		function(v)
			jumpOn = v
		end
	)

	AddToggle(
		"ทะลุกำแพง",
		function()
			return noclipOn
		end,
		function(v)
			noclipOn = v
		end
	)
end

--==================================================
-- ATTACK
--==================================================

local function Attack()
	ClearContent()

	AddLabel("โจมตี")

	local B = AddButton(Content,"ล็อกหัวผู้เล่นใกล้ที่สุด")

	B.MouseButton1Click:Connect(function()
		if deleted then return end

		if not Character then return end

		local Root = Character:FindFirstChild("HumanoidRootPart")
		if not Root then return end

		local Target
		local Distance

		for _,Player in ipairs(Players:GetPlayers()) do
			if Player ~= LP and Player.Character then

				local TargetRoot =
					Player.Character:FindFirstChild("HumanoidRootPart")

				if TargetRoot then
					local D =
						(Root.Position - TargetRoot.Position).Magnitude

					if not Distance or D < Distance then
						Distance = D
						Target = Player
					end
				end
			end
		end

		if Target and Target.Character then
			local Head =
				Target.Character:FindFirstChild("Head")

			if Head then
				Camera.CFrame =
					CFrame.lookAt(
						Camera.CFrame.Position,
						Head.Position
					)
			end
		end
	end)
end

--==================================================
-- TOOLS
--==================================================

local function Tools()
	ClearContent()

	AddLabel("เครื่องมือ")

	AddToggle(
		"วิ่งเร็ว 100",
		function()
			return speedOn
		end,
		function(v)
			speedOn = v

			if Humanoid then
				Humanoid.WalkSpeed = v and 100 or 16
			end
		end
	)

	AddToggle(
		"ทะลุกำแพง",
		function()
			return noclipOn
		end,
		function(v)
			noclipOn = v
		end
	)
end

--==================================================
-- GOD EYE
--==================================================

local function ClearESP()
	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Highlight") and v.Name == "NIULAI_ESP" then
			v:Destroy()
		end
	end
end

local function AddESP(Model)
	if not Model then return end
	if Model:FindFirstChild("NIULAI_ESP") then return end

	local H = Instance.new("Highlight")
	H.Name = "NIULAI_ESP"
	H.FillColor = Color3.fromRGB(255,0,0)
	H.OutlineColor = Color3.fromRGB(255,0,0)
	H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	H.Parent = Model
end

local function GodEye()
	ClearContent()

	AddLabel("ตาเทพ")

	AddToggle(
		"มองผู้เล่น",
		function()
			return espPlayer
		end,
		function(v)
			espPlayer = v

			if not v then
				ClearESP()
			end
		end
	)

	AddToggle(
		"มอง NPC",
		function()
			return espNPC
		end,
		function(v)
			espNPC = v

			if not v then
				ClearESP()
			end
		end
	)
end

--==================================================
-- SETTINGS
--==================================================

local function Settings()
	ClearContent()

	AddLabel("Settings")
	AddLabel("Name : "..LP.Name)
	AddLabel("DisplayName : "..LP.DisplayName)
	AddLabel("UserId : "..LP.UserId)

	local GameName = "Unknown"

	pcall(function()
		GameName = MPS:GetProductInfo(game.PlaceId).Name
	end)

	AddLabel("Game : "..GameName)
	AddLabel("PlaceId : "..game.PlaceId)
end

--==================================================
-- SIDEBAR BUTTONS
--==================================================

local function AddTab(text,callback)
	local B = AddButton(Sidebar,text)

	B.MouseButton1Click:Connect(function()
		if deleted then return end
		callback()
	end)
end

AddTab("หน้าหลัก",Home)
AddTab("โจมตี",Attack)
AddTab("เครื่องมือ",Tools)
AddTab("ตาเทพ",GodEye)
AddTab("Settings",Settings)

--==================================================
-- INFINITE JUMP
--==================================================

UIS.JumpRequest:Connect(function()
	if deleted then return end

	if jumpOn and Humanoid then
		Humanoid:ChangeState(
			Enum.HumanoidStateType.Jumping
		)
	end
end)

--==================================================
-- NOCLIP / SPEED / ESP
--==================================================

RS.Stepped:Connect(function()
	if deleted then return end

	if noclipOn and Character then
		for _,v in ipairs(Character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end
end)

RS.Heartbeat:Connect(function()
	if deleted then return end

	if speedOn and Humanoid then
		Humanoid.WalkSpeed = 100
	end

	if espPlayer then
		for _,Player in ipairs(Players:GetPlayers()) do
			if Player ~= LP and Player.Character then
				AddESP(Player.Character)
			end
		end
	end

	if espNPC then
		for _,v in ipairs(workspace:GetDescendants()) do
			if v:IsA("Model")
				and not Players:GetPlayerFromCharacter(v)
				and v:FindFirstChildOfClass("Humanoid") then

				AddESP(v)
			end
		end
	end
end)

--==================================================
-- DELETE CONFIRM
--==================================================

local Confirm = Instance.new("Frame")
Confirm.Size = UDim2.fromOffset(350,160)
Confirm.Position = UDim2.new(.5,-175,.5,-80)
Confirm.BackgroundColor3 = Color3.fromRGB(20,20,25)
Confirm.BorderSizePixel = 0
Confirm.Visible = false
Confirm.ZIndex = 50
Confirm.Parent = GUI

Instance.new("UICorner",Confirm).CornerRadius = UDim.new(0,14)

local Question = Instance.new("TextLabel")
Question.Size = UDim2.new(1,-20,0,60)
Question.Position = UDim2.fromOffset(10,10)
Question.BackgroundTransparency = 1
Question.Text = "ต้องการลบสคริปต์ใช่หรือไม่?"
Question.TextColor3 = Color3.new(1,1,1)
Question.TextSize = 17
Question.Font = Enum.Font.GothamBold
Question.ZIndex = 51
Question.Parent = Confirm

local Yes = AddButton(Confirm,"ใช่")
Yes.Size = UDim2.fromOffset(140,42)
Yes.Position = UDim2.fromOffset(20,105)
Yes.ZIndex = 51

local No = AddButton(Confirm,"ไม่")
No.Size = UDim2.fromOffset(140,42)
No.Position = UDim2.fromOffset(190,105)
No.ZIndex = 51

Delete.MouseButton1Click:Connect(function()
	if deleted then return end
	Confirm.Visible = true
end)

No.MouseButton1Click:Connect(function()
	Confirm.Visible = false
end)

Yes.MouseButton1Click:Connect(function()
	if deleted then return end

	deleted = true

	speedOn = false
	jumpOn = false
	noclipOn = false
	espPlayer = false
	espNPC = false

	if Humanoid then
		Humanoid.WalkSpeed = 16
	end

	ClearESP()

	GUI:Destroy()
end)

--==================================================
-- MINIMIZED SQUARE
--==================================================

local Small = Instance.new("TextButton")
Small.Size = UDim2.fromOffset(55,55)
Small.Position = UDim2.new(.5,-27,.5,-27)
Small.Text = ""
Small.BackgroundColor3 = Color3.fromRGB(12,12,15)
Small.BorderSizePixel = 0
Small.Visible = false
Small.Parent = GUI

Instance.new("UICorner",Small).CornerRadius = UDim.new(0,14)

--==================================================
-- MINIMIZE
--==================================================

Minimize.MouseButton1Click:Connect(function()
	if deleted then return end

	Main.Visible = false
	Small.Visible = true
end)

--==================================================
-- DRAG MAIN
--==================================================

local MainDragging = false
local MainStart
local MainInput

Top.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		MainDragging = true
		MainStart = Input.Position
		MainInput = Main.Position
	end
end)

UIS.InputChanged:Connect(function(Input)
	if not MainDragging then return end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - MainStart

		Main.Position = UDim2.new(
			MainInput.X.Scale,
			MainInput.X.Offset + Delta.X,

			MainInput.Y.Scale,
			MainInput.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		MainDragging = false
	end
end)

--==================================================
-- DRAG SMALL SQUARE
--==================================================

local SmallDragging = false
local SmallMoved = false
local SmallStart
local SmallInput

Small.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		SmallDragging = true
		SmallMoved = false
		SmallStart = Input.Position
		SmallInput = Small.Position
	end
end)

UIS.InputChanged:Connect(function(Input)
	if not SmallDragging then return end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - SmallStart

		if math.abs(Delta.X) > 5
			or math.abs(Delta.Y) > 5 then

			SmallMoved = true
		end

		Small.Position = UDim2.new(
			SmallInput.X.Scale,
			SmallInput.X.Offset + Delta.X,

			SmallInput.Y.Scale,
			SmallInput.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		if SmallDragging and not SmallMoved then
			Small.Visible = false
			Main.Visible = true
		end

		SmallDragging = false
	end
end)

--==================================================
-- START
--==================================================

Home()
