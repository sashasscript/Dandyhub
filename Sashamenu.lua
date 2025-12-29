-- Sasha'menu
return function(telegramLink)
    print("=======================================")
    print("🤍 Sasha's Menu v3.0")
    print("Telegram:", telegramLink)
    print("=======================================")
    
    local Player = game:GetService("Players").LocalPlayer
    local Workspace = game:GetService("Workspace")
    local UIS = game:GetService("UserInputService")
    
    -- Настройки
    local Settings = {
        AutoCollect = false,
        AutoFarm = false,
        ESP = false,
        Speed = 50,
        CollectRadius = 50
    }
    
    -- Простое GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game:GetService("CoreGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = "Sasha's Menu v3.0"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    title.Font = Enum.Font.FredokaOne
    title.TextSize = 24
    title.Parent = mainFrame
    
    local function createButton(text, yPos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 40)
        btn.Position = UDim2.new(0.05, 0, yPos, 0)
        btn.Text = text
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Parent = mainFrame
        
        local status = Instance.new("TextLabel")
        status.Size = UDim2.new(0, 20, 0, 20)
        status.Position = UDim2.new(1, -25, 0.5, -10)
        status.Text = "✗"
        status.TextColor3 = Color3.fromRGB(255, 50, 50)
        status.BackgroundTransparency = 1
        status.Font = Enum.Font.FredokaOne
        status.TextSize = 18
        status.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            local newValue = not (status.Text == "✓")
            status.Text = newValue and "✓" or "✗"
            status.TextColor3 = newValue and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            callback(newValue)
        end)
    end
    
    -- Кнопки
    createButton("Автосбор капсул", 0.15, function(value)
        Settings.AutoCollect = value
        if value then
            spawn(function()
                while Settings.AutoCollect do
                    if Player.Character then
                        local root = Player.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            for _, obj in pairs(Workspace:GetDescendants()) do
                                if Settings.AutoCollect and obj:IsA("BasePart") then
                                    if obj.Name:lower():find("capsule") or obj.Name:lower():find("dandy") then
                                        if (root.Position - obj.Position).Magnitude <= Settings.CollectRadius then
                                            firetouchinterest(root, obj, 0)
                                            task.wait()
                                            firetouchinterest(root, obj, 1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.3)
                end
            end)
            print("Автосбор включен!")
        else
            print("Автосбор выключен!")
        end
    end)
    
    createButton("Автофарм машин", 0.25, function(value)
        Settings.AutoFarm = value
        if value then
            spawn(function()
                while Settings.AutoFarm do
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if Settings.AutoFarm and obj:IsA("Model") then
                            if obj.Name:lower():find("machine") then
                                if obj:FindFirstChild("ClickDetector") then
                                    fireclickdetector(obj.ClickDetector)
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
            print("Автофарм включен!")
        else
            print("Автофарм выключен!")
        end
    end)
    
    createButton("ESP Подсветка", 0.35, function(value)
        Settings.ESP = value
        if value then
            spawn(function()
                while Settings.ESP do
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if Settings.ESP and obj:IsA("BasePart") then
                            if obj.Name:lower():find("capsule") or obj.Name:lower():find("dandy") or obj.Name:lower():find("machine") then
                                if not obj:FindFirstChild("SashaHighlight") then
                                    local highlight = Instance.new("Highlight")
                                    highlight.Name = "SashaHighlight"
                                    highlight.FillColor = Color3.fromRGB(255, 50, 255)
                                    highlight.OutlineColor = Color3.fromRGB(255, 50, 255)
                                    highlight.FillTransparency = 0.5
                                    highlight.Parent = obj
                                end
                            end
                        end
                    end
                    task.wait(1)
                end
            end)
            print("ESP включен!")
        else
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:FindFirstChild("SashaHighlight") then
                    obj.SashaHighlight:Destroy()
                end
            end
            print("ESP выключен!")
        end
    end)
    
    createButton("Увеличить скорость", 0.45, function(value)
        if Player.Character then
            local humanoid = Player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value and 100 or 16
                print("Скорость:", humanoid.WalkSpeed)
            end
        end
    end)
    
    -- Инфо
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, 0, 0, 50)
    infoLabel.Position = UDim2.new(0, 0, 0.9, 0)
    infoLabel.Text = "Telegram: " .. telegramLink
    infoLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 14
    infoLabel.Parent = mainFrame
    
    -- Закрытие меню
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    closeBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    closeBtn.Font = Enum.Font.FredokaOne
    closeBtn.TextSize = 20
    closeBtn.Parent = mainFrame
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        print("Меню закрыто!")
    end)
    
    print("Меню загружено! Нажмите P чтобы скрыть/показать")
    
    -- Горячие клавиши
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.P then
            mainFrame.Visible = not mainFrame.Visible
        elseif input.KeyCode == Enum.KeyCode.F1 then
            Settings.AutoCollect = not Settings.AutoCollect
            print("Автосбор:", Settings.AutoCollect and "ВКЛ" or "ВЫКЛ")
        elseif input.KeyCode == Enum.KeyCode.F2 then
            Settings.AutoFarm = not Settings.AutoFarm
            print("Автофарм:", Settings.AutoFarm and "ВКЛ" or "ВЫКЛ")
        elseif input.KeyCode == Enum.KeyCode.Delete then
            screenGui:Destroy()
            print("Меню удалено!")
        end
    end)
end
