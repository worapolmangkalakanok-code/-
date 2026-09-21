-- NIULAI HUB | DORA UI
local P=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local MPS=game:GetService("MarketplaceService")
local plr=P.LocalPlayer
local cam=workspace.CurrentCamera

local speed,jump,noclip,esp,npc=false,false,false,false,false
local char,hum
local function chr()
	char=plr.Character or plr.CharacterAdded:Wait()
	hum=char:WaitForChild("Humanoid")
end
chr()
plr.CharacterAdded:Connect(function() task.wait(.3);chr() end)

-- GUI
local gui=Instance.new("ScreenGui",plr.PlayerGui)
gui.Name="NIULAI_HUB"
local main=Instance.new("Frame",gui)
main.Size=UDim2.fromOffset(680,430)
main.Position=UDim2.new(.5,-340,.5,-215)
main.BackgroundColor3=Color3.fromRGB(18,18,22)
Instance.new("UICorner",main).CornerRadius=UDim.new(0,14)

local top=Instance.new("Frame",main)
top.Size=UDim2.new(1,0,0,50)
top.BackgroundColor3=Color3.fromRGB(12,12,15)
Instance.new("UICorner",top).CornerRadius=UDim.new(0,14)

local function btn(parent,text,size,pos)
	local b=Instance.new("TextButton",parent)
	b.Size=size;b.Position=pos;b.Text=text
	b.TextColor3=Color3.new(1,1,1)
	b.BackgroundColor3=Color3.fromRGB(35,35,42)
	b.BorderSizePixel=0
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
	return b
end

local del=btn(top,"×",UDim2.fromOffset(36,32),UDim2.fromOffset(8,9))
local mini=btn(top,"—",UDim2.fromOffset(36,32),UDim2.new(1,-44,0,9))

local title=Instance.new("TextLabel",top)
title.Size=UDim2.new(1,-100,1,0)
title.Position=UDim2.fromOffset(52,0)
title.BackgroundTransparency=1
title.Text="NIULAI HUB | DORA UI"
title.TextColor3=Color3.new(1,1,1)
title.TextSize=17
title.Font=Enum.Font.GothamBold
title.TextXAlignment=Enum.TextXAlignment.Left

local side=Instance.new("Frame",main)
side.Size=UDim2.new(0,145,1,-65)
side.Position=UDim2.fromOffset(10,58)
side.BackgroundColor3=Color3.fromRGB(13,13,17)
Instance.new("UICorner",side).CornerRadius=UDim.new(0,10)

local sl=Instance.new("UIListLayout",side)
sl.Padding=UDim.new(0,7)
sl.HorizontalAlignment=Enum.HorizontalAlignment.Center

local content=Instance.new("Frame",main)
content.Size=UDim2.new(1,-170,1,-65)
content.Position=UDim2.fromOffset(160,58)
content.BackgroundColor3=Color3.fromRGB(23,23,28)
Instance.new("UICorner",content).CornerRadius=UDim.new(0,10)

local function clear()
	for _,v in content:GetChildren() do
		if not v:IsA("UICorner") then v:Destroy() end
	end
	local l=Instance.new("UIListLayout",content)
	l.Padding=UDim.new(0,8)
end

local function label(t)
	local x=Instance.new("TextLabel",content)
	x.Size=UDim2.new(1,-20,0,34)
	x.BackgroundTransparency=1
	x.Text=t;x.TextColor3=Color3.new(1,1,1)
	x.Font=Enum.Font.GothamMedium;x.TextSize=14
	x.TextXAlignment=Enum.TextXAlignment.Left
end

local function toggle(t,get,set)
	local b=btn(content,t.." : "..(get() and "เปิด" or "ปิด"),
		UDim2.new(1,-20,0,42),UDim2.fromOffset(0,0))
	local function up() b.Text=t.." : "..(get() and "เปิด" or "ปิด") end
	b.MouseButton1Click:Connect(function() set(not get());up() end)
end

-- HOME
local function home()
	clear();label("หน้าหลัก")
	toggle("วิ่งเร็ว 100",function()return speed end,function(v)
		speed=v;if hum then hum.WalkSpeed=v and 100 or 16 end
	end)
	toggle("กระโดดไม่จำกัด",function()return jump end,function(v)jump=v end)
	toggle("ทะลุกำแพง",function()return noclip end,function(v)noclip=v end)
end

-- ATTACK
local function attack()
	clear();label("โจมตี")
	local b=btn(content,"ล็อกหัวผู้เล่นใกล้ที่สุด",
		UDim2.new(1,-20,0,42),UDim2.new())
	b.MouseButton1Click:Connect(function()
		local root=char and char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local target,dist
		for _,p in P:GetPlayers() do
			local r=p~=plr and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
			if r then
				local d=(root.Position-r.Position).Magnitude
				if not dist or d<dist then target,dist=p,d end
			end
		end
		local h=target and target.Character:FindFirstChild("Head")
		if h then cam.CFrame=CFrame.lookAt(cam.CFrame.Position,h.Position) end
	end)
end

-- TOOLS
local function tools()
	clear();label("เครื่องมือ")
	toggle("ทะลุกำแพง",function()return noclip end,function(v)noclip=v end)
	toggle("วิ่งเร็ว 100",function()return speed end,function(v)
		speed=v;if hum then hum.WalkSpeed=v and 100 or 16 end
	end)
end

-- GOD EYE
local function clearESP()
	for _,v in workspace:GetDescendants() do
		if v:IsA("Highlight") and v.Name=="NIULAI_ESP" then v:Destroy() end
	end
end

local function makeESP(x)
	if x:FindFirstChild("NIULAI_ESP") then return end
	local h=Instance.new("Highlight",x)
	h.Name="NIULAI_ESP"
	h.FillColor=Color3.new(1,0,0)
	h.OutlineColor=Color3.new(1,0,0)
	h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
end

local function god()
	clear();label("ตาเทพ")
	toggle("มองผู้เล่น",function()return esp end,function(v)
		esp=v;if not v then clearESP() end
	end)
	toggle("มอง NPC",function()return npc end,function(v)
		npc=v;if not v then clearESP() end
	end)
end

-- SETTINGS
local function settings()
	clear();label("Settings")
	label("Name : "..plr.Name)
	label("DisplayName : "..plr.DisplayName)
	label("UserId : "..plr.UserId)
	local name="Unknown"
	pcall(function()name=MPS:GetProductInfo(game.PlaceId).Name end)
	label("Game : "..name)
	label("PlaceId : "..game.PlaceId)
end

local function tab(t,f)
	local b=btn(side,t,UDim2.new(1,-14,0,42),UDim2.new())
	b.MouseButton1Click:Connect(f)
end

tab("หน้าหลัก",home)
tab("โจมตี",attack)
tab("เครื่องมือ",tools)
tab("ตาเทพ",god)
tab("Settings",settings)

-- FUNCTIONS
UIS.JumpRequest:Connect(function()
	if jump and hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

RS.Stepped:Connect(function()
	if noclip and char then
		for _,v in char:GetDescendants() do
			if v:IsA("BasePart") then v.CanCollide=false end
		end
	end
end)

RS.Heartbeat:Connect(function()
	if speed and hum then hum.WalkSpeed=100 end

	if esp then
		for _,p in P:GetPlayers() do
			if p~=plr and p.Character then makeESP(p.Character) end
		end
	end

	if npc then
		for _,v in workspace:GetDescendants() do
			if v:IsA("Model") and not P:GetPlayerFromCharacter(v)
			and v:FindFirstChildOfClass("Humanoid") then
				makeESP(v)
			end
		end
	end
end)

-- DELETE CONFIRM
local confirm=Instance.new("Frame",gui)
confirm.Size=UDim2.fromOffset(350,160)
confirm.Position=UDim2.new(.5,-175,.5,-80)
confirm.BackgroundColor3=Color3.fromRGB(20,20,25)
confirm.Visible=false
confirm.ZIndex=50
Instance.new("UICorner",confirm).CornerRadius=UDim.new(0,14)

local q=Instance.new("TextLabel",confirm)
q.Size=UDim2.new(1,-20,0,60)
q.Position=UDim2.fromOffset(10,10)
q.BackgroundTransparency=1
q.Text="ต้องการลบสคริปต์ใช่หรือไม่?"
q.TextColor3=Color3.new(1,1,1)
q.TextSize=17
q.Font=Enum.Font.GothamBold
q.ZIndex=51

local yes=btn(confirm,"ใช่",UDim2.fromOffset(140,42),UDim2.fromOffset(20,105))
local no=btn(confirm,"ไม่",UDim2.fromOffset(140,42),UDim2.fromOffset(190,105))
yes.ZIndex=51;no.ZIndex=51

del.MouseButton1Click:Connect(function()confirm.Visible=true end)
no.MouseButton1Click:Connect(function()confirm.Visible=false end)
yes.MouseButton1Click:Connect(function()
	speed=false;jump=false;noclip=false;esp=false;npc=false
	clearESP()
	gui:Destroy()
end)

-- MINI SQUARE
local small=btn(gui,"D",UDim2.fromOffset(55,55),UDim2.new(.5,-27,.5,-27))
small.TextSize=18
small.Visible=false
small.BackgroundColor3=Color3.fromRGB(12,12,15)

mini.MouseButton1Click:Connect(function()
	main.Visible=false
	small.Visible=true
end)

small.MouseButton1Click:Connect(function()
	small.Visible=false
	main.Visible=true
end)

-- DRAG
local drag,ds,sp,obj
local function start(o,i)
	drag=true;obj=o;ds=i.Position;sp=o.Position
end
local function move(i)
	if not drag then return end
	local d=i.Position-ds
	obj.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
end

top.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then start(main,i) end
end)
small.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then start(small,i) end
end)
UIS.InputChanged:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseMovement then move(i) end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)

home()
