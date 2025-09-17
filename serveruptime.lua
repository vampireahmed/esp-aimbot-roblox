--// Server Uptime GUI (نسخة جديدة ومضمونة)
-- Clean & soft style 🌸

-- GUI أساس
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ServerTimeGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 60)
Frame.Position = UDim2.new(0.5, -110, 0, 20) -- بالنص فوق
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,12)
UICorner.Parent = Frame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(100, 255, 150)
UIStroke.Parent = Frame

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1,0,1,0)
Label.BackgroundTransparency = 1
Label.Font = Enum.Font.GothamBold
Label.TextColor3 = Color3.fromRGB(200,255,200)
Label.TextSize = 18
Label.Text = "Server Uptime: Loading..."
Label.Parent = Frame

-- نجيب وقت السيرفر من Roblox
local startTime = math.floor(workspace.DistributedGameTime)

-- نخلي عداد محلي حتى يشتغل حتى لو lag
local localTimer = 0

-- نحدث كل ثانية
task.spawn(function()
	while true do
		task.wait(1)
		localTimer += 1
		local totalTime = startTime + localTimer -- الوقت الحقيقي

		local hours = math.floor(totalTime/3600)
		local minutes = math.floor((totalTime%3600)/60)
		local seconds = totalTime%60

		Label.Text = string.format("Server Uptime:\n%02d:%02d:%02d", hours, minutes, seconds)
	end
end)