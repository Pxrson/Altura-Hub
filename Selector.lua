local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then return end

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "AlturaKeyGui"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.Parent = playerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 280, 0, 160)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Parent = keyGui

Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.Position = UDim2.new(0, 0, 0, 8)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Enter Key"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 22
keyTitle.Parent = keyFrame

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0, 240, 0, 30)
keyInput.Position = UDim2.new(0.5, -120, 0, 50)
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderText = "Enter your key here..."
keyInput.Font = Enum.Font.GothamMedium
keyInput.TextSize = 16
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0, 240, 0, 30)
submitBtn.Position = UDim2.new(0.5, -120, 0, 90)
submitBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamMedium
submitBtn.TextSize = 18
submitBtn.Parent = keyFrame
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 8)

local keyExitBtn = Instance.new("TextButton")
keyExitBtn.Size = UDim2.new(0, 25, 0, 25)
keyExitBtn.Position = UDim2.new(1, -30, 0, 5)
keyExitBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
keyExitBtn.Text = "X"
keyExitBtn.TextColor3 = Color3.new(1, 1, 1)
keyExitBtn.Font = Enum.Font.GothamBold
keyExitBtn.TextSize = 14
keyExitBtn.Parent = keyFrame
Instance.new("UICorner", keyExitBtn).CornerRadius = UDim.new(0, 6)

local dragging = false
local dragInput
local dragStart
local startPos

local function updateInput(input)
	local delta = input.Position - dragStart
	keyFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

keyFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = keyFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

keyFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateInput(input)
	end
end)

keyExitBtn.MouseButton1Click:Connect(function()
	keyGui:Destroy()
end)

submitBtn.MouseButton1Click:Connect(function()
	if keyInput.Text == "alturahubkey2025" then
		keyGui:Destroy()
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "AlturaSelectorGui"
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.Parent = playerGui

		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 280, 0, 260)
		frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
		frame.BorderSizePixel = 0
		frame.Active = true
		frame.Parent = screenGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

		local selectorDragging = false
		local selectorDragInput
		local selectorDragStart
		local selectorStartPos

		local function updateSelectorInput(input)
			local delta = input.Position - selectorDragStart
			frame.Position = UDim2.new(selectorStartPos.X.Scale, selectorStartPos.X.Offset + delta.X, selectorStartPos.Y.Scale, selectorStartPos.Y.Offset + delta.Y)
		end

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				selectorDragging = true
				selectorDragStart = input.Position
				selectorStartPos = frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						selectorDragging = false
					end
				end)
			end
		end)

		frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				selectorDragInput = input
			end
		end)

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == selectorDragInput and selectorDragging then
				updateSelectorInput(input)
			end
		end)

		local title = Instance.new("TextLabel")
		title.Size = UDim2.new(1, 0, 0, 30)
		title.Position = UDim2.new(0, 0, 0, 8)
		title.BackgroundTransparency = 1
		title.Text = "Select a Mode"
		title.TextColor3 = Color3.fromRGB(255, 255, 255)
		title.Font = Enum.Font.GothamBold
		title.TextSize = 22
		title.Parent = frame

		local subtitle = Instance.new("TextLabel")
		subtitle.Size = UDim2.new(1, 0, 0, 20)
		subtitle.Position = UDim2.new(0, 0, 0, 35)
		subtitle.BackgroundTransparency = 1
		subtitle.Text = "by pxrson"
		subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
		subtitle.Font = Enum.Font.Gotham
		subtitle.TextSize = 14
		subtitle.Parent = frame

		local exitBtn = Instance.new("TextButton")
		exitBtn.Size = UDim2.new(0, 25, 0, 25)
		exitBtn.Position = UDim2.new(1, -30, 0, 5)
		exitBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
		exitBtn.Text = "X"
		exitBtn.TextColor3 = Color3.new(1, 1, 1)
		exitBtn.Font = Enum.Font.GothamBold
		exitBtn.TextSize = 14
		exitBtn.Parent = frame
		Instance.new("UICorner", exitBtn).CornerRadius = UDim.new(0, 6)

		exitBtn.MouseButton1Click:Connect(function()
			screenGui:Destroy()
		end)

		local buttonFrame = Instance.new("Frame")
		buttonFrame.Size = UDim2.new(1, 0, 1, -70)
		buttonFrame.Position = UDim2.new(0, 0, 0, 60)
		buttonFrame.BackgroundTransparency = 1
		buttonFrame.Parent = frame

		local UIListLayout = Instance.new("UIListLayout")
		UIListLayout.Padding = UDim.new(0, 10)
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Parent = buttonFrame

		local modes = {
			{Name = "Altura Hub MM2", Script = "https://raw.githubusercontent.com/DatUnknownGuy/Altura-Hub/refs/heads/main/Altura%20HubMM2.lua"},
			{Name = "Altura Hub ML", Script = "https://raw.githubusercontent.com/DatUnknownGuy/Altura-Hub/refs/heads/main/Altura%20HubML.lua"},
			{Name = "Position Tracker", Script = "https://raw.githubusercontent.com/DatUnknownGuy/Selector/refs/heads/main/PositionTracker.lua"}
		}

		for _, mode in ipairs(modes) do
			local button = Instance.new("TextButton")
			button.Size = UDim2.new(0, 240, 0, 35)
			button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.Text = mode.Name
			button.Font = Enum.Font.GothamMedium
			button.TextSize = 18
			button.Parent = buttonFrame
			Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

			button.MouseEnter:Connect(function()
				button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			end)

			button.MouseLeave:Connect(function()
				button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			end)

			button.MouseButton1Click:Connect(function()
				screenGui:Destroy()
				local success, err = pcall(function()
					local source = game:HttpGet(mode.Script)
					loadstring(source)()
				end)
			end)
		end

		local discordButton = Instance.new("TextButton")
		discordButton.Size = UDim2.new(0, 240, 0, 35)
		discordButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		discordButton.Text = "Copy Discord Invite Link"
		discordButton.Font = Enum.Font.GothamMedium
		discordButton.TextSize = 18
		discordButton.Parent = buttonFrame
		Instance.new("UICorner", discordButton).CornerRadius = UDim.new(0, 8)

		discordButton.MouseEnter:Connect(function()
			discordButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end)

		discordButton.MouseLeave:Connect(function()
			discordButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		end)

		discordButton.MouseButton1Click:Connect(function()
			pcall(function()
				setclipboard("https://discord.gg/tAA9bzYyBx")
			end)
		end)
	else
		keyInput.Text = ""
		keyInput.PlaceholderText = "Invalid key!"
		keyInput.PlaceholderColor3 = Color3.fromRGB(255, 50, 50)
	end
end)
