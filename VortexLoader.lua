local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local ProtectGui = (gethui and gethui()) or CoreGui

if ProtectGui:FindFirstChild("VortexLoaderGui") then
    ProtectGui.VortexLoaderGui:Destroy()
end

-- Configurações salvas do Loader
local LoaderConfig = {
    Theme = "Orion",
    Font = Enum.Font.GothamBold
}

local Themes = {
    Orion = {Main = Color3.fromRGB(20, 20, 26), Bar = Color3.fromRGB(28, 28, 36), Accent = Color3.fromRGB(52, 152, 219)},
    Vampiro = {Main = Color3.fromRGB(20, 10, 10), Bar = Color3.fromRGB(28, 15, 15), Accent = Color3.fromRGB(220, 50, 50)},
    Toxico = {Main = Color3.fromRGB(15, 25, 15), Bar = Color3.fromRGB(20, 35, 20), Accent = Color3.fromRGB(50, 220, 100)},
    Ametista = {Main = Color3.fromRGB(25, 18, 35), Bar = Color3.fromRGB(35, 25, 48), Accent = Color3.fromRGB(155, 89, 182)},
    Ouro = {Main = Color3.fromRGB(30, 28, 18), Bar = Color3.fromRGB(42, 38, 24), Accent = Color3.fromRGB(241, 196, 15)},
    Cyberpunk = {Main = Color3.fromRGB(18, 18, 25), Bar = Color3.fromRGB(25, 25, 35), Accent = Color3.fromRGB(255, 255, 0)}
}

local Fonts = {
    ["Gotham"] = Enum.Font.GothamBold,
    ["Code"] = Enum.Font.Code,
    ["Cartoon"] = Enum.Font.FredokaOne,
    ["SciFi"] = Enum.Font.SciFi
}

local SG = Instance.new("ScreenGui", ProtectGui)
SG.Name = "VortexLoaderGui"
SG.ResetOnSpawn = false

-- Janela Principal
local MF = Instance.new("Frame", SG)
MF.Size = UDim2.new(0, 420, 0, 345)
MF.Position = UDim2.new(0.5, -210, 0.5, -172)
MF.BackgroundColor3 = Themes.Orion.Main
MF.Active = true
MF.Draggable = true
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", MF)
stroke.Color = Themes.Orion.Accent
stroke.Thickness = 1.5

-- Barra Superior / Título
local TB = Instance.new("Frame", MF)
TB.Size = UDim2.new(1, 0, 0, 42)
TB.BackgroundColor3 = Themes.Orion.Bar
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 12)

-- Botão de Configurações no canto esquerdo superior (conforme circulado)
local ConfigBtn = Instance.new("TextButton", TB)
ConfigBtn.Size = UDim2.new(0, 36, 0, 36)
ConfigBtn.Position = UDim2.new(0, 6, 0.5, -18)
ConfigBtn.BackgroundTransparency = 1
ConfigBtn.Text = "⚙️"
ConfigBtn.TextSize = 16

local Ttl = Instance.new("TextLabel", TB)
Ttl.Size = UDim2.new(1, -55, 1, 0)
Ttl.Position = UDim2.new(0, 45, 0, 0)
Ttl.BackgroundTransparency = 1
Ttl.Text = "⚡ <font color='#3498db'>Vórtex Hub</font> — Loader Principal"
Ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
Ttl.Font = Enum.Font.GothamBold
Ttl.TextSize = 14
Ttl.RichText = true
Ttl.TextXAlignment = Enum.TextXAlignment.Left

-- Painel de Configurações (Aparece ao clicar na engrenagem)
local SettingsPanel = Instance.new("ScrollingFrame", MF)
SettingsPanel.Size = UDim2.new(1, -30, 0, 240)
SettingsPanel.Position = UDim2.new(0, 15, 0, 52)
SettingsPanel.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
SettingsPanel.Visible = false
SettingsPanel.CanvasSize = UDim2.new(0, 0, 0, 300)
SettingsPanel.ScrollBarThickness = 4
Instance.new("UICorner", SettingsPanel).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", SettingsPanel).Color = Color3.fromRGB(60, 60, 75)

local spLayout = Instance.new("UIListLayout", SettingsPanel)
spLayout.Padding = UDim.new(0, 10)
spLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
spLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function addSectionHeader(text, parent)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, -20, 0, 25)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

addSectionHeader("🎨 Escolher Tema:", SettingsPanel)

local themeContainer = Instance.new("Frame", SettingsPanel)
themeContainer.Size = UDim2.new(1, -20, 0, 70)
themeContainer.BackgroundTransparency = 1
local tcLayout = Instance.new("UIGridLayout", themeContainer)
tcLayout.CellSize = UDim2.new(0, 115, 0, 30)
tcLayout.CellPadding = UDim2.new(0, 6, 0, 6)

local function applyTheme(themeName)
    local t = Themes[themeName]
    if not t then return end
    LoaderConfig.Theme = themeName
    MF.BackgroundColor3 = t.Main
    TB.BackgroundColor3 = t.Bar
    stroke.Color = t.Accent
    Ttl.Text = string.format("⚡ <font color='#%s'>Vórtex Hub</font> — Loader Principal", t.Accent:ToHex())
end

for tName, _ in pairs(Themes) do
    local btn = Instance.new("TextButton", themeContainer)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = tName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        applyTheme(tName)
    end)
end

addSectionHeader("🔤 Escolher Estilo de Letra:", SettingsPanel)

local fontContainer = Instance.new("Frame", SettingsPanel)
fontContainer.Size = UDim2.new(1, -20, 0, 70)
fontContainer.BackgroundTransparency = 1
local fcLayout = Instance.new("UIGridLayout", fontContainer)
fcLayout.CellSize = UDim2.new(0, 115, 0, 30)
fcLayout.CellPadding = UDim2.new(0, 6, 0, 6)

local function applyFont(fontEnum)
    LoaderConfig.Font = fontEnum
    Ttl.Font = fontEnum
end

for fName, fEnum in pairs(Fonts) do
    local btn = Instance.new("TextButton", fontContainer)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.Text = fName
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = fEnum
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(function()
        applyFont(fEnum)
    end)
end

-- Conteúdo Principal do Loader
local MainContent = Instance.new("Frame", MF)
MainContent.Size = UDim2.new(1, 0, 1, -42)
MainContent.Position = UDim2.new(0, 0, 0, 42)
MainContent.BackgroundTransparency = 1

-- Caixa de Informações (Criador e YouTube)
local InfoFrame = Instance.new("Frame", MainContent)
InfoFrame.Size = UDim2.new(1, -30, 0, 60)
InfoFrame.Position = UDim2.new(0, 15, 0, 12)
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
local UnivBtn = Instance.new("TextButton", MainContent)
UnivBtn.Size = UDim2.new(1, -30, 0, 44)
UnivBtn.Position = UDim2.new(0, 15, 0, 85)
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
local BendyBtn = Instance.new("TextButton", MainContent)
BendyBtn.Size = UDim2.new(1, -30, 0, 44)
BendyBtn.Position = UDim2.new(0, 15, 0, 137)
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
local CloseBtn = Instance.new("TextButton", MainContent)
CloseBtn.Size = UDim2.new(0, 240, 0, 36)
CloseBtn.Position = UDim2.new(0.5, -120, 0, 195)
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

-- Ação do Botão de Configurações para alternar visibilidade
ConfigBtn.MouseButton1Click:Connect(function()
    SettingsPanel.Visible = not SettingsPanel.Visible
    MainContent.Visible = not SettingsPanel.Visible
end)
