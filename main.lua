-- Настройки
local menuKey = Enum.KeyCode.RightShift
local currentTab = "Combat" -- Или "Visual" для старта с другой вкладки

-- Флаги функций
local espEnabled = false
local aimbotEnabled = false
local tracersEnabled = false
local silentAimEnabled = false
local aimbotKey = Enum.KeyCode.E
local aimbotFOV = 50

-- Создание интерфейса
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CombatTab = Instance.new("TextButton")
local VisualTab = Instance.new("TextButton")

-- Комбат-элементы
local AimbotToggle = Instance.new("TextButton")
local SilentAimToggle = Instance.new("TextButton")

-- Визуал-элементы
local ESPToggle = Instance.new("TextButton")
local TracersToggle = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HackMenuV2"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.8, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 200, 0, 180)
Frame.Visible = false

Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Меню (RightShift)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- Кнопки вкладок
CombatTab.Parent = Frame
CombatTab.Position = UDim2.new(0, 0, 0, 30)
CombatTab.Size = UDim2.new(0.5, 0, 0, 25)
CombatTab.Font = Enum.Font.SourceSansBold
CombatTab.Text = "Combat"
CombatTab.TextColor3 = Color3.fromRGB(255, 255, 255)
CombatTab.BackgroundColor3 = Color3.fromRGB(80, 0, 0)

VisualTab.Parent = Frame
VisualTab.Position = UDim2.new(0.5, 0, 0, 30)
VisualTab.Size = UDim2.new(0.5, 0, 0, 25)
VisualTab.Font = Enum.Font.SourceSansBold
VisualTab.Text = "Visual"
VisualTab.TextColor3 = Color3.fromRGB(255, 255, 255)
VisualTab.BackgroundColor3 = Color3.fromRGB(0, 80, 0)

-- Combat Tab Elements
AimbotToggle.Parent = Frame
AimbotToggle.Position = UDim2.new(0, 0, 0, 60)
AimbotToggle.Size = UDim2.new(1, 0, 0, 30)
AimbotToggle.Font = Enum.Font.SourceSans
AimbotToggle.Text = "Aimbot [E]: OFF"
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.TextSize = 16
AimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AimbotToggle.Visible = (currentTab == "Combat")

SilentAimToggle.Parent = Frame
SilentAimToggle.Position = UDim2.new(0, 0, 0, 95)
SilentAimToggle.Size = UDim2.new(1, 0, 0, 30)
SilentAimToggle.Font = Enum.Font.SourceSans
SilentAimToggle.Text = "Silent Aim: OFF"
SilentAimToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SilentAimToggle.TextSize = 16
SilentAimToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SilentAimToggle.Visible = (currentTab == "Combat")

-- Visual Tab Elements
ESPToggle.Parent = Frame
ESPToggle.Position = UDim2.new(0, 0, 0, 60)
ESPToggle.Size = UDim2.new(1, 0, 0, 30)
ESPToggle.Font = Enum.Font.SourceSans
ESPToggle.Text = "ESP: OFF"
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.TextSize = 16
ESPToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ESPToggle.Visible = (currentTab == "Visual")

TracersToggle.Parent = Frame
TracersToggle.Position = UDim2.new(0, 0, 0, 95)
TracersToggle.Size = UDim2.new(1, 0, 0, 30)
TracersToggle.Font = Enum.Font.SourceSans
TracersToggle.Text = "Tracers: OFF"
TracersToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TracersToggle.TextSize = 16
TracersToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TracersToggle.Visible = (currentTab == "Visual")

-- Функции переключения вкладок
local function updateTabs()
    AimbotToggle.Visible = (currentTab == "Combat")
    SilentAimToggle.Visible = (currentTab == "Combat")
    ESPToggle.Visible = (currentTab == "Visual")
    TracersToggle.Visible = (currentTab == "Visual")
    
    CombatTab.BackgroundColor3 = (currentTab == "Combat") and Color3.fromRGB(120, 0, 0) or Color3.fromRGB(80, 0, 0)
    VisualTab.BackgroundColor3 = (currentTab == "Visual") and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(0, 80, 0)
end

CombatTab.MouseButton1Click:Connect(function()
    currentTab = "Combat"
    updateTabs()
end)

VisualTab.MouseButton1Click:Connect(function()
    currentTab = "Visual"
    updateTabs()
end)

-- Здесь добавь свои функции ESP, Aimbot и т.д. (как в предыдущем скрипте)
-- ... (остальной код остаётся таким же, как в первом примере) ...

-- Обработчики кнопок
AimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    AimbotToggle.Text = "Aimbot [E]: " .. (aimbotEnabled and "ON" or "OFF")
end)

SilentAimToggle.MouseButton1Click:Connect(function()
    silentAimEnabled = not silentAimEnabled
    SilentAimToggle.Text = "Silent Aim: " .. (silentAimEnabled and "ON" or "OFF")
end)

ESPToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    ESPToggle.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    -- Тут код для ESP (из первого скрипта)
end)

TracersToggle.MouseButton1Click:Connect(function()
    tracersEnabled = not tracersEnabled
    TracersToggle.Text = "Tracers: " .. (tracersEnabled and "ON" or "OFF")
    -- Тут код для трейсеров (линий к игрокам)
end)

-- Открытие/закрытие меню
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == menuKey then
        Frame.Visible = not Frame.Visible
    end
end)

updateTabs() -- Инициализация вкладок
