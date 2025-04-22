-- ⚙️ Настройки
local ESP_ENABLED = true
local ESP_COLOR = Color3.fromRGB(255, 50, 50)
local ESP_TRANSPARENCY = 0.7

local AIMBOT_ENABLED = true
local AIMBOT_KEY = Enum.KeyCode.x  -- Клавиша для аима
local AIMBOT_FOV = 100  -- Угол захвата цели (в пикселях)
local AIMBOT_SMOOTHNESS = 0.2  -- Плавность аима (0.1-1)

-- 🔧 Не трогай эти переменные
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- 📌 ESP Функции
local function createESP(character)
    if not character or not character:FindFirstChildOfClass("Humanoid") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = character
    highlight.FillColor = ESP_COLOR
    highlight.FillTransparency = ESP_TRANSPARENCY
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = character

    character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
        highlight:Destroy()
    end)
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if not player.Character:FindFirstChild("ESP_Highlight") and ESP_ENABLED then
                createESP(player.Character)
            end
        end
    end
end

-- 🔫 Aimbot Функции
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = AIMBOT_FOV

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local head = character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso")

            if humanoid and humanoid.Health > 0 and head then
                local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                    local playerPos = Vector2.new(screenPoint.X, screenPoint.Y)
                    local distance = (mousePos - playerPos).Magnitude

                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end

    return closestPlayer
end

local function aimAt(target)
    if not target or not target.Character then return end
    
    local targetPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("UpperTorso")
    if not targetPart then return end

    local currentCFrame = Camera.CFrame
    local targetPosition = targetPart.Position
    local newCFrame = currentCFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPosition), AIMBOT_SMOOTHNESS)
    
    Camera.CFrame = newCFrame
end

-- 🖱️ Обработка ввода
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == AIMBOT_KEY and AIMBOT_ENABLED then
        local closestPlayer = getClosestPlayer()
        if closestPlayer then
            aimAt(closestPlayer)
        end
    end
end)

-- 🔄 Автообновление
RunService.RenderStepped:Connect(function()
    if ESP_ENABLED then
        updateESP()
    end
end)

-- 🚀 Инициализация
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer and player.Character and ESP_ENABLED then
        createESP(player.Character)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if ESP_ENABLED then
            createESP(character)
        end
    end)
end)

print("✅ ESP+Aimbot активирован! Нажми "..tostring(AIMBOT_KEY).." для аима")
