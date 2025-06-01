-- // made by pxrson & DatUnknownGuy

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local keyFile = "workspace/AlturaHub/altura_key.txt"

local savedKey
pcall(function()
	if isfile(keyFile) then
		savedKey = readfile(keyFile)
	end
end)

local scripts = {
	{"Altura MM2", "https://raw.githubusercontent.com/Pxrson/Altura-Hub/refs/heads/main/Murder%20Mystery%202.lua"},
	{"Altura ML", "https://raw.githubusercontent.com/Pxrson/Altura-Hub/refs/heads/main/Muscle%20Legends.lua"},
	{"Pos Tracker", "https://raw.githubusercontent.com/Pxrson/Pos-Tracker/refs/heads/main/Position%20Tracker.lua"},
}

local function createGui(name)
	local screenGui = Instance.new("ScreenGui", gui)
	screenGui.Name = name
	screenGui.ResetOnSpawn = false
	return screenGui
end

local function createButton(parent, text, posY, onClick)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(0, 220, 0, 30)
	btn.Position = UDim2.new(0.5, -110, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Text = text
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 16
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(onClick)
	return btn
end

local function openSelector()
	local gui2 = createGui("ModeSelectorGui")

	local frame = Instance.new("Frame", gui2)
	frame.Size = UDim2.new(0, 250, 0, 250)
	frame.Position = UDim2.new(0.5, -125, 0.5, -125)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Active = true
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, 0, 0, 25)
	label.Position = UDim2.new(0, 0, 0, 5)
	label.BackgroundTransparency = 1
	label.Text = "Pick a Script"
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 20

	for i, v in ipairs(scripts) do
		createButton(frame, v[1], 40 + (i - 1) * 35, function()
			gui2:Destroy()
			pcall(function()
				loadstring(game:HttpGet(v[2]))()
			end)
		end)
	end
end

local function openKeyGui()
	local gui1 = createGui("KeyPromptGui")

	local box = Instance.new("Frame", gui1)
	box.Size = UDim2.new(0, 260, 0, 140)
	box.Position = UDim2.new(0.5, -130, 0.5, -70)
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 10)

	local title = Instance.new("TextLabel", box)
	title.Size = UDim2.new(1, 0, 0, 25)
	title.Position = UDim2.new(0, 0, 0, 5)
	title.BackgroundTransparency = 1
	title.Text = "Enter Key"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 20

	local input = Instance.new("TextBox", box)
	input.Size = UDim2.new(0, 220, 0, 30)
	input.Position = UDim2.new(0.5, -110, 0, 40)
	input.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	input.TextColor3 = Color3.new(1, 1, 1)
	input.PlaceholderText = "Key here..."
	input.Font = Enum.Font.SourceSans
	input.TextSize = 16
	Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

	local submit = createButton(box, "Submit", 80, function()
		if input.Text == "alturahubkey2025" then
			pcall(function()
				writefile(keyFile, input.Text)
			end)
			gui1:Destroy()
			openSelector()
		else
			input.Text = ""
			input.PlaceholderText = "Wrong key!"
			input.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
		end
	end)
	submit.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	submit.TextSize = 18
end

local bind = Instance.new("BindableFunction")
bind.OnInvoke = function(choice)
	if choice == "Yeah, sure" then
		pcall(function()
			setclipboard("https://discord.gg/tAA9bzYyBx")
		end)
	end
	if savedKey == "alturahubkey2025" then
		openSelector()
	else
		openKeyGui()
	end
end

StarterGui:SetCore("SendNotification", {
	Title = "Want to join the Discord and support us?",
	Text = "Click a button below.",
	Duration = 10,
	Callback = bind,
	Button1 = "Yeah, sure",
	Button2 = "No, fuck you"
})
