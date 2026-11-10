local CG,P,L,W,TS,UIS,RS,VU,PPS,HS = game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
local LP = P.LocalPlayer 
local TP = (gethui and gethui()) or CG 
if TP:FindFirstChild("VortexGraphicsHub") then TP.VortexGraphicsHub:Destroy() end

local SFName = "VortexHub_Config.json" 
local HC = {
    Shaders=false, FpsBoost=false, WallBlur=true, Fog=false, MotionBlur=false, Fullbright=false, 
    PlayerLight=false, AutoTime=false, RandomRain=false, ESPPlayer=false, ESPNPC=false, DangerESP=false, 
    TeleportTool=false, InstantInteract=false, PlayerMods=false, NoCooldown=false, InfJump=false, 
    Noclip=false, WalkSpeed=16, JumpPower=50, FOV=70, AntiFling=false, AntiVoid=false, AntiAfk=false, 
    AutoRejoin=false, Notifications=true, SelectedTheme="Orion", Whitelist=true, HealthThreshold=60, 
    AutoHeal=false, AutoClickPotion=false, AutoCollectPotion=false, AntiLag=false, LoopExplosion=false, 
    AntiEffect=false, ESPMaxDistance=1000
}

local IC = {} 
local function saveC() pcall(function() if writefile then writefile(SFName, HS:JSONEncode(HC)) end end) end
local function loadC() 
    if readfile and isfile and isfile(SFName) then 
        local s,d = pcall(function() return HS:JSONDecode(readfile(SFName)) end) 
        if s and type(d)=="table" then 
            for k,v in pairs(d) do if HC[k]~=nil then HC[k]=v end end 
        end 
    end 
end 
loadC()

local shOn,fpsOn,wbOn,fgOn,mbOn,fbOn,plOn,atOn,rrOn,epOn,enOn,dEspOn,ttOn,iiOn,pmOn,ncOn,ijOn,nclOn = HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip
local pSpd,pJmp,pFov,afOn,avOn,aaOn,arOn,jelOn,wlOn,healthThresholdPct,autoHealOn,autoClickPotionOn,autoCollectPotionOn,antiLagOn,loopExplosionOn,antiEffectOn,espMaxDistance = HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist,HC.HealthThreshold,HC.AutoHeal,HC.AutoClickPotion,HC.AutoCollectPotion,HC.AntiLag,HC.LoopExplosion,HC.AntiEffect,HC.ESPMaxDistance

local ECol = {PName="#00FFFF", PHP="#32FF32", PDist="#FFAA00", NName="#FF4444", NHP="#32FF32", NDist="#FFAA00"}
local tNPC, tPly, tDNPC = {}, {}, {} 
local SG = Instance.new("ScreenGui", TP)
SG.Name = "VortexGraphicsHub"
SG.ResetOnSpawn = false 
local ANotif = {}

local function sNotif(tl,tx,nt)
    if not jelOn and (nt=="Info" or tl=="🟢" or tl=="🔴") then return end 
    local cls = {Error=Color3.fromRGB(255,75,75), Info=Color3.fromRGB(52,152,219), Success=Color3.fromRGB(75,255,75)}
    local cc = cls[nt] or cls.Info 
    local icn = nt=="Error" and "⚠️" or (nt=="Success" and "✅" or "ℹ️")
    local NF = Instance.new("Frame", SG)
    NF.Size, NF.Position, NF.BackgroundColor3, NF.BorderSizePixel = UDim2.new(0,300,0,65), UDim2.new(1,20,1,-85-(#ANotif*75)), Color3.fromRGB(25,25,28), 0 
    Instance.new("UICorner", NF).CornerRadius = UDim.new(0,6)
    local sk = Instance.new("UIStroke", NF) sk.Color, sk.Thickness = Color3.fromRGB(50,50,55), 1 
    local Sd = Instance.new("Frame", NF) Sd.Size, Sd.BackgroundColor3, Sd.BorderSizePixel = UDim2.new(0,4,1,0), cc, 0 
    Instance.new("UICorner", Sd).CornerRadius = UDim.new(0,6)
    local Txt = Instance.new("TextLabel", NF) Txt.Name = "NTitle" Txt.Size, Txt.Position, Txt.BackgroundTransparency, Txt.Text, Txt.TextColor3, Txt.Font, Txt.TextSize, Txt.TextXAlignment = UDim2.new(1,-65,0,20), UDim2.new(0,55,0,10), 1, tl, cc, Enum.Font.GothamBold, 14, Enum.TextXAlignment.Left 
    local Dsc = Instance.new("TextLabel", NF) Dsc.Size, Dsc.Position, Dsc.BackgroundTransparency, Dsc.Text, Dsc.TextColor3, Dsc.Font, Dsc.TextSize, Dsc.TextWrapped, Dsc.TextXAlignment = UDim2.new(1,-65,0,25), UDim2.new(0,55,0,30), 1, tx, Color3.fromRGB(240,240,240), Enum.Font.Gotham, 12, true, Enum.TextXAlignment.Left 
    Dsc.RichText = true 
    table.insert(ANotif, NF)
    TS:Create(NF, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position=UDim2.new(1,-320,1,-85-(#ANotif-1)*75)}):Play()
    task.delay(4, function()
        pcall(function() NF:Destroy() end)
        for i,v in ipairs(ANotif) do if v==NF then table.remove(ANotif,i) break end end
    end)
end

-- Janela Principal do Hub
local CTh = {MBG=Color3.fromRGB(36,36,37), TB=Color3.fromRGB(30,30,30), A=Color3.fromRGB(52,152,219)}
local TE = {Bgs={}, TBs={}, Accs={}, Tgls={}, Txs={}}

local OBtn = Instance.new("TextButton", SG) 
OBtn.Size, OBtn.Position, OBtn.BackgroundColor3, OBtn.Text, OBtn.TextColor3, OBtn.Font, OBtn.TextSize, OBtn.Visible = UDim2.new(0,50,0,50), UDim2.new(0,20,0,20), Color3.fromRGB(36,36,37), "⚡\nOPEN", Color3.fromRGB(255,255,255), Enum.Font.GothamBold, 12, false 
Instance.new("UICorner", OBtn).CornerRadius = UDim.new(0,10)

local MF = Instance.new("Frame", SG) 
MF.Size, MF.Position, MF.BackgroundColor3, MF.Active, MF.Draggable = UDim2.new(0,480,0,530), UDim2.new(0.5,-240,0.5,-265), CTh.MBG, true, true 
Instance.new("UICorner", MF).CornerRadius = UDim.new(0,8)

local TB = Instance.new("Frame", MF) 
TB.Size, TB.BackgroundColor3 = UDim2.new(1,0,0,40), CTh.TB 
Instance.new("UICorner", TB).CornerRadius = UDim.new(0,8)

local CBn = Instance.new("TextButton", TB) 
CBn.Size, CBn.Position, CBn.BackgroundTransparency, CBn.Text, CBn.TextColor3, CBn.Font, CBn.TextSize = UDim2.new(0,40,0,40), UDim2.new(1,-40,0,0), 1, "X", Color3.fromRGB(200,200,200), Enum.Font.GothamBold, 16 
CBn.MouseButton1Click:Connect(function() MF.Visible = false OBtn.Visible = true end)
OBtn.MouseButton1Click:Connect(function() MF.Visible = true OBtn.Visible = false end)

sNotif("Sucesso", "VortexHub carregado com sucesso!", "Success")
