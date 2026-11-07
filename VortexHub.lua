-- // VORTEX HUB - SUPREME \\ --
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local ProximityPromptService = game:GetService("ProximityPromptService")
local HttpService = game:GetService("HttpService")

local LP = Players.LocalPlayer
local TP = nil
pcall(function()
    if typeof(gethui) == "function" then
        TP = gethui()
    end
end)
TP = TP or CoreGui or (LP and LP:FindFirstChildOfClass("PlayerGui"))

if TP:FindFirstChild("VortexGraphicsHub") then
    TP.VortexGraphicsHub:Destroy()
end

local SFName = "VortexHub_Config.json"
local HC = {
    Shaders = false, FpsBoost = false, WallBlur = true, Fog = false,
    MotionBlur = false, Fullbright = false, PlayerLight = false, AutoTime = false,
    RandomRain = false, ESPPlayer = false, ESPNPC = false, DangerESP = false,
    TeleportTool = false, InstantInteract = false, PlayerMods = false, NoCooldown = false,
    InfJump = false, Noclip = false, WalkSpeed = 16, JumpPower = 50, FOV = 70,
    AntiFling = false, AntiVoid = false, AntiAfk = false, AutoRejoin = false,
    Notifications = true, SelectedTheme = "Orion", Whitelist = true, HealthThreshold = 60,
    AutoHeal = false, AutoClickPotion = false, AutoCollectPotion = false, AntiLag = false,
    LoopExplosion = false, AntiEffect = false, ESPPlayerMaxDistance = 1000,
    ESPNPCMaxDistance = 1000, MenuProtection = false, AutoRespawnFarm = false
}

local IC = {}
local function saveC()
    pcall(function()
        if writefile then
            writefile(SFName, HttpService:JSONEncode(HC))
        end
    end)
end

local function loadC()
    if readfile and isfile and isfile(SFName) then
        local s, d = pcall(function()
            return HttpService:JSONDecode(readfile(SFName))
        end)
        if s and type(d) == "table" then
            for k, v in pairs(d) do
                if HC[k] ~= nil then HC[k] = v end
            end
        end
    end
end
loadC()

local shOn, fpsOn, wbOn, fgOn, mbOn, fbOn, plOn, atOn, rrOn, epOn, enOn, dEspOn, ttOn, iiOn, pmOn, ncOn, ijOn, nclOn, pSpd, pJmp, pFov, afOn, avOn, aaOn, arOn, jelOn, wlOn, healthThresholdPct, autoHealOn, autoClickPotionOn, autoCollectPotionOn, antiLagOn, loopExplosionOn, antiEffectOn, espPlayerMaxDistance, espNPCMaxDistance, menuProtectionOn, autoRespawnFarmOn = 
    HC.Shaders, HC.FpsBoost, HC.WallBlur, HC.Fog, HC.MotionBlur, HC.Fullbright, HC.PlayerLight, HC.AutoTime, HC.RandomRain, HC.ESPPlayer, HC.ESPNPC, HC.DangerESP, HC.TeleportTool, HC.InstantInteract, HC.PlayerMods, HC.NoCooldown, HC.InfJump, HC.Noclip, HC.WalkSpeed, HC.JumpPower, HC.FOV, HC.AntiFling, HC.AntiVoid, HC.AntiAfk, HC.AutoRejoin, HC.Notifications, HC.Whitelist, HC.HealthThreshold, HC.AutoHeal, HC.AutoClickPotion, HC.AutoCollectPotion, HC.AntiLag, HC.LoopExplosion, HC.AntiEffect, HC.ESPPlayerMaxDistance, HC.ESPNPCMaxDistance, HC.MenuProtection, HC.AutoRespawnFarm

jelOn = HC.Notifications

local ijc, nlc, avc, pmc, aac, arc, atc, sLp, iic, fbLp, plc, mbc, afc,ncc, aec = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
local lSCf = nil
local lCR = CFrame.new()
local ECol = {PName = "#00FFFF", PHP = "#32FF32", PDist = "#FFAA00", NName = "#FF4444", NHP = "#32FF32", NDist = "#FFAA00"}
local tNPC, tPly, tDNPC = {}, {}, {}

local OL = {
    GS = Lighting.GlobalShadows, B = Lighting.Brightness, EDS = Lighting.EnvironmentDiffuseScale,
    ESS = Lighting.EnvironmentSpecularScale, FS = Lighting.FogStart, FE = Lighting.FogEnd,
    FC = Lighting.FogColor, CT = Lighting.ClockTime, A = Lighting.Ambient,
    OA = Lighting.OutdoorAmbient, T = Lighting.Technology, SS = Lighting.ShadowSoftness
}

local function clrCE()
    for _, v in pairs(Lighting:GetChildren()) do
        if v.Name:match("Vortex") and v.Name ~= "VortexMotionBlur" and v.Name ~= "VortexWallBlur" and v.Name ~= "VortexDeathFade" then
            v:Destroy()
        end
    end
end

local dF = Lighting:FindFirstChild("VortexDeathFade")
if not dF then
    dF = Instance.new("ColorCorrectionEffect", Lighting)
    dF.Name = "VortexDeathFade"
    dF.Brightness = 0
    dF.Contrast = 0
end
local pDead = false

local SG = Instance.new("ScreenGui", TP)
SG.Name = "VortexGraphicsHub"
SG.ResetOnSpawn = false
local ANotif = {}

local CTh = {
    MBG = Color3.fromRGB(36, 36, 37),
    TB = Color3.fromRGB(30, 30, 30),
    A = Color3.fromRGB(52, 152, 219)
}
local TE = {Bgs = {}, TBs = {}, Accs = {}, Tgls = {}, Txs = {}}

local function appT(bgCol, tbCol, accentCol, themeName)
    CTh.MBG = bgCol
    CTh.TB = tbCol
    CTh.A = accentCol
    if themeName then
        HC.SelectedTheme = themeName
        saveC()
    end
    for _, b in pairs(TE.Bgs) do pcall(function() b.BackgroundColor3 = bgCol end) end
    for _, t in pairs(TE.TBs) do pcall(function() t.BackgroundColor3 = tbCol end) end
    for _, a in pairs(TE.Accs) do pcall(function() a.BackgroundColor3 = accentCol end) end
end

local function sNotif(tl, tx, nt)
    if not jelOn and (nt == "Info" or tl == "🟢" or tl == "🔴") then return end
    if tl == "Alvo" then
        for i = #ANotif, 1, -1 do
            local v = ANotif[i]
            if v:FindFirstChild("NTitle") and v.NTitle.Text == "Alvo" then
                pcall(function() v:Destroy() end)
                table.remove(ANotif, i)
            end
        end
        for i, v in ipairs(ANotif) do
            TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 1, -85 - ((i - 1) * 75))}):Play()
        end
    end
    local cls = {Error = Color3.fromRGB(255, 75, 75), Info = CTh.A, Success = Color3.fromRGB(75, 255, 75)}
    local cc = cls[nt] or cls.Info
    local icn = nt == "Error" and "⚠️" or (nt == "Success" and "✅" or "ℹ️")
    
    local NF = Instance.new("Frame", SG)
    NF.Size = UDim2.new(0, 300, 0, 65)
    NF.Position = UDim2.new(1, 20, 1, -85 - (#ANotif * 75))
    NF.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    NF.BorderSizePixel = 0
    Instance.new("UICorner", NF).CornerRadius = UDim.new(0, 6)
    
    local sk = Instance.new("UIStroke", NF)
    sk.Color = Color3.fromRGB(50, 50, 55)
    sk.Thickness = 1
    
    local Sd = Instance.new("Frame", NF)
    Sd.Size = UDim2.new(0, 4, 1, 0)
    Sd.BackgroundColor3 = cc
    Sd.BorderSizePixel = 0
    Instance.new("UICorner", Sd).CornerRadius = UDim.new(0, 6)
    
    local Ic = Instance.new("TextLabel", NF)
    Ic.Size = UDim2.new(0, 40, 0, 40)
    Ic.Position = UDim2.new(0, 10, 0.5, -20)
    Ic.BackgroundTransparency = 1
    Ic.Text = icn
    Ic.TextSize = 24
    
    local Txt = Instance.new("TextLabel", NF)
    Txt.Name = "NTitle"
    Txt.Size = UDim2.new(1, -65, 0, 20)
    Txt.Position = UDim2.new(0, 55, 0, 10)
    Txt.BackgroundTransparency = 1
    Txt.Text = tl
    Txt.TextColor3 = cc
    Txt.Font = Enum.Font.GothamBold
    Txt.TextSize = 14
    Txt.TextXAlignment = Enum.TextXAlignment.Left
    
    local Dsc = Instance.new("TextLabel", NF)
    Dsc.Size = UDim2.new(1, -65, 0, 25)
    Dsc.Position = UDim2.new(0, 55, 0, 30)
    Dsc.BackgroundTransparency = 1
    Dsc.Text = tx
    Dsc.TextColor3 = Color3.fromRGB(240, 240, 240)
    Dsc.Font = Enum.Font.Gotham
    Dsc.TextSize = 12
    Dsc.TextWrapped = true
    Dsc.TextXAlignment = Enum.TextXAlignment.Left
    Dsc.RichText = true
    
    local PBg = Instance.new("Frame", NF)
    PBg.Size = UDim2.new(1, 0, 0, 3)
    PBg.Position = UDim2.new(0, 0, 1, -3)
    PBg.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    PBg.BorderSizePixel = 0
    Instance.new("UICorner", PBg).CornerRadius = UDim.new(0, 6)
    
    local PBar = Instance.new("Frame", PBg)
    PBar.Size = UDim2.new(1, 0, 1, 0)
    PBar.BackgroundColor3 = cc
    PBar.BorderSizePixel = 0
    Instance.new("UICorner", PBar).CornerRadius = UDim.new(0, 6)
    
    table.insert(ANotif, NF)
    TweenService:Create(NF, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 1, -85 - (#ANotif - 1) * 75)}):Play()
    TweenService:Create(PBar, TweenInfo.new(4, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()
    
    task.delay(4, function()
        if NF.Parent then
            local oT = TweenService:Create(NF, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 1, NF.Position.Y.Offset)})
            oT:Play()
            oT.Completed:Connect(function()
                pcall(function() NF:Destroy() end)
                for i, v in ipairs(ANotif) do
                    if v == NF then table.remove(ANotif, i) break end
                end
                for i, v in ipairs(ANotif) do
                    TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 1, -85 - ((i - 1) * 75))}):Play()
                end
            end)
        end
    end)
end

-- Whitelist de Amigos
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
        local wb = Lighting:FindFirstChild("VortexWallBlur")
        if not wb then
            wb = Instance.new("BlurEffect", Lighting)
            wb.Name = "VortexWallBlur"
        end
        local ti = TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        TweenService:Create(wb, ti, {Size = 45}):Play()
        TweenService:Create(dF, ti, {Brightness = -1, Contrast = -0.5}):Play()
    end)
end

local tT = nil
local function rTT()
    if tT then pcall(function() tT:Destroy() end) tT = nil end
    if LP:FindFirstChild("Backpack") then
        local b = LP.Backpack:FindFirstChild("TeleportTool")
        if b then pcall(function() b:Destroy() end) end
    end
    if LP.Character then
        local c = LP.Character:FindFirstChild("TeleportTool")
        if c then pcall(function() c:Destroy() end) end
    end
end

local function gTT()
    rTT()
    if not ttOn then return end
    local T = Instance.new("Tool")
    T.Name, T.RequiresHandle, T.CanBeDropped = "TeleportTool", false, false
    T.Activated:Connect(function()
        local m = LP:GetMouse()
        if m and m.Hit and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(m.Hit.Position + Vector3.new(0, 3, 0))
            sNotif("✨", "Teleporte realizado!", "Success")
        end
    end)
    local bp = LP:WaitForChild("Backpack", 3)
    if bp then T.Parent = bp tT = T end
end

-- Verificação de Poção
local function isHealthPotionStrict(name, parentName)
    local n = string.lower(name or "")
    local p = string.lower(parentName or "")
    local hasHealth = string.find(n, "health") or string.find(n, "heal") or string.find(n, "vida") or string.find(n, "hp") or string.find(n, "poção") or string.find(n, "pocao") or string.find(n, "cura") or string.find(n, "potion") or string.find(n, "remedy") or
                      string.find(p, "health") or string.find(p, "heal") or string.find(p, "vida") or string.find(p, "hp") or string.find(p, "poção") or string.find(p, "pocao") or string.find(p, "cura") or string.find(p, "potion") or string.find(p, "remedy")
    local isExcluded = string.find(n, "fire") or string.find(n, "speed") or string.find(n, "jump") or string.find(n, "sword") or string.find(n, "rainbow") or string.find(n, "carpet") or string.find(n, "launcher") or string.find(n, "spellbook") or string.find(n, "bat") or string.find(n, "rocket") or string.find(n, "thunder") or string.find(n, "moto") or
                       string.find(p, "fire") or string.find(p, "speed") or string.find(p, "jump") or string.find(p, "sword") or string.find(p, "rainbow") or string.find(p, "carpet") or string.find(p, "launcher") or string.find(p, "spellbook") or string.find(p, "bat") or string.find(p, "moto")
    return hasHealth and not isExcluded
end

local autoHealConn = nil
local lastPotionUse = 0
local lastCombatToolName = nil
local activeToolConn = nil

local function setupToolTracking()
    if activeToolConn then activeToolConn:Disconnect() end
    activeToolConn = RunService.Heartbeat:Connect(function()
        local c = LP.Character
        if not c then return end
        for _, item in ipairs(c:GetChildren()) do
            if item:IsA("Tool") and not isHealthPotionStrict(item.Name, item.Parent and item.Parent.Name or "") then
                lastCombatToolName = item.Name
            end
        end
    end)
end
setupToolTracking()

LP.CharacterAdded:Connect(function(c)
    pDead = false
    if dF then TweenService:Create(dF, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Brightness = 0, Contrast = 0}):Play() end
    local wb = Lighting:FindFirstChild("VortexWallBlur")
    if wb then TweenService:Create(wb, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {Size = 0}):Play() end
    stDE(c)
    setupToolTracking()
    if ttOn then
        task.spawn(function()
            task.wait(0.5)
            gTT()
        end)
    end
end)
if LP.Character then stDE(LP.Character) end

-- Botão Flutuante e Janela Principal
local OBtn = Instance.new("TextButton", SG)
OBtn.Size = UDim2.new(0, 50, 0, 50)
OBtn.Position = UDim2.new(0, 20, 0, 20)
OBtn.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
OBtn.Text = "⚡\nOPEN"
OBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OBtn.Font = Enum.Font.GothamBold
OBtn.TextSize = 12
OBtn.Visible = false
Instance.new("UICorner", OBtn).CornerRadius = UDim.new(0, 10)
table.insert(TE.Bgs, OBtn)

local MF = Instance.new("Frame", SG)
MF.Size = UDim2.new(0, 480, 0, 530)
MF.Position = UDim2.new(0.5, -240, 0.5, -265)
MF.BackgroundColor3 = CTh.MBG
MF.Active = true
MF.Draggable = true
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 8)
table.insert(TE.Bgs, MF)

local TB = Instance.new("Frame", MF)
TB.Size = UDim2.new(1, 0, 0, 40)
TB.BackgroundColor3 = CTh.TB
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 8)
table.insert(TE.TBs, TB)

local PIco = Instance.new("ImageLabel", TB)
PIco.Size = UDim2.new(0, 26, 0, 26)
PIco.Position = UDim2.new(0, 10, 0.5, -13)
PIco.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PIco.BorderSizePixel = 0
PIco.ClipsDescendants = true
Instance.new("UICorner", PIco).CornerRadius = UDim.new(1, 0)
task.spawn(function()
    pcall(function()
        PIco.Image = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)
end)

local Ttl = Instance.new("TextLabel", TB)
Ttl.Size = UDim2.new(1, -80, 1, 0)
Ttl.Position = UDim2.new(0, 45, 0, 0)
Ttl.Text = "⚡ Vortex Hub V18 - Supreme"
Ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
Ttl.Font = Enum.Font.GothamBold
Ttl.TextSize = 14
Ttl.BackgroundTransparency = 1
Ttl.TextXAlignment = Enum.TextXAlignment.Left

local CBn = Instance.new("TextButton", TB)
CBn.Size = UDim2.new(0, 40, 0, 40)
CBn.Position = UDim2.new(1, -40, 0, 0)
CBn.BackgroundTransparency = 1
CBn.Text = "X"
CBn.TextColor3 = Color3.fromRGB(200, 200, 200)
CBn.Font = Enum.Font.GothamBold
CBn.TextSize = 16

CBn.MouseButton1Click:Connect(function()
    MF.Visible = false
    OBtn.Visible = true
end)
OBtn.MouseButton1Click:Connect(function()
    MF.Visible = true
    OBtn.Visible = false
end)

sNotif("Sucesso", "Vortex Hub carregado com sucesso!", "Success")
