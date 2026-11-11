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

local function sNotif(tl,tx,nt)if not V.jelOn and(nt=="Info"or tl=="🟢"or tl=="🔴")then return end if tl=="Alvo" then for i=#M.ANotif,1,-1 do local v=M.ANotif[i]if v:FindFirstChild("NTitle")and v.NTitle.Text=="Alvo"then pcall(function() v:Destroy() end) table.remove(M.ANotif,i)end end for i,v in ipairs(M.ANotif)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-((i-1)*75))}):Play()end end local cls={Error=Color3.fromRGB(255,75,75),Info=M.CTh.A,Success=Color3.fromRGB(75,255,75)}local cc=cls[nt]or cls.Info local icn=nt=="Error"and"⚠️"or(nt=="Success"and"✅"or"ℹ️")local NF=Instance.new("Frame",M.SG)NF.Size,NF.Position,NF.BackgroundColor3,NF.BorderSizePixel=UDim2.new(0,300,0,65),UDim2.new(1,20,1,-85-(#M.ANotif*75)),Color3.fromRGB(25,25,28),0 Instance.new("UICorner",NF).CornerRadius=UDim.new(0,6)local sk=Instance.new("UIStroke",NF)sk.Color=Color3.fromRGB(50,50,55)sk.Thickness=1 local Sd=Instance.new("Frame",NF)Sd.Size,Sd.BackgroundColor3,Sd.BorderSizePixel=UDim2.new(0,4,1,0),cc,0 Instance.new("UICorner",Sd).CornerRadius=UDim.new(0,6)local Ic=Instance.new("TextLabel",NF)Ic.Size,Ic.Position,Ic.BackgroundTransparency,Ic.Text,Ic.TextSize=UDim2.new(0,40,0,40),UDim2.new(0,10,0.5,-20),1,icn,24 local Txt=Instance.new("TextLabel",NF)Txt.Name="NTitle" Txt.Size,Txt.Position,Txt.BackgroundTransparency,Txt.Text,Txt.TextColor3,Txt.Font,Txt.TextSize,Txt.TextXAlignment=UDim2.new(1,-65,0,20),UDim2.new(0,55,0,10),1,tl,cc,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left local Dsc=Instance.new("TextLabel",NF)Dsc.Size,Dsc.Position,Dsc.BackgroundTransparency,Dsc.Text,Dsc.TextColor3,Dsc.Font,Dsc.TextSize,Dsc.TextWrapped,Dsc.TextXAlignment=UDim2.new(1,-65,0,25),UDim2.new(0,55,0,30),1,tx,Color3.fromRGB(240,240,240),Enum.Font.Gotham,12,true,Enum.TextXAlignment.Left Dsc.RichText=true local PBg=Instance.new("Frame",NF)PBg.Size,PBg.Position,PBg.BackgroundColor3,PBg.BorderSizePixel=UDim2.new(1,0,0,3),UDim2.new(0,0,1,-3),Color3.fromRGB(40,40,45),0 Instance.new("UICorner",PBg).CornerRadius=UDim.new(0,6)local PBar=Instance.new("Frame",PBg)PBar.Size,PBar.BackgroundColor3,PBar.BorderSizePixel=UDim2.new(1,0,1,0),cc,0 Instance.new("UICorner",PBar).CornerRadius=UDim.new(0,6)table.insert(M.ANotif,NF)TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-(#M.ANotif-1)*75)}):Play()TS:Create(PBar,TweenInfo.new(4,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()task.delay(4,function()if NF.Parent then local oT=TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,NF.Position.Y.Offset)})oT:Play()oT.Completed:Connect(function()pcall(function() NF:Destroy() end)for i,v in ipairs(M.ANotif)do if v==NF then table.remove(M.ANotif,i)break end end for i,v in ipairs(M.ANotif)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-((i-1)*75))}):Play()end end)end end)end

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
    User
