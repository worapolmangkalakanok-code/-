local P=game:GetService("Players")
local U=game:GetService("UserInputService")
local R=game:GetService("RunService")
local p=P.LocalPlayer
local c=p.Character or p.CharacterAdded:Wait()

local g=Instance.new("ScreenGui",p.PlayerGui)
g.Name="NIULAI"
local f=Instance.new("Frame",g)
f.Size=UDim2.fromOffset(300,220)
f.Position=UDim2.new(.5,-150,.5,-110)
f.BackgroundColor3=Color3.fromRGB(20,20,25)
Instance.new("UICorner",f).CornerRadius=UDim.new(0,12)

local t=Instance.new("TextLabel",f)
t.Size=UDim2.new(1,-40,0,40)
t.Text="NIULAI HUB | DORA UI"
t.TextColor3=Color3.new(1,1,1)
t.BackgroundTransparency=1
t.TextSize=16

local x=Instance.new("TextButton",f)
x.Size=UDim2.fromOffset(35,35)
x.Position=UDim2.new(1,-40,0,3)
x.Text="×"

local function B(txt,y,fn)
	local b=Instance.new("TextButton",f)
	b.Size=UDim2.new(1,-30,0,40)
	b.Position=UDim2.fromOffset(15,y)
	b.Text=txt
	b.BackgroundColor3=Color3.fromRGB(35,35,42)
	b.TextColor3=Color3.new(1,1,1)
	b.MouseButton1Click:Connect(fn)
	Instance.new("UICorner",b)
end

B("วิ่งเร็ว 100",50,function()
	c=p.Character or p.CharacterAdded:Wait()
	c:WaitForChild("Humanoid").WalkSpeed=100
end)

B("กระโดดไม่จำกัด",95,function()
	U.JumpRequest:Connect(function()
		local h=p.Character and p.Character:FindFirstChildOfClass("Humanoid")
		if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
	end)
end)

B("ทะลุกำแพง",140,function()
	R.Stepped:Connect(function()
		for _,v in ipairs(p.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide=false end
		end
	end)
end)

-- ลาก UI
local drag,ds,sp
f.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1
	or i.UserInputType==Enum.UserInputType.Touch then
		drag=true ds=i.Position sp=f.Position
	end
end)

U.InputChanged:Connect(function(i)
	if drag and (i.UserInputType==Enum.UserInputType.MouseMovement
	or i.UserInputType==Enum.UserInputType.Touch) then
		local d=i.Position-ds
		f.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
	end
end)

U.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1
	or i.UserInputType==Enum.UserInputType.Touch then drag=false end
end)

-- ย่อ/ขยาย
local mini=false
x.MouseButton1Click:Connect(function()
	mini=not mini
	f.Size=mini and UDim2.fromOffset(60,60) or UDim2.fromOffset(300,220)
	t.Visible=not mini
	x.Text=mini and "+" or "×"
	for _,v in ipairs(f:GetChildren()) do
		if v:IsA("TextButton") and v~=x then v.Visible=not mini end
	end
end)
