local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local ProtectGui = (gethui and gethui()) or CoreGui

-- Remove loader anterior caso já exista
if ProtectGui:FindFirstChild("VortexLoaderGui") then
    ProtectGui.VortexLoaderGui:Destroy()
end

local SG = Instance.new("ScreenGui", ProtectGui)
SG.Name = "VortexLoaderGui"
SG.ResetOnSpawn = false

-- Janela Principal
local MF = Instance.new("Frame", SG)
MF.Size = UDim2.new(0, 420, 0, 335)
MF.Position = UDim2.new(0.5, -210, 0.5, -167)
MF.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
MF.Active = true
MF.Draggable = true
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", MF)
stroke.Color = Color3.fromRGB(52, 152, 219)
stroke.Thickness = 1.5

-- Barra Superior / Título
local TB = Instance.new("Frame", MF)
TB.Size = UDim2.new(1, 0, 0, 42)
TB.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 12)

local Ttl = Instance.new("TextLabel", TB)
Ttl.Size = UDim2.new(1, -20, 1, 0)
Ttl.Position = UDim2.new(0, 15, 0, 0)
Ttl.BackgroundTransparency = 1
Ttl.Text = "⚡ <font color='#3498db'>Vórtex Hub</font> — Loader Principal"
Ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
Ttl.Font = Enum.Font.GothamBold
Ttl.TextSize = 14
Ttl.RichText = true
Ttl.TextXAlignment = Enum.TextXAlignment.Left

-- Caixa de Informações (Criador e YouTube)
local InfoFrame = Instance.new("Frame", MF)
InfoFrame.Size = UDim2.new(1, -30, 0, 60)
InfoFrame.Position = UDim2.new(0, 15, 0, 52)
InfoFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
Instance.new("UICorner", InfoFrame).CornerRadius = UDim.new(0, 8)
local infStk = Instance.new("UIStroke", InfoFrame)
infStk.Color = Color3.fromRGB(45, 45, 55)

local CreatorLbl = Instance.new("TextLabel", InfoFrame)
CreatorLbl.Size = UDim2.new(1, -20, 0, 20)
CreatorLbl.Position = UDim2.new(0, 12, 0, 9)
CreatorLbl.BackgroundTransparency = 1
CreatorLbl.Text = "👤 Criador: <font color='#00ff96'><b>Silent_Feio</b></font>"
CreatorLbl.TextColor3 = Color3.fromRGB(220, 220, 225)
CreatorLbl.Font = Enum.Font.Gotham
CreatorLbl.TextSize = 12
CreatorLbl.RichText = true
CreatorLbl.TextXAlignment = Enum.TextXAlignment.Left

local YtBtn = Instance.new("TextButton", InfoFrame)
YtBtn.Size = UDim2.new(1, -24, 0, 20)
YtBtn.Position = UDim2.new(0, 12, 0, 31)
YtBtn.BackgroundTransparency = 1
YtBtn.Text = "📺 YouTube: <font color='#ff4444'><b>Soy_Gui_Oficial</b></font> <i>(Clique para copiar link)</i>"
YtBtn.TextColor3 = Color3.fromRGB(220, 220, 225)
YtBtn.Font = Enum.Font.Gotham
YtBtn.TextSize = 11
YtBtn.RichText = true
YtBtn.TextXAlignment = Enum.TextXAlignment.Left

YtBtn.MouseButton1Click:Connect(function()
    if typeof(setclipboard) == "function" then
        setclipboard("https://www.youtube.com/@Soy_Gui_Oficial")
        YtBtn.Text = "✅ <font color='#00ff96'><b>Link copiado para a área de transferência!</b></font>"
        task.wait(2)
        YtBtn.Text = "📺 YouTube: <font color='#ff4444'><b>Soy_Gui_Oficial</b></font> <i>(Clique para copiar link)</i>"
    end
end)

-- Botão 1: Vortex Hub Universal
local UnivBtn = Instance.new("TextButton", MF)
UnivBtn.Size = UDim2.new(1, -30, 0, 44)
UnivBtn.Position = UDim2.new(0, 15, 0, 123)
UnivBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
UnivBtn.Text = "🌐 Carregar VortexHub (Universal)"
UnivBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnivBtn.Font = Enum.Font.GothamBold
UnivBtn.TextSize = 12
Instance.new("UICorner", UnivBtn).CornerRadius = UDim.new(0, 8)
local uStk = Instance.new("UIStroke", UnivBtn)
uStk.Color = Color3.fromRGB(52, 152, 219)

UnivBtn.MouseButton1Click:Connect(function()
    SG:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/soygui/VortexHub/main/VortexHubUniversal.lua"))()
end)

-- Botão 2: Vortex Hub Bendy
local BendyBtn = Instance.new("TextButton", MF)
BendyBtn.Size = UDim2.new(1, -30, 0, 44)
BendyBtn.Position = UDim2.new(0, 15, 0, 175)
BendyBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 45)
BendyBtn.Text = "🖋️ Carregar VortexHub (Bendy and the Ink Machine)"
BendyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BendyBtn.Font = Enum.Font.GothamBold
BendyBtn.TextSize = 12
Instance.new("UICorner", BendyBtn).CornerRadius = UDim.new(0, 8)
local bStk = Instance.new("UIStroke", BendyBtn)
bStk.Color = Color3.fromRGB(230, 126, 34)

BendyBtn.MouseButton1Click:Connect(function()
    SG:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/soygui/VortexHub/main/VortexHubBendy.lua"))()
end)

-- Botão de Fechar Centralizado Abaixo
local CloseBtn = Instance.new("TextButton", MF)
CloseBtn.Size = UDim2.new(0, 240, 0, 36)
CloseBtn.Position = UDim2.new(0.5, -120, 0, 235)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
CloseBtn.Text = "❌ Fechar Loader da VórtexHub"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
local cStk = Instance.new("UIStroke", CloseBtn)
cStk.Color = Color3.fromRGB(70, 70, 80)

CloseBtn.MouseButton1Click:Connect(function()
    SG:Destroy()
end)
