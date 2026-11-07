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
    LoopExplosion = false, AntiEffect = false, ESPMaxDistance = 1000
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

local shOn, fpsOn, wbOn, fgOn, mbOn, fbOn, plOn, atOn, rrOn, epOn, enOn, dEspOn, ttOn, iiOn, pmOn, ncOn, ijOn, nclOn, pSpd, pJmp, pFov, afOn, avOn, aaOn, arOn, jelOn, wlOn, healthThresholdPct, autoHealOn, autoClickPotionOn, autoCollectPotionOn, antiLagOn, loopExplosionOn, antiEffectOn, espMaxDistance = 
    HC.Shaders, HC.FpsBoost, HC.WallBlur, HC.Fog, HC.MotionBlur, HC.Fullbright, HC.PlayerLight, HC.AutoTime, HC.RandomRain, HC.ESPPlayer, HC.ESPNPC, HC.DangerESP, HC.TeleportTool, HC.InstantInteract, HC.PlayerMods, HC.NoCooldown, HC.InfJump, HC.Noclip, HC.WalkSpeed, HC.JumpPower, HC.FOV, HC.AntiFling, HC.AntiVoid, HC.AntiAfk, HC.AutoRejoin, HC.Notifications, HC.Whitelist, HC.HealthThreshold, HC.AutoHeal, HC.AutoClickPotion, HC.AutoCollectPotion, HC.AntiLag, HC.LoopExplosion, HC.AntiEffect, HC.ESPMaxDistance

jelOn = HC.Notifications

local ijc, nlc, avc, pmc, aac, arc, atc, sLp, iic, fbLp, plc, mbc, afc, ncc, aec = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
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

-- [CORREÇÃO TELEPORTTOOL NO RESPAWN] --
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

-- [SISTEMA DE VERIFICAÇÃO RIGOROSA DE POÇÃO] --
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

local function autoUseHealthPotion()
    if tick() - lastPotionUse < 0.4 then return end
    local c = LP.Character
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    local bp = LP.Character and LP.Character:FindFirstChild("Backpack") or LP:FindFirstChild("Backpack")
    if not c or not hum or not bp or hum.Health <= 0 then return end
    
    lastPotionUse = tick()
    local currentTool = nil
    for _, item in ipairs(c:GetChildren()) do
        if item:IsA("Tool") and not isHealthPotionStrict(item.Name, item.Parent and item.Parent.Name or "") then
            currentTool = item
            lastCombatToolName = item.Name
            break
        end
    end
    
    local potion = nil
    for _, item in ipairs(c:GetChildren()) do
        if item:IsA("Tool") and isHealthPotionStrict(item.Name, item.Parent and item.Parent.Name or "") then
            potion = item
            break
        end
    end
    if not potion then
        for _, item in ipairs(bp:GetChildren()) do
            if item:IsA("Tool") and isHealthPotionStrict(item.Name, item.Parent and item.Parent.Name or "") then
                potion = item
                break
            end
        end
    end
    
    if potion then
        potion.Parent = c
        pcall(function() potion:Activate() end)
        task.wait(0.05)
        pcall(function() potion:Activate() end)
        
        task.delay(0.12, function()
            if not c or not c:FindFirstChildOfClass("Humanoid") or hum.Health <= 0 then return end
            local targetTool = nil
            if currentTool and currentTool.Parent then
                targetTool = currentTool
            elseif lastCombatToolName then
                if bp then targetTool = bp:FindFirstChild(lastCombatToolName) end
                if not targetTool and c then targetTool = c:FindFirstChild(lastCombatToolName) end
            end
            if targetTool and targetTool.Parent then
                targetTool.Parent = c
            end
        end)
    end
end

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

local function gPB(cam, c)
    if not wbOn then return 0 end
    local mB, mD, cD = 12, 45, 45
    local rP = RaycastParams.new()
    rP.FilterType = Enum.RaycastFilterType.Exclude
    rP.FilterDescendantsInstances = {c, cam}
    local ang = {CFrame.Angles(0, 0, 0), CFrame.Angles(0, math.rad(25), 0), CFrame.Angles(0, math.rad(-25), 0), CFrame.Angles(math.rad(15), 0, 0), CFrame.Angles(math.rad(-15), 0, 0)}
    for _, a in ipairs(ang) do
        local dir = (cam.CFrame * a).LookVector
        local h = Workspace:Raycast(cam.CFrame.Position, dir * mD, rP)
        if h and h.Instance and h.Instance.Transparency < 0.8 and h.Instance.CanCollide and h.Distance < cD then
            cD = h.Distance
        end
    end
    local vS = cam.ViewportSize
    local function ckD(hrp, obj)
        local d = (hrp.Position - cam.CFrame.Position).Magnitude
        if d < mD then
            local sP, oS = cam:WorldToViewportPoint(hrp.Position)
            if oS and sP.X >= 0 and sP.X <= vS.X and sP.Y >= 0 and sP.Y <= vS.Y then
                local ry = Workspace:Raycast(cam.CFrame.Position, (hrp.Position - cam.CFrame.Position), rP)
                if not ry or ry.Instance:IsDescendantOf(obj) then
                    if d < cD then cD = d end
                end
            end
        end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            ckD(p.Character.HumanoidRootPart, p.Character)
        end
    end
    for _, o in ipairs(Workspace:GetChildren()) do
        if o:IsA("Model") and o ~= c and o:FindFirstChildOfClass("Humanoid") then
            local tH = o:FindFirstChild("HumanoidRootPart") or o.PrimaryPart
            if tH then ckD(tH, o) end
        end
    end
    if cD < mD then return (1 - (cD / mD)) * mB end
    return 0
end

local function cInd(hrp, rP)
    if not hrp then return false end
    local hs = 0
    local off = {Vector3.new(0, 0, 0), Vector3.new(8, 0, 0), Vector3.new(-8, 0, 0), Vector3.new(0, 0, 8), Vector3.new(0, 0, -8)}
    for _, o in ipairs(off) do
        local h = Workspace:Raycast(hrp.Position + o, Vector3.new(0, 120, 0), rP)
        if h and h.Instance and h.Instance.CanCollide and h.Instance.Transparency < 0.5 then
            hs = hs + 1
        end
    end
    return hs >= 3
end

local CNPCs = {}
local function cNPC(o)
    if o:IsA("Model") and o:FindFirstChild("Humanoid") and o:FindFirstChild("HumanoidRootPart") and not Players:GetPlayerFromCharacter(o) then
        CNPCs[o] = true
    end
end
for _, o in ipairs(Workspace:GetDescendants()) do cNPC(o) end
Workspace.DescendantAdded:Connect(function(o)
    task.delay(0.2, function()
        if o and o.Parent then
            if o:IsA("Model") then cNPC(o) end
            if o.Parent:IsA("Model") then cNPC(o.Parent) end
        end
    end)
end)
Workspace.DescendantRemoving:Connect(function(o)
    if CNPCs[o] then CNPCs[o] = nil end
end)

local CTh = {
    MBG = Color3.fromRGB(36, 36, 37),
    TB = Color3.fromRGB(30, 30, 30),
    A = Color3.fromRGB(52, 152, 219)
}
local TE = {Bgs = {}, TBs = {}, Accs = {}, Tgls = {}, Txs = {}}

local function appT(m, t, a, tn)
    CTh.MBG, CTh.TB, CTh.A = m, t, a
    if tn then HC.SelectedTheme = tn saveC() end
    for _, f in pairs(TE.Bgs) do f.BackgroundColor3 = m end
    for _, f in pairs(TE.TBs) do f.BackgroundColor3 = t end
    for _, o in pairs(TE.Accs) do
        if o:IsA("UIStroke") then o.Color = a else o.BackgroundColor3 = a end
    end
    for _, tx in pairs(TE.Txs) do tx.TextColor3 = a end
    for bg, sF in pairs(TE.Tgls) do
        if sF() then TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3 = a}):Play() end
    end
end

local SG = Instance.new("ScreenGui", TP)
SG.Name = "VortexGraphicsHub"
SG.ResetOnSpawn = false
local ANotif = {}

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

local OBtn = Instance.new("TextButton", SG)
OBtn.Size, OBtn.Position, OBtn.BackgroundColor3, OBtn.Text, OBtn.TextColor3, OBtn.Font, OBtn.TextSize, OBtn.Visible = UDim2.new(0, 50, 0, 50), UDim2.new(0, 20, 0, 20), Color3.fromRGB(36, 36, 37), "⚡\nOPEN", Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 12, false
Instance.new("UICorner", OBtn).CornerRadius = UDim.new(0, 10)
table.insert(TE.Bgs, OBtn)

local MF = Instance.new("Frame", SG)
MF.Size, MF.Position, MF.BackgroundColor3, MF.Active, MF.Draggable = UDim2.new(0, 480, 0, 530), UDim2.new(0.5, -240, 0.5, -265), CTh.MBG, true, true
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 8)
table.insert(TE.Bgs, MF)

local TB = Instance.new("Frame", MF)
TB.Size, TB.BackgroundColor3 = UDim2.new(1, 0, 0, 40), CTh.TB
Instance.new("UICorner", TB).CornerRadius = UDim.new(0, 8)
table.insert(TE.TBs, TB)

local PIco = Instance.new("ImageLabel", TB)
PIco.Size, PIco.Position, PIco.BackgroundColor3, PIco.BorderSizePixel, PIco.ClipsDescendants = UDim2.new(0, 26, 0, 26), UDim2.new(0, 10, 0.5, -13), Color3.fromRGB(50, 50, 50), 0, true
Instance.new("UICorner", PIco).CornerRadius = UDim.new(1, 0)
task.spawn(function()
    pcall(function()
        PIco.Image = Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)
end)

local Ttl = Instance.new("TextLabel", TB)
Ttl.Size, Ttl.Position, Ttl.Text, Ttl.TextColor3, Ttl.Font, Ttl.TextSize, Ttl.BackgroundTransparency, Ttl.TextXAlignment = UDim2.new(1, -80, 1, 0), UDim2.new(0, 45, 0, 0), "⚡ Vortex Hub V18 - Supreme", Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 14, 1, Enum.TextXAlignment.Left

local CBn = Instance.new("TextButton", TB)
CBn.Size, CBn.Position, CBn.BackgroundTransparency, CBn.Text, CBn.TextColor3, CBn.Font, CBn.TextSize = UDim2.new(0, 40, 0, 40), UDim2.new(1, -40, 0, 0), 1, "X", Color3.fromRGB(200, 200, 200), Enum.Font.GothamBold, 16
CBn.MouseButton1Click:Connect(function() MF.Visible = false OBtn.Visible = true end)
OBtn.MouseButton1Click:Connect(function() MF.Visible = true OBtn.Visible = false end)

local TC = Instance.new("Frame", MF)
TC.Size, TC.Position, TC.BackgroundTransparency = UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 40), 1

-- [ABAS] (Expandidas para acomodar a nova aba) --
local function cTB(n, px, w)
    local B = Instance.new("TextButton", TC)
    B.Size, B.Position, B.BackgroundColor3, B.Text, B.TextColor3, B.Font, B.TextSize = UDim2.new(w or 0.111, 0, 1, 0), UDim2.new(px, 0, 0, 0), Color3.fromRGB(30, 30, 30), n, Color3.fromRGB(150, 150, 150), Enum.Font.GothamBold, 9
    return B
end
local tMB, tEB, tPB, tPrB, tHB, tThB, tVB, tDCB, tSMisc = cTB("🔧 Princ.", 0, 0.111), cTB("👁️ ESPS", 0.111, 0.111), cTB("👤 Player", 0.222, 0.111), cTB("🛡️ Prot.", 0.333, 0.111), cTB("📜 Hist.", 0.444, 0.111), cTB("🎨 Temas", 0.555, 0.111), cTB("👀 Viewer", 0.666, 0.111), cTB("⚔️ Comb.", 0.777, 0.111), cTB("🧟 Troll", 0.888, 0.112)
tMB.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
tMB.TextColor3 = Color3.fromRGB(255, 255, 255)

local function cScr(n)
    local S = Instance.new("ScrollingFrame", MF)
    S.Size, S.Position, S.BackgroundTransparency, S.ScrollBarThickness, S.Visible = UDim2.new(1, -20, 1, -80), UDim2.new(0, 10, 0, 75), 1, 4, false
    S.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local L = Instance.new("UIListLayout", S)
    L.Padding, L.HorizontalAlignment, L.SortOrder = UDim.new(0, 10), Enum.HorizontalAlignment.Center, Enum.SortOrder.LayoutOrder
    return S
end
local sM, sE, sP, sPr, sH, sTh, sV, sDC, sSMiscTab = cScr("SM"), cScr("SE"), cScr("SP"), cScr("SPr"), cScr("SH"), cScr("STh"), cScr("SV"), cScr("SDC"), cScr("SMisc")
sM.Visible = true

local function sTab(aB, aS)
    local t = {{tMB, sM}, {tEB, sE}, {tPB, sP}, {tPrB, sPr}, {tHB, sH}, {tThB, sTh}, {tVB, sV}, {tDCB, sDC}, {tSMisc, sSMiscTab}}
    for _, d in pairs(t) do
        local b, s = d[1], d[2]
        if b == aB then
            b.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            s.Visible = true
        else
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.TextColor3 = Color3.fromRGB(150, 150, 150)
            s.Visible = false
        end
    end
end
tMB.MouseButton1Click:Connect(function() sTab(tMB, sM) end)
tEB.MouseButton1Click:Connect(function() sTab(tEB, sE) end)
tPB.MouseButton1Click:Connect(function() sTab(tPB, sP) end)
tPrB.MouseButton1Click:Connect(function() sTab(tPrB, sPr) end)
tHB.MouseButton1Click:Connect(function() sTab(tHB, sH) end)
tThB.MouseButton1Click:Connect(function() sTab(tThB, sTh) end)
tVB.MouseButton1Click:Connect(function() sTab(tVB, sV) end)
tDCB.MouseButton1Click:Connect(function() sTab(tDCB, sDC) end)
tSMisc.MouseButton1Click:Connect(function() sTab(tSMisc, sSMiscTab) end)

local function cST(n, p)
    local T = Instance.new("TextLabel", p)
    T.Size, T.BackgroundTransparency, T.Text, T.TextColor3, T.Font, T.TextSize, T.TextXAlignment = UDim2.new(1, 0, 0, 25), 1, n, CTh.A, Enum.Font.GothamBlack, 13, Enum.TextXAlignment.Left
    table.insert(TE.Txs, T)
end

local function cTog(n, p, iS, cb, ck)
    local F = Instance.new("Frame", p)
    F.Size, F.BackgroundColor3 = UDim2.new(1, 0, 0, 42), Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)
    local L = Instance.new("TextLabel", F)
    L.Size, L.Position, L.Text, L.TextColor3, L.Font, L.TextSize, L.BackgroundTransparency, L.TextXAlignment = UDim2.new(0.7, 0, 1, 0), UDim2.new(0.05, 0, 0, 0), n, Color3.fromRGB(255, 255, 255), Enum.Font.Gotham, 13, 1, Enum.TextXAlignment.Left
    L.RichText = true
    local SB = Instance.new("Frame", F)
    SB.Size, SB.Position, SB.BackgroundColor3 = UDim2.new(0, 40, 0, 20), UDim2.new(1, -55, 0.5, -10), iS and CTh.A or Color3.fromRGB(70, 70, 70)
    Instance.new("UICorner", SB).CornerRadius = UDim.new(1, 0)
    local SK = Instance.new("Frame", SB)
    SK.Size, SK.Position, SK.BackgroundColor3 = UDim2.new(0, 16, 0, 16), iS and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8), Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", SK).CornerRadius = UDim.new(1, 0)
    local st = iS
    TE.Tgls[SB] = function() return st end
    local function sVS(ns)
        st = ns
        TweenService:Create(SB, TweenInfo.new(0.2), {BackgroundColor3 = st and CTh.A or Color3.fromRGB(70, 70, 70)}):Play()
        TweenService:Create(SK, TweenInfo.new(0.2), {Position = st and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        if ck then HC[ck] = st saveC() end
    end
    local B = Instance.new("TextButton", F)
    B.Size, B.BackgroundTransparency, B.Text = UDim2.new(1, 0, 1, 0), 1, ""
    B.MouseButton1Click:Connect(function() sVS(not st) cb(st) end)
    if ck then IC[ck] = function() if st then cb(true) end end end
    return sVS
end

local function cSli(n, rT, mV, mxV, cV, p, cb, ck)
    local SF = Instance.new("Frame", p)
    SF.Size, SF.BackgroundColor3 = UDim2.new(1, 0, 0, 65), Color3.fromRGB(42, 42, 45)
    Instance.new("UICorner", SF).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", SF).Color = Color3.fromRGB(60, 60, 65)
    local TL = Instance.new("TextLabel", SF)
    TL.Size, TL.Position, TL.Text, TL.TextColor3, TL.Font, TL.TextSize, TL.BackgroundTransparency, TL.TextXAlignment = UDim2.new(1, -20, 0, 20), UDim2.new(0, 12, 0, 6), n.." [ "..tostring(cV).." ]", Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 13, 1, Enum.TextXAlignment.Left
    local RL = Instance.new("TextLabel", SF)
    RL.Size, RL.Position, RL.Text, RL.TextColor3, RL.Font, RL.TextSize, RL.BackgroundTransparency, RL.TextXAlignment = UDim2.new(1, -20, 0, 14), UDim2.new(0, 12, 0, 24), "Recomendado: "..rT, Color3.fromRGB(160, 160, 165), Enum.Font.Gotham, 11, 1, Enum.TextXAlignment.Left
    local Tk = Instance.new("Frame", SF)
    Tk.Size, Tk.Position, Tk.BackgroundColor3 = UDim2.new(1, -24, 0, 8), UDim2.new(0, 12, 0, 46), Color3.fromRGB(25, 25, 28)
    Instance.new("UICorner", Tk).CornerRadius = UDim.new(1, 0)
    local pI = math.clamp((cV - mV) / (mxV - mV), 0, 1)
    local F = Instance.new("Frame", Tk)
    F.Size, F.BackgroundColor3 = UDim2.new(pI, 0, 1, 0), CTh.A
    Instance.new("UICorner", F).CornerRadius = UDim.new(1, 0)
    table.insert(TE.Accs, F)
    local K = Instance.new("Frame", Tk)
    K.Size, K.AnchorPoint, K.Position, K.BackgroundColor3 = UDim2.new(0, 18, 0, 18), Vector2.new(0.5, 0.5), UDim2.new(pI, 0, 0.5, 0), Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", K).CornerRadius = UDim.new(1, 0)
    local KS = Instance.new("UIStroke", K)
    KS.Color, KS.Thickness = CTh.A, 2
    table.insert(TE.Accs, KS)
    local HB = Instance.new("TextButton", SF)
    HB.Size, HB.BackgroundTransparency, HB.Text = UDim2.new(1, 0, 1, 0), 1, ""
    local d = false
    local function upd(ip)
        local pX = math.clamp(ip.Position.X - Tk.AbsolutePosition.X, 0, Tk.AbsoluteSize.X)
        local pc = pX / Tk.AbsoluteSize.X
        local vl = math.floor(mV + (mxV - mV) * pc)
        TweenService:Create(F, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(pc, 0, 1, 0)}):Play()
        TweenService:Create(K, TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(pc, 0, 0.5, 0)}):Play()
        TL.Text = n.." [ "..tostring(vl).." ]"
        if ck then HC[ck] = vl saveC() end
        cb(vl)
    end
    HB.InputBegan:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
            d = true upd(ip)
        end
    end)
    UserInputService.InputEnded:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
            d = false
        end
    end)
    UserInputService.InputChanged:Connect(function(ip)
        if d and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
            upd(ip)
        end
    end)
    if ck then IC[ck] = function() cb(cV) end end
end

-- =========================================================================
-- [NOVA ABA SERVER MISC & TROLL - SISTEMA PROFISSIONAL "TSUNAMI ZOMBIE"]
-- =========================================================================
cST("🧟 TROLL & SERVER MISC SYSTEM", sSMiscTab)

local zombieTsunamiDesc = Instance.new("TextLabel", sSMiscTab)
zombieTsunamiDesc.Size, zombieTsunamiDesc.BackgroundTransparency, zombieTsunamiDesc.Text, zombieTsunamiDesc.TextColor3, zombieTsunamiDesc.Font, zombieTsunamiDesc.TextSize, zombieTsunamiDesc.TextWrapped, zombieTsunamiDesc.TextXAlignment = UDim2.new(1,0,0,38), 1, "Sistema profissional de detecção, coleta rápida (200x), auto-equipe e ativação em massa do ZombieLauncher!", Color3.fromRGB(200,200,210), Enum.Font.Gotham, 11, true, Enum.TextXAlignment.Left
table.insert(TE.Txs, zombieTsunamiDesc)

-- Funções profissionais de detecção e interação com o ZombieLauncher (Imagens 9 & 10)
local function isZombieLauncherStrict(name, parentName)
    local n = string.lower(name or "")
    local p = string.lower(parentName or "")
    local hasLauncher = string.find(n, "zombielauncher") or string.find(n, "zombie launcher") or string.find(n, "launcher") or string.find(n, "zombie")
    local isExcluded = string.find(n, "health") or string.find(n, "heal") or string.find(n, "vida") or string.find(n, "potion")
    return hasLauncher and not isExcluded
end

local function getZombiePlatePart()
    -- Procura pela placa/localizador mostrado nas imagens 9 e 10
    local plateNames = {"wallgenen3", "walldelantera", "zombieplate", "spawner", "zombielauncherplate"}
    for _, name in ipairs(plateNames) do
        local obj = Workspace:FindFirstChild(name, true)
        if obj then
            if obj:IsA("Model") then
                return obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
            elseif obj:IsA("BasePart") then
                return obj
            end
        end
    end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        local nm = string.lower(obj.Name)
        if string.find(nm, "zombie") or string.find(nm, "launcher") or string.find(nm, "plate") then
            if obj:IsA("Model") then
                local p = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                if p then return p end
            elseif obj:IsA("BasePart") then
                return obj
            end
        end
    end
    return nil
end

local function countZombieLaunchersInInventory()
    local count = 0
    local bp = LP:FindFirstChild("Backpack")
    local char = LP.Character
    local function countCont(cont)
        if not cont then return end
        for _, item in ipairs(cont:GetChildren()) do
            if item:IsA("Tool") and isZombieLauncherStrict(item.Name, item.Parent and item.Parent.Name or "") then
                count = count + 1
            end
        end
    end
    countCont(bp)
    countCont(char)
    return count
end

local tsunamiRunning = false

local function executeTsunamiZombie()
    if tsunamiRunning then
        sNotif("Tsunami Zombie", "O sistema já está em execução!", "Info")
        return
    end
    tsunamiRunning = true
    sNotif("TSUNAMI ZOMBIE", "Iniciando sistema profissional de coleta (200x)...", "Success")

    task.spawn(function()
        pcall(function()
            local char = LP.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if not hrp or not hum then tsunamiRunning = false return end

            local originalCF = hrp.CFrame

            -- 1. Detecção da Placa e Teleporte inicial (Imagens 9 & 10)
            local platePart = getZombiePlatePart()
            if platePart then
                hrp.CFrame = platePart.CFrame + Vector3.new(0, 3, 0)
                local cd = platePart:FindFirstChildOfClass("ClickDetector") or (platePart.Parent and platePart.Parent:FindFirstChildOfClass("ClickDetector"))
                if not cd and platePart.Parent then
                    cd = platePart.Parent:FindFirstChildWhichIsA("ClickDetector", true)
                end
                if cd and typeof(fireclickdetector) == "function" then
                    pcall(function() fireclickdetector(cd) end)
                end
                task.wait(0.2)
            end

            -- 2. Loop de Coleta Rápida até atingir 200 itens no inventário
            local maxTries = 0
            while countZombieLaunchersInInventory() < 200 and tsunamiRunning and maxTries < 400 do
                maxTries = maxTries + 1
                local targetPart = nil
                local targetCD = nil

                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj and obj.Parent then
                        if isZombieLauncherStrict(obj.Name, obj.Parent.Name) then
                            local cd = obj:FindFirstChildOfClass("ClickDetector") or obj.Parent:FindFirstChildOfClass("ClickDetector")
                            if not cd and obj:IsA("Model") then
                                cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
                            end
                            if cd then
                                targetCD = cd
                                break
                            end
                            if obj:IsA("BasePart") then
                                targetPart = obj
                                break
                            elseif obj:IsA("Model") then
                                targetPart = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                                if targetPart then break end
                            end
                        end
                    end
                end

                if targetCD and typeof(fireclickdetector) == "function" then
                    pcall(function() fireclickdetector(targetCD) end)
                elseif targetPart then
                    hrp.CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 0.5, 0))
                    pcall(function()
                        if typeof(firetouchinterest) == "function" then
                            firetouchinterest(hrp, targetPart, 0)
                            firetouchinterest(hrp, targetPart, 1)
                        end
                    end)
                end

                -- Teleporte seguro para cima se necessário (evitando quedas ou alturas excessivas ajustadas)
                if hrp.Position.Y < -5 or hrp.Position.Y > 500 then
                    hrp.CFrame = originalCF + Vector3.new(0, 10, 0)
                end

                task.wait(0.03) -- Velocidade relâmpago de coleta
            end

            sNotif("TSUNAMI ZOMBIE", "200 itens coletados com sucesso! Equipando todos simultaneamente...", "Success")

            -- 3. Equipar TODOS os 200 itens ao mesmo tempo na mão do jogador (Sistema Profissional)
            local bp = LP:FindFirstChild("Backpack")
            if bp and char then
                for _, item in ipairs(bp:GetChildren()) do
                    if item:IsA("Tool") and isZombieLauncherStrict(item.Name, item.Parent and item.Parent.Name or "") then
                        pcall(function() item.Parent = char end)
                    end
                end
            end

            task.wait(0.2)

            -- 4. Detector Profissional de Equipamento e Clicar na Tela na Velocidade da Luz
            local equippedCount = 0
            for _, item in ipairs(char:GetChildren()) do
                if item:IsA("Tool") and isZombieLauncherStrict(item.Name, item.Parent and item.Parent.Name or "") then
                    equippedCount = equippedCount + 1
                end
            end

            if equippedCount > 0 then
                sNotif("TSUNAMI ZOMBIE", "Equipados "..equippedCount.." itens! Disparando Tsunami...", "Success")
                
                -- Clica na tela velozmente para acionar todos em massa instantaneamente
                for i = 1, 15 do
                    pcall(function()
                        for _, item in ipairs(char:GetChildren()) do
                            if item:IsA("Tool") then
                                item:Activate()
                            end
                        end
                    end)
                    task.wait(0.01)
                end
            end

            -- 5. Teleporte automático para local seguro (alguns studs para cima, abaixando se estiver muito alto)
            if hrp then
                local currentY = hrp.Position.Y
                local safeYOffset = 15
                if currentY > 200 then
                    safeYOffset = 5 -- Se estiver muito alto, abaixa para um patamar seguro
                end
                hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + safeYOffset, hrp.Position.Z)
                sNotif("TSUNAMI ZOMBIE", "Teleportado para local seguro com sucesso!", "Success")
            end

            tsunamiRunning = false
        end)
    end)
end

-- Criação do Botão Principal na aba Troll
local tsunamiBtn = Instance.new("TextButton", sSMiscTab)
tsunamiBtn.Size, tsunamiBtn.BackgroundColor3, tsunamiBtn.Text, tsunamiBtn.TextColor3, tsunamiBtn.Font, tsunamiBtn.TextSize = UDim2.new(1, 0, 0, 48), Color3.fromRGB(52, 152, 219), "🧟 TSUNAMI ZOMBIE", Color3.fromRGB(255, 255, 255), Enum.Font.GothamBold, 15
Instance.new("UICorner", tsunamiBtn).CornerRadius = UDim.new(0, 8)
local tsunamiStroke = Instance.new("UIStroke", tsunamiBtn)
tsunamiStroke.Color, tsunamiStroke.Thickness = Color3.fromRGB(255, 255, 255), 1.5
table.insert(TE.Accs, tsunamiBtn)

tsunamiBtn.MouseButton1Click:Connect(function()
    executeTsunamiZombie()
end)

-- [MANTIDO TODO O RESTO DO HUB INTACTO] --
cST("✨ GRÁFICOS", sM)
local stU, ftU
stU = cTog("✨ Shaders", sM, shOn, function(s) shOn = s uLig() end, "Shaders")

local originalPartsData = {}
local function applyBoostState(state)
    if fpsOn == state then return end
    fpsOn = state
    HC.FpsBoost = state
    saveC()
    if state then
        if shOn then shOn = false HC.Shaders = false saveC() end
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.GlobalShadows = false
        clrCE()
        rLig()
        task.spawn(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    if not originalPartsData[obj] then
                        originalPartsData[obj] = {Material = obj.Material, Reflectance = obj.Reflectance}
                    end
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    if not originalPartsData[obj] then
                        originalPartsData[obj] = {Transparency = obj.Transparency}
                    end
                    obj.Transparency = 1
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    if not originalPartsData[obj] then
                        originalPartsData[obj] = {Enabled = obj.Enabled}
                    end
                    obj.Enabled = false
                end
            end
        end)
    else
        uLig()
        task.spawn(function()
            for obj, data in pairs(originalPartsData) do
                if obj and obj.Parent then
                    if obj:IsA("BasePart") then
                        obj.Material = data.Material or Enum.Material.Plastic
                        obj.Reflectance = data.Reflectance or 0
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then
                        obj.Transparency = data.Transparency or 0
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                        obj.Enabled = data.Enabled ~= false
                    end
                end
            end
            table.clear(originalPartsData)
        end)
    end
end

ftU = cTog("🥔 Booster FPS", sM, fpsOn, function(s)
    if s and shOn then
        sNotif("Erro", "Desative Shaders primeiro.", "Error")
        fpsOn = false
        if ftU then ftU(false) end
        return
    end
    applyBoostState(s)
    if s then
        sNotif("FPS Booster", "Qualidade reduzida para máxima mobilidade e desempenho!", "Success")
    else
        sNotif("FPS Booster", "Booster FPS desativado. Qualidade restaurada.", "Info")
    end
end, "FpsBoost")

cTog("🌫️ Desfoque Parede", sM, wbOn, function(s) wbOn = s if not s then local b = Lighting:FindFirstChild("VortexWallBlur") if b then b.Size = 0 end end end, "WallBlur")
cTog("🌫️ Neblina", sM, fgOn, function(s) fgOn = s uLig() end, "Fog")
cTog("🌀 Motion Blur", sM, mbOn, function(s)
    if s then
        local b = Instance.new("BlurEffect", Lighting)
        b.Name, b.Size = "VortexMotionBlur", 0
        local c = Workspace.CurrentCamera
        if c then lCR = c.CFrame - c.CFrame.Position end
        mbc = RunService.RenderStepped:Connect(function()
            local cam = Workspace.CurrentCamera
            if not cam then return end
            local rot = cam.CFrame - cam.CFrame.Position
            local d = rot.LookVector:Dot(lCR.LookVector)
            local a = math.acos(math.clamp(d, -1, 1))
            local tB = math.clamp(math.deg(a) * 1.5, 0, 30)
            b.Size, lCR = b.Size + (tB - b.Size) * 0.2, rot
        end)
    else
        if mbc then mbc:Disconnect() mbc = nil end
        local b = Lighting:FindFirstChild("VortexMotionBlur")
        if b then pcall(function() b:Destroy() end) end
    end
end, "MotionBlur")

local fbConn = nil
cTog("☀️ Fullbright", sM, fbOn, function(s)
    fbOn = s
    HC.Fullbright = s
    saveC()
    if s then
        if fbConn then fbConn:Disconnect() end
        fbConn = RunService.RenderStepped:Connect(function()
            if not fbOn then return end
            Lighting.Brightness = 2
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
            Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
            Lighting.ColorShift_Top = Color3.new(1, 1, 1)
            pcall(function() Lighting.FogEnd = 100000 end)
        end)
        sNotif("Fullbright", "Iluminação máxima ativada para mapas escuros!", "Success")
    else
        if fbConn then fbConn:Disconnect() fbConn = nil end
        rLig()
        sNotif("Fullbright", "Fullbright desativado.", "Info")
    end
end, "Fullbright")

cTog("🔦 Luz Player", sM, plOn, function(s)
    plOn = s
    if s then
        plc = RunService.Heartbeat:Connect(function()
            local c = LP.Character
            if c and c:FindFirstChild("HumanoidRootPart") then
                local h = c.HumanoidRootPart
                if not h:FindFirstChild("VortexPlayerLight") then
                    local l = Instance.new("PointLight", h)
                    l.Name, l.Brightness, l.Range, l.Shadows, l.Color = "VortexPlayerLight", 3, 60, false, Color3.new(1, 1, 1)
                end
            end
        end)
    else
        if plc then plc:Disconnect() plc = nil end
        local c = LP.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local l = c.HumanoidRootPart:FindFirstChild("VortexPlayerLight")
            if l then pcall(function() l:Destroy() end) end
        end
    end
end, "PlayerLight")

cST("⏰ TEMPO", sM)
local uTSUI, mtLp, manualT = nil, nil, Lighting.ClockTime
cTog("🔄 Auto Tempo", sM, atOn, function(s)
    atOn = s
    if s then
        if mtLp then mtLp:Disconnect() mtLp = nil end
        atc = RunService.RenderStepped:Connect(function(dt)
            Lighting.ClockTime = (Lighting.ClockTime + (0.4 * dt)) % 24
            manualT = Lighting.ClockTime
            if uTSUI then uTSUI(Lighting.ClockTime, true) end
        end)
    else
        if atc then atc:Disconnect() atc = nil end
        if not mtLp then
            mtLp = RunService.RenderStepped:Connect(function()
                Lighting.ClockTime = manualT
            end)
        end
    end
end, "AutoTime")

-- [ESP OTIMIZADO COM THROTTLING E DISTÂNCIA] --
cST("👁️ ESP", sE)
cTog("👤 ESP Player", sE, epOn, function(s) epOn = s uESP() end, "ESPPlayer")
cTog("🤖 ESP NPC", sE, enOn, function(s) enOn = s uESP() end, "ESPNPC")
cTog("⚠️ Alerta NPC Hostil", sE, dEspOn, function(s) dEspOn = s if not s then cETb(tDNPC) end uDEsp() end, "DangerESP")

cSli("O QUÃO LONGE O ESP VAI", "0 a 1000 studs", 0, 1000, espMaxDistance, sE, function(v)
    espMaxDistance = v
    HC.ESPMaxDistance = v
    saveC()
end, "ESPMaxDistance")

cST("🎨 CORES", sE)
local function cECBtn(n, c3, hc)
    local b = Instance.new("TextButton", sE)
    b.Size, b.BackgroundColor3, b.Text, b.TextColor3, b.Font, b.TextSize = UDim2.new(1, 0, 0, 32), Color3.fromRGB(45, 45, 45), "🎨 "..n, c3, Enum.Font.GothamBold, 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() ECol.PName, ECol.NName = hc, hc end)
end
cECBtn("Branco", Color3.fromRGB(255, 255, 255), "#FFFFFF")
cECBtn("Amarelo", Color3.fromRGB(255, 215, 0), "#FFD700")
cECBtn("Roxo", Color3.fromRGB(176, 38, 255), "#B026FF")
cECBtn("Verde", Color3.fromRGB(50, 205, 50), "#32CD32")
cECBtn("Rosa", Color3.fromRGB(255, 20, 147), "#FF1493")

cST("👤 MODS", sP)
cTog("🌀 TeleportTool", sP, ttOn, function(s) ttOn = s if s then gTT() else rTT() end end, "TeleportTool")
cTog("⚡ Instant Interact", sP, iiOn, function(s)
    iiOn = s
    if s then
        for _, p in pairs(Workspace:GetDescendants()) do
            if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end
        end
        iic = ProximityPromptService.PromptShown:Connect(function(p) p.HoldDuration = 0 end)
    else
        if iic then iic:Disconnect() iic = nil end
    end
end, "InstantInteract")

cTog("⚡ Mods Player", sP, pmOn, function(s)
    pmOn = s
    if s then
        pmc = RunService.Stepped:Connect(function()
            if Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView = pFov end
            local c = LP.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then
                    h.UseJumpPower = true
                    if h.WalkSpeed ~= pSpd then h.WalkSpeed = pSpd end
                    if h.JumpPower ~= pJmp then h.JumpPower = pJmp end
                end
            end
        end)
    else
        if pmc then pmc:Disconnect() pmc = nil end
        local c = LP.Character
        if c and c:FindFirstChildOfClass("Humanoid") then c.Humanoid.WalkSpeed, c.Humanoid.JumpPower = 16, 50 end
        if Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView = 70 end
    end
end, "PlayerMods")

cTog("⚡ No Cooldown (Instantâneo)", sP, ncOn, function(s)
    ncOn = s
    if s then
        ncc = RunService.Stepped:Connect(function()
            local c = LP.Character
            if c then
                for _, t in ipairs(c:GetChildren()) do
                    if t:IsA("Tool") then
                        t.Enabled = true
                        pcall(function()
                            if t.Cooldown then t.Cooldown = 0 end
                            for _, v in ipairs(t:GetDescendants()) do
                                if v:IsA("NumberValue") or v:IsA("IntValue") then
                                    local ln = string.lower(v.Name)
                                    if string.find(ln, "cooldown") or string.find(ln, "cd") or string.find(ln, "time") or string.find(ln, "delay") then
                                        v.Value = 0
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end)
    else
        if ncc then ncc:Disconnect() ncc = nil end
    end
end, "NoCooldown")

cTog("🚀 Inf Jump", sP, ijOn, function(s)
    ijOn = s
    if s then
        ijc = UserInputService.JumpRequest:Connect(function()
            local c = LP.Character
            if c then
                local h = c:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)
    else
        if ijc then ijc:Disconnect() ijc = nil end
    end
end, "InfJump")

cTog("👻 Noclip", sP, nclOn, function(s)
    nclOn = s
    HC.Noclip = s
    saveC()
    if s then
        sNotif("Aviso Noclip", "Ativado!", "Error")
    end
end, "Noclip")

cTog("🛡️ Anti-Effect", sP, antiEffectOn, function(s)
    antiEffectOn = s
    HC.AntiEffect = s
    saveC()
end, "AntiEffect")

cSli("🏃 WalkSpeed", "16 a 50", 16, 200, pSpd, sP, function(v) pSpd = v end, "WalkSpeed")
cSli("🦘 JumpPower", "50 a 100", 50, 300, pJmp, sP, function(v) pJmp = v end, "JumpPower")
cSli("🔭 FOV", "70 a 90", 70, 120, pFov, sP, function(v) pFov = v end, "FOV")

cST("🛡️ PROTEÇÃO", sPr)
cTog("🛡️ Anti-Fling", sPr, afOn, function(s) afOn = s if s then eAF() else if afc then afc:Disconnect() afc = nil end end end, "AntiFling")
cTog("🌌 Anti-Void", sPr, avOn, function(s) avOn = s end, "AntiVoid")
cTog("🚫 Anti-AFK", sPr, aaOn, function(s) aaOn = s if s then aac = LP.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end) else if aac then aac:Disconnect() aac = nil end end end, "AntiAfk")
cTog("🔄 Auto-Rejoin", sPr, arOn, function(s) arOn = s end, "AutoRejoin")

cST("🛡️ DEFENSE & COMBAT", sDC)
cTog("🧪 Auto-Usar Poção de Vida", sDC, autoHealOn, function(s) autoHealOn = s HC.AutoHeal = s saveC() end, "AutoHeal")
cSli("Em Que Momento Usar O Item", "60 (%)", 0, 100, healthThresholdPct, sDC, function(v) healthThresholdPct = v HC.HealthThreshold = v saveC() end, "HealthThreshold")
cTog("🧪 Auto-Click Poção De vida", sDC, autoClickPotionOn, function(s) autoClickPotionOn = s HC.AutoClickPotion = s saveC() end, "AutoClickPotion")
cTog("🎒 Auto-Grab", sDC, autoCollectPotionOn, function(s) autoCollectPotionOn = s HC.AutoCollectPotion = s saveC() end, "AutoCollectPotion")

cST("👥 VIEWER & LOOP PLAYERS", sV)
cTog("🛡️ Whitelist de Amigos", sV, wlOn, function(s) wlOn = s uESP() end, "Whitelist")

cST("💥 LOOP EXPLOSION SYSTEM", sV)
cTog("💥 Loop Explosion", sV, loopExplosionOn, function(s) loopExplosionOn = s HC.LoopExplosion = s saveC() end, "LoopExplosion")

cST("🎨 TEMAS", sTh)
local function cTBtn(n, mc, tc, ac, tk)
    local b = Instance.new("TextButton", sTh)
    b.Size, b.BackgroundColor3, b.Text, b.TextColor3, b.Font, b.TextSize = UDim2.new(1, 0, 0, 40), Color3.fromRGB(45, 45, 45), "🎨 "..n, ac, Enum.Font.GothamBold, 14
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() appT(mc, tc, ac, tk) end)
end
cTBtn("Orion", Color3.fromRGB(36, 36, 37), Color3.fromRGB(30, 30, 30), Color3.fromRGB(52, 152, 219), "Orion")
cTBtn("Vampiro", Color3.fromRGB(20, 10, 10), Color3.fromRGB(15, 5, 5), Color3.fromRGB(220, 50, 50), "Vampiro")
cTBtn("Tóxico", Color3.fromRGB(15, 25, 15), Color3.fromRGB(10, 15, 10), Color3.fromRGB(50, 220, 100), "Tóxico")
cTBtn("Ametista", Color3.fromRGB(30, 20, 40), Color3.fromRGB(20, 10, 30), Color3.fromRGB(155, 89, 182), "Ametista")
cTBtn("Ouro", Color3.fromRGB(40, 35, 20), Color3.fromRGB(30, 25, 10), Color3.fromRGB(241, 196, 15), "Ouro")
cTBtn("Sakura", Color3.fromRGB(40, 25, 30), Color3.fromRGB(30, 15, 20), Color3.fromRGB(255, 153, 204), "Sakura")

task.spawn(function()
    if not LP.Character then LP.CharacterAdded:Wait() end
    task.wait(0.5)
    local sT = HC.SelectedTheme
    if sT == "Vampiro" then appT(Color3.fromRGB(20,10,10), Color3.fromRGB(15,5,5), Color3.fromRGB(220,50,50))
    elseif sT == "Tóxico" then appT(Color3.fromRGB(15,25,15), Color3.fromRGB(10,15,10), Color3.fromRGB(50,220,100))
    elseif sT == "Ametista" then appT(Color3.fromRGB(30,20,40), Color3.fromRGB(20,10,30), Color3.fromRGB(155,89,182))
    elseif sT == "Ouro" then appT(Color3.fromRGB(40,35,20), Color3.fromRGB(30,25,10), Color3.fromRGB(241,196,15))
    elseif sT == "Sakura" then appT(Color3.fromRGB(40,25,30), Color3.fromRGB(30,15,20), Color3.fromRGB(255,153,204)) end
    for _, iF in pairs(IC) do pcall(function() iF() end) end
    uLig()
end)
