-- ⚙️ Настройки
local MENU_KEY = Enum.KeyCode.RightShift -- Клавиша открытия меню
local ESP_COLOR = Color3.fromRGB(255, 50, 50) -- Цвет ESP
local AIMBOT_KEY = Enum.KeyCode.Q -- Клавиша аима
local AIMBOT_FOV = 100 -- Угол захвата

-- 🔧 Системные переменные
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Состояния
local ESPEnabled = false
local AimbotEnabled = false
local MenuVisible = false

-- 📜 Создаем интерфейс
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ESPToggle = Instance.new("TextButton")
local AimbotToggle = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "HackMenu"

Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Visible = false

Title.Parent = Frame
Title.Text = "Меню (RightShift)"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.TextColor3 = Color3.white

ESPToggle.Parent = Frame
ESPToggle.Text = "ESP: OFF"
ESPToggle.Size = UDim2.new(0.9, 0, 0, 30)
ESPToggle.Position = UDim2.new(0.05, 0, 0.3, 0)
ESPToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

AimbotToggle.Parent = Frame
AimbotToggle.Text = "Aimbot (Q): OFF"
AimbotToggle.Size = UDim2.new(0.9, 0, 0, 30)
AimbotToggle.Position = UDim2.new(0.05, 0, 0.6, 0)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

-- 🔄 Функции
local function toggleMenu()
    MenuVisible = not MenuVisible
    Frame.Visible = MenuVisible
end

local function createESP(character)
    if not character then return end
    
    local highlight = Instance.new("Highlight")
    highlight.Adornee = character
    highlight.FillColor = ESP_COLOR
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.FillTransparency = 0.7
    highlight.Parent = character
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if ESPEnabled and not player.Character:FindFirstChildOfClass("Highlight") then
                createESP(player.Character)
            elseif not ESPEnabled and player.Character:FindFirstChildOfClass("Highlight") then
                player.Character:FindFirstChildOfClass("Highlight"):Destroy()
            end
        end
    end
end

local function getClosestPlayer()
    local closest = nil
    local minDist = AIMBOT_FOV
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(UIS:GetMouseLocation().X, UIS:GetMouseLocation().Y).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = player
                    end
                end
            end
        end
    end
    
    return closest
end

-- 🖱️ Обработчики
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == MENU_KEY then
        toggleMenu()
    elseif input.KeyCode == AIMBOT_KEY and AimbotEnabled then
        local target = getClosestPlayer()
        if target then
            local head = target.Character:FindFirstChild("Head")
            if head then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position)
            end
        end
    end
end)

ESPToggle.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    ESPToggle.Text = "ESP: " .. (ESPEnabled and "ON" or "OFF")
    updateESP()
end)

AimbotToggle.MouseButton1Click:Connect(function()
    AimbotEnabled = not AimbotEnabled
    AimbotToggle.Text = "Aimbot (Q): " .. (AimbotEnabled and "ON" or "OFF")
end)

-- 🔄 Автообновление
RunService.RenderStepped:Connect(updateESP)

-- 🚀 Инициализация
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        if ESPEnabled then
            createESP(char)
        end
    end)
end)

for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character and ESPEnabled then
        createESP(player.Character)
    end
end

print("✅ Меню активировано! Нажми RightShift")
