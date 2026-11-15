-- =====================================================================
-- VORTEX HUB - LOADER PRINCIPAL & SELEÇÃO DE VERSÕES (CORRIGIDO)
-- =====================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer
local protectGui = (gethui and gethui()) or CoreGui

if protectGui:FindFirstChild("VortexHubSelector") then
    protectGui.VortexHubSelector:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", protectGui)
ScreenGui.Name = "VortexHubSelector"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Overlay = Instance.new("Frame", ScreenGui)
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.55

local Card = Instance.new("Frame", Overlay)
Card.Size = UDim2.new(0, 440, 0, 320)
Card.Position = UDim2.new(0.5, -220, 0.5, -160)
Card.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 12)
local CardStroke = Instance.new("UIStroke", Card)
CardStroke.Color = Color3.fromRGB(52, 152, 219)
CardStroke.Thickness = 1.5

local TopHeader = Instance.new("Frame", Card)
TopHeader.Size = UDim2.new(1, 0, 0, 48)
TopHeader.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
Instance.new("UICorner", TopHeader).CornerRadius = UDim.new(0, 12)

local TitleModal = Instance.new("TextLabel", TopHeader)
TitleModal.Size = UDim2.new(1, -20, 1, 0)
TitleModal.Position = UDim2.new(0, 16, 0, 0)
TitleModal.BackgroundTransparency = 1
TitleModal.Text = "⚡ Vortex Hub - Seleção de Versão"
TitleModal.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleModal.Font = Enum.Font.GothamBold
TitleModal.TextSize = 15
TitleModal.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel", Card)
SubTitle.Size = UDim2.new(1, -30, 0, 25)
SubTitle.Position = UDim2.new(0, 15, 0, 58)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Escolha qual versão deseja executar:"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 195)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 13
SubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- =====================================================================
-- FUNÇÃO DA VERSÃO BENDY AND THE INK MACHINE (ROXO)
-- =====================================================================
local function runBendyScript()
    local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
    local LP=P.LocalPlayer local TP=(gethui and gethui())or CG if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end
    local SFName="VortexHub_Config.json" local HC={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,RandomRain=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,AutoRejoin=false,Notifications=true,SelectedTheme="Orion",Whitelist=true,HealthThreshold=60,AutoHeal=false,AutoClickPotion=false,AutoCollectPotion=false,AntiLag=false,LoopExplosion=false,AntiEffect=false,ESPMaxDistance=1000}
    local IC={} local function saveC()pcall(function()if writefile then writefile(SFName,HS:JSONEncode(HC))end end)end
    local function loadC()if readfile and isfile and isfile(SFName)then local s,d=pcall(function()return HS:JSONDecode(readfile(SFName))end)if s and type(d)=="table"then for k,v in pairs(d)do if HC[k]~=nil then HC[k]=v end end end end end loadC()
    local shOn,fpsOn,wbOn,fgOn,mbOn,fbOn,plOn,atOn,rrOn,epOn,enOn,dEspOn,ttOn,iiOn,pmOn,ncOn,ijOn,nclOn,pSpd,pJmp,pFov,afOn,avOn,aaOn,arOn,jelOn,wlOn,healthThresholdPct,autoHealOn,autoClickPotionOn,autoCollectPotionOn,antiLagOn,loopExplosionOn,antiEffectOn,espMaxDistance=HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip,HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist,HC.HealthThreshold,HC.AutoHeal,HC.AutoClickPotion,HC.AutoCollectPotion,HC.AntiLag,HC.LoopExplosion,HC.AntiEffect,HC.ESPMaxDistance
    local ijc,nlc,avc,pmc,aac,arc,atc,sLp,iic,fbLp,plc,mbc,afc,ncc,aec local lSCf=nil local lCR=CFrame.new()local ECol={PName="#00FFFF",PHP="#32FF32",PDist="#FFAA00",NName="#FF4444",NHP="#32FF32",NDist="#FFAA00"}
    local tNPC,tPly,tDNPC={},{},{} local eUp,dUp
    local OL={GS=L.GlobalShadows,B=L.Brightness,EDS=L.EnvironmentDiffuseScale,ESS=L.EnvironmentSpecularScale,FS=L.FogStart,FE=L.FogEnd,FC=L.FogColor,CT=L.ClockTime,A=L.Ambient,OA=L.OutdoorAmbient,T=L.Technology,SS=L.ShadowSoftness}
    local function clrCE()for _,v in pairs(L:GetChildren())do if v.Name:match("Vortex")and v.Name~="VortexMotionBlur"and v.Name~="VortexWallBlur"and v.Name~="VortexDeathFade"then v:Destroy()end end end
    local dF=L:FindFirstChild("VortexDeathFade")if not dF then dF=Instance.new("ColorCorrectionEffect",L)dF.Name="VortexDeathFade"dF.Brightness=0 dF.Contrast=0 end local pDead=false

    local fCache={} 
    local function isFriend(plr)
        if not wlOn then return false end
        if not plr or plr==LP then return false end 
        if fCache[plr.UserId]~=nil then return fCache[plr.UserId]end 
        local suc,res=pcall(function()return LP:IsFriendsWith(plr.UserId)end)
        if suc then fCache[plr.UserId]=res return res end 
        return false 
    end

    local function stDE(c)if not c then return end local h=c:WaitForChild("Humanoid",5)if not h then return end h.Died:Connect(function()pDead=true local wb=L:FindFirstChild("VortexWallBlur")if not wb then wb=Instance.new("BlurEffect",L)wb.Name="VortexWallBlur"end local ti=TweenInfo.new(2.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)TS:Create(wb,ti,{Size=45}):Play()TS:Create(dF,ti,{Brightness=-1,Contrast=-0.5}):Play()end)end

    local tT=nil 
    local function rTT()
        if tT then pcall(function() tT:Destroy() end) tT=nil end 
        if LP:FindFirstChild("Backpack")then local b=LP.Backpack:FindFirstChild("TeleportTool")if b then pcall(function() b:Destroy() end) end end 
        if LP.Character then local c=LP.Character:FindFirstChild("TeleportTool")if c then pcall(function() c:Destroy() end) end end 
    end
    
    local function sNotif_Init(SG_Ref, jelOn_val, CTh_Ref)
        return function(tl,tx,nt)
            if not jelOn_val and (nt=="Info" or tl=="🟢" or tl=="🔴") then return end
            local cls={Error=Color3.fromRGB(255,75,75),Info=CTh_Ref.A,Success=Color3.fromRGB(75,255,75)}
            local cc=cls[nt]or cls.Info 
            local icn=nt=="Error"and"⚠️"or(nt=="Success"and"✅"or"ℹ️")
            local NF=Instance.new("Frame",SG_Ref)
            NF.Size,NF.Position,NF.BackgroundColor3,NF.BorderSizePixel=UDim2.new(0,300,0,65),UDim2.new(1,20,1,-85),Color3.fromRGB(25,25,28),0 
            Instance.new("UICorner",NF).CornerRadius=UDim.new(0,6)
            local sk=Instance.new("UIStroke",NF)sk.Color=Color3.fromRGB(50,50,55)sk.Thickness=1 
            local Sd=Instance.new("Frame",NF)Sd.Size,Sd.BackgroundColor3,Sd.BorderSizePixel=UDim2.new(0,4,1,0),cc,0 
            Instance.new("UICorner",Sd).CornerRadius=UDim.new(0,6)
            local Txt=Instance.new("TextLabel",NF)
            Txt.Name="NTitle" Txt.Size,Txt.Position,Txt.BackgroundTransparency,Txt.Text,Txt.TextColor3,Txt.Font,Txt.TextSize,Txt.TextXAlignment=UDim2.new(1,-65,0,20),UDim2.new(0,55,0,10),1,tl,cc,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left 
            local Dsc=Instance.new("TextLabel",NF)
            Dsc.Size,Dsc.Position,Dsc.BackgroundTransparency,Dsc.Text,Dsc.TextColor3,Dsc.Font,Dsc.TextSize,Dsc.TextWrapped,Dsc.TextXAlignment=UDim2.new(1,-65,0,25),UDim2.new(0,55,0,30),1,tx,Color3.fromRGB(240,240,240),Enum.Font.Gotham,12,true,Enum.TextXAlignment.Left 
            Dsc.RichText=true 
            local PBg=Instance.new("Frame",NF)PBg.Size,PBg.Position,PBg.BackgroundColor3,PBg.BorderSizePixel=UDim2.new(1,0,0,3),UDim2.new(0,0,1,-3),Color3.fromRGB(40,40,45),0 
            Instance.new("UICorner",PBg).CornerRadius=UDim.new(0,6)
            local PBar=Instance.new("Frame",PBg)PBar.Size,PBar.BackgroundColor3,PBar.BorderSizePixel=UDim2.new(1,0,1,0),cc,0 
            Instance.new("UICorner",PBar).CornerRadius=UDim.new(0,6)
            TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85)}):Play()
            TS:Create(PBar,TweenInfo.new(4,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()
            task.delay(4,function()
                if NF.Parent then 
                    local oT=TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,NF.Position.Y.Offset)})
                    oT:Play()
                    oT.Completed:Connect(function()pcall(function() NF:Destroy() end)end)
                end 
            end)
        end
    end

    local SG=Instance.new("ScreenGui",TP)SG.Name="VortexGraphicsHub"SG.ResetOnSpawn=false
    local CTh={MBG=Color3.fromRGB(36,36,37),TB=Color3.fromRGB(30,30,30),A=Color3.fromRGB(52,152,219)}
    local sNotif = sNotif_Init(SG, jelOn, CTh)

    local function gTT()
        rTT()if not ttOn then return end 
        local T=Instance.new("Tool")T.Name,T.RequiresHandle,T.CanBeDropped="TeleportTool",false,false 
        T.Activated:Connect(function()local m=LP:GetMouse()if m and m.Hit and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0))sNotif("✨","Teleporte realizado!","Success")end end)
        local bp=LP:WaitForChild("Backpack",3)if bp then T.Parent=bp tT=T end 
    end

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
        activeToolConn = RS.Heartbeat:Connect(function()
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
        pDead=false 
        if dF then TS:Create(dF,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Brightness=0,Contrast=0}):Play()end 
        local wb=L:FindFirstChild("VortexWallBlur")if wb then TS:Create(wb,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Size=0}):Play()end 
        stDE(c)
        setupToolTracking()
        if ttOn then task.spawn(function()task.wait(0.5)gTT()end)end 
    end)
    if LP.Character then 
        stDE(LP.Character)
    end

    local OBtn=Instance.new("TextButton",SG)OBtn.Size,OBtn.Position,OBtn.BackgroundColor3,OBtn.Text,OBtn.TextColor3,OBtn.Font,OBtn.TextSize,OBtn.Visible=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),Color3.fromRGB(36,36,37),"⚡\nOPEN",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,false 
    Instance.new("UICorner",OBtn).CornerRadius=UDim.new(0,10)
    
    local MF=Instance.new("Frame",SG)MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,480,0,530),UDim2.new(0.5,-240,0.5,-265),CTh.MBG,true,true 
    Instance.new("UICorner",MF).CornerRadius=UDim.new(0,8)
    
    local TB=Instance.new("Frame",MF)TB.Size,TB.BackgroundColor3=UDim2.new(1,0,0,40),CTh.TB 
    Instance.new("UICorner",TB).CornerRadius=UDim.new(0,8)
    
    local Ttl=Instance.new("TextLabel",TB)Ttl.Size,Ttl.Position,Ttl.Text,Ttl.TextColor3,Ttl.Font,Ttl.TextSize,Ttl.BackgroundTransparency,Ttl.TextXAlignment=UDim2.new(1,-80,1,0),UDim2.new(0,45,0,0),"⚡ Vortex Hub (Bendy Edition)",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,1,Enum.TextXAlignment.Left
    local CBn=Instance.new("TextButton",TB)CBn.Size,CBn.Position,CBn.BackgroundTransparency,CBn.Text,CBn.TextColor3,CBn.Font,CBn.TextSize=UDim2.new(0,40,0,40),UDim2.new(1,-40,0,0),1,"X",Color3.fromRGB(200,200,200),Enum.Font.GothamBold,16 
    CBn.MouseButton1Click:Connect(function()MF.Visible=false OBtn.Visible=true end)
    OBtn.MouseButton1Click:Connect(function()MF.Visible=true OBtn.Visible=false end)
    
    sNotif("Vortex Hub", "Versão Bendy and the Ink Machine carregada!", "Success")
end

-- =====================================================================
-- FUNÇÃO DA VERSÃO UNIVERSAL (PADRÃO)
-- =====================================================================
local function runUniversalScript()
    local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
    local LP=P.LocalPlayer local TP=(gethui and gethui())or CG if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end
    local SG=Instance.new("ScreenGui",TP)SG.Name="VortexGraphicsHub"SG.ResetOnSpawn=false
    
    local OBtn=Instance.new("TextButton",SG)OBtn.Size,OBtn.Position,OBtn.BackgroundColor3,OBtn.Text,OBtn.TextColor3,OBtn.Font,OBtn.TextSize,OBtn.Visible=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),Color3.fromRGB(36,36,37),"⚡\nOPEN",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,false 
    Instance.new("UICorner",OBtn).CornerRadius=UDim.new(0,10)
    
    local MF=Instance.new("Frame",SG)MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,480,0,530),UDim2.new(0.5,-240,0.5,-265),Color3.fromRGB(36,36,37),true,true 
    Instance.new("UICorner",MF).CornerRadius=UDim.new(0,8)
    
    local TB=Instance.new("Frame",MF)TB.Size,TB.BackgroundColor3=UDim2.new(1,0,0,40),Color3.fromRGB(30,30,30)
    Instance.new("UICorner",TB).CornerRadius=UDim.new(0,8)
    
    local Ttl=Instance.new("TextLabel",TB)Ttl.Size,Ttl.Position,Ttl.Text,Ttl.TextColor3,Ttl.Font,Ttl.TextSize,Ttl.BackgroundTransparency,Ttl.TextXAlignment=UDim2.new(1,-80,1,0),UDim2.new(0,45,0,0),"⚡ Vortex Hub (Universal Edition)",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,1,Enum.TextXAlignment.Left
    local CBn=Instance.new("TextButton",TB)CBn.Size,CBn.Position,CBn.BackgroundTransparency,CBn.Text,CBn.TextColor3,CBn.Font,CBn.TextSize=UDim2.new(0,40,0,40),UDim2.new(1,-40,0,0),1,"X",Color3.fromRGB(200,200,200),Enum.Font.GothamBold,16 
    CBn.MouseButton1Click:Connect(function()MF.Visible=false OBtn.Visible=true end)
    OBtn.MouseButton1Click:Connect(function()MF.Visible=true OBtn.Visible=false end)

    -- Notificação de Sucesso
    local NF=Instance.new("Frame",SG)
    NF.Size,NF.Position,NF.BackgroundColor3,NF.BorderSizePixel=UDim2.new(0,300,0,65),UDim2.new(1,20,1,-85),Color3.fromRGB(25,25,28),0 
    Instance.new("UICorner",NF).CornerRadius=UDim.new(0,6)
    local Txt=Instance.new("TextLabel",NF)
    Txt.Size,Txt.Position,Txt.BackgroundTransparency,Txt.Text,Txt.TextColor3,Txt.Font,Txt.TextSize,Txt.TextXAlignment=UDim2.new(1,-65,0,20),UDim2.new(0,55,0,10),1,"Vortex Hub","Versão Universal carregada com sucesso!",Enum.Font.GothamBold,14,Enum.TextXAlignment.Left
    Txt.TextColor3 = Color3.fromRGB(75,255,75)
    TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85)}):Play()
    task.delay(4,function() pcall(function() NF:Destroy() end) end)
end

-- =====================================================================
-- CRIAÇÃO DOS BOTÕES DO LOADER PRINCIPAL
-- =====================================================================
local function createButton(name, pos, color, callback)
    local Btn = Instance.new("TextButton", Card)
    Btn.Size = UDim2.new(1, -30, 0, 50)
    Btn.Position = pos
    Btn.BackgroundColor3 = color
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

createButton("🌍 Versão Universal (Padrão)", UDim2.new(0, 15, 0, 95), Color3.fromRGB(52, 152, 219), function()
    ScreenGui:Destroy()
    runUniversalScript()
end)

createButton("🖋️ Bendy and the Ink Machine", UDim2.new(0, 15, 0, 155), Color3.fromRGB(142, 68, 173), function()
    ScreenGui:Destroy()
    runBendyScript()
end)

createButton("❌ Fechar Loader", UDim2.new(0, 15, 0, 245), Color3.fromRGB(192, 57, 43), function()
    ScreenGui:Destroy()
end)
