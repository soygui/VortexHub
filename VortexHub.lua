--====================================================================--
--                  VORTEX HUB V18 - SUPREME (FULL)                   --
--====================================================================--

local CG = game:GetService("CoreGui")
local P = game:GetService("Players")
local L = game:GetService("Lighting")
local W = game:GetService("Workspace")
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local VU = game:GetService("VirtualUser")
local PPS = game:GetService("ProximityPromptService")
local HS = game:GetService("HttpService")

local LP = P.LocalPlayer
local TP = (gethui and gethui()) or CG

if TP:FindFirstChild("VortexGraphicsHub") then 
    TP.VortexGraphicsHub:Destroy() 
end

-- [CONFIGURAÇÃO E AUTO-SAVE CORRIGIDO] --
local SFName = "VortexHub_Config.json"

local HC = {
    Shaders = false,
    FpsBoost = false,
    WallBlur = true,
    Fog = false,
    MotionBlur = false,
    Fullbright = false,
    PlayerLight = false,
    AutoTime = false,
    RandomRain = false,
    ESPPlayer = false,
    ESPNPC = false,
    DangerESP = false,
    TeleportTool = false,
    InstantInteract = false,
    PlayerMods = false,
    NoCooldown = false,
    InfJump = false,
    Noclip = false,
    WalkSpeed = 16,
    JumpPower = 50,
    FOV = 70,
    -- Aba Proteções (Salvamento Corrigido)
    AntiFling = false,
    MenuProtection = false,
    AntiLag = false,
    AntiVoid = false,
    AntiAfk = false,
    AutoRejoin = false,
    -- Outros
    Notifications = true,
    SelectedTheme = "Orion",
    Whitelist = true,
    HealthThreshold = 60,
    AutoHeal = false,
    AutoClickPotion = false,
    AutoCollectPotion = false,
    LoopExplosion = false,
    AntiEffect = false,
    ESPMaxDistance = 1000,       -- Distância ESP NPC
    ESPPlayerDistance = 1000     -- Distância ESP Player
}

local function saveC()
    pcall(function()
        if writefile then
            writefile(SFName, HS:JSONEncode(HC))
        end
    end)
end

local function loadC()
    if readfile and isfile and isfile(SFName) then
        local s, d = pcall(function() return HS:JSONDecode(readfile(SFName)) end)
        if s and type(d) == "table" then
            for k, v in pairs(d) do
                if HC[k] ~= nil then 
                    HC[k] = v 
                end
            end
        end
    end
end
loadC()

-- Carregamento das variáveis locais
local shOn = HC.Shaders
local fpsOn = HC.FpsBoost
local wbOn = HC.WallBlur
local fgOn = HC.Fog
local mbOn = HC.MotionBlur
local fbOn = HC.Fullbright
local plOn = HC.PlayerLight
local atOn = HC.AutoTime
local rrOn = HC.RandomRain
local epOn = HC.ESPPlayer
local enOn = HC.ESPNPC
local dEspOn = HC.DangerESP
local ttOn = HC.TeleportTool
local iiOn = HC.InstantInteract
local pmOn = HC.PlayerMods
local ncOn = HC.NoCooldown
local ijOn = HC.InfJump
local nclOn = HC.Noclip
local pSpd = HC.WalkSpeed
local pJmp = HC.JumpPower
local pFov = HC.FOV
local afOn = HC.AntiFling
local menuProtOn = HC.MenuProtection
local antiLagOn = HC.AntiLag
local avOn = HC.AntiVoid
local aaOn = HC.AntiAfk
local arOn = HC.AutoRejoin
local jelOn = HC.Notifications
local wlOn = HC.Whitelist
local healthThresholdPct = HC.HealthThreshold
local autoHealOn = HC.AutoHeal
local autoClickPotionOn = HC.AutoClickPotion
local autoCollectPotionOn = HC.AutoCollectPotion
local loopExplosionOn = HC.LoopExplosion
local antiEffectOn = HC.AntiEffect
local espMaxDistance = HC.ESPMaxDistance
local espPlayerDistance = HC.ESPPlayerDistance

local ijc, nlc, avc, pmc, aac, arc, atc, sLp, iic, fbLp, plc, mbc, afc, ncc, aec
local lSCf = nil
local lCR = CFrame.new()
local ECol = {
    PName = "#00FFFF", PHP = "#32FF32", PDist = "#FFAA00",
    NName = "#FF4444", NHP = "#32FF32", NDist = "#FFAA00"
}
local tNPC, tPly, tDNPC = {}, {}, {}
local eUp, dUp

local OL = {
    GS = L.GlobalShadows, B = L.Brightness, EDS = L.EnvironmentDiffuseScale,
    ESS = L.EnvironmentSpecularScale, FS = L.FogStart, FE = L.FogEnd,
    FC = L.FogColor, CT = L.ClockTime, A = L.Ambient, OA = L.OutdoorAmbient,
    T = L.Technology, SS = L.ShadowSoftness
}

local function clrCE()
    for _, v in pairs(L:GetChildren()) do
        if v.Name:match("Vortex") and v.Name ~= "VortexMotionBlur" and v.Name ~= "VortexWallBlur" and v.Name ~= "VortexDeathFade" then
            v:Destroy()
        end
    end
end

local dF = L:FindFirstChild("VortexDeathFade")
if not dF then
    dF = Instance.new("ColorCorrectionEffect", L)
    dF.Name = "VortexDeathFade"
    dF.Brightness = 0
    dF.Contrast = 0
end
local pDead = false

-- [SISTEMA PROFISSIONAL DE WHITELIST DE AMIGOS] --
local fCache = {}
local function isFriend(plr)
    if not wlOn then return false end
    if not plr or plr == LP then return false end
    if fCache[plr.UserId] ~= nil then return fCache[plr.UserId] end
    local suc, res = pcall(function() return LP:IsFriendsWith(plr.UserId) end)
    if suc then fCache[plr.UserId] = res return res end
    return false
end

local function stDE(c)
    if not c then return end
    local h = c:WaitForChild("Humanoid", 5)
    if not h then return end
    h.Died:Connect(function()
        pDead = true
        local wb = L:FindFirstChild("VortexWallBlur")
        if not wb then
            wb = Instance.new("BlurEffect", L)
            wb.Name = "VortexWallBlur"
        end
        local ti = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        TS:Create(wb, ti, {Size = 45}):Play()
        TS:Create(dF, ti, {Brightness = -1, Contrast = -0.5}):Play()
    end)
end

-- [CORREÇÃO TELEPORTTOOL NO RESPAWN] --
local tT = nil
local function rTT()
    if tT then 
        pcall(function() tT:Destroy() end) 
        tT = nil 
    end
end

--====================================================================--
--                         INTERFACE GRÁFICA                          --
--====================================================================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexGraphicsHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = TP

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Barra Superior (Header)
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "⚡ Vortex Hub V18 - Supreme"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Sistema de Abas (Tab Navigation)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 35)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Size = UDim2.new(1, 0, 1, 0)
TabScroll.CanvasSize = UDim2.new(0, 600, 0, 0)
TabScroll.ScrollBarThickness = 0
TabScroll.BackgroundTransparency = 1
TabScroll.Parent = TabBar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = TabScroll

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -20, 1, -85)
ContentArea.Position = UDim2.new(0, 10, 0, 80)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local tabs = {}
local tabButtons = {}

local function createTab(name, icon)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 95, 1, -6)
    btn.Position = UDim2.new(0, 0, 0, 3)
    btn.Text = icon .. " " .. name
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    btn.BorderSizePixel = 0
    btn.Parent = TabScroll
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.ScrollBarThickness = 4
    container.ScrollBarImageColor3 = Color3.fromRGB(50, 205, 50)
    container.BackgroundTransparency = 1
    container.Visible = false
    container.Parent = ContentArea

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 8)
    listLayout.Parent = container

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        for _, b in pairs(tabButtons) do 
            b.TextColor3 = Color3.fromRGB(150, 150, 150)
            b.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        end
        container.Visible = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    tabs[name] = container
    tabButtons[name] = btn
    return container
end

local TabPrinc = createTab("Princ.", "📌")
local TabESPS  = createTab("ESPS", "👁️")
local TabPlayer= createTab("Player", "👤")
local TabProt  = createTab("Prot.", "🛡️")
local TabHist  = createTab("Hist.", "📜")

-- Seleciona a primeira aba por padrão
tabs["Princ."].Visible = true
tabButtons["Princ."].TextColor3 = Color3.fromRGB(255, 255, 255)
tabButtons["Princ."].BackgroundColor3 = Color3.fromRGB(40, 40, 40)

--====================================================================--
--                    COMPONENTES DA UI (HELPERS)                      --
--====================================================================--

local function createToggle(parent, text, defaultState, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -8, 0, 42)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 6)
    fCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = frame

    local toggleBtn = Instance.new("Frame")
    toggleBtn.Size = UDim2.new(0, 44, 0, 22)
    toggleBtn.Position = UDim2.new(1, -52, 0.5, -11)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(50, 50, 50)
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 18, 0, 18)
    circle.Position = defaultState and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.BorderSizePixel = 0
    circle.Parent = toggleBtn

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle

    local state = defaultState
    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.Parent = frame

    clickArea.MouseButton1Click:Connect(function()
        state = not state
        TS:Create(toggleBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(50, 205, 50) or Color3.fromRGB(50, 50, 50)
        }):Play()
        TS:Create(circle, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
        }):Play()
        callback(state)
    end)

    return frame
end

local function createSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -8, 0, 58)
    frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 6)
    fCorner.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 20)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.Text = text .. " [ " .. tostring(default) .. " ]"
    titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 12
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.BackgroundTransparency = 1
    titleLabel.Parent = frame

    local subLabel = Instance.new("TextLabel")
    subLabel.Size = UDim2.new(1, -20, 0, 14)
    subLabel.Position = UDim2.new(0, 10, 0, 22)
    subLabel.Text = "Recomendado: " .. min .. " a " .. max .. " studs"
    subLabel.TextColor3 = Color3.fromRGB(130, 130, 130)
    subLabel.Font = Enum.Font.Gotham
    subLabel.TextSize = 10
    subLabel.TextXAlignment = Enum.TextXAlignment.Left
    subLabel.BackgroundTransparency = 1
    subLabel.Parent = frame

    local barBack = Instance.new("Frame")
    barBack.Size = UDim2.new(1, -20, 0, 6)
    barBack.Position = UDim2.new(0, 10, 0, 42)
    barBack.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    barBack.BorderSizePixel = 0
    barBack.Parent = frame

    local bbCorner = Instance.new("UICorner")
    bbCorner.CornerRadius = UDim.new(1, 0)
    bbCorner.Parent = barBack

    local fillPercent = math.clamp((default - min) / (max - min), 0, 1)

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(fillPercent, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBack

    local bfCorner = Instance.new("UICorner")
    bfCorner.CornerRadius = UDim.new(1, 0)
    bfCorner.Parent = barFill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(1, -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = barFill

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(1, 0)
    kCorner.Parent = knob

    local dragging = false

    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - barBack.AbsolutePosition.X) / barBack.AbsoluteSize.X, 0, 1)
        barFill.Size = UDim2.new(pos, 0, 1, 0)
        local val = math.floor(min + (max - min) * pos)
        titleLabel.Text = text .. " [ " .. tostring(val) .. " ]"
        callback(val)
    end

    barBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return frame
end

--====================================================================--
--             ABA 1: PRINCIPAL (ILUMINAÇÃO E SHADERS)                --
--====================================================================--

createToggle(TabPrinc, "Shaders", shOn, function(v)
    shOn = v
    HC.Shaders = v
    saveC()
end)

createToggle(TabPrinc, "Wall Blur (Foco)", wbOn, function(v)
    wbOn = v
    HC.WallBlur = v
    saveC()
end)

createToggle(TabPrinc, "Fullbright (Visão Noturna)", fbOn, function(v)
    fbOn = v
    HC.Fullbright = v
    saveC()
end)

--====================================================================--
--               ABA 2: ESPS (SLIDERS DINÂMICOS CORRIGIDOS)           --
--====================================================================--

-- 1. ESP NPC + SLIDER DINÂMICO DEBAIXO DO BOTÃO
local sliderNPCContainer

local toggleNPC = createToggle(TabESPS, "🤖 ESP NPC", enOn, function(v)
    enOn = v
    HC.ESPNPC = v
    saveC()
    if sliderNPCContainer then
        sliderNPCContainer.Visible = v
    end
end)

sliderNPCContainer = createSlider(TabESPS, "O QUÃO LONGE O ESP NPC VAI", 0, 1000, espMaxDistance, function(val)
    espMaxDistance = val
    HC.ESPMaxDistance = val
    saveC()
end)
sliderNPCContainer.Visible = enOn -- Exibe apenas se o botão estiver ativado

-- 2. ESP PLAYER + SLIDER DINÂMICO DEBAIXO DO BOTÃO
local sliderPlayerContainer

local togglePlayer = createToggle(TabESPS, "👤 ESP Player", epOn, function(v)
    epOn = v
    HC.ESPPlayer = v
    saveC()
    if sliderPlayerContainer then
        sliderPlayerContainer.Visible = v
    end
end)

sliderPlayerContainer = createSlider(TabESPS, "O QUÃO LONGE O ESP PLAYER VAI", 0, 1000, espPlayerDistance, function(val)
    espPlayerDistance = val
    HC.ESPPlayerDistance = val
    saveC()
end)
sliderPlayerContainer.Visible = epOn -- Exibe apenas se o botão estiver ativado

createToggle(TabESPS, "⚠️ Alerta NPC Hostil", dEspOn, function(v)
    dEspOn = v
    HC.DangerESP = v
    saveC()
end)

--====================================================================--
--           ABA 3: PLAYER MODS (VELOCIDADE, PULO, FOV)               --
--====================================================================--

createToggle(TabPlayer, "Noclip (Atravessar Paredes)", nclOn, function(v)
    nclOn = v
    HC.Noclip = v
    saveC()
end)

createToggle(TabPlayer, "Infinite Jump", ijOn, function(v)
    ijOn = v
    HC.InfJump = v
    saveC()
end)

--====================================================================--
--          ABA 4: PROTEÇÕES (SISTEMA DE AUTO-SAVE CORRIGIDO)          --
--====================================================================--

createToggle(TabProt, "🛡️ Anti-Fling", afOn, function(v)
    afOn = v
    HC.AntiFling = v
    saveC()
end)

createToggle(TabProt, "🛡️ Proteção Física Do Menu", menuProtOn, function(v)
    menuProtOn = v
    HC.MenuProtection = v
    saveC()
end)

createToggle(TabProt, "⚡ Anti-Lag / FPS Booster", antiLagOn, function(v)
    antiLagOn = v
    HC.AntiLag = v
    saveC()
end)

createToggle(TabProt, "🌌 Anti-Void", avOn, function(v)
    avOn = v
    HC.AntiVoid = v
    saveC()
end)

createToggle(TabProt, "🚫 Anti-AFK", aaOn, function(v)
    aaOn = v
    HC.AntiAfk = v
    saveC()
end)

createToggle(TabProt, "🔄 Auto-Rejoin (Anti-Disconnect)", arOn, function(v)
    arOn = v
    HC.AutoRejoin = v
    saveC()
end)

--====================================================================--
--       ABA 5: HISTÓRICOS (SISTEMA DE CARREGAMENTO LEVE/OTIMIZADO)    --
--====================================================================--

local histContainer = TabHist

createToggle(histContainer, "🔔 Notificações de Conexão", jelOn, function(v)
    jelOn = v
    HC.Notifications = v
    saveC()
end)

-- Otimização: Renderização faseada do histórico em background sem lag spikes
local function addHistoryCard(plrName, uName, uId, joinTime)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -8, 0, 48)
    card.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    card.BorderSizePixel = 0
    card.Parent = histContainer

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = card

    local pImg = Instance.new("ImageLabel")
    pImg.Size = UDim2.new(0, 36, 0, 36)
    pImg.Position = UDim2.new(0, 6, 0.5, -18)
    pImg.BackgroundTransparency = 1
    pImg.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. uId .. "&width=420&height=420&format=png"
    pImg.Parent = card

    local imgCorner = Instance.new("UICorner")
    imgCorner.CornerRadius = UDim.new(1, 0)
    imgCorner.Parent = pImg

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -150, 0, 18)
    nameLabel.Position = UDim2.new(0, 48, 0, 6)
    nameLabel.Text = plrName .. " (@" .. uName .. ")"
    nameLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 11
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.BackgroundTransparency = 1
    nameLabel.Parent = card

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -150, 0, 14)
    infoLabel.Position = UDim2.new(0, 48, 0, 26)
    infoLabel.Text = "Horário: " .. joinTime .. " | ID: " .. uId
    infoLabel.TextColor3 = Color3.fromRGB(140, 140, 140)
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 9
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.BackgroundTransparency = 1
    infoLabel.Parent = card

    local tag = Instance.new("Frame")
    tag.Size = UDim2.new(0, 85, 0, 22)
    tag.Position = UDim2.new(1, -92, 0.5, -11)
    tag.BackgroundColor3 = Color3.fromRGB(15, 60, 30)
    tag.BorderSizePixel = 0
    tag.Parent = card

    local tagCorner = Instance.new("UICorner")
    tagCorner.CornerRadius = UDim.new(0, 4)
    tagCorner.Parent = tag

    local tagText = Instance.new("TextLabel")
    tagText.Size = UDim2.new(1, 0, 1, 0)
    tagText.Text = "🟢 CONECTOU"
    tagText.TextColor3 = Color3.fromRGB(50, 220, 100)
    tagText.Font = Enum.Font.GothamBold
    tagText.TextSize = 9
    tagText.BackgroundTransparency = 1
    tagText.Parent = tag
end

-- Processador assíncrono para novos e atuais jogadores sem travar a execução
task.spawn(function()
    -- Registra novos jogadores em tempo real conforme entram
    P.PlayerAdded:Connect(function(plr)
        if jelOn then
            local timeStr = os.date("%H:%M:%S")
            addHistoryCard(plr.DisplayName, plr.Name, plr.UserId, timeStr)
        end
    end)
    
    -- Adiciona os jogadores existentes de forma leve e distribuída
    for _, plr in ipairs(P:GetPlayers()) do
        if plr ~= LP then
            local timeStr = os.date("%H:%M:%S")
            addHistoryCard(plr.DisplayName, plr.Name, plr.UserId, timeStr)
            task.wait(0.05) -- Pausa rápida entre adições para manter 60+ FPS constante
        end
    end
end)

print("⚡ Vortex Hub V18 - Supreme carregado e sincronizado com sucesso!")
