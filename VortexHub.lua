local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
local LP=P.LocalPlayer local TP=(gethui and gethui())or CG if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end
local SFName="VortexHub_Config.json" local HC={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,RandomRain=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,AutoRejoin=false,Notifications=true,SelectedTheme="Orion",Whitelist=true,HealthThreshold=60,AutoHeal=false,AutoClickPotion=false,AutoCollectPotion=false,AntiLag=false,LoopExplosion=false,AntiEffect=false,ESPMaxDistance=1000}
local IC={} local function saveC()pcall(function()if writefile then writefile(SFName,HS:JSONEncode(HC))end end)end
local function loadC()if readfile and isfile and isfile(SFName)then local s,d=pcall(function()return HS:JSONDecode(readfile(SFName))end)if s and type(d)=="table"then for k,v in pairs(d)do if HC[k]~=nil then HC[k]=v end end end end end loadC()

-- [AGRUPAMENTO DE VARIÁVEIS EM TABELAS PARA EVITAR O ERRO "OUT OF LOCAL REGISTERS"]
local V, C, M, UI = {}, {}, {}, {}

V.shOn,V.fpsOn,V.wbOn,V.fgOn,V.mbOn,V.fbOn,V.plOn,V.atOn,V.rrOn,V.epOn,V.enOn,V.dEspOn,V.ttOn,V.iiOn,V.pmOn,V.ncOn,V.ijOn,V.nclOn,V.pSpd,V.pJmp,V.pFov,V.afOn,V.avOn,V.aaOn,V.arOn,V.jelOn,V.wlOn,V.healthThresholdPct,V.autoHealOn,V.autoClickPotionOn,V.autoCollectPotionOn,V.antiLagOn,V.loopExplosionOn,V.antiEffectOn,V.espMaxDistance=HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip,HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist,HC.HealthThreshold,HC.AutoHeal,HC.AutoClickPotion,HC.AutoCollectPotion,HC.AntiLag,HC.LoopExplosion,HC.AntiEffect,HC.ESPMaxDistance

C.ijc,C.nlc,C.avc,C.pmc,C.aac,C.arc,C.atc,C.sLp,C.iic,C.fbLp,C.plc,C.mbc,C.afc,C.ncc,C.aec,C.autoHealConn,C.activeToolConn,C.fbConn,C.rainLoop,C.nclConn,C.menuProtConn,C.antiLagConn,C.autoClickPotionConn,C.autoGrabConn,C.verifiedSpawnConnection,C.flingLoop,C.hpCn,C.lgCn,C.fCn = nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil

M.lSCf,M.lCR,M.tNPC,M.tPly,M.tDNPC,M.eUp,M.dUp,M.OL,M.dF,M.pDead,M.fCache,M.tT,M.CNPCs,M.CTh,M.TE,M.SG,M.ANotif,M.AJT,M.trackedHistoryUsers,M.espUpdateClock,M.originalPartsData,M.rPrt,M.rEmt,M.uTSUI,M.mtLp,M.manualT,M.antiLagState,M.lagStartTime,M.boostTriggerTime,M.uPL,M.sPly,M.disconnectedTarget,M.pBD,M.loopExplosionTask,M.flingOrigCF,M.hpOrigCF = nil,CFrame.new(),{},{},{},nil,nil,{GS=L.GlobalShadows,B=L.Brightness,EDS=L.EnvironmentDiffuseScale,ESS=L.EnvironmentSpecularScale,FS=L.FogStart,FE=L.FogEnd,FC=L.FogColor,CT=L.ClockTime,A=L.Ambient,OA=L.OutdoorAmbient,T=L.Technology,SS=L.ShadowSoftness},L:FindFirstChild("VortexDeathFade"),false,{},nil,{}, {MBG=Color3.fromRGB(36,36,37),TB=Color3.fromRGB(30,30,30),A=Color3.fromRGB(52,152,219)}, {Bgs={},TBs={},Accs={},Tgls={},Txs={}}, Instance.new("ScreenGui",TP), {}, {}, {}, 0, {}, nil, nil, nil, nil, nil, "IDLE", 0, 0, nil, nil, nil, {}, nil, nil, nil

M.SG.Name="VortexGraphicsHub" M.SG.ResetOnSpawn=false

-- [CORREÇÃO: DECLARAÇÃO DA FUNÇÃO sNotif MOVIDA PARA O TOPO]
local function sNotif(tl,tx,nt)if not V.jelOn and(nt=="Info"or tl=="🟢"or tl=="🔴")then return end if tl=="Alvo" then for i=#M.ANotif,1,-1 do local v=M.ANotif[i]if v:FindFirstChild("NTitle")and v.NTitle.Text=="Alvo"then pcall(function() v:Destroy() end) table.remove(M.ANotif,i)end end for i,v in ipairs(M.ANotif)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-((i-1)*75))}):Play()end end local cls={Error=Color3.fromRGB(255,75,75),Info=M.CTh.A,Success=Color3.fromRGB(75,255,75)}local cc=cls[nt]or cls.Info local icn=nt=="Error"and"⚠️"or(nt=="Success"and"✅"or"ℹ️")local NF=Instance.new("Frame",M.SG)NF.Size,NF.Position,NF.BackgroundColor3,NF.BorderSizePixel=UDim2.new(0,300,0,65),UDim2.new(1,20,1,-85-(#M.ANotif*75)),Color3.fromRGB(25,25,28),0 Instance.new("UICorner",NF).CornerRadius=UDim.new(0,6)local sk=Instance.new("UIStroke",NF)sk.Color=Color3.fromRGB(50,50,55)sk.Thickness=1 local Sd=Instance.new("Frame",NF)Sd.Size,Sd.BackgroundColor3,Sd.BorderSizePixel=UDim2.new(0,4,1,0),cc,0 Instance.new("UICorner",Sd).CornerRadius=UDim.new(0,6)local Ic=Instance.new("TextLabel",NF)Ic.Size,Ic.Position,Ic.BackgroundTransparency,Ic.Text,Ic.TextSize=UDim2.new(0,40,0,40),UDim2.new(0,10,0.5,-20),1,icn,24 local Txt=Instance.new("TextLabel",NF)Txt.Name="NTitle" Txt.Size,Txt.Position,Txt.BackgroundTransparency,Txt.Text,Txt.TextColor3,Txt.Font,Txt.TextSize,Txt.TextXAlignment=UDim2.new(1,-65,0,20),UDim2.new(0,55,0,10),1,tl,cc,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left local Dsc=Instance.new("TextLabel",NF)Dsc.Size,Dsc.Position,Dsc.BackgroundTransparency,Dsc.Text,Dsc.TextColor3,Dsc.Font,Dsc.TextSize,Dsc.TextWrapped,Dsc.TextXAlignment=UDim2.new(1,-65,0,25),UDim2.new(0,55,0,30),1,tx,Color3.fromRGB(240,240,240),Enum.Font.Gotham,12,true,Enum.TextXAlignment.Left Dsc.RichText=true local PBg=Instance.new("Frame",NF)PBg.Size,PBg.Position,PBg.BackgroundColor3,PBg.BorderSizePixel=UDim2.new(1,0,0,3),UDim2.new(0,0,1,-3),Color3.fromRGB(40,40,45),0 Instance.new("UICorner",PBg).CornerRadius=UDim.new(0,6)local PBar=Instance.new("Frame",PBg)PBar.Size,PBar.BackgroundColor3,PBar.BorderSizePixel=UDim2.new(1,0,1,0),cc,0 Instance.new("UICorner",PBar).CornerRadius=UDim.new(0,6)table.insert(M.ANotif,NF)TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-(#M.ANotif-1)*75)}):Play()TS:Create(PBar,TweenInfo.new(4,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()task.delay(4,function()if NF.Parent then local oT=TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,NF.Position.Y.Offset)})oT:Play()oT.Completed:Connect(function()pcall(function() NF:Destroy() end)for i,v in ipairs(M.ANotif)do if v==NF then table.remove(M.ANotif,i)break end end for i,v in ipairs(M.ANotif)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-((i-1)*75))}):Play()end end)end end)end

local function clrCE()for _,v in pairs(L:GetChildren())do if v.Name:match("Vortex")and v.Name~="VortexMotionBlur"and v.Name~="VortexWallBlur"and v.Name~="VortexDeathFade"then v:Destroy()end end end
if not M.dF then M.dF=Instance.new("ColorCorrectionEffect",L) M.dF.Name="VortexDeathFade" M.dF.Brightness=0 M.dF.Contrast=0 end

-- [SISTEMA PROFISSIONAL DE WHITELIST DE AMIGOS] --
local function isFriend(plr)
    if not V.wlOn then return false end
    if not plr or plr==LP then return false end 
    if M.fCache[plr.UserId]~=nil then return M.fCache[plr.UserId]end 
    local suc,res=pcall(function()return LP:IsFriendsWith(plr.UserId)end)
    if suc then M.fCache[plr.UserId]=res return res end 
    return false 
end

local function stDE(c)if not c then return end local h=c:WaitForChild("Humanoid",5)if not h then return end h.Died:Connect(function()M.pDead=true local wb=L:FindFirstChild("VortexWallBlur")if not wb then wb=Instance.new("BlurEffect",L)wb.Name="VortexWallBlur"end local ti=TweenInfo.new(2.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)TS:Create(wb,ti,{Size=45}):Play()TS:Create(M.dF,ti,{Brightness=-1,Contrast=-0.5}):Play()end)end

-- [CORREÇÃO TELEPORTTOOL NO RESPAWN] --
local function rTT()
    if M.tT then pcall(function() M.tT:Destroy() end) M.tT=nil end 
    if LP:FindFirstChild("Backpack")then local b=LP.Backpack:FindFirstChild("TeleportTool")if b then pcall(function() b:Destroy() end) end end 
    if LP.Character then local c=LP.Character:FindFirstChild("TeleportTool")if c then pcall(function() c:Destroy() end) end end 
end
local function gTT()
    rTT()if not V.ttOn then return end 
    local T=Instance.new("Tool")T.Name,T.RequiresHandle,T.CanBeDropped="TeleportTool",false,false 
    T.Activated:Connect(function()local m=LP:GetMouse()if m and m.Hit and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0))sNotif("✨","Teleporte realizado!","Success")end end)
    local bp=LP:WaitForChild("Backpack",3)if bp then T.Parent=bp M.tT=T end 
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

local function setupToolTracking()
    if C.activeToolConn then C.activeToolConn:Disconnect() end
    C.activeToolConn = RS.Heartbeat:Connect(function()
        local c = LP.Character
        if not c then return end
        for _, item in ipairs(c:GetChildren()) do
            if item:IsA("Tool") and not isHealthPotionStrict(item.Name, item.Parent and item.Parent.Name or "") then
                M.lastCombatToolName = item.Name
            end
        end
    end)
end
setupToolTracking()

local function autoUseHealthPotion()
    if tick() - M.lastPotionUse < 0.4 then return end
    local c = LP.Character
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    local bp = LP.Character and LP.Character:FindFirstChild("Backpack") or LP:FindFirstChild("Backpack")
    if not c or not hum or not bp or hum.Health <= 0 then return end
    
    M.lastPotionUse = tick()
    local currentTool = nil
    for _, item in ipairs(c:GetChildren()) do
        if item:IsA("Tool") and not isHealthPotionStrict(item.Name, item.Parent and item.Parent.Name or "") then
            currentTool = item
            M.lastCombatToolName = item.Name
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
            elseif M.lastCombatToolName then
                if bp then targetTool = bp:FindFirstChild(M.lastCombatToolName) end
                if not targetTool and c then targetTool = c:FindFirstChild(M.lastCombatToolName) end
            end
            if targetTool and targetTool.Parent then
                targetTool.Parent = c
            end
        end)
    end
end

LP.CharacterAdded:Connect(function(c)
    M.pDead=false 
    if M.dF then TS:Create(M.dF,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Brightness=0,Contrast=0}):Play()end 
    local wb=L:FindFirstChild("VortexWallBlur")if wb then TS:Create(wb,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Size=0}):Play()end 
    stDE(c)
    setupToolTracking()
    if V.ttOn then task.spawn(function()task.wait(0.5)gTT()end)end 
end)
if LP.Character then 
    stDE(LP.Character)
end

local function gPB(cam,c)if not V.wbOn then return 0 end local mB,mD,cD=12,45,45 local rP=RaycastParams.new()rP.FilterType=Enum.RaycastFilterType.Exclude rP.FilterDescendantsInstances={c,cam}local ang={CFrame.Angles(0,0,0),CFrame.Angles(0,math.rad(25),0),CFrame.Angles(0,math.rad(-25),0),CFrame.Angles(math.rad(15),0,0),CFrame.Angles(math.rad(-15),0,0)}for _,a in ipairs(ang)do local dir=(cam.CFrame*a).LookVector local h=W:Raycast(cam.CFrame.Position,dir*mD,rP)if h and h.Instance and h.Instance.Transparency<0.8 and h.Instance.CanCollide and h.Distance<cD then cD=h.Distance end end local vS=cam.ViewportSize local function ckD(hrp,obj)local d=(hrp.Position-cam.CFrame.Position).Magnitude if d<mD then local sP,oS=cam:WorldToViewportPoint(hrp.Position)if oS and sP.X>=0 and sP.X<=vS.X and sP.Y>=0 and sP.Y<=vS.Y then local ry=W:Raycast(cam.CFrame.Position,(hrp.Position-cam.CFrame.Position),rP)if not ry or ry.Instance:IsDescendantOf(obj)then if d<cD then cD=d end end end end end for _,p in ipairs(P:GetPlayers())do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then ckD(p.Character.HumanoidRootPart,p.Character)end end for _,o in ipairs(W:GetChildren())do if o:IsA("Model")and o~=c and o:FindFirstChildOfClass("Humanoid")then local tH=o:FindFirstChild("HumanoidRootPart")or o.PrimaryPart if tH then ckD(tH,o)end end end if cD<mD then return(1-(cD/mD))*mB end return 0 end
local function cInd(hrp,rP)if not hrp then return false end local hs=0 local off={Vector3.new(0,0,0),Vector3.new(8,0,0),Vector3.new(-8,0,0),Vector3.new(0,0,8),Vector3.new(0,0,-8)}for _,o in ipairs(off)do local h=W:Raycast(hrp.Position+o,Vector3.new(0,120,0),rP)if h and h.Instance and h.Instance.CanCollide and h.Instance.Transparency<0.5 then hs=hs+1 end end return hs>=3 end
local function cNPC(o)if o:IsA("Model")and o:FindFirstChild("Humanoid")and o:FindFirstChild("HumanoidRootPart")and not P:GetPlayerFromCharacter(o)then M.CNPCs[o]=true end end for _,o in ipairs(W:GetDescendants())do cNPC(o)end W.DescendantAdded:Connect(function(o)task.delay(0.2,function()if o and o.Parent then if o:IsA("Model")then cNPC(o)end if o.Parent:IsA("Model")then cNPC(o.Parent)end end end)end)W.DescendantRemoving:Connect(function(o)if M.CNPCs[o]then M.CNPCs[o]=nil end end)
local function appT(m,t,a,tn)M.CTh.MBG,M.CTh.TB,M.CTh.A=m,t,a if tn then HC.SelectedTheme=tn saveC()end for _,f in pairs(M.TE.Bgs)do f.BackgroundColor3=m end for _,f in pairs(M.TE.TBs)do f.BackgroundColor3=t end for _,o in pairs(M.TE.Accs)do if o:IsA("UIStroke")then o.Color=a else o.BackgroundColor3=a end end for _,tx in pairs(M.TE.Txs)do tx.TextColor3=a end for bg,sF in pairs(M.TE.Tgls)do if sF()then TS:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=a}):Play()end end end

UI.OBtn=Instance.new("TextButton",M.SG)UI.OBtn.Size,UI.OBtn.Position,UI.OBtn.BackgroundColor3,UI.OBtn.Text,UI.OBtn.TextColor3,UI.OBtn.Font,UI.OBtn.TextSize,UI.OBtn.Visible=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),Color3.fromRGB(36,36,37),"⚡\nOPEN",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,false Instance.new("UICorner",UI.OBtn).CornerRadius=UDim.new(0,10)table.insert(M.TE.Bgs,UI.OBtn)

UI.MF=Instance.new("Frame",M.SG)UI.MF.Size,UI.MF.Position,UI.MF.BackgroundColor3,UI.MF.Active,UI.MF.Draggable=UDim2.new(0,480,0,530),UDim2.new(0.5,-240,0.5,-265),M.CTh.MBG,true,true Instance.new("UICorner",UI.MF).CornerRadius=UDim.new(0,8)table.insert(M.TE.Bgs,UI.MF)

UI.TB=Instance.new("Frame",UI.MF)UI.TB.Size,UI.TB.BackgroundColor3=UDim2.new(1,0,0,40),M.CTh.TB Instance.new("UICorner",UI.TB).CornerRadius=UDim.new(0,8)table.insert(M.TE.TBs,UI.TB)

UI.PIco=Instance.new("ImageLabel",UI.TB)UI.PIco.Size,UI.PIco.Position,UI.PIco.BackgroundColor3,UI.PIco.BorderSizePixel,UI.PIco.ClipsDescendants=UDim2.new(0,26,0,26),UDim2.new(0,10,0.5,-13),Color3.fromRGB(50,50,50),0,true Instance.new("UICorner",UI.PIco).CornerRadius=UDim.new(1,0)
task.spawn(function()pcall(function()UI.PIco.Image=P:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)end)
UI.Ttl=Instance.new("TextLabel",UI.TB)UI.Ttl.Size,UI.Ttl.Position,UI.Ttl.Text,UI.Ttl.TextColor3,UI.Ttl.Font,UI.Ttl.TextSize,UI.Ttl.BackgroundTransparency,UI.Ttl.TextXAlignment=UDim2.new(1,-80,1,0),UDim2.new(0,45,0,0),"⚡ Vortex Hub V18 - Supreme",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,1,Enum.TextXAlignment.Left
UI.CBn=Instance.new("TextButton",UI.TB)UI.CBn.Size,UI.CBn.Position,UI.CBn.BackgroundTransparency,UI.CBn.Text,UI.CBn.TextColor3,UI.CBn.Font,UI.CBn.TextSize=UDim2.new(0,40,0,40),UDim2.new(1,-40,0,0),1,"X",Color3.fromRGB(200,200,200),Enum.Font.GothamBold,16 UI.CBn.MouseButton1Click:Connect(function()UI.MF.Visible=false UI.OBtn.Visible=true end)UI.OBtn.MouseButton1Click:Connect(function()UI.MF.Visible=true UI.OBtn.Visible=false end)
UI.TC=Instance.new("Frame",UI.MF)UI.TC.Size,UI.TC.Position,UI.TC.BackgroundTransparency=UDim2.new(1,0,0,30),UDim2.new(0,0,0,40),1

-- [ABAS] --
local function cTB(n,px,w)local B=Instance.new("TextButton",UI.TC)B.Size,B.Position,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(w or 0.125,0,1,0),UDim2.new(px,0,0,0),Color3.fromRGB(30,30,30),n,Color3.fromRGB(150,150,150),Enum.Font.GothamBold,10 return B end
UI.tMB,UI.tEB,UI.tPB,UI.tPrB,UI.tHB,UI.tThB,UI.tVB,UI.tDCB=cTB("🔧 Princ.",0,0.125),cTB("👁️ ESPS",0.125,0.125),cTB("👤 Player",0.250,0.125),cTB("🛡️ Prot.",0.375,0.125),cTB("📜 Hist.",0.500,0.125),cTB("🎨 Temas",0.625,0.125),cTB("👀 Viewer & Loop",0.750,0.125),cTB("⚔️ Comb.",0.875,0.125)UI.tMB.BackgroundColor3=Color3.fromRGB(45,45,45)UI.tMB.TextColor3=Color3.fromRGB(255,255,255)

local function cScr(n)local S=Instance.new("ScrollingFrame",UI.MF)S.Size,S.Position,S.BackgroundTransparency,S.ScrollBarThickness,S.Visible=UDim2.new(1,-20,1,-80),UDim2.new(0,10,0,75),1,4,false S.AutomaticCanvasSize=Enum.AutomaticSize.Y local L=Instance.new("UIListLayout",S)L.Padding,L.HorizontalAlignment,L.SortOrder=UDim.new(0,10),Enum.HorizontalAlignment.Center,Enum.SortOrder.LayoutOrder return S end
UI.sM,UI.sE,UI.sP,UI.sPr,UI.sH,UI.sTh,UI.sV,UI.sDC=cScr("SM"),cScr("SE"),cScr("SP"),cScr("SPr"),cScr("SH"),cScr("STh"),cScr("SV"),cScr("SDC")UI.sM.Visible=true

local function sTab(aB,aS)local t={{UI.tMB,UI.sM},{UI.tEB,UI.sE},{UI.tPB,UI.sP},{UI.tPrB,UI.sPr},{UI.tHB,UI.sH},{UI.tThB,UI.sTh},{UI.tVB,UI.sV},{UI.tDCB,UI.sDC}}for _,d in pairs(t)do local b,s=d[1],d[2]if b==aB then b.BackgroundColor3=Color3.fromRGB(45,45,45)b.TextColor3=Color3.fromRGB(255,255,255)s.Visible=true else b.BackgroundColor3=Color3.fromRGB(30,30,30)b.TextColor3=Color3.fromRGB(150,150,150)s.Visible=false end end end
UI.tMB.MouseButton1Click:Connect(function()sTab(UI.tMB,UI.sM)end)UI.tEB.MouseButton1Click:Connect(function()sTab(UI.tEB,UI.sE)end)UI.tPB.MouseButton1Click:Connect(function()sTab(UI.tPB,UI.sP)end)UI.tPrB.MouseButton1Click:Connect(function()sTab(UI.tPrB,UI.sPr)end)UI.tHB.MouseButton1Click:Connect(function()sTab(UI.tHB,UI.sH)end)UI.tThB.MouseButton1Click:Connect(function()sTab(UI.tThB,UI.sTh)end)UI.tVB.MouseButton1Click:Connect(function()sTab(UI.tVB,UI.sV)end)UI.tDCB.MouseButton1Click:Connect(function()sTab(UI.tDCB,UI.sDC)end)

local function cST(n,p)local T=Instance.new("TextLabel",p)T.Size,T.BackgroundTransparency,T.Text,T.TextColor3,T.Font,T.TextSize,T.TextXAlignment=UDim2.new(1,0,0,25),1,n,M.CTh.A,Enum.Font.GothamBlack,13,Enum.TextXAlignment.Left table.insert(M.TE.Txs,T)end
local function cTog(n,p,iS,cb,ck)local F=Instance.new("Frame",p)F.Size,F.BackgroundColor3=UDim2.new(1,0,0,42),Color3.fromRGB(45,45,45)Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)local L=Instance.new("TextLabel",F)L.Size,L.Position,L.Text,L.TextColor3,L.Font,L.TextSize,L.BackgroundTransparency,L.TextXAlignment=UDim2.new(0.7,0,1,0),UDim2.new(0.05,0,0,0),n,Color3.fromRGB(255,255,255),Enum.Font.Gotham,13,1,Enum.TextXAlignment.Left L.RichText = true local SB=Instance.new("Frame",F)SB.Size,SB.Position,SB.BackgroundColor3=UDim2.new(0,40,0,20),UDim2.new(1,-55,0.5,-10),iS and M.CTh.A or Color3.fromRGB(70,70,70)Instance.new("UICorner",SB).CornerRadius=UDim.new(1,0)local SK=Instance.new("Frame",SB)SK.Size,SK.Position,SK.BackgroundColor3=UDim2.new(0,16,0,16),iS and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8),Color3.fromRGB(255,255,255)Instance.new("UICorner",SK).CornerRadius=UDim.new(1,0)local st=iS M.TE.Tgls[SB]=function()return st end local function sVS(ns)st=ns TS:Create(SB,TweenInfo.new(0.2),{BackgroundColor3=st and M.CTh.A or Color3.fromRGB(70,70,70)}):Play()TS:Create(SK,TweenInfo.new(0.2),{Position=st and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8)}):Play()if ck then HC[ck]=st saveC()end end local B=Instance.new("TextButton",F)B.Size,B.BackgroundTransparency,B.Text=UDim2.new(1,0,1,0),1,""B.MouseButton1Click:Connect(function()sVS(not st)cb(st)end)if ck then IC[ck]=function()if st then cb(true)end end end return sVS end

local function sJET(p,et)
    if not V.jelOn then return end 
    local isJ=(et=="JOIN")
    local aC=isJ and Color3.fromRGB(0,255,150)or Color3.fromRGB(255,70,90)
    local tT=isJ and"🟢 ENTRADA"or"🔴 SAÍDA"
    local sT=p.DisplayName.." (@"..p.Name..")"
    local Tst=Instance.new("Frame",M.SG)
    Tst.Size,Tst.BackgroundColor3,Tst.BorderSizePixel,Tst.BackgroundTransparency,Tst.ClipsDescendants=UDim2.new(0,280,0,60),Color3.fromRGB(20,20,25),0,0.05,true 
    Instance.new("UICorner",Tst).CornerRadius=UDim.new(0,10)
    local Sk=Instance.new("UIStroke",Tst)Sk.Color,Sk.Thickness,Sk.Transparency=aC,1.5,0.2 
    local AB=Instance.new("Frame",Tst)AB.Size,AB.BackgroundColor3,AB.BorderSizePixel=UDim2.new(0,4,1,0),aC,0 
    Instance.new("UICorner",AB).CornerRadius=UDim.new(0,10)
    local Im=Instance.new("ImageLabel",Tst)Im.Size,Im.Position,Im.BackgroundColor3,Im.BackgroundTransparency,Im.BorderSizePixel=UDim2.new(0,42,0,42),UDim2.new(0,12,0.5,-21),Color3.fromRGB(30,30,38),0.2,0 
    Instance.new("UICorner",Im).CornerRadius=UDim.new(1,0)
    Instance.new("UIStroke",Im).Color=aC 
    task.spawn(function()pcall(function()local c=P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)if c then Im.Image=c end end)end)
    local TL=Instance.new("TextLabel",Tst)TL.Size,TL.Position,TL.BackgroundTransparency,TL.Text,TL.TextColor3,TL.Font,TL.TextSize,TL.TextXAlignment=UDim2.new(1,-65,0,20),UDim2.new(0,62,0,10),1,tT,aC,Enum.Font.GothamBlack,11,Enum.TextXAlignment.Left 
    local ML=Instance.new("TextLabel",Tst)ML.Size,ML.Position,ML.BackgroundTransparency,ML.Text,ML.TextColor3,ML.Font,ML.TextSize,ML.TextTruncate,ML.TextXAlignment=UDim2.new(1,-68,0,20),UDim2.new(0,62,0,28),1,sT,Color3.fromRGB(245,245,255),Enum.Font.GothamBold,12,Enum.TextTruncate.AtEnd,Enum.TextXAlignment.Left 
    table.insert(M.AJT,Tst)
    local tY=-85-(#M.AJT-1)*68 
    Tst.Position=UDim2.new(1,20,1,tY)
    TS:Create(Tst,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-295,1,tY)}):Play()
    task.delay(4,function()
        if Tst.Parent then 
            local oT=TS:Create(Tst,TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,Tst.Position.Y.Offset),BackgroundTransparency=1})
            oT:Play()
            oT.Completed:Connect(function()
                pcall(function() Tst:Destroy() end)
                for i,v in ipairs(M.AJT)do if v==Tst then table.remove(M.AJT,i)break end end 
                for i,v in ipairs(M.AJT)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-295,1,-85-((i-1)*68))}):Play()end 
            end)
        end 
    end)
end

local function openPlayerProfileModal(p)
    local ModalBg = Instance.new("Frame", M.SG)
    ModalBg.Size, ModalBg.Position, ModalBg.BackgroundColor3, ModalBg.BackgroundTransparency = UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Color3.fromRGB(0,0,0), 1
    ModalBg.ZIndex = 200
    
    local BlurEffect = Instance.new("BlurEffect", L)
    BlurEffect.Size = 15
    BlurEffect.Name = "VortexProfileBlur"
    
    local Card = Instance.new("Frame", ModalBg)
    Card.Size, Card.Position, Card.BackgroundColor3 = UDim2.new(0,380,0,240), UDim2.new(0.5,-190,0.5,-120), Color3.fromRGB(22,22,28)
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0,14)
    local CardStroke = Instance.new("UIStroke", Card)
    CardStroke.Color, CardStroke.Thickness = M.CTh.A, 1.5
    Card.Active = true
    
    local TopHeader = Instance.new("Frame", Card)
    TopHeader.Size, TopHeader.BackgroundColor3, TopHeader.BorderSizePixel = UDim2.new(1,0,0,45), Color3.fromRGB(28,28,36), 0
    Instance.new("UICorner", TopHeader).CornerRadius = UDim.new(0,14)
    
    local TitleModal = Instance.new("TextLabel", TopHeader)
    TitleModal.Size, TitleModal.Position, TitleModal.BackgroundTransparency, TitleModal.Text, TitleModal.TextColor3, TitleModal.Font, TitleModal.TextSize = UDim2.new(1,-50,1,0), UDim2.new(0,16,0,0), 1, "⚡ Perfil do Jogador", Color3.fromRGB(255,255,255), Enum.Font.GothamBold, 15
    TitleModal.TextXAlignment = Enum.TextXAlignment.Left
    
    local CloseBtn = Instance.new("TextButton", TopHeader)
    CloseBtn.Size, CloseBtn.Position, CloseBtn.BackgroundTransparency, CloseBtn.Text, CloseBtn.TextColor3, CloseBtn.Font, CloseBtn.TextSize = UDim2.new(0,35,0,35), UDim2.new(1,-40,0.5,-17.5), 1, "✕", Color3.fromRGB(200,200,210), Enum.Font.GothamBold, 16
    CloseBtn.MouseButton1Click:Connect(function()
        if BlurEffect then pcall(function() BlurEffect:Destroy() end) end
        pcall(function() ModalBg:Destroy() end)
    end)
    
    local AvatarBg = Instance.new("Frame", Card)
    AvatarBg.Size, AvatarBg.Position, AvatarBg.BackgroundColor3, AvatarBg.BorderSizePixel = UDim2.new(0,85,0,85), UDim2.new(0,18,0,60), Color3.fromRGB(30,30,38), 0
    Instance.new("UICorner", AvatarBg).CornerRadius = UDim.new(1,0)
    local AvStk = Instance.new("UIStroke", AvatarBg)
    AvStk.Color, AvStk.Thickness = M.CTh.A, 2
    
    local AvatarImg = Instance.new("ImageLabel", AvatarBg)
    AvatarImg.Size, AvatarImg.Position, AvatarImg.BackgroundTransparency = UDim2.new(1,-6,1,-6), UDim2.new(0,3,0,3), 1
    Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1,0)
    task.spawn(function()
        pcall(function()
            local thumb = P:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            if thumb then AvatarImg.Image = thumb end
        end)
    end)
    
    local CreationLbl = Instance.new("TextLabel", Card)
    CreationLbl.Size, CreationLbl.Position, CreationLbl.BackgroundTransparency, CreationLbl.Text, CreationLbl.TextColor3, CreationLbl.Font, CreationLbl.TextSize = UDim2.new(0,105,0,50), UDim2.new(0,8,0,152), 1, "📅 Criado em:\nCalculando...", Color3.fromRGB(150,150,165), Enum.Font.Gotham, 10
    CreationLbl.TextWrapped = true
    CreationLbl.TextXAlignment = Enum.TextXAlignment.Center
    
    task.spawn(function()
        pcall(function()
            local daysAgo = p.AccountAge or 0
            local approxUnix = os.time() - (daysAgo * 86400)
            local formattedDate = os.date("%d/%m/%Y", approxUnix)
            CreationLbl.Text = "📅 Criado em:\n"..formattedDate.." ("..daysAgo.." dias)"
        end)
    end)
    
    local NameLbl = Instance.new("TextLabel", Card)
    NameLbl.Size, NameLbl.Position, NameLbl.BackgroundTransparency, NameLbl.Text, NameLbl.TextColor3, NameLbl.Font, NameLbl.TextSize = UDim2.new(1,-130,0,24), UDim2.new(0,120,0,58), 1, p.DisplayName, Color3.fromRGB(255,255,255), Enum.Font.GothamBold, 15
    NameLbl.TextXAlignment = Enum.TextXAlignment.Left
    NameLbl.TextTruncate = Enum.TextTruncate.AtEnd
    
    local UserLbl = Instance.new("TextLabel", Card)
    UserLbl.Size, UserLbl.Position, UserLbl.BackgroundTransparency, UserLbl.Text, UserLbl.TextColor3, UserLbl.Font, UserLbl.TextSize = UDim2.new(1,-130,0,20), UDim2.new(0,120,0,82), 1, "@"..p.Name, Color3.fromRGB(170,170,185), Enum.Font.Gotham, 12
    UserLbl.TextXAlignment = Enum.TextXAlignment.Left
    UserLbl.TextTruncate = Enum.TextTruncate.AtEnd
    
    local IdLbl = Instance.new("TextLabel", Card)
    IdLbl.Size, IdLbl.Position, IdLbl.BackgroundTransparency, IdLbl.Text, IdLbl.TextColor3, IdLbl.Font, IdLbl.TextSize = UDim2.new(1,-130,0,20), UDim2.new(0,120,0,105), 1, "ID: "..tostring(p.UserId), Color3.fromRGB(90,210,255), Enum.Font.GothamBold, 12
    IdLbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local CopyBtn = Instance.new("TextButton", Card)
    CopyBtn.Size, CopyBtn.Position, CopyBtn.BackgroundColor3, CopyBtn.Text, CopyBtn.TextColor3, CopyBtn.Font, CopyBtn.TextSize = UDim2.new(1,-36,0,38), UDim2.new(0,18,1,-48), M.CTh.A, "📋 Copiar ID do Jogador", Color3.fromRGB(255,255,255), Enum.Font.GothamBold, 13
    Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0,8)
    CopyBtn.MouseButton1Click:Connect(function()
        if typeof(setclipboard)=="function" then
            pcall(function() setclipboard(tostring(p.UserId)) end)
            sNotif("Copiado", "ID copiado para a área de transferência!", "Success")
        else
            sNotif("Erro", "Seu executor não suporta setclipboard.", "Error")
        end
    end)
end

cST("📜 HISTÓRICO DE ENTRADAS E SAÍDAS", M.sH)
cTog("🔔 Notificações", M.sH, V.jelOn, function(s) V.jelOn = s end, "Notifications")

local HistoryListFrame = Instance.new("ScrollingFrame", M.sH)
HistoryListFrame.Size, HistoryListFrame.Position, HistoryListFrame.BackgroundTransparency, HistoryListFrame.ScrollBarThickness, HistoryListFrame.CanvasSize = UDim2.new(1,0,0,2500), UDim2.new(0,0,0,70), 1, 4, UDim2.new(0,0,0,0)
local HistoryLayout = Instance.new("UIListLayout", HistoryListFrame)
HistoryLayout.Padding, HistoryLayout.HorizontalAlignment, HistoryLayout.SortOrder = UDim.new(0,8), Enum.HorizontalAlignment.Center, Enum.SortOrder.LayoutOrder
HistoryLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HistoryListFrame.CanvasSize = UDim2.new(0,0,0,HistoryLayout.AbsoluteContentSize.Y+15)
end)

M.trackedHistoryUsers = {}
local function aLH(p, et)
    if not p then return end
    if et == "JOIN" and M.trackedHistoryUsers[p.UserId] then return end
    if et == "JOIN" then M.trackedHistoryUsers[p.UserId] = true end
    if et == "EXIT" then M.trackedHistoryUsers[p.UserId] = nil end

    local ts, isJ = os.date("%H:%M:%S"), et=="JOIN" 
    local aC = isJ and Color3.fromRGB(0,230,120) or Color3.fromRGB(255,65,85)
    local bC = isJ and Color3.fromRGB(25,42,32) or Color3.fromRGB(42,22,26)
    sJET(p, et)
    
    local IF = Instance.new("TextButton", HistoryListFrame)
    IF.Size, IF.BackgroundColor3, IF.AutoButtonColor, IF.Text = UDim2.new(1,-10,0,52), Color3.fromRGB(30,30,35), true, ""
    Instance.new("UICorner", IF).CornerRadius = UDim.new(0,8)
    Instance.new("UIStroke", IF).Color = aC 
    
    IF.MouseButton1Click:Connect(function()
        openPlayerProfileModal(p)
    end)
    
    local SB = Instance.new("Frame", IF)
    SB.Size, SB.BackgroundColor3, SB.BorderSizePixel = UDim2.new(0,5,1,0), aC, 0 
    Instance.new("UICorner", SB).CornerRadius = UDim.new(0,8)
    
    local AB = Instance.new("ImageLabel", IF)
    AB.Size, AB.Position, AB.BackgroundColor3, AB.BorderSizePixel = UDim2.new(0,36,0,36), UDim2.new(0,12,0.5,-18), bC, 0 
    Instance.new("UICorner", AB).CornerRadius = UDim.new(1,0)
    Instance.new("UIStroke", AB).Color = aC 
    task.spawn(function()
        pcall(function()
            local c = P:GetUserThumbnailAsync(p.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            if c then AB.Image = c end 
        end)
    end)
    
    local NL = Instance.new("TextLabel", IF)
    NL.Size, NL.Position, NL.BackgroundTransparency, NL.Text, NL.TextColor3, NL.Font, NL.TextSize, NL.TextXAlignment, NL.TextTruncate = UDim2.new(1,-185,0,20), UDim2.new(0,56,0,8), 1, p.DisplayName.." (@"..p.Name..")", Color3.fromRGB(255,255,255), Enum.Font.GothamBold, 12, Enum.TextXAlignment.Left, Enum.TextTruncate.AtEnd 
    
    local TiL = Instance.new("TextLabel", IF)
    TiL.Size, TiL.Position, TiL.BackgroundTransparency, TiL.Text, TiL.TextColor3, TiL.Font, TiL.TextSize, TiL.TextXAlignment = UDim2.new(1,-185,0,16), UDim2.new(0,56,0,28), 1, "🕒 Horário: "..ts.." | ID: "..tostring(p.UserId), Color3.fromRGB(160,160,170), Enum.Font.Gotham, 10, Enum.TextXAlignment.Left 
    
    local TBx = Instance.new("Frame", IF)
    TBx.Size, TBx.Position, TBx.BackgroundColor3, TBx.BorderSizePixel = UDim2.new(0,110,0,26), UDim2.new(1,-118,0.5,-13), bC, 0 
    Instance.new("UICorner", TBx).CornerRadius = UDim.new(0,6)
    Instance.new("UIStroke", TBx).Color = aC 
    
    local TLL = Instance.new("TextLabel", TBx)
    TLL.Size, TLL.BackgroundTransparency, TLL.Text, TLL.TextColor3, TLL.Font, TLL.TextSize = UDim2.new(1,0,1,0), 1, isJ and "🟢 CONECTOU" or "🔴 DESCONECTOU", aC, Enum.Font.GothamBlack, 9 
end

for _, p in ipairs(P:GetPlayers()) do
    if p ~= LP then
        aLH(p, "JOIN")
    end
end

local function cSli(n,rT,mV,mxV,cV,p,cb,ck)local SF=Instance.new("Frame",p)SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,65),Color3.fromRGB(42,42,45)Instance.new("UICorner",SF).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",SF).Color=Color3.fromRGB(60,60,65)local TL=Instance.new("TextLabel",SF)TL.Size,TL.Position,TL.Text,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,12,0,6),n.." [ "..tostring(cV).." ]",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left local RL=Instance.new("TextLabel",SF)RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,24),"Recomendado: "..rT,Color3.fromRGB(160,160,165),Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left local Tk=Instance.new("Frame",SF)Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,46),Color3.fromRGB(25,25,28)Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)local pI=math.clamp((cV-mV)/(mxV-mV),0,1)local F=Instance.new("Frame",Tk)F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),M.CTh.A Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)table.insert(M.TE.Accs,F)local K=Instance.new("Frame",Tk)K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)local KS=Instance.new("UIStroke",K)KS.Color,KS.Thickness=M.CTh.A,2 table.insert(M.TE.Accs,KS)local HB=Instance.new("TextButton",SF)HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""local d=false local function upd(ip)local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)local pc=pX/Tk.AbsoluteSize.X local vl=math.floor(mV+(mxV-mV)*pc)TS:Create(F,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(pc,0,1,0)}):Play()TS:Create(K,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(pc,0,0.5,0)}):Play()TL.Text=n.." [ "..tostring(vl).." ]"if ck then HC[ck]=vl saveC()end cb(vl)end HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)UIS.InputChanged:Connect(function(ip)if d and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then upd(ip)end end)if ck then IC[ck]=function()cb(cV)end end end
local function cTSli(mV,mxV,cV,p,cb)local SF=Instance.new("Frame",p)SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,65),Color3.fromRGB(42,42,45)Instance.new("UICorner",SF).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",SF).Color=Color3.fromRGB(60,60,65)local TL=Instance.new("TextLabel",SF)TL.Size,TL.Position,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0,12,0,6),Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left local TiL=Instance.new("TextLabel",SF)TiL.Size,TiL.Position,TiL.TextColor3,TiL.Font,TiL.TextSize,TiL.BackgroundTransparency,TiL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0.5,0,0,6),M.CTh.A,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Right table.insert(M.TE.Txs,TiL)local RL=Instance.new("TextLabel",SF)RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,24),"Arraste para ajustar",Color3.fromRGB(160,160,165),Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left local Tk=Instance.new("Frame",SF)Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,46),Color3.fromRGB(25,25,28)Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)local pI=math.clamp((cV-mV)/(mxV-mV),0,1)local F=Instance.new("Frame",Tk)F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),M.CTh.A Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)table.insert(M.TE.Accs,F)local K=Instance.new("Frame",Tk)K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)local KS=Instance.new("UIStroke",K)KS.Color,KS.Thickness=M.CTh.A,2 table.insert(M.TE.Accs,KS)local function fUI(v)local h,m=math.floor(v),math.floor((v-math.floor(v))*60)local pt="Noite 🌙"if h>=6 and h<13 then pt="Dia ☀️"elseif h>=13 and h<18 then pt="Tarde 🌤️"end TL.Text="Período: "..pt TiL.Text=string.format("%02d:%02d",h,m)end fUI(cV)local HB=Instance.new("TextButton",SF)HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""local d=false local function upd(ip)local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)local pc=pX/Tk.AbsoluteSize.X local vl=mV+(mxV-mV)*pc TS:Create(F,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(pc,0,1,0)}):Play()TS:Create(K,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(pc,0,0.5,0)}):Play()fUI(vl)cb(vl)end HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)UIS.InputChanged:Connect(function(ip)if d and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then upd(ip)end end)return function(nV,ig)if d and ig then return end local pc=math.clamp((nV-mV)/(mxV-mV),0,1)F.Size=UDim2.new(pc,0,1,0)K.Position=UDim2.new(pc,0,0.5,0)fUI(nV)end end
local function cEGui(tM)local r,h=tM:FindFirstChild("HumanoidRootPart"),tM:FindFirstChildOfClass("Humanoid")if not r or not h then return nil end local bg=Instance.new("BillboardGui")bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="ESPGui",r,UDim2.new(0,400,0,45),Vector3.new(0,3.5,0),true,M.SG local el=Instance.new("TextLabel",bg)el.Size,el.BackgroundTransparency,el.RichText,el.TextStrokeTransparency,el.Font,el.TextSize,el.TextYAlignment=UDim2.new(1,0,1,0),1,true,0.5,Enum.Font.GothamBold,13,Enum.TextYAlignment.Center return{Gui=bg,Humanoid=h,Root=r,Label=el,Model=tM}end
local function cETb(tb)for k,d in pairs(tb)do if d.Gui then pcall(function() d.Gui:Destroy() end)end end table.clear(tb)end

-- [ESP OTIMIZADO COM THROTTLING E DISTÂNCIA] --
local function uESP()
    if M.eUp then M.eUp:Disconnect() M.eUp = nil end
    if not V.enOn and not V.epOn then return end
    
    M.eUp = RS.Heartbeat:Connect(function(dt)
        local lC = LP.Character
        local lR = lC and lC:FindFirstChild("HumanoidRootPart")
        if not lR then return end
        
        M.espUpdateClock = M.espUpdateClock + dt
        local shouldUpdateText = M.espUpdateClock >= 0.15
        if shouldUpdateText then
            M.espUpdateClock = 0
        end
        
        if V.epOn then
            for _, p in pairs(P:GetPlayers()) do
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                    if isFriend(p) then
                        if M.tPly[p] then
                            if M.tPly[p].Gui then pcall(function() M.tPly[p].Gui:Destroy() end) end
                            M.tPly[p] = nil
                        end
                        continue
                    end
                    if not M.tPly[p] or M.tPly[p].Model ~= p.Character then
                        if M.tPly[p] and M.tPly[p].Gui then pcall(function() M.tPly[p].Gui:Destroy() end) end
                        M.tPly[p] = cEGui(p.Character)
                    end
                end
            end
            for p, d in pairs(M.tPly) do
                if not p or not p.Parent or not p.Character or not d.Humanoid or d.Humanoid.Health <= 0 or d.Model ~= p.Character or isFriend(p) then
                    if d.Gui then pcall(function() d.Gui:Destroy() end) end
                    M.tPly[p] = nil
                else
                    local dist = (lR.Position - d.Root.Position).Magnitude
                    if dist > V.espMaxDistance then
                        if d.Gui.Enabled then d.Gui.Enabled = false end
                    else
                        if not d.Gui.Enabled then d.Gui.Enabled = true end
                        if shouldUpdateText then
                            local hS = math.floor(d.Humanoid.Health)
                            d.Label.Text = string.format('<b><font color="%s">%s</font> | <font color="%s">HP: %s</font> | <font color="%s">%d studs</font></b>', ECol.PName, p.Name, ECol.PHP, hS, ECol.PDist, math.floor(dist))
                        end
                    end
                end
            end
        else
            if next(M.tPly) then cETb(M.tPly) end
        end
        
        if V.enOn then
            for m in pairs(M.CNPCs) do
                if m.Parent and not M.tNPC[m] then
                    M.tNPC[m] = cEGui(m)
                end
            end
            for m, d in pairs(M.tNPC) do
                if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health <= 0 or not M.CNPCs[m] then
                    if d.Gui then pcall(function() d.Gui:Destroy() end) end
                    M.tNPC[m] = nil
                else
                    local dist = (lR.Position - d.Root.Position).Magnitude
                    if dist > V.espMaxDistance then
                        if d.Gui.Enabled then d.Gui.Enabled = false end
                    else
                        if not d.Gui.Enabled then d.Gui.Enabled = true end
                        if shouldUpdateText then
                            d.Label.Text = string.format('<b><font color="%s">NAME: %s</font><br /><font color="%s">HP: %s</font><br /><font color="%s">Dist: %s</font></b>', ECol.NName, m.Name, ECol.NHP, math.floor(d.Humanoid.Health), ECol.NDist, math.floor(dist))
                        end
                    end
                end
            end
        else
            if next(M.tNPC) then cETb(M.tNPC) end
        end
    end)
end

local function iHN(n)if not n:FindFirstChild("Humanoid")or P:GetPlayerFromCharacter(n)or n.Humanoid.Health<=0 then return false end for _,c in ipairs(n:GetChildren())do if c:IsA("Tool")then return true end end local nm,h=string.lower(n.Name),{"zombie","enemy","boss","killer","monster","soldier","mutant","dummy","bot","hostile","demon","beast","guard","slayer","vampire","werewolf","criminal","thief","attacker","infect","scp","entity","nextbot"}for _,v in ipairs(h)do if string.find(nm,v)then return true end end if n.Humanoid.MaxHealth>105 and n.Humanoid.MaxHealth<math.huge then return true end for _,d in ipairs(n:GetDescendants())do if d:IsA("Script")or d:IsA("LocalScript")then local s=string.lower(d.Name)if string.find(s,"damage")or string.find(s,"kill")or string.find(s,"attack")then return true end end end return false end
local function cDEsp(m)local r=m:FindFirstChild("HumanoidRootPart")if not r then return end local bg=Instance.new("BillboardGui")bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="DangerESP",r,UDim2.new(0,40,0,40),Vector3.new(0,6,0),true,M.SG local ic=Instance.new("TextLabel",bg)ic.Size,ic.BackgroundTransparency,ic.Text,ic.TextSize=UDim2.new(1,0,1,0),1,"⚠️",16 task.spawn(function()while bg.Parent do TS:Create(ic,TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{TextSize=22}):Play()break end end)return{Gui=bg,Model=m,Humanoid=m:FindFirstChild("Humanoid")}end
local function uDEsp()if M.dUp then M.dUp:Disconnect() M.dUp=nil end if not V.dEspOn then return end M.dUp=RS.Heartbeat:Connect(function()for m in pairs(M.CNPCs)do if m.Parent and not M.tDNPC[m]and iHN(m)then M.tDNPC[m]=cDEsp(m)end end for m,d in pairs(M.tDNPC)do if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not M.CNPCs[m]then if d.Gui then pcall(function() d.Gui:Destroy() end)end M.tDNPC[m]=nil end end end)end
local function rLig()L.FogStart,L.FogEnd,L.FogColor,L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale=M.OL.FS,M.OL.FE,M.OL.FC,M.OL.A,M.OL.OA,M.OL.B,M.OL.GS,M.OL.EDS,M.OL.ESS pcall(function()L.ShadowSoftness,L.Technology=M.OL.SS,M.OL.T end)if L:FindFirstChild("VortexAtmosphere")then pcall(function() L.VortexAtmosphere:Destroy() end)end end

-- [SHADERS] --
local function uLig()
    if V.fpsOn then 
        if C.sLp then C.sLp:Disconnect() C.sLp=nil end 
        L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale,L.GlobalShadows=0,0,false 
        clrCE()rLig()
    elseif V.shOn then 
        L.GlobalShadows=true 
        pcall(function()L.Technology,L.ShadowSoftness=Enum.Technology.Future,0.1 end)
        L.EnvironmentSpecularScale,L.EnvironmentDiffuseScale=1.2,1.2 
        if not L:FindFirstChild("VortexCC")then 
            local CC=Instance.new("ColorCorrectionEffect",L)CC.Name,CC.Contrast,CC.Saturation,CC.Brightness="VortexCC",0.15,0.2,0.02 
            local B=Instance.new("BloomEffect",L)B.Name,B.Intensity,B.Size,B.Threshold="VortexBloom",0.15,25,2 
            local S=Instance.new("SunRaysEffect",L)S.Name,S.Intensity,S.Spread="VortexSunRays",0.05,0.8 
            local A=Instance.new("Atmosphere",L)A.Name,A.Density,A.Offset,A.Glare,A.Haze="VortexAtmosphere",0,0.25,1,1 
        end 
        local wB=L:FindFirstChild("VortexWallBlur")
        if not wB then wB=Instance.new("BlurEffect",L)wB.Name,wB.Size="VortexWallBlur",0 end 
        if not C.sLp then 
            local rP=RaycastParams.new()rP.FilterType=Enum.RaycastFilterType.Exclude 
            C.sLp=RS.RenderStepped:Connect(function()
                if M.pDead or V.fbOn then return end 
                local t,n,c,cam=L.ClockTime,false,W.CurrentCamera 
                if t>=18.2 or t<=6.2 then n=true end 
                local tB,i=0,false 
                if c and cam then 
                    rP.FilterDescendantsInstances={c,cam}
                    local hrp=c:FindFirstChild("HumanoidRootPart")
                    if hrp then i=cInd(hrp,rP)end 
                    local dB=gPB(cam,c)
                    if dB>tB then tB=dB end 
                end 

                local a,oa,fs,fe,fc,ad,ac 
                if i and n then 
                    a,oa=Color3.fromRGB(5,5,8),Color3.fromRGB(2,2,5) 
                    local cr=Color3.fromRGB(8,12,18) 
                    if V.fgOn then fs,fe,fc,ad,ac=0,90,cr,0.95,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                elseif i then 
                    a,oa=Color3.fromRGB(15,15,20),Color3.fromRGB(10,10,15) 
                    local cr=Color3.fromRGB(18,22,30) 
                    if V.fgOn then fs,fe,fc,ad,ac=10,220,cr,0.80,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                elseif n then 
                    a,oa=Color3.fromRGB(25,30,45),Color3.fromRGB(20,25,35) 
                    local cr=Color3.fromRGB(35,45,65) 
                    if V.fgOn then fs,fe,fc,ad,ac=80,800,cr,0.45,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                else 
                    a,oa=Color3.fromRGB(105,105,110),Color3.fromRGB(135,135,145) 
                    local cr=Color3.fromRGB(200,220,240) 
                    if V.fgOn then fs,fe,fc,ad,ac=200,4000,cr,0.15,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                end 

                L.Ambient,L.OutdoorAmbient,L.FogStart,L.FogEnd,L.FogColor=L.Ambient:Lerp(a,0.08),L.OutdoorAmbient:Lerp(oa,0.08),L.FogStart+(fs-L.FogStart)*0.08,L.FogEnd+(fe-L.FogEnd)*0.08,L.FogColor:Lerp(fc,0.08)
                local atm=L:FindFirstChild("VortexAtmosphere")
                if atm then atm.Density,atm.Color=atm.Density+(ad-atm.Density)*0.08,atm.Color:Lerp(ac,0.08)end 
                local cb=L:FindFirstChild("VortexWallBlur")
                if cb then cb.Size=tB>cb.Size and tB or cb.Size+(tB-cb.Size)*0.2 end 
            end)
        end 
    else 
        if C.sLp then C.sLp:Disconnect() C.sLp=nil end 
        clrCE()rLig()
        if V.fgOn then L.FogStart,L.FogEnd,L.FogColor=100,2000,Color3.fromRGB(200,215,230)end 
    end 
end

local function eAF()if C.afc then C.afc:Disconnect()end C.afc=RS.Stepped:Connect(function()if not V.afOn then return end local c=LP.Character if not c then return end for _,p in pairs(c:GetChildren())do if p:IsA("BasePart")then if p.Velocity.Magnitude>1000 then p.Velocity=Vector3.new(0,0,0)end if p.RotVelocity.Magnitude>1000 then p.RotVelocity=Vector3.new(0,0,0)end end end for _,op in pairs(P:GetPlayers())do if op~=LP and op.Character then if isFriend(op) then continue end for _,oprt in pairs(op.Character:GetChildren())do if oprt:IsA("BasePart")then oprt.CanCollide=false if oprt.Velocity.Magnitude>100 then oprt.Velocity=Vector3.new(0,0,0)end if oprt.RotVelocity.Magnitude>100 then oprt.RotVelocity=Vector3.new(0,0,0)end end end end end end)end

cST("✨ GRÁFICOS",UI.sM)local stU,ftU stU=cTog("✨ Shaders",UI.sM,V.shOn,function(s)V.shOn=s uLig()end,"Shaders")

local function applyBoostState(state)
    if V.fpsOn == state then return end
    V.fpsOn = state
    HC.FpsBoost = state
    saveC()
    if state then
        if V.shOn then
            V.shOn = false
            HC.Shaders = false
            saveC()
        end
        L.EnvironmentDiffuseScale = 0
        L.EnvironmentSpecularScale = 0
        L.GlobalShadows = false
        clrCE()
        rLig()
        task.spawn(function()
            for _, obj in ipairs(W:GetDescendants()) do
                if obj:IsA("BasePart") then
                    if not M.originalPartsData[obj] then
                        M.originalPartsData[obj] = {Material = obj.Material, Reflectance = obj.Reflectance}
                    end
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                elseif obj:IsA("Decal") or obj:IsA("Texture") then
                    if not M.originalPartsData[obj] then
                        M.originalPartsData[obj] = {Transparency = obj.Transparency}
                    end
                    obj.Transparency = 1
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                    if not M.originalPartsData[obj] then
                        M.originalPartsData[obj] = {Enabled = obj.Enabled}
                    end
                    obj.Enabled = false
                end
            end
        end)
    else
        uLig()
        task.spawn(function()
            for obj, data in pairs(M.originalPartsData) do
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
            table.clear(M.originalPartsData)
        end)
    end
end

ftU=cTog("🥔 Booster FPS",UI.sM,V.fpsOn,function(s)
    if s and V.shOn then 
        sNotif("Erro","Desative Shaders primeiro.","Error")
        V.fpsOn=false 
        if ftU then ftU(false) end 
        return 
    end 
    applyBoostState(s)
    if s then
        sNotif("FPS Booster", "Qualidade reduzida para máxima mobilidade e desempenho!", "Success")
    else
        sNotif("FPS Booster", "Booster FPS desativado. Qualidade restaurada.", "Info")
    end
end,"FpsBoost")

cTog("🌫️ Desfoque Parede",UI.sM,V.wbOn,function(s)V.wbOn=s if not s then local b=L:FindFirstChild("VortexWallBlur")if b then b.Size=0 end end end,"WallBlur")cTog("🌫️ Neblina",UI.sM,V.fgOn,function(s)V.fgOn=s uLig()end,"Fog")
cTog("🌀 Motion Blur",UI.sM,V.mbOn,function(s)if s then local b=Instance.new("BlurEffect",L)b.Name,b.Size="VortexMotionBlur",0 local c=W.CurrentCamera if c then M.lCR=c.CFrame-c.CFrame.Position end C.mbc=RS.RenderStepped:Connect(function()local cam=W.CurrentCamera if not cam then return end local rot=cam.CFrame-cam.CFrame.Position local d=rot.LookVector:Dot(M.lCR.LookVector)local a=math.acos(math.clamp(d,-1,1))local tB=math.clamp(math.deg(a)*1.5,0,30)b.Size,M.lCR=b.Size+(tB-b.Size)*0.2,rot end)else if C.mbc then C.mbc:Disconnect()C.mbc=nil end local b=L:FindFirstChild("VortexMotionBlur")if b then pcall(function() b:Destroy() end)end end end,"MotionBlur")

cTog("☀️ Fullbright",UI.sM,V.fbOn,function(s)
    V.fbOn=s
    HC.Fullbright=s
    saveC()
    if s then
        if C.fbConn then C.fbConn:Disconnect() end
        C.fbConn=RS.RenderStepped:Connect(function()
            if not V.fbOn then return end
            L.Brightness = 2
            L.GlobalShadows = false
            L.Ambient = Color3.new(1, 1, 1)
            L.OutdoorAmbient = Color3.new(1, 1, 1)
            L.ColorShift_Bottom = Color3.new(1, 1, 1)
            L.ColorShift_Top = Color3.new(1, 1, 1)
            pcall(function() L.FogEnd = 100000 end)
        end)
        sNotif("Fullbright", "Iluminação máxima ativada para mapas escuros!", "Success")
    else
        if C.fbConn then C.fbConn:Disconnect() C.fbConn=nil end
        rLig()
        sNotif("Fullbright", "Fullbright desativado.", "Info")
    end
end,"Fullbright")

cTog("🔦 Luz Player",UI.sM,V.plOn,function(s)V.plOn=s if s then C.plc=RS.Heartbeat:Connect(function()local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local h=c.HumanoidRootPart if not h:FindFirstChild("VortexPlayerLight")then local l=Instance.new("PointLight",h)l.Name,l.Brightness,l.Range,l.Shadows,l.Color="VortexPlayerLight",3,60,false,Color3.new(1,1,1)end end end)else if C.plc then C.plc:Disconnect()C.plc=nil end local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local l=c.HumanoidRootPart:FindFirstChild("VortexPlayerLight")if l then pcall(function() l:Destroy() end)end end end end,"PlayerLight")

cST("⏰ TEMPO",UI.sM)local uTSUI local mtLp local manualT=L.ClockTime 
cTog("🔄 Auto Tempo",UI.sM,V.atOn,function(s)V.atOn=s if s then if M.mtLp then M.mtLp:Disconnect()M.mtLp=nil end C.atc=RS.RenderStepped:Connect(function(dt)L.ClockTime=(L.ClockTime+(0.4*dt))%24 manualT=L.ClockTime if uTSUI then uTSUI(L.ClockTime,true)end end)else if C.atc then C.atc:Disconnect()C.atc=nil end if not M.mtLp then M.mtLp=RS.RenderStepped:Connect(function()L.ClockTime=manualT end)end end end,"AutoTime")
uTSUI=cTSli(0,24,L.ClockTime,UI.sM,function(v)manualT=v L.ClockTime=v end)
if not V.atOn then M.mtLp=RS.RenderStepped:Connect(function()L.ClockTime=manualT end)end

local function stpR()if M.rEmt then M.rEmt.Enabled=false end end
local function stRt()if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart")then return end if not M.rPrt then M.rPrt=Instance.new("Part")M.rPrt.Name="VtxRain"M.rPrt.Anchored=true M.rPrt.CanCollide=false M.rPrt.Transparency=1 M.rPrt.Size=Vector3.new(150,1,150)M.rPrt.Parent=W M.rEmt=Instance.new("ParticleEmitter",M.rPrt)M.rEmt.Texture="rbxassetid://2273224484"M.rEmt.Rate=600 M.rEmt.Speed=NumberRange.new(60,80)M.rEmt.Lifetime=NumberRange.new(1.5,2.5)M.rEmt.EmissionDirection=Enum.NormalId.Bottom M.rEmt.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,0.3)})M.rEmt.Color=ColorSequence.new(Color3.fromRGB(150,170,200))M.rEmt.Transparency=NumberSequence.new(0.5)end task.spawn(function()M.rEmt.Enabled=true local d=math.random(10,20)local sT=tick()while V.rrOn and(tick()-sT<d)and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")do M.rPrt.CFrame=LP.Character.HumanoidRootPart.CFrame*CFrame.new(0,50,0)task.wait(0.1)end stpR()end)end
cTog("🌧️ Chuva Aleatória (15% Chance)",UI.sM,V.rrOn,function(s)V.rrOn=s if s then C.rainLoop=task.spawn(function()while V.rrOn do task.wait(5)if math.random(1,100)<=15 then stRt()task.wait(25)end end end)else if C.rainLoop then task.cancel(C.rainLoop)C.rainLoop=nil end stpR()end end,"RandomRain")

cST("👁️ ESP",UI.sE)
cTog("👤 ESP Player",UI.sE,V.epOn,function(s)V.epOn=s if not s then cETb(M.tPly)end uESP()end,"ESPPlayer")
cTog("🤖 ESP NPC",UI.sE,V.enOn,function(s)V.enOn=s if not s then cETb(M.tNPC)end uESP()end,"ESPNPC")
cTog("⚠️ Alerta NPC Hostil",UI.sE,V.dEspOn,function(s)V.dEspOn=s if not s then cETb(M.tDNPC)end uDEsp()end,"DangerESP")

-- [NOVO SLIDER DE DISTÂNCIA DO ESP] --
cSli("O QUÃO LONGE O ESP VAI", "0 a 1000 studs", 0, 1000, V.espMaxDistance, UI.sE, function(v)
    V.espMaxDistance = v
    HC.ESPMaxDistance = v
    saveC()
end, "ESPMaxDistance")

cST("🎨 CORES",UI.sE)local function cECBtn(n,c3,hc)local b=Instance.new("TextButton",UI.sE)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,32),Color3.fromRGB(45,45,45),"🎨 "..n,c3,Enum.Font.GothamBold,12 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(function()ECol.PName,ECol.NName=hc,hc end)end
cECBtn("Branco",Color3.fromRGB(255,255,255),"#FFFFFF")cECBtn("Amarelo",Color3.fromRGB(255,215,0),"#FFD700")cECBtn("Roxo",Color3.fromRGB(176,38,255),"#B026FF")cECBtn("Verde",Color3.fromRGB(50,205,50),"#32CD32")cECBtn("Rosa",Color3.fromRGB(255,20,147),"#FF1493")

cST("👤 MODS",UI.sP)cTog("🌀 TeleportTool",UI.sP,V.ttOn,function(s)V.ttOn=s if s then gTT()else rTT()end end,"TeleportTool")
cTog("⚡ Instant Interact",UI.sP,V.iiOn,function(s)V.iiOn=s if s then for _,p in pairs(W:GetDescendants())do if p:IsA("ProximityPrompt")then p.HoldDuration=0 end end C.iic=PPS.PromptShown:Connect(function(p)p.HoldDuration=0 end)else if C.iic then C.iic:Disconnect()C.iic=nil end end end,"InstantInteract")

-- [MODS PLAYER] --
cTog("⚡ Mods Player",UI.sP,V.pmOn,function(s)
    V.pmOn=s 
    if s then 
        C.pmc=RS.Stepped:Connect(function()
            if W.CurrentCamera then W.CurrentCamera.FieldOfView=V.pFov end 
            local c=LP.Character 
            if c then 
                local h=c:FindFirstChildOfClass("Humanoid")
                if h then 
                    h.UseJumpPower=true 
                    if h.WalkSpeed~=V.pSpd then h.WalkSpeed=V.pSpd end 
                    if h.JumpPower~=V.pJmp then h.JumpPower=V.pJmp end 
                end 
            end 
        end)
    else 
        if C.pmc then C.pmc:Disconnect()C.pmc=nil end 
        local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed,c.Humanoid.JumpPower=16,50 end 
        if W.CurrentCamera then W.CurrentCamera.FieldOfView=70 end 
    end 
end,"PlayerMods")

cTog("⚡ No Cooldown (Instantâneo)",UI.sP,V.ncOn,function(s)V.ncOn=s if s then C.ncc=RS.Stepped:Connect(function()local c=LP.Character if c then for _,t in ipairs(c:GetChildren())do if t:IsA("Tool")then t.Enabled=true pcall(function()if t.Cooldown then t.Cooldown=0 end for _,v in ipairs(t:GetDescendants())do if v:IsA("NumberValue")or v:IsA("IntValue")then local ln=string.lower(v.Name)if string.find(ln,"cooldown")or string.find(ln,"cd")or string.find(ln,"time")or string.find(ln,"delay")then v.Value=0 end end end end)end end end if LP:FindFirstChild("Backpack")then for _,t in ipairs(LP.Backpack:GetChildren())do if t:IsA("Tool")then t.Enabled=true pcall(function()if t.Cooldown then t.Cooldown=0 end for _,v in ipairs(t:GetDescendants())do if v:IsA("NumberValue")or v:IsA("IntValue")then local ln=string.lower(v.Name)if string.find(ln,"cooldown")or string.find(ln,"cd")or string.find(ln,"time")or string.find(ln,"delay")then v.Value=0 end end end end)end end end end)else if C.ncc then C.ncc:Disconnect()C.ncc=nil end end end,"NoCooldown")
cTog("🚀 Inf Jump",UI.sP,V.ijOn,function(s)V.ijOn=s if s then C.ijc=UIS.JumpRequest:Connect(function()local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)else if C.ijc then C.ijc:Disconnect()C.ijc=nil end end end,"InfJump")

cTog("👻 Noclip",UI.sP,V.nclOn,function(s)
    V.nclOn = s
    HC.Noclip = s
    saveC()
    if s then
        sNotif("Aviso Noclip", "Ativado! Cuidado: em alguns jogos o NOCLIP pode ser detectado como Exploração Indevida.", "Error")
        if C.nclConn then C.nclConn:Disconnect() end
        C.nclConn = RS.Stepped:Connect(function()
            local c = LP.Character
            if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if C.nclConn then C.nclConn:Disconnect() C.nclConn = nil end
        local c = LP.Character
        if c then
            for _, part in ipairs(c:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        sNotif("Noclip", "Noclip desativado com segurança.", "Info")
    end
end,"Noclip")

-- [ANTI-EFFECT COM CARREGAMENTO AUTOMÁTICO ROBUSTO] --
cTog("🛡️ Anti-Effect", UI.sP, V.antiEffectOn, function(s)
    V.antiEffectOn = s
    HC.AntiEffect = s
    saveC()
    if s then
        if C.aec then C.aec:Disconnect() end
        C.aec = RS.RenderStepped:Connect(function()
            if not V.antiEffectOn then return end
            pcall(function()
                local pGui = LP:FindFirstChildOfClass("PlayerGui")
                if pGui then
                    for _, obj in ipairs(pGui:GetDescendants()) do
                        if obj and obj.Parent then
                            if obj:IsA("ScreenGui") or obj:IsA("Frame") or obj:IsA("ImageLabel") then
                                local n = string.lower(obj.Name)
                                if string.find(n, "flashbang") or string.find(n, "moai") or string.find(n, "flash") or string.find(n, "blind") or string.find(n, "white") then
                                    if obj:IsA("ScreenGui") then obj.Enabled = false end
                                    if obj:IsA("Frame") or obj:IsA("ImageLabel") then obj.Visible = false obj.BackgroundTransparency = 1 end
                                end
                            elseif obj:IsA("LocalScript") then
                                local n = string.lower(obj.Name)
                                if string.find(n, "flashbang") or string.find(n, "moai") then
                                    obj.Disabled = true
                                end
                            end
                        end
                    end
                end
                for _, eff in ipairs(L:GetChildren()) do
                    if eff and eff.Parent and (eff:IsA("ColorCorrectionEffect") or eff:IsA("BlurEffect") or eff:IsA("BloomEffect")) then
                        local n = string.lower(eff.Name)
                        if string.find(n, "flash") or string.find(n, "moai") or string.find(n, "bang") or (eff:IsA("ColorCorrectionEffect") and eff.Brightness >= 0.8 and eff.Name ~= "VortexCC" and eff.Name ~= "VortexDeathFade") then
                            pcall(function() eff:Destroy() end)
                        end
                    end
                end
            end)
        end)
        sNotif("Anti-Effect", "Anti-Effect ativado!", "Success")
    else
        if C.aec then C.aec:Disconnect() C.aec = nil end
        sNotif("Anti-Effect", "Anti-Effect desativado.", "Info")
    end
end, "AntiEffect")

cSli("🏃 WalkSpeed","16 a 50",16,200,V.pSpd,UI.sP,function(v)V.pSpd=v if V.pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed=v end end end,"WalkSpeed")cSli("🦘 JumpPower","50 a 100",50,300,V.pJmp,UI.sP,function(v)V.pJmp=v if V.pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.JumpPower=v end end end,"JumpPower")cSli("🔭 FOV","70 a 90",70,120,V.pFov,UI.sP,function(v)V.pFov=v end,"FOV")

cST("🛡️ PROTEÇÃO",UI.sPr)cTog("🛡️ Anti-Fling",UI.sPr,V.afOn,function(s)V.afOn=s if s then eAF()else if C.afc then C.afc:Disconnect()C.afc=nil end end end,"AntiFling")

local menuProtectionOn = false
cTog("🛡️ Proteção Física Do Menu", UI.sPr, menuProtectionOn, function(s)
    menuProtectionOn = s
    if s then
        sNotif("Proteção", "Menu protegido contra remoção da tela.", "Success")
        if C.menuProtConn then C.menuProtConn:Disconnect() end
        C.menuProtConn = RS.RenderStepped:Connect(function()
            if not menuProtectionOn or not UI.MF or not UI.MF.Parent then return end
            local cam = W.CurrentCamera
            if not cam then return end
            local vSize = cam.ViewportSize
            local pos = UI.MF.AbsolutePosition
            local size = UI.MF.AbsoluteSize
            if pos.X + size.X < 50 or pos.X > vSize.X - 50 or pos.Y + size.Y < 50 or pos.Y > vSize.Y - 50 then
                UI.MF.Position = UDim2.new(0.5, -240, 0.5, -265)
            end
        end)
    else
        if C.menuProtConn then C.menuProtConn:Disconnect() C.menuProtConn = nil end
        sNotif("Proteção", "Proteção Física do Menu desativada.", "Info")
    end
end, nil)

cTog("⚡ Anti-Lag / FPS Booster",UI.sPr,V.antiLagOn,function(s)
    V.antiLagOn = s
    HC.AntiLag = s
    saveC()
    M.antiLagState = "IDLE"
    if C.antiLagConn then C.antiLagConn:Disconnect() C.antiLagConn = nil end
    if s then
        sNotif("Proteção","Auto-Anti-Lag ativado!","Success")
        C.antiLagConn = RS.RenderStepped:Connect(function(dt)
            if not V.antiLagOn then return end
            local fps = 1 / dt
            local currentTime = tick()
            if M.antiLagState == "IDLE" then
                if fps >= 7 and fps <= 10 then
                    M.antiLagState = "BOOSTED"
                    M.lagStartTime = currentTime
                    M.boostTriggerTime = currentTime
                    applyBoostState(true)
                end
            elseif M.antiLagState == "BOOSTED" then
                if fps > 12 then
                    if currentTime - M.boostTriggerTime >= 5 then
                        M.antiLagState = "IDLE"
                        applyBoostState(false)
                    end
                end
            end
        end)
    else
        if C.antiLagConn then C.antiLagConn:Disconnect() C.antiLagConn = nil end
        applyBoostState(false)
    end
end,"AntiLag")

-- [ANTI-VOID] --
cTog("🌌 Anti-Void",UI.sPr,V.avOn,function(s)
    V.avOn=s 
    if s then 
        local rp=RaycastParams.new()
        rp.FilterType=Enum.RaycastFilterType.Exclude 
        C.avc=RS.Heartbeat:Connect(function()
            if not V.avOn then return end 
            local c=LP.Character 
            if not c then return end 
            local h,hu=c:FindFirstChild("HumanoidRootPart"),c:FindFirstChildOfClass("Humanoid")
            if not h or not hu or hu.Health<=0 then return end 
            rp.FilterDescendantsInstances={c}
            if hu.FloorMaterial~=Enum.Material.Air and h.Position.Y > -5 then 
                M.lSCf=h.CFrame 
            end 
            local groundCheck = W:Raycast(h.Position + Vector3.new(0, 5, 0), Vector3.new(0, -200, 0), rp)
            if h.Position.Y < -10 or (not groundCheck and h.Position.Y < 5) then 
                h.AssemblyLinearVelocity,h.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)
                pcall(function()h.Velocity,h.RotVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)end)
                local sCF 
                if M.lSCf and M.lSCf.Position.Y > 0 then 
                    sCF=M.lSCf+Vector3.new(0,3,0)
                end 
                if not sCF then 
                    local sl=W:FindFirstChildWhichIsA("SpawnLocation",true)
                    if sl then sCF=sl.CFrame+Vector3.new(0,5,0)end 
                end 
                if not sCF then 
                    local cr=W:Raycast(Vector3.new(h.Position.X, 500, h.Position.Z),Vector3.new(0,-1000,0),rp)
                    if cr and cr.Position then sCF=CFrame.new(cr.Position+Vector3.new(0,5,0))end 
                end 
                if not sCF then 
                    sCF=CFrame.new(0,50,0)
                end 
                h.CFrame=sCF 
                sNotif("🛡️","Salvo do Void!","Success")
            end 
        end)
    else 
        if C.avc then C.avc:Disconnect()C.avc=nil end 
    end 
end,"AntiVoid")

cTog("🚫 Anti-AFK",UI.sPr,V.aaOn,function(s)V.aaOn=s if s then C.aac=LP.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)else if C.aac then C.aac:Disconnect()C.aac=nil end end end,"AntiAfk")
cTog("🔄 Auto-Rejoin (Anti-Disconnect)",UI.sPr,V.arOn,function(s)V.arOn=s if s then C.arc=game:GetService("GuiService").ErrorMessageChanged:Connect(function()task.wait(1.5)game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)else if C.arc then C.arc:Disconnect()C.arc=nil end end end,"AutoRejoin")

local function cTBtn(n,mc,tc,ac,tk)local b=Instance.new("TextButton",UI.sTh)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,40),Color3.fromRGB(45,45,45),"🎨 "..n,ac,Enum.Font.GothamBold,14 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(function()appT(mc,tc,ac,tk)end)end
cTBtn("Orion",Color3.fromRGB(36,36,37),Color3.fromRGB(30,30,30),Color3.fromRGB(52,152,219),"Orion")cTBtn("Vampiro",Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50),"Vampiro")cTBtn("Tóxico",Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100),"Tóxico")cTBtn("Ametista",Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182),"Ametista")cTBtn("Ouro",Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15),"Ouro")cTBtn("Sakura",Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204),"Sakura")cTBtn("Neon",Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255),"Neon")cTBtn("Magma",Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34),"Magma")
cTBtn("Cyberpunk",Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0),"Cyberpunk")cTBtn("Oceano",Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255),"Oceano")cTBtn("Inferno",Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0),"Inferno")cTBtn("Fantasma",Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230),"Fantasma")cTBtn("Floresta",Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100),"Floresta")

-- [DEFENSE & COMBAT] --
cST("🛡️ DEFENSE & COMBAT",UI.sDC)

local warnPotionLbl = Instance.new("TextLabel", UI.sDC)
warnPotionLbl.Size, warnPotionLbl.BackgroundTransparency, warnPotionLbl.Text, warnPotionLbl.TextColor3, warnPotionLbl.Font, warnPotionLbl.TextSize, warnPotionLbl.TextWrapped, warnPotionLbl.TextXAlignment = UDim2.new(1,0,0,24), 1, "É Preciso Ter O Item, Poção De vida para Continuar", Color3.fromRGB(255, 200, 50), Enum.Font.GothamBold, 11, true, Enum.TextXAlignment.Left
table.insert(M.TE.Txs, warnPotionLbl)

cTog("🧪 Auto-Usar Poção de Vida", UI.sDC, V.autoHealOn, function(s)
    V.autoHealOn = s
    HC.AutoHeal = s
    saveC()
    if s then
        if C.autoHealConn then C.autoHealConn:Disconnect() end
        C.autoHealConn = RS.Heartbeat:Connect(function()
            if not V.autoHealOn then return end
            local c = LP.Character
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local maxH = hum.MaxHealth > 0 and hum.MaxHealth or 100
                local currentPct = (hum.Health / maxH) * 100
                if currentPct <= V.healthThresholdPct then
                    autoUseHealthPotion()
                end
            end
        end)
        sNotif("Defense & Combat", "Auto-Cura ativada com sucesso!", "Success")
    else
        if C.autoHealConn then C.autoHealConn:Disconnect() C.autoHealConn = nil end
        sNotif("Defense & Combat", "Auto-Cura desativada.", "Info")
    end
end, "AutoHeal")

cSli("Em Que Momento Usar O Item", "60 (%)", 0, 100, V.healthThresholdPct, UI.sDC, function(v)
    V.healthThresholdPct = v
    HC.HealthThreshold = v
    saveC()
end, "HealthThreshold")

cTog("🧪 Auto-Click Poção De vida", UI.sDC, V.autoClickPotionOn, function(s)
    V.autoClickPotionOn = s
    HC.AutoClickPotion = s
    saveC()
    if s then
        if C.autoClickPotionConn then task.cancel(C.autoClickPotionConn) end
        C.autoClickPotionConn = task.spawn(function()
            while V.autoClickPotionOn do
                task.wait(1.5)
                pcall(function()
                    for _, obj in ipairs(W:GetDescendants()) do
                        if not V.autoClickPotionOn then break end
                        if obj and obj.Parent then
                            if isHealthPotionStrict(obj.Name, obj.Parent.Name) then
                                local cd = obj:FindFirstChildOfClass("ClickDetector") or obj.Parent:FindFirstChildOfClass("ClickDetector")
                                if not cd and obj:IsA("Model") then
                                    cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
                                end
                                if cd and typeof(fireclickdetector)=="function" then
                                    pcall(function() fireclickdetector(cd) end)
                                end
                            end
                        end
                    end
                end)
            end
        end)
        sNotif("Defense & Combat", "Auto-Click Poção ativado!", "Success")
    else
        if C.autoClickPotionConn then task.cancel(C.autoClickPotionConn) C.autoClickPotionConn = nil end
        sNotif("Defense & Combat", "Auto-Click desativado.", "Info")
    end
end, "AutoClickPotion")

-- [SISTEMA PROFISSIONAL DE VERIFICAÇÃO E AUTO-GRAB / TELEPORT PARA POÇÃO DE VIDA EXATA] --
local function isExactPinkHealthPotion(obj)
    if not obj or not obj.Parent then return false end
    local name = string.lower(obj.Name or "")
    local parentName = string.lower(obj.Parent.Name or "")
    
    local isHealth = string.find(name, "health") or string.find(name, "heal") or string.find(name, "vida") or string.find(name, "hp") or string.find(name, "poção") or string.find(name, "pocao") or string.find(name, "cura") or string.find(name, "potion") or
                     string.find(parentName, "health") or string.find(parentName, "heal") or string.find(parentName, "vida") or string.find(parentName, "hp") or string.find(parentName, "poção") or string.find(parentName, "pocao") or string.find(parentName, "cura") or string.find(parentName, "potion")
    
    local isBad = string.find(name, "fire") or string.find(name, "speed") or string.find(name, "jump") or string.find(name, "sword") or string.find(name, "moto") or string.find(name, "wall") or
                  string.find(parentName, "fire") or string.find(parentName, "speed") or string.find(parentName, "jump") or string.find(parentName, "sword") or string.find(parentName, "moto")
                  
    return isHealth and not isBad
end

cTog("🎒 Auto-Grab", UI.sDC, V.autoCollectPotionOn, function(s)
    V.autoCollectPotionOn = s
    HC.AutoCollectPotion = s
    saveC()
    if s then
        if C.autoGrabConn then C.autoGrabConn:Disconnect() end
        
        if C.verifiedSpawnConnection then C.verifiedSpawnConnection:Disconnect() end
        C.verifiedSpawnConnection = W.DescendantAdded:Connect(function(spawnedObj)
            if not V.autoCollectPotionOn then return end
            task.spawn(function()
                task.wait(0.05)
                if isExactPinkHealthPotion(spawnedObj) then
                    pcall(function()
                        local char = LP.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        
                        local targetPart = nil
                        if spawnedObj:IsA("BasePart") then
                            targetPart = spawnedObj
                        elseif spawnedObj:IsA("Model") then
                            targetPart = spawnedObj.PrimaryPart or spawnedObj:FindFirstChildWhichIsA("BasePart", true)
                        elseif spawnedObj:IsA("Tool") then
                            targetPart = spawnedObj:FindFirstChild("Handle") or spawnedObj:FindFirstChildWhichIsA("BasePart", true)
                        end
                        
                        local cd = spawnedObj:FindFirstChildOfClass("ClickDetector") or (spawnedObj.Parent and spawnedObj.Parent:FindFirstChildOfClass("ClickDetector"))
                        if not cd and spawnedObj:IsA("Model") then
                            cd = spawnedObj:FindFirstChildWhichIsA("ClickDetector", true)
                        end
                        
                        if cd and typeof(fireclickdetector) == "function" then
                            pcall(function() fireclickdetector(cd) end)
                        end
                        
                        if targetPart then
                            task.wait(0.02)
                            hrp.CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 2, 0))
                            sNotif("Poção Detectada", "Clicado na poção de vida e teleportado com sucesso!", "Success")
                        end
                    end)
                end
            end)
        end)

        C.autoGrabConn = RS.Heartbeat:Connect(function()
            if not V.autoCollectPotionOn then return end
            pcall(function()
                local char = LP.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                
                local targetPart = nil
                local targetCD = nil
                
                for _, obj in ipairs(W:GetDescendants()) do
                    if not V.autoCollectPotionOn then break end
                    if isExactPinkHealthPotion(obj) then
                        local cd = obj:FindFirstChildOfClass("ClickDetector") or (obj.Parent and obj.Parent:FindFirstChildOfClass("ClickDetector"))
                        if not cd and obj:IsA("Model") then
                            cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
                        end
                        
                        local part = nil
                        if obj:IsA("BasePart") then
                            part = obj
                        elseif obj:IsA("Model") then
                            part = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart", true)
                        elseif obj:IsA("Tool") then
                            part = obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart", true)
                        end
                        
                        if part then
                            targetPart = part
                            targetCD = cd
                            break
                        end
                    end
                end
                
                if targetPart then
                    if targetCD and typeof(fireclickdetector) == "function" then
                        pcall(function() fireclickdetector(targetCD) end)
                    end
                    hrp.CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 2, 0))
                end
            end)
        end)
        sNotif("Auto-Grab", "Filtro profissional de poção de vida ativado!", "Success")
    else
        if C.autoGrabConn then C.autoGrabConn:Disconnect() C.autoGrabConn = nil end
        if C.verifiedSpawnConnection then C.verifiedSpawnConnection:Disconnect() C.verifiedSpawnConnection = nil end
        sNotif("Auto-Grab", "Auto-Grab desativado.", "Info")
    end
end, "AutoCollectPotion")

-- [ABA VIEWER COM WHITELIST & SUPORTE A OFFLINE] --
cST("👥 VIEWER & LOOP PLAYERS",UI.sV)
cTog("🛡️ Whitelist de Amigos",UI.sV,V.wlOn,function(s)
    V.wlOn=s 
    if M.uPL then M.uPL() end 
    uESP()
end,"Whitelist")

P.PlayerRemoving:Connect(function(p)
    if M.sPly == p then
        M.disconnectedTarget = {Name = p.Name, DisplayName = p.DisplayName, UserId = p.UserId}
    end
    aLH(p,"EXIT")
    M.uPL()
end)

P.PlayerAdded:Connect(function(p)
    if M.disconnectedTarget and p.Name == M.disconnectedTarget.Name then
        M.disconnectedTarget = nil
    end
    aLH(p,"JOIN")
    M.uPL()
end)

UI.TgtF=Instance.new("Frame",UI.sV)
UI.TgtF.Size,UI.TgtF.BackgroundColor3=UDim2.new(1,0,0,50),Color3.fromRGB(35,35,40)
Instance.new("UICorner",UI.TgtF).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",UI.TgtF).Color=Color3.fromRGB(60,60,65)

UI.TarName=Instance.new("TextLabel",UI.TgtF)
UI.TarName.Size,UI.TarName.Position,UI.TarName.BackgroundTransparency,UI.TarName.Text,UI.TarName.TextColor3,UI.TarName.Font,UI.TarName.TextSize,UI.TarName.TextXAlignment=UDim2.new(0.4,0,1,0),UDim2.new(0,15,0,0),1,"Select Player",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,Enum.TextXAlignment.Left
table.insert(M.TE.Txs,UI.TarName)

UI.SelectSearchIcon = Instance.new("ImageLabel", UI.TgtF)
UI.SelectSearchIcon.Size, UI.SelectSearchIcon.Position, UI.SelectSearchIcon.BackgroundTransparency, UI.SelectSearchIcon.Image = UDim2.new(0,18,0,18), UDim2.new(1,-115,0.5,-9), 1, "rbxassetid://6031094667"
UI.SelectSearchIcon.ImageColor3 = Color3.fromRGB(255,255,255)

UI.SelText = Instance.new("TextLabel", UI.TgtF)
UI.SelText.Size, UI.SelText.Position, UI.SelText.BackgroundTransparency, UI.SelText.Text, UI.SelText.TextColor3, UI.SelText.Font, UI.SelText.TextSize, UI.SelText.TextXAlignment = UDim2.new(0,60,0,18), UDim2.new(1,-95,0.5,-9), 1, "Selected", Color3.fromRGB(180,180,180), Enum.Font.Gotham, 13, Enum.TextXAlignment.Left
UI.SelText.TextTruncate = Enum.TextTruncate.AtEnd
table.insert(M.TE.Txs, UI.SelText)

UI.Arrow = Instance.new("TextLabel", UI.TgtF)
UI.Arrow.Size, UI.Arrow.Position, UI.Arrow.BackgroundTransparency, UI.Arrow.Text, UI.Arrow.TextColor3, UI.Arrow.Font, UI.Arrow.TextSize = UDim2.new(0,18,0,18), UDim2.new(1,-25,0.5,-9), 1, "▼", Color3.fromRGB(150,150,150), Enum.Font.GothamBold, 12

UI.TgtBtn=Instance.new("TextButton",UI.TgtF)
UI.TgtBtn.Size,UI.TgtBtn.BackgroundTransparency,UI.TgtBtn.Text=UDim2.new(1,0,1,0),1,""

UI.PLContainer=Instance.new("Frame",UI.sV)UI.PLContainer.Size,UI.PLContainer.BackgroundTransparency,UI.PLContainer.Visible=UDim2.new(1,0,0,225),1,false

UI.SBF=Instance.new("Frame",UI.PLContainer)UI.SBF.Size,UI.SBF.BackgroundColor3=UDim2.new(1,0,0,35),Color3.fromRGB(30,30,35)Instance.new("UICorner",UI.SBF).CornerRadius=UDim.new(0,6)
UI.SIc=Instance.new("ImageLabel",UI.SBF)
UI.SIc.Size, UI.SIc.Position, UI.SIc.BackgroundTransparency, UI.SIc.Image = UDim2.new(0,18,0,18), UDim2.new(0,10,0.5,-9), 1, "rbxassetid://6031094667"
UI.SIc.ImageColor3 = Color3.fromRGB(255,255,255)
UI.SInp=Instance.new("TextBox",UI.SBF)UI.SInp.Size,UI.SInp.Position,UI.SInp.BackgroundTransparency,UI.SInp.Text,UI.SInp.PlaceholderText,UI.SInp.TextColor3,UI.SInp.Font,UI.SInp.TextSize,UI.SInp.TextXAlignment=UDim2.new(1,-45,1,0),UDim2.new(0,35,0,0),1,"","Pesquisar jogador...",Color3.fromRGB(255,255,255),Enum.Font.Gotham,13,Enum.TextXAlignment.Left

UI.PLF=Instance.new("ScrollingFrame",UI.PLContainer)UI.PLF.Size,UI.PLF.Position,UI.PLF.BackgroundColor3,UI.PLF.BorderSizePixel,UI.PLF.ScrollBarThickness=UDim2.new(1,0,1,-45),UDim2.new(0,0,0,45),Color3.fromRGB(30,30,35),0,4 
Instance.new("UICorner",UI.PLF).CornerRadius=UDim.new(0,6)
UI.UIL=Instance.new("UIListLayout",UI.PLF)UI.UIL.Padding,UI.UIL.HorizontalAlignment,UI.UIL.SortOrder=UDim.new(0,6),Enum.HorizontalAlignment.Center,Enum.SortOrder.Name 
UI.UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()UI.PLF.CanvasSize=UDim2.new(0,0,0,UI.UIL.AbsoluteContentSize.Y+10)end)

UI.TgtBtn.MouseButton1Click:Connect(function()
    UI.PLContainer.Visible = not UI.PLContainer.Visible
    UI.Arrow.Text = UI.PLContainer.Visible and "▲" or "▼"
end)

M.uPL=function()
    for _,d in pairs(M.pBD)do if d.Btn then pcall(function() d.Btn:Destroy() end) end end table.clear(M.pBD)
    local f=string.lower(UI.SInp.Text or"")
    
    if M.disconnectedTarget then
        local p = M.disconnectedTarget
        local b=Instance.new("TextButton",UI.PLF)
        b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment=UDim2.new(1,-12,0,44),Color3.fromRGB(45,30,30),"              "..p.DisplayName,Color3.fromRGB(240,240,240),Enum.Font.GothamBold,13,Enum.TextXAlignment.Left
        Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
        local st = Instance.new("UIStroke",b)
        st.Color = Color3.fromRGB(255, 60, 60)
        st.Thickness = 1.5
        local subT=Instance.new("TextLabel",b)subT.Size,subT.Position,subT.BackgroundTransparency,subT.Text,subT.TextColor3,subT.Font,subT.TextSize,subT.TextXAlignment=UDim2.new(1,-45,0,15),UDim2.new(0,45,0,24),1,"@"..p.Name,Color3.fromRGB(200,150,150),Enum.Font.Gotham,11,Enum.TextXAlignment.Left
        local avI=Instance.new("ImageLabel",b)avI.Size,avI.Position,avI.BackgroundTransparency,avI.BackgroundColor3=UDim2.new(0,32,0,32),UDim2.new(0,8,0.5,-16),1,Color3.fromRGB(30,30,35)
        Instance.new("UICorner",avI).CornerRadius=UDim.new(1,0)
        task.spawn(function()
            local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)
            if s and r then avI.Image=r end 
        end)
        b.MouseButton1Click:Connect(function()
            M.disconnectedTarget = nil
            M.uPL()
            sNotif("Viewer","Jogador offline removido.","Info")
        end)
        table.insert(M.pBD,{Btn=b})
    end

    for _,p in ipairs(P:GetPlayers())do
        if p~=LP then
            if isFriend(p) then continue end 
            local b=Instance.new("TextButton",UI.PLF)
            b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment=UDim2.new(1,-12,0,44),Color3.fromRGB(42,42,48),"              "..p.DisplayName,Color3.fromRGB(240,240,240),Enum.Font.GothamBold,13,Enum.TextXAlignment.Left
            Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
            Instance.new("UIStroke",b).Color=Color3.fromRGB(60,60,65)
            local subT=Instance.new("TextLabel",b)subT.Size,subT.Position,subT.BackgroundTransparency,subT.Text,subT.TextColor3,subT.Font,subT.TextSize,subT.TextXAlignment=UDim2.new(1,-45,0,15),UDim2.new(0,45,0,24),1,"@"..p.Name,Color3.fromRGB(160,160,165),Enum.Font.Gotham,11,Enum.TextXAlignment.Left
            local avI=Instance.new("ImageLabel",b)avI.Size,avI.Position,avI.BackgroundTransparency,avI.BackgroundColor3=UDim2.new(0,32,0,32),UDim2.new(0,8,0.5,-16),1,Color3.fromRGB(30,30,35)
            Instance.new("UICorner",avI).CornerRadius=UDim.new(1,0)
            task.spawn(function()
                local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)
                if s and r then avI.Image=r end 
            end)
            b.MouseButton1Click:Connect(function()
                if M.sPly == p then
                    M.sPly = nil
                    UI.SelText.Text = "Selected"
                    sNotif("Viewer","Jogador desmarcado.","Info")
                else
                    M.sPly=p 
                    M.disconnectedTarget = nil
                    UI.TarName.Text="Select Player" 
                    UI.SelText.Text = p.DisplayName 
                    sNotif("Alvo","Selecionado: "..p.Name,"Info")
                end
                UI.PLContainer.Visible = false
                UI.Arrow.Text = "▼"
            end)
            table.insert(M.pBD,{Btn=b,Player=p})
            local pn,pd=string.lower(p.Name),string.lower(p.DisplayName)
            if f==""or string.find(pn,f)or string.find(pd,f)then b.Visible=true else b.Visible=false end
        end
    end
end
UI.SInp:GetPropertyChangedSignal("Text"):Connect(M.uPL)M.uPL()

-- [SISTEMA LOOP EXPLOSION] --
cST("💥 LOOP EXPLOSION SYSTEM",UI.sV)

local function isMotoStrict(name)
    local n = string.lower(name or "")
    local isMotoName = (string.find(n, "call tool moto no dmg") or string.find(n, "calltoolmotonodmg") or string.find(n, "call tool moto"))
    local isExcluded = string.find(n, "health") or string.find(n, "heal") or string.find(n, "vida") or string.find(n, "hp") or string.find(n, "poção") or string.find(n, "pocao") or string.find(n, "potion")
    return isMotoName and not isExcluded
end

local function hasMotoItem()
    local bp = LP:FindFirstChild("Backpack")
    local char = LP.Character
    local function checkContainer(cont)
        if not cont then return false end
        for _, item in ipairs(cont:GetChildren()) do
            if item:IsA("Tool") and isMotoStrict(item.Name) then
                return true
            end
        end
        return false
    end
    return checkContainer(bp) or checkContainer(char)
end

local function getMotoPlatePart()
    local wallPlate = W:FindFirstChild("WALLDELANTERA2", true) or W:FindFirstChild("WALLDELANTERA1", true) or W:FindFirstChild("wallgenen3", true)
    if wallPlate then
        if wallPlate:IsA("Model") then
            return wallPlate.PrimaryPart or wallPlate:FindFirstChildWhichIsA("BasePart", true)
        elseif wallPlate:IsA("BasePart") then
            return wallPlate
        end
    end
    for _, obj in ipairs(W:GetDescendants()) do
        if obj.Name == "WALLDELANTERA2" or obj.Name == "wallgenen3" or string.find(string.lower(obj.Name), "walldelantera") then
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

cTog("💥 Loop Explosion", UI.sV, V.loopExplosionOn, function(s)
    V.loopExplosionOn = s
    HC.LoopExplosion = s
    saveC()
    if s then
        if not M.sPly and not M.disconnectedTarget then
            sNotif("Aviso", "Selecione um jogador na lista do Viewer primeiro!", "Error")
            V.loopExplosionOn = false
            return
        end
        sNotif("Loop Explosion", "Sistema iniciado!", "Success")
        if M.loopExplosionTask then task.cancel(M.loopExplosionTask) end
        M.loopExplosionTask = task.spawn(function()
            while V.loopExplosionOn do
                task.wait(0.3)
                pcall(function()
                    local char = LP.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if not hrp or not hum or hum.Health <= 0 then return end
                    
                    if not hasMotoItem() then
                        local platePart = getMotoPlatePart()
                        if platePart then
                            hrp.CFrame = platePart.CFrame + Vector3.new(0, 3, 0)
                            local plateCD = platePart:FindFirstChildOfClass("ClickDetector") or (platePart.Parent and platePart.Parent:FindFirstChildOfClass("ClickDetector"))
                            if not plateCD and platePart.Parent then
                                plateCD = platePart.Parent:FindFirstChildWhichIsA("ClickDetector", true)
                            end
                            if plateCD and typeof(fireclickdetector)=="function" then
                                pcall(function() fireclickdetector(plateCD) end)
                            end
                            task.wait(0.15)
                        end
                        
                        local motoPart = nil
                        for _, obj in ipairs(W:GetDescendants()) do
                            if not V.loopExplosionOn then break end
                            if obj and obj.Parent then
                                local nm = string.lower(obj.Name)
                                local pNm = string.lower(obj.Parent.Name or "")
                                if not (string.find(nm, "health") or string.find(nm, "potion")) and (isMotoStrict(obj.Name) or string.find(nm, "call tool moto no dmg")) then
                                    if obj:IsA("Tool") then
                                        motoPart = obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart", true)
                                    elseif obj:IsA("BasePart") then
                                        motoPart = obj
                                    end
                                    if motoPart then break end
                                end
                            end
                        end
                        
                        if motoPart then
                            hrp.CFrame = motoPart.CFrame + Vector3.new(0, 1, 0)
                            task.wait(0.08)
                            pcall(function()
                                if typeof(firetouchinterest)=="function" then
                                    firetouchinterest(hrp, motoPart, 0)
                                    task.wait()
                                    firetouchinterest(hrp, motoPart, 1)
                                end
                            end)
                        end
                    else
                        local bp = LP:FindFirstChild("Backpack")
                        local motoTool = nil
                        for _, item in ipairs(char:GetChildren()) do
                            if item:IsA("Tool") and isMotoStrict(item.Name) then
                                motoTool = item
                                break
                            end
                        end
                        if not motoTool and bp then
                            for _, item in ipairs(bp:GetChildren()) do
                                if item:IsA("Tool") and isMotoStrict(item.Name) then
                                    motoTool = item
                                    break
                                end
                            end
                        end
                        
                        if motoTool then
                            motoTool.Parent = char
                            pcall(function() motoTool:Activate() end)
                            task.wait(0.15)
                            pcall(function() motoTool:Activate() end)
                            task.wait(0.2)
                        end
                        
                        local targetHRP = nil
                        if M.sPly and M.sPly.Character and M.sPly.Character:FindFirstChild("HumanoidRootPart") then
                            targetHRP = M.sPly.Character.HumanoidRootPart
                        end
                        
                        if targetHRP then
                            hrp.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.25)
                            if hum.Health > 0 then
                                hum.Health = 0
                                task.wait(1.2)
                            end
                        end
                    end
                end)
            end
        end)
    else
        if M.loopExplosionTask then task.cancel(M.loopExplosionTask) M.loopExplosionTask = nil end
        sNotif("Loop Explosion", "Desativado.", "Info")
    end
end, "LoopExplosion")

-- [SISTEMA LOOP DEATH (FLING)] --
cST("💀 LOOP DEATH",UI.sV)
cTog("🌪️ Loop <font color='#39FF14'><b>Fling</b></font>",UI.sV,false,function(s)
    if s then
        if not M.sPly and not M.disconnectedTarget then sNotif("Aviso","Selecione um jogador primeiro!","Error") return end
        local c = LP.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            M.flingOrigCF = c.HumanoidRootPart.CFrame 
        end
        C.flingLoop = RS.Heartbeat:Connect(function()
            local c = LP.Character
            if c and M.sPly and M.sPly.Character and c:FindFirstChild("HumanoidRootPart") and M.sPly.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = c.HumanoidRootPart
                local tHrp = M.sPly.Character.HumanoidRootPart
                hrp.RotVelocity = Vector3.new(30000, 30000, 30000)
                hrp.AssemblyLinearVelocity = tHrp.AssemblyLinearVelocity + Vector3.new(0, 50, 0)
                for _, part in ipairs(c:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
                hrp.CFrame = tHrp.CFrame + (tHrp.AssemblyLinearVelocity * 0.15)
            end
        end)
        sNotif("Fling
