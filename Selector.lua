--// made by pxrson, remade by havoc
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

-- Key storage
local VALID_KEY = "alturahubkey2025"
local savedKey = nil

-- Animation helper
local function animateIn(element, targetSize)
	element.Size = UDim2.new(0, 0, 0, 0)
	element.BackgroundTransparency = 1
	element.Position = UDim2.new(0.5, 0, 0.5, 0)
	
	local sizeInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local fadeInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	TweenService:Create(element, sizeInfo, {
		Size = targetSize,
		Position = UDim2.new(0.5, -targetSize.X.Offset/2, 0.5, -targetSize.Y.Offset/2)
	}):Play()
	TweenService:Create(element, fadeInfo, {BackgroundTransparency = 0}):Play()
end

local function createCloseAnimation(gui)
	local frame = gui:FindFirstChild("MainFrame")
	if not frame then return end
	
	-- Move to center and spin
	local centerTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
		Position = UDim2.new(0.5, -frame.Size.X.Offset/2, 0.5, -frame.Size.Y.Offset/2),
		Size = UDim2.new(0, 50, 0, 50)
	})
	
	centerTween:Play()
	centerTween.Completed:Wait()
	
	-- Spin effect
	local spinConnection
	local rotation = 0
	spinConnection = RunService.Heartbeat:Connect(function()
		rotation = rotation + 10
		frame.Rotation = rotation
	end)
	
	-- Fade out
	local fadeOut = TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quad), {
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 0, 0, 0)
	})
	
	-- Fade out all children
	for _, child in pairs(frame:GetChildren()) do
		if child:IsA("GuiObject") then
			TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 1,
				TextTransparency = 1
			}):Play()
		end
	end
	
	fadeOut:Play()
	fadeOut.Completed:Connect(function()
		spinConnection:Disconnect()
		gui:Destroy()
	end)
end

local function createXButton(parent, gui)
	local xButton = Instance.new("TextButton", parent)
	xButton.Size = UDim2.new(0, 30, 0, 30)
	xButton.Position = UDim2.new(1, -35, 0, 5)
	xButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
	xButton.Text = "✕"
	xButton.TextColor3 = Color3.new(1, 1, 1)
	xButton.Font = Enum.Font.GothamBold
	xButton.TextSize = 16
	xButton.BorderSizePixel = 0
	xButton.ZIndex = 10
	
	local corner = Instance.new("UICorner", xButton)
	corner.CornerRadius = UDim.new(0, 15)
	
	-- Hover effects
	xButton.MouseEnter:Connect(function()
		TweenService:Create(xButton, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(255, 70, 85),
			Size = UDim2.new(0, 32, 0, 32)
		}):Play()
	end)
	
	xButton.MouseLeave:Connect(function()
		TweenService:Create(xButton, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(220, 53, 69),
			Size = UDim2.new(0, 30, 0, 30)
		}):Play()
	end)
	
	xButton.MouseButton1Click:Connect(function()
		createCloseAnimation(gui)
	end)
	
	return xButton
end

local function createModernButton(parent, text, position, size, color)
	local button = Instance.new("TextButton", parent)
	button.Size = size or UDim2.new(0, 240, 0, 35)
	button.Position = position
	button.BackgroundColor3 = color or Color3.fromRGB(70, 130, 180)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Text = text
	button.Font = Enum.Font.GothamBold
	button.TextSize = 16
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.TextStrokeTransparency = 0.5
	button.TextStrokeColor3 = Color3.new(0, 0, 0)
	
	local corner = Instance.new("UICorner", button)
	corner.CornerRadius = UDim.new(0, 8)
	
	local gradient = Instance.new("UIGradient", button)
	gradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
	}
	gradient.Rotation = 90
	gradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.8),
		NumberSequenceKeypoint.new(1, 0.9)
	}
	
	-- Hover effects
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(
				math.min(255, color.R * 255 + 30),
				math.min(255, color.G * 255 + 30),
				math.min(255, color.B * 255 + 30)
			),
			Size = UDim2.new(size.X.Scale, size.X.Offset + 5, size.Y.Scale, size.Y.Offset + 2)
		}):Play()
	end)
	
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {
			BackgroundColor3 = color,
			Size = size
		}):Play()
	end)
	
	return button
end

local function openModeSelector()
	local newGui = Instance.new("ScreenGui", gui)
	newGui.Name = "ModeSelectorGui"
	newGui.ResetOnSpawn = false

	local frame = Instance.new("Frame", newGui)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 320, 0, 300)
	frame.Position = UDim2.new(0.5, -160, 0.5, -150)
	frame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
	frame.BorderSizePixel = 0
	frame.Active = true
	
	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 15)
	
	local stroke = Instance.new("UIStroke", frame)
	stroke.Color = Color3.fromRGB(100, 150, 255)
	stroke.Thickness = 3
	
	-- Animated border
	local borderGradient = Instance.new("UIGradient", stroke)
	borderGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 150))
	}
	
	spawn(function()
		while newGui.Parent do
			for i = 0, 360, 5 do
				if not newGui.Parent then break end
				borderGradient.Rotation = i
				wait(0.05)
			end
		end
	end)

	-- Background gradient
	local bgGradient = Instance.new("UIGradient", frame)
	bgGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 55))
	}
	bgGradient.Rotation = 45

	createXButton(frame, newGui)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1, 0, 0, 50)
	label.Position = UDim2.new(0, 0, 0, 10)
	label.BackgroundTransparency = 1
	label.Text = "🚀 Select Your Script"
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamBold
	label.TextSize = 24
	label.TextStrokeTransparency = 0.5
	label.TextStrokeColor3 = Color3.new(0, 0, 0)

	local scripts = {
		{"🗡️ Altura MM2", "https://raw.githubusercontent.com/Pxrson/Altura-Hub/refs/heads/main/Murder%20Mystery%202.lua", Color3.fromRGB(220, 20, 60)},
		{"📍 Pos Tracker", "https://raw.githubusercontent.com/Pxrson/Pos-Tracker/refs/heads/main/Position%20Tracker.lua", Color3.fromRGB(255, 165, 0)},
	}

	local y = 70
	for i, data in ipairs(scripts) do
		local btn = createModernButton(frame, data[1], UDim2.new(0.5, -130, 0, y), UDim2.new(0, 260, 0, 40), data[3])
		
		-- Stagger animation
		btn.BackgroundTransparency = 1
		btn.TextTransparency = 1
		wait(0.1)
		TweenService:Create(btn, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
			BackgroundTransparency = 0,
			TextTransparency = 0
		}):Play()
		
		btn.MouseButton1Click:Connect(function()
			-- Button click animation
			TweenService:Create(btn, TweenInfo.new(0.1), {
				Size = UDim2.new(0, 250, 0, 35),
				BackgroundColor3 = Color3.new(1, 1, 1)
			}):Play()
			wait(0.1)
			TweenService:Create(btn, TweenInfo.new(0.1), {
				Size = UDim2.new(0, 260, 0, 40),
				BackgroundColor3 = data[3]
			}):Play()
			
			StarterGui:SetCore("SendNotification", {
				Title = "🔄 Loading Script...",
				Text = "Please wait while " .. data[1] .. " loads.",
				Duration = 3,
			})
			
			createCloseAnimation(newGui)
			
			wait(1.5)
			pcall(function()
				local code = game:HttpGet(data[2])
				loadstring(code)()
			end)
		end)

		y = y + 55
	end
	
	animateIn(frame, UDim2.new(0, 320, 0, 300))
end

local function openKeyGui()
	-- Check if key is already saved
	if savedKey == VALID_KEY then
		openModeSelector()
		return
	end

	local mainGui = Instance.new("ScreenGui", gui)
	mainGui.Name = "KeyPromptGui"
	mainGui.ResetOnSpawn = false

	local box = Instance.new("Frame", mainGui)
	box.Name = "MainFrame"
	box.Size = UDim2.new(0, 320, 0, 180)
	box.Position = UDim2.new(0.5, -160, 0.5, -90)
	box.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
	box.BorderSizePixel = 0
	box.Active = true
	
	local corner = Instance.new("UICorner", box)
	corner.CornerRadius = UDim.new(0, 15)
	
	local stroke = Instance.new("UIStroke", box)
	stroke.Color = Color3.fromRGB(100, 150, 255)
	stroke.Thickness = 3
	
	-- Background gradient
	local bgGradient = Instance.new("UIGradient", box)
	bgGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 65)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 55))
	}
	bgGradient.Rotation = 45

	createXButton(box, mainGui)

	local title = Instance.new("TextLabel", box)
	title.Size = UDim2.new(1, 0, 0, 45)
	title.Position = UDim2.new(0, 0, 0, 15)
	title.BackgroundTransparency = 1
	title.Text = "🔐 Enter Access Key"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 22
	title.TextStrokeTransparency = 0.5
	title.TextStrokeColor3 = Color3.new(0, 0, 0)

	local input = Instance.new("TextBox", box)
input.Size = UDim2.new(0, 260, 0, 40)
input.Position = UDim2.new(0.5, -130, 0, 70)
input.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
input.TextColor3 = Color3.new(1, 1, 1)
input.PlaceholderText = "Enter your key here..."
input.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.BorderSizePixel = 0
input.TextStrokeTransparency = 0.7
input.TextStrokeColor3 = Color3.new(0, 0, 0)

local inputCorner = Instance.new("UICorner", input)
inputCorner.CornerRadius = UDim.new(0, 10)

local inputStroke = Instance.new("UIStroke", input)
inputStroke.Color = Color3.fromRGB(80, 80, 100)
inputStroke.Thickness = 2

local inputGradient = Instance.new("UIGradient", input)
inputGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 80)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 70))
}
inputGradient.Rotation = 90

local submit = createModernButton(box, "✓ Submit Key", UDim2.new(0.5, -130, 0, 125), UDim2.new(0, 260, 0, 40), Color3.fromRGB(70, 130, 180))

-- Focus effects for input
input.Focused:Connect(function()
	TweenService:Create(inputStroke, TweenInfo.new(0.3), {
		Color = Color3.fromRGB(100, 150, 255),
		Thickness = 3
	}):Play()
	TweenService:Create(input, TweenInfo.new(0.3), {
		Size = UDim2.new(0, 270, 0, 42)
	}):Play()
end)

input.FocusLost:Connect(function()
	TweenService:Create(inputStroke, TweenInfo.new(0.3), {
		Color = Color3.fromRGB(80, 80, 100),
		Thickness = 2
	}):Play()
	TweenService:Create(input, TweenInfo.new(0.3), {
		Size = UDim2.new(0, 260, 0, 40)
	}):Play()
end)

submit.MouseButton1Click:Connect(function()
	if input.Text == VALID_KEY then
		savedKey = VALID_KEY -- Save the key
		
		-- Success animation
		TweenService:Create(box, TweenInfo.new(0.5), {
			BackgroundColor3 = Color3.fromRGB(50, 205, 50)
		}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.5), {
			Color = Color3.fromRGB(50, 255, 50)
		}):Play()
		
		StarterGui:SetCore("SendNotification", {
			Title = "✅ Access Granted!",
			Text = "Key verified successfully. Welcome!",
			Duration = 3,
		})
		
		wait(0.8)
		createCloseAnimation(mainGui)
		wait(1.5)
		openModeSelector()
	else
		-- Error animation
		input.Text = ""
		input.PlaceholderText = "❌ Invalid key! Try again..."
		input.PlaceholderColor3 = Color3.fromRGB(255, 120, 120)
		
		-- Shake animation
		local originalPos = box.Position
		local shakeIntensity = 10
		for i = 1, 6 do
			TweenService:Create(box, TweenInfo.new(0.05), {
				Position = UDim2.new(0.5, -160 + (i % 2 == 0 and shakeIntensity or -shakeIntensity), 0.5, -90)
			}):Play()
			wait(0.05)
		end
		TweenService:Create(box, TweenInfo.new(0.1), {Position = originalPos}):Play()
		
		-- Flash red
		TweenService:Create(inputStroke, TweenInfo.new(0.2), {
			Color = Color3.fromRGB(255, 50, 50)
		}):Play()
		
		wait(2)
		input.PlaceholderText = "Enter your key here..."
		input.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
		TweenService:Create(inputStroke, TweenInfo.new(0.3), {
			Color = Color3.fromRGB(80, 80, 100)
		}):Play()
	end
end)

-- Enter key support
input.FocusLost:Connect(function(enterPressed)
	if enterPressed and input.Text ~= "" then
		submit.MouseButton1Click:Fire()
	end
end)

animateIn(box, UDim2.new(0, 320, 0, 180))
end

local bindable = Instance.new("BindableFunction")
bindable.OnInvoke = function(choice)
	if choice == "Yeah, sure!" then
		pcall(function()
			setclipboard("https://discord.gg/tAA9bzYyBx")
		end)
		StarterGui:SetCore("SendNotification", {
			Title = "📋 Copied!",
			Text = "Discord link copied to clipboard!",
			Duration = 3,
		})
	end
	wait(0.5)
	openKeyGui()
end
