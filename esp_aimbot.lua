-- الخدمات الأساسية
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

local localPlayer = Players.LocalPlayer

-- إعداد المتغيرات
local espEnabled = false
local aimbotEnabled = false
local circleRadius = 150 -- حجم دائرة الـ Aimbot

-- واجهة المستخدم
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenuUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- زر القائمة الرئيسي
local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 80, 0, 30)
mainButton.Position = UDim2.new(0, 10, 0, 10)
mainButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainButton.Text = "Menu"
mainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainButton.Font = Enum.Font.GothamBold
mainButton.TextScaled = true
mainButton.Parent = screenGui

-- إطار القائمة
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 250, 0, 300)
menuFrame.Position = UDim2.new(0, 10, 0, 50)
menuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
menuFrame.Visible = false
menuFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = menuFrame

-- خيار ESP
local showESPButton = Instance.new("TextButton")
showESPButton.Size = UDim2.new(0, 220, 0, 40)
showESPButton.Position = UDim2.new(0.5, -110, 0, 20)
showESPButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
showESPButton.Text = "Show ESP: Off"
showESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showESPButton.Font = Enum.Font.Gotham
showESPButton.TextScaled = true
showESPButton.Parent = menuFrame

-- خيار Aimbot
local aimbotButton = Instance.new("TextButton")
aimbotButton.Size = UDim2.new(0, 220, 0, 40)
aimbotButton.Position = UDim2.new(0.5, -110, 0, 80)
aimbotButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
aimbotButton.Text = "Aimbot: Off"
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotButton.Font = Enum.Font.Gotham
aimbotButton.TextScaled = true
aimbotButton.Parent = menuFrame

-- التحكم في حجم الدائرة
local circleSizeButton = Instance.new("TextButton")
circleSizeButton.Size = UDim2.new(0, 220, 0, 40)
circleSizeButton.Position = UDim2.new(0.5, -110, 0, 140)
circleSizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
circleSizeButton.Text = "Circle Size: 150"
circleSizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
circleSizeButton.Font = Enum.Font.Gotham
circleSizeButton.TextScaled = true
circleSizeButton.Parent = menuFrame

-- حقوقك
local watermark = Instance.new("TextLabel")
watermark.Size = UDim2.new(0, 200, 0, 20)
watermark.Position = UDim2.new(0.5, -100, 1, -20)
watermark.AnchorPoint = Vector2.new(0.5, 1)
watermark.BackgroundTransparency = 1
watermark.Text = "vampire: Insta-uvrreee"
watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
watermark.Font = Enum.Font.Gotham
watermark.TextScaled = true
watermark.Parent = screenGui

-- التحكم في عرض القائمة
mainButton.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- دائرة الـ Aimbot
local circle = Drawing.new("Circle")
circle.Thickness = 2
circle.Color = Color3.fromRGB(255, 0, 0)
circle.Filled = false
circle.Radius = circleRadius
circle.Visible = false

RunService.RenderStepped:Connect(function()
    circle.Position = UserInputService:GetMouseLocation()
end)

-- دالة لحساب المسافة بين نقطتين
local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

-- دالة لتحديد أقرب لاعب داخل الدائرة
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = circleRadius

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPosition, onScreen = camera:WorldToViewportPoint(head.Position)

            if onScreen then
                local mousePosition = UserInputService:GetMouseLocation()
                local headPosition = Vector2.new(screenPosition.X, screenPosition.Y)
                local distance = getDistance(mousePosition, headPosition)

                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end

    return closestPlayer
end

-- تفعيل/تعطيل ESP
local function toggleESP()
    espEnabled = not espEnabled
    showESPButton.Text = "Show ESP: " .. (espEnabled and "On" or "Off")
end

showESPButton.MouseButton1Click:Connect(toggleESP)

-- تفعيل/تعطيل Aimbot
aimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotButton.Text = "Aimbot: " .. (aimbotEnabled and "On" or "Off")
    circle.Visible = aimbotEnabled
end)

-- تغيير حجم الدائرة
circleSizeButton.MouseButton1Click:Connect(function()
    circleRadius = circleRadius + 50
    if circleRadius > 300 then
        circleRadius = 50
    end
    circle.Radius = circleRadius
    circleSizeButton.Text = "Circle Size: " .. circleRadius
end)

-- تحديث الكاميرا للـ Aimbot
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
            local head = closestPlayer.Character.Head
            camera.CFrame = CFrame.new(camera.CFrame.Position, head.Position)
        end
    end
end)
