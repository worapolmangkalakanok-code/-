-- Create GUI for teleportation auto button
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
 
-- Function to create a button with styling
local function createButton(text, position, func)
    local button = Instance.new("TextButton")
    button.Parent = ScreenGui
    button.Size = UDim2.new(0.2, 0, 0.1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.SourceSans
    button.Text = text
    button.TextColor3 = Color3.fromRGB(0, 255, 255)
    button.TextSize = 16
    button.BackgroundTransparency = 0.3
 
    button.MouseButton1Click:Connect(func)
end
 
-- Teleport function to specific location
local function teleportTo(position)
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local rootPart = player.Character:WaitForChild("HumanoidRootPart")
        rootPart.CFrame = CFrame.new(position)
    end
end
 
-- Locations for Lantern and Teddy Bear
local lanternPosition = Vector3.new(8.706391334533691, 5.000004291534424, 18.507421493530273)
local teddyBearPosition = Vector3.new(-7.841606140136719, 5.000003814697266, -6.7323689460754395)
 
-- Variable to track if auto teleport is active
local isAutoTeleportActive = false
local teleportingCoroutine = nil
 
-- Function to start/stop the teleport cycle
local function toggleAutoTeleport()
    if isAutoTeleportActive then
        isAutoTeleportActive = false
        if teleportingCoroutine then
            coroutine.close(teleportingCoroutine)
        end
    else
        isAutoTeleportActive = true
        teleportingCoroutine = coroutine.create(function()
            while isAutoTeleportActive do
                -- Teleport to Lantern
                teleportTo(lanternPosition)
                wait(3)
                -- Teleport to Teddy Bear
                teleportTo(teddyBearPosition)
                wait(3)
            end
        end)
        coroutine.resume(teleportingCoroutine)
    end
end
 
-- Create "Auto" button
createButton("Auto", UDim2.new(0.3, 0, 0, 0), toggleAutoTeleport)
 
-- Create "Made by Hecker" label below the button
local madeByLabel = Instance.new("TextLabel")
madeByLabel.Parent = ScreenGui
madeByLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
madeByLabel.Position = UDim2.new(0.4, 0, 0.8, 0)  -- Positioned below the button
madeByLabel.BackgroundTransparency = 1
madeByLabel.Font = Enum.Font.SourceSans
madeByLabel.Text = "Made by Hecker"
madeByLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
madeByLabel.TextSize = 20
madeByLabel.TextXAlignment = Enum.TextXAlignment.Center
madeByLabel.TextYAlignment = Enum.TextYAlignment.Center
