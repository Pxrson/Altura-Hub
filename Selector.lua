local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local function openKeyGui()
	local mainGui = Instance.new("ScreenGui", gui)
	mainGui.Name = "KeyPromptGui"
	mainGui.ResetOnSpawn = false

	local box = Instance.new("Frame", mainGui)
	box.Size = UDim2.new(0, 260, 0, 140)
	box.Position = UDim2.new(0.5, -130, 0.5, -70)
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	box.BorderSizePixel = 0
	box.Active = true
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

	local submit = Instance.new("TextButton", box)
	submit.Size = UDim2.new(0, 220, 0, 30)
	submit.Position = UDim2.new(0.5, -110, 0, 80)
	submit.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	submit.TextColor3 = Color3.new(1, 1, 1)
	submit.Text = "Submit"
	submit.Font = Enum.Font.SourceSans
	submit.TextSize = 18
	Instance.new("UICorner", submit).CornerRadius = UDim.new(0, 6)

	submit.MouseButton1Click:Connect(function()
		if input.Text == "alturahubkey2025" then
			mainGui:Destroy()

			local newGui = Instance.new("ScreenGui", gui)
			newGui.Name = "ModeSelectorGui"
			newGui.ResetOnSpawn = false

			local frame = Instance.new("Frame", newGui)
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

			local scripts = {
				{"Altura MM2", "https://raw.githubusercontent.com/Pxrson/Altura-Hub/refs/heads/main/Murder%20Mystery%202.lua"},
				{"Altura ML", "https://raw.githubusercontent.com/Pxrson/Altura-Hub/refs/heads/main/Muscle%20Legends.lua"},
				{"Pos Tracker", "https://raw.githubusercontent.com/Pxrson/Pos-Tracker/refs/heads/main/Position%20Tracker.lua"},
			}

			local y = 40
			for _, data in ipairs(scripts) do
				local btn = Instance.new("TextButton", frame)
				btn.Size = UDim2.new(0, 220, 0, 30)
				btn.Position = UDim2.new(0.5, -110, 0, y)
				btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				btn.TextColor3 = Color3.new(1, 1, 1)
				btn.Text = data[1]
				btn.Font = Enum.Font.SourceSans
				btn.TextSize = 16
				Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

				btn.MouseButton1Click:Connect(function()
					newGui:Destroy()
					pcall(function()
						local code = game:HttpGet(data[2])
						loadstring(code)()
					end)
				end)

				y = y + 35
			end
		else
			input.Text = ""
			input.PlaceholderText = "Wrong key!"
			input.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
		end
	end)
end

local bindable = Instance.new("BindableFunction")
bindable.OnInvoke = function(choice)
	if choice == "Yeah, sure" then
		pcall(function()
			setclipboard("https://discord.gg/tAA9bzYyBx")
		end)
	end
	openKeyGui()
end

StarterGui:SetCore("SendNotification", {
	Title = "Want to join the Discord and support us?",
	Text = "Click a button below.",
	Duration = 10,
	Callback = bindable,
	Button1 = "Yeah, sure",
	Button2 = "No, fuck you"
})
