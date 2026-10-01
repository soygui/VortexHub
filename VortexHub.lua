-- ==========================================================
-- VORTEX HUB V19 - SUPREME EDITION (VERSÃO FINAL CORRIGIDA)
-- ==========================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local TargetParent = (gethui and gethui()) or CoreGui

if TargetParent:FindFirstChild("VortexGraphicsHub") then TargetParent.VortexGraphicsHub:Destroy() end

-- ==========================================================
-- CONFIGURAÇÕES
-- ==========================================================
local SaveFileName = "VortexHub_Config.json"
local HubConfig = {
    Shaders = false, FpsBoost = false, WallBlur = true, Fog = false, MotionBlur = false,
    Fullbright = false, PlayerLight = false, AutoTime = false, ESPPlayer = false,
    ESPNPC = false, DangerESP = false, ItemESP = false, Chams = false, Tracers = false,
    XRay = false, TeleportTool = false, InstantInteract = false, PlayerMods = false,
    NoCooldown = false, InfJump = false, Noclip = false, NoclipRaycast = false,
    Freecam = false, MaxZoom = false, WalkSpeed = 16, JumpPower = 50, FOV = 70,
    AntiFling = false, AntiVoid = false, AntiAfk = false, Notifications = true,
    JoinLogs = false, ChatLogs = false, StaffDetector = false, AutoLeave = false,
    ChatCommands = false, MemoryCleaner = false, LowGraphics = false, RealFPSBoost = false,
    SelectedTheme = "Orion"
}

local function saveConfig()
    pcall(function()
        if writefile then writefile(SaveFileName, HttpService:JSONEncode(HubConfig)) end
    end)
end

local function loadConfig()
    pcall(function()
        if readfile and isfile and isfile(SaveFileName) then
            local data = HttpService:JSONDecode(readfile(SaveFileName))
            if type(data) == "table" then
                for k, v in pairs(data) do
                    if HubConfig[k] ~= nil then HubConfig[k] = v end
                end
            end
        end
    end)
end
loadConfig()

-- ==========================================================
-- SISTEMA DE IDIOMA
-- ==========================================================
local SelectedLanguage = "pt"
pcall(function()
    if readfile and isfile and isfile("VortexHub_Lang.txt") then
        local l = readfile("VortexHub_Lang.txt")
        if l == "en" or l == "pt" then SelectedLanguage = l end
    end
end)

local Trans = {
    pt = { 
        title = "🌍 Selecione o Idioma", pt = "🇧🇷 Português", en = "🇺🇸 English",
        tab_main = "🔧 Principal", tab_esp = "👁️ ESPS", tab_player = "👤 Player",
        tab_prot = "🛡️ Proteção", tab_hist = "📜 Logs", tab_theme = "🎨 Temas",
        tab_view = "👀 Viewer", tab_stats = "📊 Stats", tab_opt = "⚡ Otimização",
        tab_sec = "🔒 Anti-Staff", tab_remote = "🎮 Controle"
    },
    en = { 
        title = "🌍 Select Language", pt = "🇧🇷 Portuguese", en = "🇺🇸 English",
        tab_main = "🔧 Main", tab_esp = "👁️ ESPS", tab_player = "👤 Player",
        tab_prot = "🛡️ Protect", tab_hist = "📜 Logs", tab_theme = "🎨 Themes",
        tab_view = "👀 Viewer", tab_stats = "📊 Stats", tab_opt = "⚡ Optimization",
        tab_sec = "🔒 Anti-Staff", tab_remote = "🎮 Remote"
    }
}
local function tx(k) return (Trans[SelectedLanguage] or Trans.pt)[k] or k end

local LangGui = Instance.new("ScreenGui", TargetParent)
LangGui.Name = "VortexLangGui"
local LF = Instance.new("Frame", LangGui)
LF.Size = UDim2.new(0, 300, 0, 180)
LF.Position = UDim2.new(0.5, -150, 0.5, -90)
LF.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Instance.new("UICorner", LF).CornerRadius = UDim.new(0, 10)

local LT = Instance.new("TextLabel", LF)
LT.Size = UDim2.new(1, -20, 0, 30)
LT.Position = UDim2.new(0, 10, 0, 15)
LT.BackgroundTransparency = 1
LT.Text = "🌍 Selecione o Idioma / Select Language"
LT.TextColor3 = Color3.fromRGB(255, 255, 255)
LT.Font = Enum.Font.GothamBold
LT.TextSize = 14

local BP = Instance.new("TextButton", LF)
BP.Size = UDim2.new(1, -40, 0, 45)
BP.Position = UDim2.new(0, 20, 0, 60)
BP.BackgroundColor3 = Color3.fromRGB(0, 156, 59)
BP.Text = "🇧🇷 Português"
BP.TextColor3 = Color3.fromRGB(255, 255, 255)
BP.Font = Enum.Font.GothamBold
Instance.new("UICorner", BP).CornerRadius = UDim.new(0, 8)

local BE = Instance.new("TextButton", LF)
BE.Size = UDim2.new(1, -40, 0, 45)
BE.Position = UDim2.new(0, 20, 0, 115)
BE.BackgroundColor3 = Color3.fromRGB(50, 70, 150)
BE.Text = "🇺🇸 English"
BE.TextColor3 = Color3.fromRGB(255, 255, 255)
BE.Font = Enum.Font.GothamBold
Instance.new("UICorner", BE).CornerRadius = UDim.new(0, 8)

local function setLang(l)
    SelectedLanguage = l
    pcall(function() if writefile then writefile("VortexHub_Lang.txt", l) end end)
    LangGui:Destroy()
end

BP.MouseButton1Click:Connect(function() setLang("pt") end)
BE.MouseButton1Click:Connect(function() setLang("en") end)

if SelectedLanguage == "pt" or SelectedLanguage == "en" then LangGui:Destroy() end
repeat task.wait(0.05) until not LangGui.Parent or LangGui.Parent ~= TargetParent

-- ==========================================================
-- VARIÁVEIS E CACHE
-- ==========================================================
local conns = {}
local EspColors = { PName = "#00FFFF", PHP = "#32FF32", PDist = "#FFAA00", NName = "#FF4444", NHP = "#32FF32", NDist = "#FFAA00", Item = "#00FFCC" }
local trackedPlayers, trackedNPCs, trackedItems, trackedChams, trackedTracers = {}, {}, {}, {}, {}
local CachedNPCs = {}
local espUpd, tracerUpd, itemUpd, xrayUpd, noclipUpd, freecamUpd

local function checkNPC(o)
    if o:IsA("Model") and o:FindFirstChild("Humanoid") and o:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(o) then
        CachedNPCs[o] = true
    end
end
for _, o in ipairs(Workspace:GetDescendants()) do checkNPC(o) end
Workspace.DescendantAdded:Connect(function(o)
    task.delay(0.2, function()
        if o and o.Parent then
            if o:IsA("Model") then checkNPC(o) end
            if o.Parent:IsA("Model") then checkNPC(o.Parent) end
        end
    end)
end)
Workspace.DescendantRemoving:Connect(function(o)
    if CachedNPCs[o] then CachedNPCs[o] = nil end
end)

-- ==========================================================
-- UI PRINCIPAL
-- ==========================================================
local SG = Instance.new("ScreenGui", TargetParent)
SG.Name = "VortexGraphicsHub"
SG.ResetOnSpawn = false

local MF = Instance.new("Frame", SG)
MF.Size = UDim2.new(0, 520, 0, 560)
MF.Position = UDim2.new(0.5, -260, 0.5, -280)
MF.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
MF.Active = true
MF.Draggable = true
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 8)

local TB = Instance.new("Frame", MF)
TB.Size = UDim2.new(1, 0, 0, 40)
TB.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 8)

local Ttl = Instance.new("TextLabel", TB)
Ttl.Size = UDim2.new(1, -50, 1, 0)
Ttl.Position = UDim2.new(0, 15, 0, 0)
Ttl.Text = "⚡ Vortex Hub V19 - Supreme"
Ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
Ttl.Font = Enum.Font.GothamBold
Ttl.TextSize = 14
Ttl.BackgroundTransparency = 1
Ttl.TextXAlignment = Enum.TextXAlignment.Left

local CB = Instance.new("TextButton", TB)
CB.Size = UDim2.new(0, 40, 0, 40)
CB.Position = UDim2.new(1, -40, 0, 0)
CB.BackgroundTransparency = 1
CB.Text = "X"
CB.TextColor3 = Color3.fromRGB(200, 200, 200)
CB.Font = Enum.Font.GothamBold
CB.TextSize = 16
CB.MouseButton1Click:Connect(function() MF.Visible = false end)

-- TABS
local TabC = Instance.new("Frame", MF)
TabC.Size = UDim2.new(1, 0, 0, 60)
TabC.Position = UDim2.new(0, 0, 0, 40)
TabC.BackgroundTransparency = 1

local function cTab(n, x, y, w)
    local b = Instance.new("TextButton", TabC)
    b.Size = UDim2.new(w, 0, 0.5, 0)
    b.Position = UDim2.new(x, 0, y, 0)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = n
    b.TextColor3 = Color3.fromRGB(150, 150, 150)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 9
    return b
end

local tMain = cTab(tx("tab_main"), 0, 0, 0.181)
local tESP = cTab(tx("tab_esp"), 0.181, 0, 0.181)
local tPlayer = cTab(tx("tab_player"), 0.362, 0, 0.181)
local tProt = cTab(tx("tab_prot"), 0.543, 0, 0.181)
local tHist = cTab(tx("tab_hist"), 0.724, 0, 0.181)
local tTheme = cTab(tx("tab_theme"), 0.905, 0, 0.095)
local tView = cTab(tx("tab_view"), 0, 0.5, 0.181)
local tStats = cTab(tx("tab_stats"), 0.181, 0.5, 0.181)
local tOpt = cTab(tx("tab_opt"), 0.362, 0.5, 0.181)
local tSec = cTab(tx("tab_sec"), 0.543, 0.5, 0.181)
local tRemote = cTab(tx("tab_remote"), 0.724, 0.5, 0.276)

local function cScroll(cY)
    local S = Instance.new("ScrollingFrame", MF)
    S.Size = UDim2.new(1, -20, 1, -110)
    S.Position = UDim2.new(0, 10, 0, 105)
    S.BackgroundTransparency = 1
    S.ScrollBarThickness = 4
    S.CanvasSize = UDim2.new(0, 0, 0, cY)
    local L = Instance.new("UIListLayout", S)
    L.Padding = UDim.new(0, 8)
    L.HorizontalAlignment = Enum.HorizontalAlignment.Center
    S.Visible = false
    return S
end

local sMain = cScroll(900)
local sESP = cScroll(1000)
local sPlayer = cScroll(1200)
local sProt = cScroll(900)
local sHist = cScroll(1500)
local sTheme = cScroll(500)
local sView = cScroll(1200)
local sStats = cScroll(600)
local sOpt = cScroll(800)
local sSec = cScroll(600)
local sRemote = cScroll(800)

local allTabs = {{tMain, sMain}, {tESP, sESP}, {tPlayer, sPlayer}, {tProt, sProt}, {tHist, sHist}, {tTheme, sTheme}, {tView, sView}, {tStats, sStats}, {tOpt, sOpt}, {tSec, sSec}, {tRemote, sRemote}}
local function switchTab(ab)
    for _, d in pairs(allTabs) do
        if d[1] == ab then
            d[1].BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            d[1].TextColor3 = Color3.fromRGB(255, 255, 255)
            d[2].Visible = true
        else
            d[1].BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            d[1].TextColor3 = Color3.fromRGB(150, 150, 150)
            d[2].Visible = false
        end
    end
end
for _, d in pairs(allTabs) do d[1].MouseButton1Click:Connect(function() switchTab(d[1]) end) end
sMain.Visible = true
tMain.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tMain.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ==========================================================
-- COMPONENTES DE UI
-- ==========================================================
local function cTitle(n, p)
    local t = Instance.new("TextLabel", p)
    t.Size = UDim2.new(1, 0, 0, 25)
    t.BackgroundTransparency = 1
    t.Text = n
    t.TextColor3 = Color3.fromRGB(52, 152, 219)
    t.Font = Enum.Font.GothamBlack
    t.TextSize = 13
    t.TextXAlignment = Enum.TextXAlignment.Left
end

local function cTog(n, p, st, cb, ck)
    local f = Instance.new("Frame", p)
    f.Size = UDim2.new(1, 0, 0, 42)
    f.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
    local L = Instance.new("TextLabel", f)
    L.Size = UDim2.new(0.7, 0, 1, 0)
    L.Position = UDim2.new(0.05, 0, 0, 0)
    L.Text = n
    L.TextColor3 = Color3.fromRGB(255, 255, 255)
    L.Font = Enum.Font.Gotham
    L.TextSize = 13
    L.BackgroundTransparency = 1
    L.TextXAlignment = Enum.TextXAlignment.Left
    local sb = Instance.new("Frame", f)
    sb.Size = UDim2.new(0, 40, 0, 20)
    sb.Position = UDim2.new(1, -55, 0.5, -10)
    sb.BackgroundColor3 = st and Color3.fromRGB(52, 152, 219) or Color3.fromRGB(70, 70, 70)
    Instance.new("UICorner", sb).CornerRadius = UDim.new(1, 0)
    local sk = Instance.new("Frame", sb)
    sk.Size = UDim2.new(0, 16, 0, 16)
    sk.Position = st and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    sk.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", sk).CornerRadius = UDim.new(1, 0)
    local state = st
    local function setS(ns)
        state = ns
        TweenService:Create(sb, TweenInfo.new(0.2), { BackgroundColor3 = state and Color3.fromRGB(52, 152, 219) or Color3.fromRGB(70, 70, 70) }):Play()
        TweenService:Create(sk, TweenInfo.new(0.2), { Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8) }):Play()
        if ck then HubConfig[ck] = state saveConfig() end
    end
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(1, 0, 1, 0)
    b.BackgroundTransparency = 1
    b.Text = ""
    b.MouseButton1Click:Connect(function() setS(not state) cb(state) end)
    return setS
end

local function cSli(n, rt, mn, mx, cv, p, cb, ck)
    local f = Instance.new("Frame", p)
    f.Size = UDim2.new(1, 0, 0, 65)
    f.BackgroundColor3 = Color3.fromRGB(42, 42, 45)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1, -20, 0, 20)
    t.Position = UDim2.new(0, 12, 0, 6)
    t.Text = n .. " [ " .. tostring(cv) .. " ]"
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.Font = Enum.Font.GothamBold
    t.TextSize = 13
    t.BackgroundTransparency = 1
    t.TextXAlignment = Enum.TextXAlignment.Left
    local r = Instance.new("TextLabel", f)
    r.Size = UDim2.new(1, -20, 0, 14)
    r.Position = UDim2.new(0, 12, 0, 24)
    r.Text = "Rec: " .. rt
    r.TextColor3 = Color3.fromRGB(160, 160, 165)
    r.Font = Enum.Font.Gotham
    r.TextSize = 11
    r.BackgroundTransparency = 1
    r.TextXAlignment = Enum.TextXAlignment.Left
    local tr = Instance.new("Frame", f)
    tr.Size = UDim2.new(1, -24, 0, 8)
    tr.Position = UDim2.new(0, 12, 0, 46)
    tr.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    Instance.new("UICorner", tr).CornerRadius = UDim.new(1, 0)
    local pi = math.clamp((cv - mn) / (mx - mn), 0, 1)
    local fi = Instance.new("Frame", tr)
    fi.Size = UDim2.new(pi, 0, 1, 0)
    fi.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
    Instance.new("UICorner", fi).CornerRadius = UDim.new(1, 0)
    local kn = Instance.new("Frame", tr)
    kn.Size = UDim2.new(0, 18, 0, 18)
    kn.AnchorPoint = Vector2.new(0.5, 0.5)
    kn.Position = UDim2.new(pi, 0, 0.5, 0)
    kn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", kn).CornerRadius = UDim.new(1, 0)
    local hb = Instance.new("TextButton", f)
    hb.Size = UDim2.new(1, 0, 1, 0)
    hb.BackgroundTransparency = 1
    hb.Text = ""
    local dr = false
    local function upd(i)
        local px = math.clamp(i.Position.X - tr.AbsolutePosition.X, 0, tr.AbsoluteSize.X)
        local pc = px / tr.AbsoluteSize.X
        local v = math.floor(mn + (mx - mn) * pc)
        TweenService:Create(fi, TweenInfo.new(0.05), { Size = UDim2.new(pc, 0, 1, 0) }):Play()
        TweenService:Create(kn, TweenInfo.new(0.05), { Position = UDim2.new(pc, 0, 0.5, 0) }):Play()
        t.Text = n .. " [ " .. tostring(v) .. " ]"
        if ck then HubConfig[ck] = v saveConfig() end
        cb(v)
    end
    hb.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dr = true upd(i) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dr = false end end)
    UserInputService.InputChanged:Connect(function(i) if dr and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then upd(i) end end)
end

local function cBtn(n, p, cb)
    local b = Instance.new("TextButton", p)
    b.Size = UDim2.new(1, 0, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.Text = n
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(cb)
end

-- ==========================================================
-- LÓGICA DE SISTEMAS
-- ==========================================================
local function cESP(m)
    local r = m:FindFirstChild("HumanoidRootPart")
    local h = m:FindFirstChildOfClass("Humanoid")
    if not r or not h then return nil end
    local bg = Instance.new("BillboardGui")
    bg.Size = UDim2.new(0, 400, 0, 50)
    bg.Adornee = r
    bg.StudsOffset = Vector3.new(0, 3.5, 0)
    bg.AlwaysOnTop = true
    bg.Parent = SG
    local el = Instance.new("TextLabel", bg)
    el.Size = UDim2.new(1, 0, 1, 0)
    el.BackgroundTransparency = 1
    el.RichText = true
    el.TextStrokeTransparency = 0.5
    el.Font = Enum.Font.GothamBold
    el.TextSize = 13
    return { Gui = bg, Hum = h, Root = r, Lbl = el, Model = m }
end

local function updESP()
    if espUpd then espUpd:Disconnect() end
    if not HubConfig.ESPNPC and not HubConfig.ESPPlayer then return end
    espUpd = RunService.RenderStepped:Connect(function()
        local lc = LocalPlayer.Character
        local lr = lc and lc:FindFirstChild("HumanoidRootPart")
        if HubConfig.ESPPlayer then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                    if not trackedPlayers[p] or trackedPlayers[p].Model ~= p.Character then
                        if trackedPlayers[p] and trackedPlayers[p].Gui then trackedPlayers[p].Gui:Destroy() end
                        trackedPlayers[p] = cESP(p.Character)
                    end
                end
            end
            for p, d in pairs(trackedPlayers) do
                if not p or not p.Parent or not p.Character or not d.Hum or d.Hum.Health <= 0 or d.Model ~= p.Character then
                    if d.Gui then d.Gui:Destroy() end
                    trackedPlayers[p] = nil
                else
                    local hs = math.floor(d.Hum.Health)
                    local ds = lr and d.Root and tostring(math.floor((lr.Position - d.Root.Position).Magnitude)) or "???"
                    d.Lbl.Text = string.format('<b><font color="%s">%s</font> | <font color="%s">HP: %s</font> | <font color="%s">%s</font></b>', EspColors.PName, p.Name, EspColors.PHP, hs, EspColors.PDist, ds)
                end
            end
        end
        if HubConfig.ESPNPC then
            for m in pairs(CachedNPCs) do
                if m.Parent and not trackedNPCs[m] then trackedNPCs[m] = cESP(m) end
            end
            for m, d in pairs(trackedNPCs) do
                if not m or not m.Parent or not d.Hum or d.Hum.Health <= 0 or not CachedNPCs[m] then
                    if d.Gui then d.Gui:Destroy() end
                    trackedNPCs[m] = nil
                else
                    local ds = lr and d.Root and (lr.Position - d.Root.Position).Magnitude or 9999
                    if ds > 2500 then
                        d.Gui.Enabled = false
                    else
                        d.Gui.Enabled = true
                        d.Lbl.Text = string.format('<b><font color="%s">%s</font><br /><font color="%s">HP: %s</font><br /><font color="%s">D: %s</font></b>', EspColors.NName, m.Name, EspColors.NHP, math.floor(d.Hum.Health), EspColors.NDist, math.floor(ds))
                    end
                end
            end
        end
    end)
end

local function updChams()
    for _, h in pairs(trackedChams) do h:Destroy() end
    table.clear(trackedChams)
    if not HubConfig.Chams then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = Instance.new("Highlight")
            hl.Adornee = p.Character
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.FillTransparency = 0.5
            hl.OutlineColor = Color3.fromRGB(255, 0, 0)
            hl.Parent = SG
            trackedChams[p] = hl
        end
    end
end

local function updTracers()
    if tracerUpd then tracerUpd:Disconnect() end
    if not HubConfig.Tracers then
        for _, t in pairs(trackedTracers) do if t.L then t.L:Remove() end end
        table.clear(trackedTracers)
        return
    end
    tracerUpd = RunService.RenderStepped:Connect(function()
        local cam = Workspace.CurrentCamera
        if not cam then return end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local r = p.Character:FindFirstChild("HumanoidRootPart")
                if r then
                    if not trackedTracers[p] then
                        local l = Drawing.new("Line")
                        l.Thickness = 1
                        l.Color = Color3.fromRGB(255, 0, 0)
                        l.Transparency = 1
                        trackedTracers[p] = { L = l, Model = p.Character }
                    end
                    if trackedTracers[p] and trackedTracers[p].L then
                        local sp, onS = cam:WorldToViewportPoint(r.Position)
                        if onS then
                            trackedTracers[p].L.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                            trackedTracers[p].L.To = Vector2.new(sp.X, sp.Y)
                            trackedTracers[p].L.Visible = true
                        else
                            trackedTracers[p].L.Visible = false
                        end
                    end
                end
            end
        end
        for p, t in pairs(trackedTracers) do
            if not p.Parent or not p.Character then
                if t.L then t.L:Remove() end
                trackedTracers[p] = nil
            end
        end
    end)
end

local function updItemESP()
    if itemUpd then itemUpd:Disconnect() itemUpd = nil end
    for _, d in pairs(trackedItems) do if d.Gui then d.Gui:Destroy() end end
    table.clear(trackedItems)
    if not HubConfig.ItemESP then return end
    itemUpd = RunService.RenderStepped:Connect(function()
        local lc = LocalPlayer.Character
        local lr = lc and lc:FindFirstChild("HumanoidRootPart")
        for _, v in ipairs(Workspace:GetDescendants()) do
            local root = nil
            if v:IsA("Tool") and v.Parent == Workspace then
                root = v:FindFirstChild("Handle")
            elseif v:IsA("Model") and v.Parent == Workspace and (v:FindFirstChildOfClass("Tool") or v:FindFirstChildOfClass("MeshPart") or v.Name:lower():find("coin") or v.Name:lower():find("chest")) then
                root = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
            end
            if root and not trackedItems[v] then
                local bg = Instance.new("BillboardGui")
                bg.Size = UDim2.new(0, 250, 0, 40)
                bg.Adornee = root
                bg.StudsOffset = Vector3.new(0, 2, 0)
                bg.AlwaysOnTop = true
                bg.Parent = SG
                local el = Instance.new("TextLabel", bg)
                el.Size = UDim2.new(1, 0, 1, 0)
                el.BackgroundTransparency = 1
                el.RichText = true
                el.TextStrokeTransparency = 0.5
                el.Font = Enum.Font.GothamBold
                el.TextSize = 12
                trackedItems[v] = { Gui = bg, Part = root, Lbl = el }
            end
        end
        for v, d in pairs(trackedItems) do
            if not v or not v.Parent or not d.Part or not d.Part.Parent then
                if d.Gui then d.Gui:Destroy() end
                trackedItems[v] = nil
            else
                local ds = lr and (lr.Position - d.Part.Position).Magnitude or 0
                d.Lbl.Text = string.format('<b><font color="%s">%s</font> | <font color="%s">%d</font></b>', EspColors.Item, v.Name, EspColors.PDist, math.floor(ds))
            end
        end
    end)
end

local function updXRay()
    if xrayUpd then xrayUpd:Disconnect() xrayUpd = nil end
    if HubConfig.XRay then
        xrayUpd = RunService.Heartbeat:Connect(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and not v:FindFirstChildOfClass("Humanoid") then
                    if v.Transparency < 1 and v ~= LocalPlayer.Character then
                        v.LocalTransparencyModifier = 0.7
                    end
                end
            end
        end)
    else
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.LocalTransparencyModifier = 0 end
        end
    end
end

local afConn
local function enableAF()
    if afConn then afConn:Disconnect() end
    afConn = RunService.Stepped:Connect(function()
        if not HubConfig.AntiFling then return end
        local c = LocalPlayer.Character
        if not c then return end
        for _, p in pairs(c:GetChildren()) do
            if p:IsA("BasePart") then
                if p.Velocity.Magnitude > 1000 then p.Velocity = Vector3.new(0, 0, 0) end
                if p.RotVelocity.Magnitude > 1000 then p.RotVelocity = Vector3.new(0, 0, 0) end
            end
        end
    end)
end

-- ==========================================================
-- UI: ABA PRINCIPAL
-- ==========================================================
cTitle("✨ GRÁFICOS", sMain)
local stU, ftU
stU = cTog("✨ Shaders", sMain, HubConfig.Shaders, function(s) HubConfig.Shaders = s end, "Shaders")
ftU = cTog("🥔 Booster FPS", sMain, HubConfig.FpsBoost, function(s) HubConfig.FpsBoost = s end, "FpsBoost")
cTog("🌫️ Desfoque", sMain, HubConfig.WallBlur, function(s) HubConfig.WallBlur = s end, "WallBlur")
cTog("🌫️ Neblina", sMain, HubConfig.Fog, function(s) HubConfig.Fog = s end, "Fog")
cTog("🌀 Motion Blur", sMain, HubConfig.MotionBlur, function(s) HubConfig.MotionBlur = s end, "MotionBlur")
cTog("☀️ Fullbright", sMain, HubConfig.Fullbright, function(s) HubConfig.Fullbright = s end, "Fullbright")
cTog("🔦 Luz Player", sMain, HubConfig.PlayerLight, function(s) HubConfig.PlayerLight = s end, "PlayerLight")
cTitle("🔬 X-RAY", sMain)
cTog("👁️ X-Ray em Partes", sMain, HubConfig.XRay, function(s) HubConfig.XRay = s updXRay() end, "XRay")
cTitle("⏰ TEMPO", sMain)
cTog("🔄 Auto Tempo", sMain, HubConfig.AutoTime, function(s) HubConfig.AutoTime = s end, "AutoTime")

-- ==========================================================
-- UI: ABA ESPS
-- ==========================================================
cTitle("👁️ ESP", sESP)
cTog("👤 ESP Player", sESP, HubConfig.ESPPlayer, function(s) HubConfig.ESPPlayer = s updESP() end, "ESPPlayer")
cTog("🤖 ESP NPC", sESP, HubConfig.ESPNPC, function(s) HubConfig.ESPNPC = s updESP() end, "ESPNPC")
cTog("⚠️ Alerta Hostil", sESP, HubConfig.DangerESP, function(s) HubConfig.DangerESP = s end, "DangerESP")
cTog("📦 Item / Drop ESP", sESP, HubConfig.ItemESP, function(s) HubConfig.ItemESP = s updItemESP() end, "ItemESP")
cTitle("🎨 VISUAL", sESP)
cTog("✨ Chams / Highlight", sESP, HubConfig.Chams, function(s) HubConfig.Chams = s updChams() end, "Chams")
cTog("📏 Tracers (Linhas)", sESP, HubConfig.Tracers, function(s) HubConfig.Tracers = s updTracers() end, "Tracers")

-- ==========================================================
-- UI: ABA PLAYER
-- ==========================================================
cTitle("👤 MODS", sPlayer)
cTog("🌀 TeleportTool", sPlayer, HubConfig.TeleportTool, function(s) HubConfig.TeleportTool = s end, "TeleportTool")
cTog("⚡ Instant Interact", sPlayer, HubConfig.InstantInteract, function(s) HubConfig.InstantInteract = s end, "InstantInteract")
cTog("⚡ Mods Player", sPlayer, HubConfig.PlayerMods, function(s) HubConfig.PlayerMods = s end, "PlayerMods")
cTog("⚡ No Cooldown", sPlayer, HubConfig.NoCooldown, function(s) HubConfig.NoCooldown = s end, "NoCooldown")
cTog("🚀 Inf Jump", sPlayer, HubConfig.InfJump, function(s) HubConfig.InfJump = s end, "InfJump")
cTog("👻 Noclip", sPlayer, HubConfig.Noclip, function(s) HubConfig.Noclip = s end, "Noclip")
cTog("🧠 Noclip Raycast", sPlayer, HubConfig.NoclipRaycast, function(s) HubConfig.NoclipRaycast = s end, "NoclipRaycast")
cTog("🔍 Max Zoom", sPlayer, HubConfig.MaxZoom, function(s) HubConfig.MaxZoom = s end, "MaxZoom")
cTog("🎥 Freecam", sPlayer, HubConfig.Freecam, function(s) HubConfig.Freecam = s end, "Freecam")
cSli("🏃 WalkSpeed", "16-50", 16, 200, HubConfig.WalkSpeed, sPlayer, function(v) HubConfig.WalkSpeed = v end, "WalkSpeed")
cSli("🦘 JumpPower", "50-100", 50, 300, HubConfig.JumpPower, sPlayer, function(v) HubConfig.JumpPower = v end, "JumpPower")
cSli("🔭 FOV", "70-90", 70, 120, HubConfig.FOV, sPlayer, function(v) HubConfig.FOV = v end, "FOV")
cTitle("🌐 SERVER HOP", sPlayer)
cBtn("🔇 Servidores Vazios (Farm)", sPlayer, function()
    local ok, servers = pcall(function() return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")) end)
    if ok and servers and servers.data then
        for _, s in ipairs(servers.data) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer) return end
        end
    end
end)
cBtn("⚡ Servidores Baixo Ping (PVP)", sPlayer, function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)

-- ==========================================================
-- UI: ABA PROTEÇÃO
-- ==========================================================
cTitle("🛡️ PROTEÇÃO", sProt)
cTog("🛡️ Anti-Fling", sProt, HubConfig.AntiFling, function(s) HubConfig.AntiFling = s if s then enableAF() end end, "AntiFling")
cTog("🌌 Anti-Void", sProt, HubConfig.AntiVoid, function(s) HubConfig.AntiVoid = s end, "AntiVoid")
cTog("🚫 Anti-AFK", sProt, HubConfig.AntiAfk, function(s) HubConfig.AntiAfk = s end, "AntiAfk")
cTog("💬 ChatLogs", sProt, HubConfig.ChatLogs, function(s) HubConfig.ChatLogs = s end, "ChatLogs")

-- ==========================================================
-- UI: ABA HISTÓRICO
-- ==========================================================
cTitle("📜 LOGS", sHist)
cTog("📥 JoinLogs & ExitLogs", sHist, HubConfig.JoinLogs, function(s) HubConfig.JoinLogs = s end, "JoinLogs")
cTog("💬 ChatLogs (Visualizador)", sHist, HubConfig.ChatLogs, function(s) HubConfig.ChatLogs = s end, "ChatLogs")
cTog("🔔 Notificações", sHist, HubConfig.Notifications, function(s) HubConfig.Notifications = s end, "Notifications")

-- ==========================================================
-- UI: ABA TEMAS
-- ==========================================================
cTitle("🎨 TEMAS", sTheme)
local function cTBtn(n, m, t, a, k)
    local b = Instance.new("TextButton", sTheme)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    b.Text = "🎨 " .. n
    b.TextColor3 = a
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() end)
end
cTBtn("Orion", Color3.fromRGB(36, 36, 37), Color3.fromRGB(30, 30, 30), Color3.fromRGB(52, 152, 219), "Orion")
cTBtn("Vampiro", Color3.fromRGB(20, 10, 10), Color3.fromRGB(15, 5, 5), Color3.fromRGB(220, 50, 50), "Vampiro")
cTBtn("Tóxico", Color3.fromRGB(15, 25, 15), Color3.fromRGB(10, 15, 10), Color3.fromRGB(50, 220, 100), "Tóxico")
cTBtn("Neon", Color3.fromRGB(15, 30, 35), Color3.fromRGB(10, 20, 25), Color3.fromRGB(0, 255, 255), "Neon")

-- ==========================================================
-- UI: ABA VIEWER
-- ==========================================================
cTitle("👥 SELECIONAR JOGADOR", sView)
local SelectedPlayer = nil
local TargetLbl = Instance.new("TextLabel", sView)
TargetLbl.Size = UDim2.new(1, 0, 0, 30)
TargetLbl.BackgroundTransparency = 1
TargetLbl.Text = "Alvo: Nenhum"
TargetLbl.TextColor3 = Color3.fromRGB(52, 152, 219)
TargetLbl.Font = Enum.Font.GothamBold
TargetLbl.TextSize = 14

local PLF = Instance.new("ScrollingFrame", sView)
PLF.Size = UDim2.new(1, 0, 0, 180)
PLF.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
PLF.BorderSizePixel = 0
PLF.ScrollBarThickness = 4
Instance.new("UICorner", PLF).CornerRadius = UDim.new(0, 6)
local UIL = Instance.new("UIListLayout", PLF)
UIL.Padding = UDim.new(0, 5)
UIL.HorizontalAlignment = Enum.HorizontalAlignment.Center

local pBtns = {}
local function updPL()
    for _, b in pairs(pBtns) do b:Destroy() end
    table.clear(pBtns)
    local ys = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = Instance.new("TextButton", PLF)
            b.Size = UDim2.new(1, -10, 0, 32)
            b.Position = UDim2.new(0, 5, 0, ys)
            b.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
            b.Text = "  " .. p.DisplayName .. " (@" .. p.Name .. ")"
            b.TextColor3 = Color3.fromRGB(230, 230, 230)
            b.Font = Enum.Font.GothamBold
            b.TextSize = 12
            b.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
            b.MouseButton1Click:Connect(function() SelectedPlayer = p TargetLbl.Text = "Alvo: " .. p.DisplayName end)
            table.insert(pBtns, b)
            ys = ys + 37
        end
    end
    PLF.CanvasSize = UDim2.new(0, 0, 0, ys + 10)
end
Players.PlayerAdded:Connect(updPL)
Players.PlayerRemoving:Connect(function(p) if SelectedPlayer == p then SelectedPlayer = nil TargetLbl.Text = "Alvo: Nenhum" end updPL() end)
updPL()

cTitle("⚙️ AÇÕES", sView)
cBtn("🚀 Teleport", sView, function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
    end
end)
cTog("📊 Painel Info do Alvo", sView, false, function(s) end, nil)

-- ==========================================================
-- UI: ABA STATS
-- ==========================================================
cTitle("📊 SERVER STATS & ANALYTICS", sStats)
local uptimeLbl = Instance.new("TextLabel", sStats)
uptimeLbl.Size = UDim2.new(1, 0, 0, 30)
uptimeLbl.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
uptimeLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
uptimeLbl.Font = Enum.Font.GothamBold
uptimeLbl.TextSize = 13
Instance.new("UICorner", uptimeLbl).CornerRadius = UDim.new(0, 6)

local fpsLbl = Instance.new("TextLabel", sStats)
fpsLbl.Size = UDim2.new(1, 0, 0, 30)
fpsLbl.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
fpsLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLbl.Font = Enum.Font.Gotham
fpsLbl.TextSize = 13
Instance.new("UICorner", fpsLbl).CornerRadius = UDim.new(0, 6)

task.spawn(function()
    local st = tick()
    while true do
        task.wait(1)
        local fps = math.floor(1 / RunService.RenderStepped:Wait() or 60)
        local ping = 0
        pcall(function() ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        local up = math.floor(tick() - st)
        local hrs = math.floor(up / 3600)
        local mns = math.floor((up % 3600) / 60)
        uptimeLbl.Text = "Server Uptime: " .. hrs .. "h " .. mns .. "m"
        fpsLbl.Text = "FPS: " .. fps .. " | Ping: " .. ping .. "ms | Players: " .. #Players:GetPlayers()
    end
end)

-- ==========================================================
-- UI: ABA OTIMIZAÇÃO
-- ==========================================================
cTitle("⚡ OTIMIZAÇÃO & PERFORMANCE", sOpt)
cTog("🥔 FPS Booster Real", sOpt, HubConfig.RealFPSBoost, function(s) HubConfig.RealFPSBoost = s end, "RealFPSBoost")
cTog("🧹 Memory Cleaner (RAM)", sOpt, HubConfig.MemoryCleaner, function(s) HubConfig.MemoryCleaner = s end, "MemoryCleaner")
cTog("📉 Low Graphics Mode", sOpt, HubConfig.LowGraphics, function(s) HubConfig.LowGraphics = s end, "LowGraphics")

-- ==========================================================
-- UI: ABA ANTI-STAFF
-- ==========================================================
cTitle("🔒 SEGURANÇA AVANÇADA (ANTI-STAFF)", sSec)
cTog("🚨 Detector de Staff", sSec, HubConfig.StaffDetector, function(s) HubConfig.StaffDetector = s end, "StaffDetector")
cTog("🚪 Auto-Leave de Emergência", sSec, HubConfig.AutoLeave, function(s) HubConfig.AutoLeave = s end, "AutoLeave")

-- ==========================================================
-- UI: ABA CONTROLE REMOTO
-- ==========================================================
cTitle("🎮 CONTROLE REMOTO & COMUNICAÇÃO", sRemote)
cTog("💬 Chat Command Controller", sRemote, HubConfig.ChatCommands, function(s) HubConfig.ChatCommands = s end, "ChatCommands")
cTitle("⏱️ SERVER AGE TRACKER", sRemote)
local ageLbl = Instance.new("TextLabel", sRemote)
ageLbl.Size = UDim2.new(1, 0, 0, 30)
ageLbl.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ageLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
ageLbl.Font = Enum.Font.GothamBold
ageLbl.TextSize = 13
Instance.new("UICorner", ageLbl).CornerRadius = UDim.new(0, 6)
task.spawn(function()
    while true do
        task.wait(5)
        ageLbl.Text = "Servidor aberto há: " .. math.floor(tick() % 1000) .. " minutos"
    end
end)

-- ==========================================================
-- LOOPS FINAIS (RenderStepped Global)
-- ==========================================================
RunService.RenderStepped:Connect(function()
    -- Freecam
    if HubConfig.Freecam then
        Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    else
        if Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
    end

    -- MaxZoom
    if HubConfig.MaxZoom then
        LocalPlayer.CameraMaxZoomDistance = 999999
        LocalPlayer.CameraMinZoomDistance = 0.5
    else
        LocalPlayer.CameraMaxZoomDistance = 128
        LocalPlayer.CameraMinZoomDistance = 0.5
    end

    -- Noclip Raycast
    if HubConfig.NoclipRaycast then
        local c = LocalPlayer.Character
        if c then
            local hrp = c:FindFirstChild("HumanoidRootPart")
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hrp and hum and hum.MoveDirection.Magnitude > 0.1 then
                local rp = RaycastParams.new()
                rp.FilterType = Enum.RaycastFilterType.Exclude
                rp.FilterDescendantsInstances = { c }
                local hit = Workspace:Raycast(hrp.Position, hum.MoveDirection * 3, rp)
                if hit and hit.Instance.CanCollide then
                    hit.Instance.CanCollide = false
                    task.delay(0.3, function() if hit.Instance then hit.Instance.CanCollide = true end end)
                end
            end
        end
    end

    -- Player Mods
    if HubConfig.PlayerMods then
        local c = LocalPlayer.Character
        if c and c:FindFirstChildOfClass("Humanoid") then
            c.Humanoid.UseJumpPower = true
            c.Humanoid.WalkSpeed = HubConfig.WalkSpeed
            c.Humanoid.JumpPower = HubConfig.JumpPower
        end
        if Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView = HubConfig.FOV end
    end
end)

-- ==========================================================
-- INICIALIZAÇÃO
-- ==========================================================
task.spawn(function()
    task.wait(0.5)
    if SelectedLanguage == "pt" then
        -- PT Notificação
    else
        -- EN Notificação
    end
end)
