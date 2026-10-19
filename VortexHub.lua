local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
local LP=P.LocalPlayer local TP=(gethui and gethui())or CG if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end
local SFName="VortexHub_Config.json" local HC={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,RandomRain=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,AutoRejoin=false,Notifications=true,SelectedTheme="Orion",Whitelist=true,HealthThreshold=60,AutoHeal=false,AutoClickPotion=false,AutoCollectPotion=false,AntiLag=false,LoopExplosion=false}
local IC={} local function saveC()pcall(function()if writefile then writefile(SFName,HS:JSONEncode(HC))end end)end
local function loadC()if readfile and isfile and isfile(SFName)then local s,d=pcall(function()return HS:JSONDecode(readfile(SFName))end)if s and type(d)=="table"then for k,v in pairs(d)do if HC[k]~=nil then HC[k]=v end end end end end loadC()

local shOn,fpsOn,wbOn,fgOn,mbOn,fbOn,plOn,atOn,rrOn,epOn,enOn,dEspOn,ttOn,iiOn,pmOn,ncOn,ijOn,nclOn,pSpd,pJmp,pFov,afOn,avOn,aaOn,arOn,jelOn,wlOn,healthThresholdPct,autoHealOn,autoClickPotionOn,autoCollectPotionOn,antiLagOn,loopExplosionOn=HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip,HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist,HC.HealthThreshold,HC.AutoHeal,HC.AutoClickPotion,HC.AutoCollectPotion,HC.AntiLag,HC.LoopExplosion
local ijc,nlc,avc,pmc,aac,arc,atc,sLp,iic,fbLp,plc,mbc,afc,ncc local lSCf=nil local lCR=CFrame.new()local ECol={PName="#00FFFF",PHP="#32FF32",PDist="#FFAA00",NName="#FF4444",NHP="#32FF32",NDist="#FFAA00"}
local tNPC,tPly,tDNPC={},{},{} local eUp,dUp
local OL={GS=L.GlobalShadows,B=L.Brightness,EDS=L.EnvironmentDiffuseScale,ESS=L.EnvironmentSpecularScale,FS=L.FogStart,FE=L.FogEnd,FC=L.FogColor,CT=L.ClockTime,A=L.Ambient,OA=L.OutdoorAmbient,T=L.Technology,SS=L.ShadowSoftness}
local function clrCE()for _,v in pairs(L:GetChildren())do if v.Name:match("Vortex")and v.Name~="VortexMotionBlur"and v.Name~="VortexWallBlur"and v.Name~="VortexDeathFade"then v:Destroy()end end end
local dF=L:FindFirstChild("VortexDeathFade")if not dF then dF=Instance.new("ColorCorrectionEffect",L)dF.Name="VortexDeathFade"dF.Brightness=0 dF.Contrast=0 end local pDead=false

-- [SISTEMA PROFISSIONAL DE WHITELIST DE AMIGOS] --
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

-- [CORREÇÃO TELEPORTTOOL NO RESPAWN] --
local tT=nil 
local function rTT()
    if tT then tT:Destroy()tT=nil end 
    if LP:FindFirstChild("Backpack")then local b=LP.Backpack:FindFirstChild("TeleportTool")if b then b:Destroy()end end 
    if LP.Character then local c=LP.Character:FindFirstChild("TeleportTool")if c then c:Destroy()end end 
end
local function gTT()
    rTT()if not ttOn then return end 
    local T=Instance.new("Tool")T.Name,T.RequiresHandle,T.CanBeDropped="TeleportTool",false,false 
    T.Activated:Connect(function()local m=LP:GetMouse()if m and m.Hit and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0))sNotif("✨","Teleporte realizado!","Success")end end)
    local bp=LP:WaitForChild("Backpack",3)if bp then T.Parent=bp tT=T end 
end

-- [FILTRO RIGOROSO E EXPANDIDO DE POÇÃO DE VIDA] --
local function isHealthPotionStrict(name, parentName)
    local n = string.lower(name or "")
    local p = string.lower(parentName or "")
    
    local hasHealth = string.find(n, "health") or string.find(n, "heal") or string.find(n, "vida") or string.find(n, "hp") or string.find(n, "poção") or string.find(n, "pocao") or string.find(n, "cura") or string.find(n, "potion") or string.find(n, "remedy") or
                      string.find(p, "health") or string.find(p, "heal") or string.find(p, "vida") or string.find(p, "hp") or string.find(p, "poção") or string.find(p, "pocao") or string.find(p, "cura") or string.find(p, "potion") or string.find(p, "remedy")
                      
    local isExcluded = string.find(n, "fire") or string.find(n, "speed") or string.find(n, "jump") or string.find(n, "sword") or string.find(n, "rainbow") or string.find(n, "carpet") or string.find(n, "launcher") or string.find(n, "spellbook") or string.find(n, "bat") or string.find(n, "rocket") or string.find(n, "thunder") or string.find(n, "moto") or
                       string.find(p, "fire") or string.find(p, "speed") or string.find(p, "jump") or string.find(p, "sword") or string.find(p, "rainbow") or string.find(p, "carpet") or string.find(p, "launcher") or string.find(p, "spellbook") or string.find(p, "bat") or string.find(p, "moto")
                       
    return hasHealth and not isExcluded
end

-- [AUTO-HEAL COM DETECÇÃO ROBUSTA DE POÇÃO DE VIDA E AUTO-EQUIPAR] --
local autoHealConn = nil
local lastPotionUse = 0

local function autoUseHealthPotion()
    if tick() - lastPotionUse < 0.4 then return end
    local c = LP.Character
    local hum = c and c:FindFirstChildOfClass("Humanoid")
    local bp = LP.Character and LP.Character:FindFirstChild("Backpack") or LP:FindFirstChild("Backpack")
    if not c or not hum or not bp or hum.Health <= 0 then return end
    
    lastPotionUse = tick()
    
    local previousTool = nil
    for _, item in ipairs(c:GetChildren()) do
        if item:IsA("Tool") then
            if not isHealthPotionStrict(item.Name, item.Parent and item.Parent.Name or "") then
                previousTool = item
                break
            end
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
        pcall(function()
            potion:Activate()
        end)
        task.wait(0.1)
        pcall(function()
            potion:Activate()
        end)
        
        if previousTool and previousTool.Parent then
            task.delay(0.2, function()
                if c and c:FindFirstChildOfClass("Humanoid") and previousTool.Parent then
                    previousTool.Parent = c
                end
            end)
        end
    end
end

LP.CharacterAdded:Connect(function(c)
    pDead=false 
    if dF then TS:Create(dF,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Brightness=0,Contrast=0}):Play()end 
    local wb=L:FindFirstChild("VortexWallBlur")if wb then TS:Create(wb,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Size=0}):Play()end 
    stDE(c)
    if ttOn then task.spawn(function()task.wait(0.5)gTT()end)end 
end)
if LP.Character then 
    stDE(LP.Character)
end

local function gPB(cam,c)if not wbOn then return 0 end local mB,mD,cD=12,45,45 local rP=RaycastParams.new()rP.FilterType=Enum.RaycastFilterType.Exclude rP.FilterDescendantsInstances={c,cam}local ang={CFrame.Angles(0,0,0),CFrame.Angles(0,math.rad(25),0),CFrame.Angles(0,math.rad(-25),0),CFrame.Angles(math.rad(15),0,0),CFrame.Angles(math.rad(-15),0,0)}for _,a in ipairs(ang)do local dir=(cam.CFrame*a).LookVector local h=W:Raycast(cam.CFrame.Position,dir*mD,rP)if h and h.Instance and h.Instance.Transparency<0.8 and h.Instance.CanCollide and h.Distance<cD then cD=h.Distance end end local vS=cam.ViewportSize local function ckD(hrp,obj)local d=(hrp.Position-cam.CFrame.Position).Magnitude if d<mD then local sP,oS=cam:WorldToViewportPoint(hrp.Position)if oS and sP.X>=0 and sP.X<=vS.X and sP.Y>=0 and sP.Y<=vS.Y then local ry=W:Raycast(cam.CFrame.Position,(hrp.Position-cam.CFrame.Position),rP)if not ry or ry.Instance:IsDescendantOf(obj)then if d<cD then cD=d end end end end end for _,p in ipairs(P:GetPlayers())do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then ckD(p.Character.HumanoidRootPart,p.Character)end end for _,o in ipairs(W:GetChildren())do if o:IsA("Model")and o~=c and o:FindFirstChildOfClass("Humanoid")then local tH=o:FindFirstChild("HumanoidRootPart")or o.PrimaryPart if tH then ckD(tH,o)end end end if cD<mD then return(1-(cD/mD))*mB end return 0 end
local function cInd(hrp,rP)if not hrp then return false end local hs=0 local off={Vector3.new(0,0,0),Vector3.new(8,0,0),Vector3.new(-8,0,0),Vector3.new(0,0,8),Vector3.new(0,0,-8)}for _,o in ipairs(off)do local h=W:Raycast(hrp.Position+o,Vector3.new(0,120,0),rP)if h and h.Instance and h.Instance.CanCollide and h.Instance.Transparency<0.5 then hs=hs+1 end end return hs>=3 end
local CNPCs={} local function cNPC(o)if o:IsA("Model")and o:FindFirstChild("Humanoid")and o:FindFirstChild("HumanoidRootPart")and not P:GetPlayerFromCharacter(o)then CNPCs[o]=true end end for _,o in ipairs(W:GetDescendants())do cNPC(o)end W.DescendantAdded:Connect(function(o)task.delay(0.2,function()if o and o.Parent then if o:IsA("Model")then cNPC(o)end if o.Parent:IsA("Model")then cNPC(o.Parent)end end end)end)W.DescendantRemoving:Connect(function(o)if CNPCs[o]then CNPCs[o]=nil end end)
local CTh={MBG=Color3.fromRGB(36,36,37),TB=Color3.fromRGB(30,30,30),A=Color3.fromRGB(52,152,219)}local TE={Bgs={},TBs={},Accs={},Tgls={},Txs={}}
local function appT(m,t,a,tn)CTh.MBG,CTh.TB,CTh.A=m,t,a if tn then HC.SelectedTheme=tn saveC()end for _,f in pairs(TE.Bgs)do f.BackgroundColor3=m end for _,f in pairs(TE.TBs)do f.BackgroundColor3=t end for _,o in pairs(TE.Accs)do if o:IsA("UIStroke")then o.Color=a else o.BackgroundColor3=a end end for _,tx in pairs(TE.Txs)do tx.TextColor3=a end for bg,sF in pairs(TE.Tgls)do if sF()then TS:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=a}):Play()end end end
local SG=Instance.new("ScreenGui",TP)SG.Name="VortexGraphicsHub"SG.ResetOnSpawn=false local ANotif={}
local function sNotif(tl,tx,nt)if not jelOn and(nt=="Info"or tl=="🟢"or tl=="🔴")then return end if tl=="Alvo" then for i=#ANotif,1,-1 do local v=ANotif[i]if v:FindFirstChild("NTitle")and v.NTitle.Text=="Alvo"then v:Destroy()table.remove(ANotif,i)end end for i,v in ipairs(ANotif)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-((i-1)*75))}):Play()end end local cls={Error=Color3.fromRGB(255,75,75),Info=CTh.A,Success=Color3.fromRGB(75,255,75)}local cc=cls[nt]or cls.Info local icn=nt=="Error"and"⚠️"or(nt=="Success"and"✅"or"ℹ️")local NF=Instance.new("Frame",SG)NF.Size,NF.Position,NF.BackgroundColor3,NF.BorderSizePixel=UDim2.new(0,300,0,65),UDim2.new(1,20,1,-85-(#ANotif*75)),Color3.fromRGB(25,25,28),0 Instance.new("UICorner",NF).CornerRadius=UDim.new(0,6)local sk=Instance.new("UIStroke",NF)sk.Color=Color3.fromRGB(50,50,55)sk.Thickness=1 local Sd=Instance.new("Frame",NF)Sd.Size,Sd.BackgroundColor3,Sd.BorderSizePixel=UDim2.new(0,4,1,0),cc,0 Instance.new("UICorner",Sd).CornerRadius=UDim.new(0,6)local Ic=Instance.new("TextLabel",NF)Ic.Size,Ic.Position,Ic.BackgroundTransparency,Ic.Text,Ic.TextSize=UDim2.new(0,40,0,40),UDim2.new(0,10,0.5,-20),1,icn,24 local Txt=Instance.new("TextLabel",NF)Txt.Name="NTitle" Txt.Size,Txt.Position,Txt.BackgroundTransparency,Txt.Text,Txt.TextColor3,Txt.Font,Txt.TextSize,Txt.TextXAlignment=UDim2.new(1,-65,0,20),UDim2.new(0,55,0,10),1,tl,cc,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left local Dsc=Instance.new("TextLabel",NF)Dsc.Size,Dsc.Position,Dsc.BackgroundTransparency,Dsc.Text,Dsc.TextColor3,Dsc.Font,Dsc.TextSize,Dsc.TextWrapped,Dsc.TextXAlignment=UDim2.new(1,-65,0,25),UDim2.new(0,55,0,30),1,tx,Color3.fromRGB(240,240,240),Enum.Font.Gotham,12,true,Enum.TextXAlignment.Left Dsc.RichText=true local PBg=Instance.new("Frame",NF)PBg.Size,PBg.Position,PBg.BackgroundColor3,PBg.BorderSizePixel=UDim2.new(1,0,0,3),UDim2.new(0,0,1,-3),Color3.fromRGB(40,40,45),0 Instance.new("UICorner",PBg).CornerRadius=UDim.new(0,6)local PBar=Instance.new("Frame",PBg)PBar.Size,PBar.BackgroundColor3,PBar.BorderSizePixel=UDim2.new(1,0,1,0),cc,0 Instance.new("UICorner",PBar).CornerRadius=UDim.new(0,6)table.insert(ANotif,NF)TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-(#ANotif-1)*75)}):Play()TS:Create(PBar,TweenInfo.new(4,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()task.delay(4,function()if NF.Parent then local oT=TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,NF.Position.Y.Offset)})oT:Play()oT.Completed:Connect(function()NF:Destroy()for i,v in ipairs(ANotif)do if v==NF then table.remove(ANotif,i)break end end for i,v in ipairs(ANotif)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-((i-1)*75))}):Play()end end)end end)end
local OBtn=Instance.new("TextButton",SG)OBtn.Size,OBtn.Position,OBtn.BackgroundColor3,OBtn.Text,OBtn.TextColor3,OBtn.Font,OBtn.TextSize,OBtn.Visible=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),Color3.fromRGB(36,36,37),"⚡\nOPEN",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,false Instance.new("UICorner",OBtn).CornerRadius=UDim.new(0,10)table.insert(TE.Bgs,OBtn)
local MF=Instance.new("Frame",SG)MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,480,0,530),UDim2.new(0.5,-240,0.5,-265),CTh.MBG,true,true Instance.new("UICorner",MF).CornerRadius=UDim.new(0,8)table.insert(TE.Bgs,MF)
local TB=Instance.new("Frame",MF)TB.Size,TB.BackgroundColor3=UDim2.new(1,0,0,40),CTh.TB Instance.new("UICorner",TB).CornerRadius=UDim.new(0,8)table.insert(TE.TBs,TB)
local PIco=Instance.new("ImageLabel",TB)PIco.Size,PIco.Position,PIco.BackgroundColor3,PIco.BorderSizePixel,PIco.ClipsDescendants=UDim2.new(0,26,0,26),UDim2.new(0,10,0.5,-13),Color3.fromRGB(50,50,50),0,true Instance.new("UICorner",PIco).CornerRadius=UDim.new(1,0)
task.spawn(function()pcall(function()PIco.Image=P:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)end)
local Ttl=Instance.new("TextLabel",TB)Ttl.Size,Ttl.Position,Ttl.Text,Ttl.TextColor3,Ttl.Font,Ttl.TextSize,Ttl.BackgroundTransparency,Ttl.TextXAlignment=UDim2.new(1,-80,1,0),UDim2.new(0,45,0,0),"⚡ Vortex Hub V18 - Supreme",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,1,Enum.TextXAlignment.Left
local CBn=Instance.new("TextButton",TB)CBn.Size,CBn.Position,CBn.BackgroundTransparency,CBn.Text,CBn.TextColor3,CBn.Font,CBn.TextSize=UDim2.new(0,40,0,40),UDim2.new(1,-40,0,0),1,"X",Color3.fromRGB(200,200,200),Enum.Font.GothamBold,16 CBn.MouseButton1Click:Connect(function()MF.Visible=false OBtn.Visible=true end)OBtn.MouseButton1Click:Connect(function()MF.Visible=true OBtn.Visible=false end)
local TC=Instance.new("Frame",MF)TC.Size,TC.Position,TC.BackgroundTransparency=UDim2.new(1,0,0,30),UDim2.new(0,0,0,40),1

-- [ABAS] --
local function cTB(n,px,w)local B=Instance.new("TextButton",TC)B.Size,B.Position,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(w or 0.125,0,1,0),UDim2.new(px,0,0,0),Color3.fromRGB(30,30,30),n,Color3.fromRGB(150,150,150),Enum.Font.GothamBold,10 return B end
local tMB,tEB,tPB,tPrB,tHB,tThB,tVB,tDCB=cTB("🔧 Princ.",0,0.125),cTB("👁️ ESPS",0.125,0.125),cTB("👤 Player",0.250,0.125),cTB("🛡️ Prot.",0.375,0.125),cTB("📜 Hist.",0.500,0.125),cTB("🎨 Temas",0.625,0.125),cTB("👀 Viewer & Loop",0.750,0.125),cTB("⚔️ Comb.",0.875,0.125)tMB.BackgroundColor3=Color3.fromRGB(45,45,45)tMB.TextColor3=Color3.fromRGB(255,255,255)

local function cScr(n,cY)local S=Instance.new("ScrollingFrame",MF)S.Size,S.Position,S.BackgroundTransparency,S.ScrollBarThickness,S.CanvasSize,S.Visible=UDim2.new(1,-20,1,-80),UDim2.new(0,10,0,75),1,4,UDim2.new(0,0,0,cY),false local L=Instance.new("UIListLayout",S)L.Padding,L.HorizontalAlignment,L.SortOrder=UDim.new(0,10),Enum.HorizontalAlignment.Center,Enum.SortOrder.LayoutOrder return S end
local sM,sE,sP,sPr,sH,sTh,sV,sDC=cScr("SM",950),cScr("SE",850),cScr("SP",720),cScr("SPr",460),cScr("SH",3500),cScr("STh",650),cScr("SV",1350),cScr("SDC",750)sM.Visible=true

local function sTab(aB,aS)local t={{tMB,sM},{tEB,sE},{tPB,sP},{tPrB,sPr},{tHB,sH},{tThB,sTh},{tVB,sV},{tDCB,sDC}}for _,d in pairs(t)do local b,s=d[1],d[2]if b==aB then b.BackgroundColor3=Color3.fromRGB(45,45,45)b.TextColor3=Color3.fromRGB(255,255,255)s.Visible=true else b.BackgroundColor3=Color3.fromRGB(30,30,30)b.TextColor3=Color3.fromRGB(150,150,150)s.Visible=false end end end
tMB.MouseButton1Click:Connect(function()sTab(tMB,sM)end)tEB.MouseButton1Click:Connect(function()sTab(tEB,sE)end)tPB.MouseButton1Click:Connect(function()sTab(tPB,sP)end)tPrB.MouseButton1Click:Connect(function()sTab(tPrB,sPr)end)tHB.MouseButton1Click:Connect(function()sTab(tHB,sH)end)tThB.MouseButton1Click:Connect(function()sTab(tThB,sTh)end)tVB.MouseButton1Click:Connect(function()sTab(tVB,sV)end)tDCB.MouseButton1Click:Connect(function()sTab(tDCB,sDC)end)

local function cST(n,p)local T=Instance.new("TextLabel",p)T.Size,T.BackgroundTransparency,T.Text,T.TextColor3,T.Font,T.TextSize,T.TextXAlignment=UDim2.new(1,0,0,25),1,n,CTh.A,Enum.Font.GothamBlack,13,Enum.TextXAlignment.Left table.insert(TE.Txs,T)end
local function cTog(n,p,iS,cb,ck)local F=Instance.new("Frame",p)F.Size,F.BackgroundColor3=UDim2.new(1,0,0,42),Color3.fromRGB(45,45,45)Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)local L=Instance.new("TextLabel",F)L.Size,L.Position,L.Text,L.TextColor3,L.Font,L.TextSize,L.BackgroundTransparency,L.TextXAlignment=UDim2.new(0.7,0,1,0),UDim2.new(0.05,0,0,0),n,Color3.fromRGB(255,255,255),Enum.Font.Gotham,13,1,Enum.TextXAlignment.Left L.RichText = true local SB=Instance.new("Frame",F)SB.Size,SB.Position,SB.BackgroundColor3=UDim2.new(0,40,0,20),UDim2.new(1,-55,0.5,-10),iS and CTh.A or Color3.fromRGB(70,70,70)Instance.new("UICorner",SB).CornerRadius=UDim.new(1,0)local SK=Instance.new("Frame",SB)SK.Size,SK.Position,SK.BackgroundColor3=UDim2.new(0,16,0,16),iS and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8),Color3.fromRGB(255,255,255)Instance.new("UICorner",SK).CornerRadius=UDim.new(1,0)local st=iS TE.Tgls[SB]=function()return st end local function sVS(ns)st=ns TS:Create(SB,TweenInfo.new(0.2),{BackgroundColor3=st and CTh.A or Color3.fromRGB(70,70,70)}):Play()TS:Create(SK,TweenInfo.new(0.2),{Position=st and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8)}):Play()if ck then HC[ck]=st saveC()end end local B=Instance.new("TextButton",F)B.Size,B.BackgroundTransparency,B.Text=UDim2.new(1,0,1,0),1,""B.MouseButton1Click:Connect(function()sVS(not st)cb(st)end)if ck then IC[ck]=function()if st then cb(true)end end end return sVS end

-- [SISTEMA CORRIGIDO E MELHORADO DO HISTÓRICO] --
local AJT={}
local function sJET(p,et)
    if not jelOn then return end 
    local isJ=(et=="JOIN")
    local aC=isJ and Color3.fromRGB(0,255,150)or Color3.fromRGB(255,70,90)
    local tT=isJ and"🟢 ENTRADA"or"🔴 SAÍDA"
    local sT=p.DisplayName.." (@"..p.Name..")"
    local Tst=Instance.new("Frame",SG)
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
    table.insert(AJT,Tst)
    local tY=-85-(#AJT-1)*68 
    Tst.Position=UDim2.new(1,20,1,tY)
    TS:Create(Tst,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-295,1,tY)}):Play()
    task.delay(4,function()
        if Tst.Parent then 
            local oT=TS:Create(Tst,TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,Tst.Position.Y.Offset),BackgroundTransparency=1})
            oT:Play()
            oT.Completed:Connect(function()
                Tst:Destroy()
                for i,v in ipairs(AJT)do if v==Tst then table.remove(AJT,i)break end end 
                for i,v in ipairs(AJT)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-295,1,-85-((i-1)*68))}):Play()end 
            end)
        end 
    end)
end

-- Menu Detalhado ao Clicar no Jogador
local function openPlayerProfileModal(p)
    local ModalBg = Instance.new("Frame", SG)
    ModalBg.Size, ModalBg.Position, ModalBg.BackgroundColor3, ModalBg.BackgroundTransparency = UDim2.new(1,0,1,0), UDim2.new(0,0,0,0), Color3.fromRGB(0,0,0), 1
    ModalBg.ZIndex = 200
    
    local BlurEffect = Instance.new("BlurEffect", L)
    BlurEffect.Size = 15
    BlurEffect.Name = "VortexProfileBlur"
    
    local Card = Instance.new("Frame", ModalBg)
    Card.Size, Card.Position, Card.BackgroundColor3 = UDim2.new(0,380,0,240), UDim2.new(0.5,-190,0.5,-120), Color3.fromRGB(22,22,28)
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0,14)
    local CardStroke = Instance.new("UIStroke", Card)
    CardStroke.Color, CardStroke.Thickness = CTh.A, 1.5
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
        if BlurEffect then BlurEffect:Destroy() end
        ModalBg:Destroy()
    end)
    
    local AvatarBg = Instance.new("Frame", Card)
    AvatarBg.Size, AvatarBg.Position, AvatarBg.BackgroundColor3, AvatarBg.BorderSizePixel = UDim2.new(0,85,0,85), UDim2.new(0,18,0,60), Color3.fromRGB(30,30,38), 0
    Instance.new("UICorner", AvatarBg).CornerRadius = UDim.new(1,0)
    local AvStk = Instance.new("UIStroke", AvatarBg)
    AvStk.Color, AvStk.Thickness = CTh.A, 2
    
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
    CopyBtn.Size, CopyBtn.Position, CopyBtn.BackgroundColor3, CopyBtn.Text, CopyBtn.TextColor3, CopyBtn.Font, CopyBtn.TextSize = UDim2.new(1,-36,0,38), UDim2.new(0,18,1,-48), CTh.A, "📋 Copiar ID do Jogador", Color3.fromRGB(255,255,255), Enum.Font.GothamBold, 13
    Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0,8)
    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(tostring(p.UserId))
            sNotif("Copiado", "ID copiado para a área de transferência!", "Success")
        else
            sNotif("Erro", "Seu executor não suporta setclipboard.", "Error")
        end
    end)
end

-- [HISTÓRICO: BOTÃO DE ATIVAR/DESATIVAR NO TOPO] --
cST("📜 HISTÓRICO DE ENTRADAS E SAÍDAS", sH)
cTog("🔔 Notificações", sH, jelOn, function(s) jelOn = s end, "Notifications")

local historyEntries = {}
local HistoryListFrame = Instance.new("ScrollingFrame", sH)
HistoryListFrame.Size, HistoryListFrame.Position, HistoryListFrame.BackgroundTransparency, HistoryListFrame.ScrollBarThickness, HistoryListFrame.CanvasSize = UDim2.new(1,0,0,2500), UDim2.new(0,0,0,70), 1, 4, UDim2.new(0,0,0,0)
local HistoryLayout = Instance.new("UIListLayout", HistoryListFrame)
HistoryLayout.Padding, HistoryLayout.HorizontalAlignment, HistoryLayout.SortOrder = UDim.new(0,8), Enum.HorizontalAlignment.Center, Enum.SortOrder.LayoutOrder
HistoryLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    HistoryListFrame.CanvasSize = UDim2.new(0,0,0,HistoryLayout.AbsoluteContentSize.Y+15)
end)

local trackedHistoryUsers = {}
local function aLH(p, et)
    if not p then return end
    if et == "JOIN" and trackedHistoryUsers[p.UserId] then return end
    if et == "JOIN" then trackedHistoryUsers[p.UserId] = true end
    if et == "EXIT" then trackedHistoryUsers[p.UserId] = nil end

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

local function cSli(n,rT,mV,mxV,cV,p,cb,ck)local SF=Instance.new("Frame",p)SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,65),Color3.fromRGB(42,42,45)Instance.new("UICorner",SF).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",SF).Color=Color3.fromRGB(60,60,65)local TL=Instance.new("TextLabel",SF)TL.Size,TL.Position,TL.Text,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,12,0,6),n.." [ "..tostring(cV).. " ]",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left local RL=Instance.new("TextLabel",SF)RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,24),"Recomendado: "..rT,Color3.fromRGB(160,160,165),Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left local Tk=Instance.new("Frame",SF)Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,46),Color3.fromRGB(25,25,28)Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)local pI=math.clamp((cV-mV)/(mxV-mV),0,1)local F=Instance.new("Frame",Tk)F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),CTh.A Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)table.insert(TE.Accs,F)local K=Instance.new("Frame",Tk)K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)local KS=Instance.new("UIStroke",K)KS.Color,KS.Thickness=CTh.A,2 table.insert(TE.Accs,KS)local HB=Instance.new("TextButton",SF)HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""local d=false local function upd(ip)local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)local pc=pX/Tk.AbsoluteSize.X local vl=math.floor(mV+(mxV-mV)*pc)TS:Create(F,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(pc,0,1,0)}):Play()TS:Create(K,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(pc,0,0.5,0)}):Play()TL.Text=n.." [ "..tostring(vl).." ]"if ck then HC[ck]=vl saveC()end cb(vl)end HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)UIS.InputChanged:Connect(function(ip)if d and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then upd(ip)end end)if ck then IC[ck]=function()cb(cV)end end end
local function cTSli(mV,mxV,cV,p,cb)local SF=Instance.new("Frame",p)SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,65),Color3.fromRGB(42,42,45)Instance.new("UICorner",SF).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",SF).Color=Color3.fromRGB(60,60,65)local TL=Instance.new("TextLabel",SF)TL.Size,TL.Position,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0,12,0,6),Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left local TiL=Instance.new("TextLabel",SF)TiL.Size,TiL.Position,TiL.TextColor3,TiL.Font,TiL.TextSize,TiL.BackgroundTransparency,TiL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0.5,0,0,6),CTh.A,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Right table.insert(TE.Txs,TiL)local RL=Instance.new("TextLabel",SF)RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,24),"Arraste para ajustar",Color3.fromRGB(160,160,165),Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left local Tk=Instance.new("Frame",SF)Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,46),Color3.fromRGB(25,25,28)Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)local pI=math.clamp((cV-mV)/(mxV-mV),0,1)local F=Instance.new("Frame",Tk)F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),CTh.A Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)table.insert(TE.Accs,F)local K=Instance.new("Frame",Tk)K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)local KS=Instance.new("UIStroke",K)KS.Color,KS.Thickness=CTh.A,2 table.insert(TE.Accs,KS)local function fUI(v)local h,m=math.floor(v),math.floor((v-math.floor(v))*60)local pt="Noite 🌙"if h>=6 and h<13 then pt="Dia ☀️"elseif h>=13 and h<18 then pt="Tarde 🌤️"end TL.Text="Período: "..pt TiL.Text=string.format("%02d:%02d",h,m)end fUI(cV)local HB=Instance.new("TextButton",SF)HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""local d=false local function upd(ip)local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)local pc=pX/Tk.AbsoluteSize.X local vl=mV+(mxV-mV)*pc TS:Create(F,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(pc,0,1,0)}):Play()TS:Create(K,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(pc,0,0.5,0)}):Play()fUI(vl)cb(vl)end HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)UIS.InputChanged:Connect(function(ip)if d and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then upd(ip)end end)return function(nV,ig)if d and ig then return end local pc=math.clamp((nV-mV)/(mxV-mV),0,1)F.Size=UDim2.new(pc,0,1,0)K.Position=UDim2.new(pc,0,0.5,0)fUI(nV)end end
local function cEGui(tM)local r,h=tM:FindFirstChild("HumanoidRootPart"),tM:FindFirstChildOfClass("Humanoid")if not r or not h then return nil end local bg=Instance.new("BillboardGui")bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="ESPGui",r,UDim2.new(0,400,0,45),Vector3.new(0,3.5,0),true,SG local el=Instance.new("TextLabel",bg)el.Size,el.BackgroundTransparency,el.RichText,el.TextStrokeTransparency,el.Font,el.TextSize,el.TextYAlignment=UDim2.new(1,0,1,0),1,true,0.5,Enum.Font.GothamBold,13,Enum.TextYAlignment.Center return{Gui=bg,Humanoid=h,Root=r,Label=el,Model=tM}end
local function cETb(tb)for k,d in pairs(tb)do if d.Gui then d.Gui:Destroy()end end table.clear(tb)end
local function uESP()if eUp then eUp:Disconnect()end if not enOn and not epOn then return end eUp=RS.RenderStepped:Connect(function()local lC=LP.Character local lR=lC and lC:FindFirstChild("HumanoidRootPart")if epOn then for _,p in pairs(P:GetPlayers())do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")and p.Character:FindFirstChild("Humanoid")then if isFriend(p) then continue end if not tPly[p]or tPly[p].Model~=p.Character then if tPly[p]and tPly[p].Gui then tPly[p].Gui:Destroy()end tPly[p]=cEGui(p.Character)end end end for p,d in pairs(tPly)do if not p or not p.Parent or not p.Character or not d.Humanoid or d.Humanoid.Health<=0 or d.Model~=p.Character or isFriend(p) then if d.Gui then d.Gui:Destroy()end tPly[p]=nil continue end local hS,dS=math.floor(d.Humanoid.Health),lR and d.Root and tostring(math.floor((lR.Position-d.Root.Position).Magnitude))or"???" d.Label.Text=string.format('<b><font color="%s">%s</font> | <font color="%s">HP: %s</font> | <font color="%s">%s studs</font></b>',ECol.PName,p.Name,ECol.PHP,hS,ECol.PDist,dS)end end if enOn then for m in pairs(CNPCs)do if m.Parent and not tNPC[m]then tNPC[m]=cEGui(m)end end for m,d in pairs(tNPC)do if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then if d.Gui then d.Gui:Destroy()end tNPC[m]=nil continue end local dist=lR and d.Root and(lR.Position-d.Root.Position).Magnitude or 9999 if dist>2500 then d.Gui.Enabled=false else d.Gui.Enabled=true d.Label.Text=string.format('<b><font color="%s">NAME: %s</font><br /><font color="%s">HP: %s</font><br /><font color="%s">Dist: %s</font></b>',ECol.NName,m.Name,ECol.NHP,math.floor(d.Humanoid.Health),ECol.NDist,math.floor(dist))end end end end)end
local function iHN(n)if not n:FindFirstChild("Humanoid")or P:GetPlayerFromCharacter(n)or n.Humanoid.Health<=0 then return false end for _,c in ipairs(n:GetChildren())do if c:IsA("Tool")then return true end end local nm,h=string.lower(n.Name),{"zombie","enemy","boss","killer","monster","soldier","mutant","dummy","bot","hostile","demon","beast","guard","slayer","vampire","werewolf","criminal","thief","attacker","infect","scp","entity","nextbot"}for _,v in ipairs(h)do if string.find(nm,v)then return true end end if n.Humanoid.MaxHealth>105 and n.Humanoid.MaxHealth<math.huge then return true end for _,d in ipairs(n:GetDescendants())do if d:IsA("Script")or d:IsA("LocalScript")then local s=string.lower(d.Name)if string.find(s,"damage")or string.find(s,"kill")or string.find(s,"attack")then return true end end end return false end
local function cDEsp(m)local r=m:FindFirstChild("HumanoidRootPart")if not r then return end local bg=Instance.new("BillboardGui")bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="DangerESP",r,UDim2.new(0,40,0,40),Vector3.new(0,6,0),true,SG local ic=Instance.new("TextLabel",bg)ic.Size,ic.BackgroundTransparency,ic.Text,ic.TextSize=UDim2.new(1,0,1,0),1,"⚠️",16 task.spawn(function()while bg.Parent do TS:Create(ic,TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{TextSize=22}):Play()break end end)return{Gui=bg,Model=m,Humanoid=m:FindFirstChild("Humanoid")}end
local function cDEspUp()if dUp then dUp:Disconnect()dUp=nil end if not dEspOn then return end dUp=RS.Heartbeat:Connect(function()for m in pairs(CNPCs)do if m.Parent and not tDNPC[m]and iHN(m)then tDNPC[m]=cDEsp(m)end end for m,d in pairs(tDNPC)do if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then if d.Gui then d.Gui:Destroy()end tDNPC[m]=nil end end end)end
local function rLig()L.FogStart,L.FogEnd,L.FogColor,L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale=OL.FS,OL.FE,OL.FC,OL.A,OL.OA,OL.B,OL.GS,OL.EDS,OL.ESS pcall(function()L.ShadowSoftness,L.Technology=OL.SS,OL.T end)if L:FindFirstChild("VortexAtmosphere")then L.VortexAtmosphere:Destroy()end end

-- [SHADERS] --
local function uLig()
    if fpsOn then 
        if sLp then sLp:Disconnect()sLp=nil end 
        L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale,L.GlobalShadows=0,0,false 
        clrCE()rLig()
    elseif shOn then 
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
        if not sLp then 
            local rP=RaycastParams.new()rP.FilterType=Enum.RaycastFilterType.Exclude 
            sLp=RS.RenderStepped:Connect(function()
                if pDead or fbOn then return end 
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
                    if fgOn then fs,fe,fc,ad,ac=0,90,cr,0.95,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                elseif i then 
                    a,oa=Color3.fromRGB(15,15,20),Color3.fromRGB(10,10,15) 
                    local cr=Color3.fromRGB(18,22,30) 
                    if fgOn then fs,fe,fc,ad,ac=10,220,cr,0.80,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                elseif n then 
                    a,oa=Color3.fromRGB(25,30,45),Color3.fromRGB(20,25,35) 
                    local cr=Color3.fromRGB(35,45,65) 
                    if fgOn then fs,fe,fc,ad,ac=80,800,cr,0.45,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                else 
                    a,oa=Color3.fromRGB(105,105,110),Color3.fromRGB(135,135,145) 
                    local cr=Color3.fromRGB(200,220,240) 
                    if fgOn then fs,fe,fc,ad,ac=200,4000,cr,0.15,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end 
                end 

                L.Ambient,L.OutdoorAmbient,L.FogStart,L.FogEnd,L.FogColor=L.Ambient:Lerp(a,0.08),L.OutdoorAmbient:Lerp(oa,0.08),L.FogStart+(fs-L.FogStart)*0.08,L.FogEnd+(fe-L.FogEnd)*0.08,L.FogColor:Lerp(fc,0.08)
                local atm=L:FindFirstChild("VortexAtmosphere")
                if atm then atm.Density,atm.Color=atm.Density+(ad-atm.Density)*0.08,atm.Color:Lerp(ac,0.08)end 
                local cb=L:FindFirstChild("VortexWallBlur")
                if cb then cb.Size=tB>cb.Size and tB or cb.Size+(tB-cb.Size)*0.2 end 
            end)
        end 
    else 
        if sLp then sLp:Disconnect()sLp=nil end 
        clrCE()rLig()
        if fgOn then L.FogStart,L.FogEnd,L.FogColor=100,2000,Color3.fromRGB(200,215,230)end 
    end 
end

local function eAF()if afc then afc:Disconnect()end afc=RS.Stepped:Connect(function()if not afOn then return end local c=LP.Character if not c then return end for _,p in pairs(c:GetChildren())do if p:IsA("BasePart")then if p.Velocity.Magnitude>1000 then p.Velocity=Vector3.new(0,0,0)end if p.RotVelocity.Magnitude>1000 then p.RotVelocity=Vector3.new(0,0,0)end end end for _,op in pairs(P:GetPlayers())do if op~=LP and op.Character then if isFriend(op) then continue end for _,oprt in pairs(op.Character:GetChildren())do if oprt:IsA("BasePart")then oprt.CanCollide=false if oprt.Velocity.Magnitude>100 then oprt.Velocity=Vector3.new(0,0,0)end if oprt.RotVelocity.Magnitude>100 then oprt.RotVelocity=Vector3.new(0,0,0)end end end end end end)end

cST("✨ GRÁFICOS",sM)local stU,ftU stU=cTog("✨ Shaders",sM,shOn,function(s)shOn=s uLig()end,"Shaders")

local originalPartsData = {}

local function applyBoostState(state)
    if fpsOn == state then return end
    fpsOn = state
    HC.FpsBoost = state
    saveC()
    if state then
        if shOn then
            shOn = false
            HC.Shaders = false
            saveC()
        end
        L.EnvironmentDiffuseScale = 0
        L.EnvironmentSpecularScale = 0
        L.GlobalShadows = false
        clrCE()
        rLig()
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end)
        task.spawn(function()
            for _, obj in ipairs(W:GetDescendants()) do
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
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end)
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

ftU=cTog("🥔 Booster FPS",sM,fpsOn,function(s)
    if s and shOn then 
        sNotif("Erro","Desative Shaders primeiro.","Error")
        fpsOn=false 
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

cTog("🌫️ Desfoque Parede",sM,wbOn,function(s)wbOn=s if not s then local b=L:FindFirstChild("VortexWallBlur")if b then b.Size=0 end end end,"WallBlur")cTog("🌫️ Neblina",sM,fgOn,function(s)fgOn=s uLig()end,"Fog")
cTog("🌀 Motion Blur",sM,mbOn,function(s)if s then local b=Instance.new("BlurEffect",L)b.Name,b.Size="VortexMotionBlur",0 local c=W.CurrentCamera if c then lCR=c.CFrame-c.CFrame.Position end mbc=RS.RenderStepped:Connect(function()local cam=W.CurrentCamera if not cam then return end local rot=cam.CFrame-cam.CFrame.Position local d=rot.LookVector:Dot(lCR.LookVector)local a=math.acos(math.clamp(d,-1,1))local tB=math.clamp(math.deg(a)*1.5,0,30)b.Size,lCR=b.Size+(tB-b.Size)*0.2,rot end)else if mbc then mbc:Disconnect()mbc=nil end local b=L:FindFirstChild("VortexMotionBlur")if b then b:Destroy()end end end,"MotionBlur")

local fbConn=nil
cTog("☀️ Fullbright",sM,fbOn,function(s)
    fbOn=s
    HC.Fullbright=s
    saveC()
    if s then
        if fbConn then fbConn:Disconnect() end
        fbConn=RS.RenderStepped:Connect(function()
            if not fbOn then return end
            L.Brightness = 2
            L.GlobalShadows = false
            L.Ambient = Color3.new(1, 1, 1)
            L.OutdoorAmbient = Color3.new(1, 1, 1)
            L.ColorShift_Bottom = Color3.new(1, 1, 1)
            L.ColorShift_Top = Color3.new(1, 1, 1)
            pcall(function()
                L.FogEnd = 100000
            end)
        end)
        sNotif("Fullbright", "Iluminação máxima ativada para mapas escuros!", "Success")
    else
        if fbConn then fbConn:Disconnect() fbConn=nil end
        rLig()
        sNotif("Fullbright", "Fullbright desativado.", "Info")
    end
end,"Fullbright")

cTog("🔦 Luz Player",sM,plOn,function(s)plOn=s if s then plc=RS.Heartbeat:Connect(function()local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local h=c.HumanoidRootPart if not h:FindFirstChild("VortexPlayerLight")then local l=Instance.new("PointLight",h)l.Name,l.Brightness,l.Range,l.Shadows,l.Color="VortexPlayerLight",3,60,false,Color3.new(1,1,1)end end end)else if plc then plc:Disconnect()plc=nil end local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local l=c.HumanoidRootPart:FindFirstChild("VortexPlayerLight")if l then l:Destroy()end end end end,"PlayerLight")

cST("⏰ TEMPO",sM)local uTSUI local mtLp local manualT=L.ClockTime 
cTog("🔄 Auto Tempo",sM,atOn,function(s)atOn=s if s then if mtLp then mtLp:Disconnect()mtLp=nil end atc=RS.RenderStepped:Connect(function(dt)L.ClockTime=(L.ClockTime+(0.4*dt))%24 manualT=L.ClockTime if uTSUI then uTSUI(L.ClockTime,true)end end)else if atc then atc:Disconnect()atc=nil end if not mtLp then mtLp=RS.RenderStepped:Connect(function()L.ClockTime=manualT end)end end end,"AutoTime")
uTSUI=cTSli(0,24,L.ClockTime,sM,function(v)manualT=v L.ClockTime=v end)
if not atOn then mtLp=RS.RenderStepped:Connect(function()L.ClockTime=manualT end)end

local rainLoop=nil local rPrt=nil local rEmt=nil
local function stpR()if rEmt then rEmt.Enabled=false end end
local function stRt()if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart")then return end if not rPrt then rPrt=Instance.new("Part")rPrt.Name="VtxRain"rPrt.Anchored=true rPrt.CanCollide=false rPrt.Transparency=1 rPrt.Size=Vector3.new(150,1,150)rPrt.Parent=W rEmt=Instance.new("ParticleEmitter",rPrt)rEmt.Texture="rbxassetid://2273224484"rEmt.Rate=600 rEmt.Speed=NumberRange.new(60,80)rEmt.Lifetime=NumberRange.new(1.5,2.5)rEmt.EmissionDirection=Enum.NormalId.Bottom rEmt.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,0.3)})rEmt.Color=ColorSequence.new(Color3.fromRGB(150,170,200))rEmt.Transparency=NumberSequence.new(0.5)end task.spawn(function()rEmt.Enabled=true local d=math.random(10,20)local sT=tick()while rrOn and(tick()-sT<d)and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")do rPrt.CFrame=LP.Character.HumanoidRootPart.CFrame*CFrame.new(0,50,0)task.wait(0.1)end stpR()end)end
cTog("🌧️ Chuva Aleatória (15% Chance)",sM,rrOn,function(s)rrOn=s if s then rainLoop=task.spawn(function()while rrOn do task.wait(5)if math.random(1,100)<=15 then stRt()task.wait(25)end end end)else if rainLoop then task.cancel(rainLoop)rainLoop=nil end stpR()end end,"RandomRain")

cST("👁️ ESP",sE)
cTog("👤 ESP Player",sE,epOn,function(s)epOn=s if not s then cETb(tPly)end uESP()end,"ESPPlayer")
cTog("🤖 ESP NPC",sE,enOn,function(s)enOn=s if not s then cETb(tNPC)end uESP()end,"ESPNPC")
cTog("⚠️ Alerta NPC Hostil",sE,dEspOn,function(s)dEspOn=s if not s then cETb(tDNPC)end cDEspUp()end,"DangerESP")

cST("🎨 CORES",sE)local function cECBtn(n,c3,hc)local b=Instance.new("TextButton",sE)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,32),Color3.fromRGB(45,45,45),"🎨 "..n,c3,Enum.Font.GothamBold,12 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(function()ECol.PName,ECol.NName=hc,hc end)end
cECBtn("Branco",Color3.fromRGB(255,255,255),"#FFFFFF")cECBtn("Amarelo",Color3.fromRGB(255,215,0),"#FFD700")cECBtn("Roxo",Color3.fromRGB(176,38,255),"#B026FF")cECBtn("Verde",Color3.fromRGB(50,205,50),"#32CD32")cECBtn("Rosa",Color3.fromRGB(255,20,147),"#FF1493")

cST("👤 MODS",sP)cTog("🌀 TeleportTool",sP,ttOn,function(s)ttOn=s if s then gTT()else rTT()end end,"TeleportTool")
cTog("⚡ Instant Interact",sP,iiOn,function(s)iiOn=s if s then for _,p in pairs(W:GetDescendants())do if p:IsA("ProximityPrompt")then p.HoldDuration=0 end end iic=PPS.PromptShown:Connect(function(p)p.HoldDuration=0 end)else if iic then iic:Disconnect()iic=nil end end end,"InstantInteract")

cTog("⚡ Mods Player",sP,pmOn,function(s)
    pmOn=s 
    if s then 
        pmc=RS.Stepped:Connect(function()
            if W.CurrentCamera then W.CurrentCamera.FieldOfView=pFov end 
            local c=LP.Character 
            if c then 
                local h=c:FindFirstChildOfClass("Humanoid")
                if h then 
                    h.UseJumpPower=true 
                    if h.WalkSpeed~=pSpd then h.WalkSpeed=pSpd end 
                    if h.JumpPower~=pJmp then h.JumpPower=pJmp end 
                end 
            end 
        end)
    else 
        if pmc then pmc:Disconnect()pmc=nil end 
        local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed,c.Humanoid.JumpPower=16,50 end 
        if W.CurrentCamera then W.CurrentCamera.FieldOfView=70 end 
    end 
end,"PlayerMods")

cTog("⚡ No Cooldown (Instantâneo)",sP,ncOn,function(s)ncOn=s if s then ncc=RS.Stepped:Connect(function()local c=LP.Character if c then for _,t in ipairs(c:GetChildren())do if t:IsA("Tool")then t.Enabled=true pcall(function()if t.Cooldown then t.Cooldown=0 end for _,v in ipairs(t:GetDescendants())do if v:IsA("NumberValue")or v:IsA("IntValue")then local ln=string.lower(v.Name)if string.find(ln,"cooldown")or string.find(ln,"cd")or string.find(ln,"time")or string.find(ln,"delay")then v.Value=0 end end end end)end end end if LP:FindFirstChild("Backpack")then for _,t in ipairs(LP.Backpack:GetChildren())do if t:IsA("Tool")then t.Enabled=true pcall(function()if t.Cooldown then t.Cooldown=0 end for _,v in ipairs(t:GetDescendants())do if v:IsA("NumberValue")or v:IsA("IntValue")then local ln=string.lower(v.Name)if string.find(ln,"cooldown")or string.find(ln,"cd")or string.find(ln,"time")or string.find(ln,"delay")then v.Value=0 end end end end)end end end end)else if ncc then ncc:Disconnect()ncc=nil end end end,"NoCooldown")
cTog("🚀 Inf Jump",sP,ijOn,function(s)ijOn=s if s then ijc=UIS.JumpRequest:Connect(function()local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)else if ijc then ijc:Disconnect()ijc=nil end end end,"InfJump")

local nclConn = nil
local lastNoclipCheck = 0
local wasInsideSolid = false

cTog("👻 Noclip",sP,nclOn,function(s)
    nclOn = s
    HC.Noclip = s
    saveC()
    if s then
        sNotif("Aviso Noclip", "Ativado! Cuidado: em alguns jogos o NOCLIP pode ser detectado como Exploração Indevida Por <font color='#FF0000'>CHEATS</font>.", "Error")
        if nclConn then nclConn:Disconnect() end
        nclConn = RS.Stepped:Connect(function()
            local c = LP.Character
            if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                
                local hrp = c:FindFirstChild("HumanoidRootPart")
                if hrp and tick() - lastNoclipCheck > 1 then
                    lastNoclipCheck = tick()
                    local partsInPart = W:GetPartsInPart(hrp)
                    local insideSolid = false
                    for _, pPart in ipairs(partsInPart) do
                        if pPart.CanCollide and not pPart:IsDescendantOf(c) then
                            insideSolid = true
                            break
                        end
                    end
                    if insideSolid and not wasInsideSolid then
                        wasInsideSolid = true
                        sNotif("Noclip Alerta", "Atravessando parede! Atenção à detecção de <font color='#FF0000'>CHEATS</font>.", "Error")
                    elseif not insideSolid then
                        wasInsideSolid = false
                    end
                end
            end
        end)
    else
        if nclConn then nclConn:Disconnect() nclConn = nil end
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

cSli("🏃 WalkSpeed","16 a 50",16,200,pSpd,sP,function(v)pSpd=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed=v end end end,"WalkSpeed")cSli("🦘 JumpPower","50 a 100",50,300,pJmp,sP,function(v)pJmp=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.JumpPower=v end end end,"JumpPower")cSli("🔭 FOV","70 a 90",70,120,pFov,sP,function(v)pFov=v end,"FOV")

cST("🛡️ PROTEÇÃO",sPr)cTog("🛡️ Anti-Fling",sPr,afOn,function(s)afOn=s if s then eAF()else if afc then afc:Disconnect()afc=nil end end end,"AntiFling")

-- [PROTEÇÃO FÍSICA DO MENU] --
local menuProtectionOn = false
local menuProtConn = nil

cTog("🛡️ Proteção Física Do Menu", sPr, menuProtectionOn, function(s)
    menuProtectionOn = s
    if s then
        sNotif("Proteção", "Ao Ativar Essa Função, O Menu Será Impossibilitado De Ser Retirado Da Tela", "Success")
        if menuProtConn then menuProtConn:Disconnect() end
        menuProtConn = RS.RenderStepped:Connect(function()
            if not menuProtectionOn or not MF or not MF.Parent then return end
            local cam = W.CurrentCamera
            if not cam then return end
            local vSize = cam.ViewportSize
            local pos = MF.AbsolutePosition
            local size = MF.AbsoluteSize
            
            if pos.X + size.X < 50 or pos.X > vSize.X - 50 or pos.Y + size.Y < 50 or pos.Y > vSize.Y - 50 then
                MF.Position = UDim2.new(0.5, -240, 0.5, -265)
                sNotif("Proteção", "Menu recuperado para o centro da tela!", "Info")
            end
        end)
    else
        if menuProtConn then menuProtConn:Disconnect() menuProtConn = nil end
        sNotif("Proteção", "Proteção Física do Menu desativada.", "Info")
    end
end, nil)

local antiLagConn = nil
local antiLagState = "IDLE" 
local lagStartTime = 0
local boostTriggerTime = 0

cTog("⚡ Anti-Lag / FPS Booster",sPr,antiLagOn,function(s)
    antiLagOn = s
    HC.AntiLag = s
    saveC()
    antiLagState = "IDLE"
    
    if antiLagConn then antiLagConn:Disconnect() antiLagConn = nil end
    
    if s then
        sNotif("Proteção","Auto-Anti-Lag ativado! Monitorando FPS...","Success")
        antiLagConn = RS.RenderStepped:Connect(function(dt)
            if not antiLagOn then return end
            local fps = 1 / dt
            local currentTime = tick()
            
            if antiLagState == "IDLE" then
                if fps >= 7 and fps <= 10 then
                    antiLagState = "BOOSTED"
                    lagStartTime = currentTime
                    boostTriggerTime = currentTime
                    applyBoostState(true)
                    sNotif("ANTI-LAG ATIVADO", "Queda detectada (7-10 FPS). Booster aplicado!", "Error")
                end
            elseif antiLagState == "BOOSTED" then
                if fps > 12 then
                    if currentTime - boostTriggerTime >= 5 then
                        antiLagState = "IDLE"
                        applyBoostState(false)
                        sNotif("Auto-AntiLag", "Jogo normalizado! Booster desativado e qualidade original restaurada.", "Info")
                    end
                else
                    if currentTime - lagStartTime >= 12 then
                        antiLagState = "IDLE"
                        applyBoostState(false)
                        shOn = true
                        HC.Shaders = true
                        saveC()
                        uLig()
                        sNotif("Auto-AntiLag", "Lag persistiu. Shaders ativados para máxima beleza!", "Success")
                    end
                end
            end
        end)
    else
        if antiLagConn then antiLagConn:Disconnect() antiLagConn = nil end
        applyBoostState(false)
        sNotif("Proteção","Anti-Lag desativado.","Info")
    end
end,"AntiLag")

cTog("🌌 Anti-Void",sPr,avOn,function(s)
    avOn=s 
    if s then 
        local rp=RaycastParams.new()
        rp.FilterType=Enum.RaycastFilterType.Exclude 
        avc=RS.Heartbeat:Connect(function()
            if not avOn then return end 
            local c=LP.Character 
            if not c then return end 
            local h,hu=c:FindFirstChild("HumanoidRootPart"),c:FindFirstChildOfClass("Humanoid")
            if not h or not hu or hu.Health<=0 then return end 
            rp.FilterDescendantsInstances={c}
            if hu.FloorMaterial~=Enum.Material.Air and h.Position.Y > -5 then 
                lSCf=h.CFrame 
            end 
            local groundCheck = W:Raycast(h.Position + Vector3.new(0, 5, 0), Vector3.new(0, -200, 0), rp)
            if h.Position.Y < -10 or (not groundCheck and h.Position.Y < 5) then 
                h.AssemblyLinearVelocity,h.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)
                pcall(function()h.Velocity,h.RotVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)end)
                local sCF 
                if lSCf and lSCf.Position.Y > 0 then 
                    sCF=lSCf+Vector3.new(0,3,0)
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
        if avc then avc:Disconnect()avc=nil end 
    end 
end,"AntiVoid")

cTog("🚫 Anti-AFK",sPr,aaOn,function(s)aaOn=s if s then aac=LP.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)else if aac then aac:Disconnect()aac=nil end end end,"AntiAfk")
cTog("🔄 Auto-Rejoin (Anti-Disconnect)",sPr,arOn,function(s)arOn=s if s then arc=game:GetService("GuiService").ErrorMessageChanged:Connect(function()task.wait(1.5)game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)else if arc then arc:Disconnect()arc=nil end end end,"AutoRejoin")

local function cTBtn(n,mc,tc,ac,tk)local b=Instance.new("TextButton",sTh)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,40),Color3.fromRGB(45,45,45),"🎨 "..n,ac,Enum.Font.GothamBold,14 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(function()appT(mc,tc,ac,tk)end)end
cTBtn("Orion",Color3.fromRGB(36,36,37),Color3.fromRGB(30,30,30),Color3.fromRGB(52,152,219),"Orion")cTBtn("Vampiro",Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50),"Vampiro")cTBtn("Tóxico",Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100),"Tóxico")cTBtn("Ametista",Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182),"Ametista")cTBtn("Ouro",Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15),"Ouro")cTBtn("Sakura",Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204),"Sakura")cTBtn("Neon",Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255),"Neon")cTBtn("Magma",Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34),"Magma")
cTBtn("Cyberpunk",Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0),"Cyberpunk")cTBtn("Oceano",Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255),"Oceano")cTBtn("Inferno",Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0),"Inferno")cTBtn("Fantasma",Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230),"Fantasma")cTBtn("Floresta",Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100),"Floresta")

-- [DEFENSE & COMBAT & AUTO FARM DE POÇÃO DE VIDA] --
cST("🛡️ DEFENSE & COMBAT",sDC)

local warnPotionLbl = Instance.new("TextLabel", sDC)
warnPotionLbl.Size, warnPotionLbl.BackgroundTransparency, warnPotionLbl.Text, warnPotionLbl.TextColor3, warnPotionLbl.Font, warnPotionLbl.TextSize, warnPotionLbl.TextWrapped, warnPotionLbl.TextXAlignment = UDim2.new(1,0,0,24), 1, "É Preciso Ter O Item, Poção De vida para Continuar", Color3.fromRGB(255, 200, 50), Enum.Font.GothamBold, 11, true, Enum.TextXAlignment.Left
table.insert(TE.Txs, warnPotionLbl)

cTog("🧪 Auto-Usar Poção de Vida", sDC, autoHealOn, function(s)
    autoHealOn = s
    HC.AutoHeal = s
    saveC()
    if s then
        if autoHealConn then autoHealConn:Disconnect() end
        
        autoHealConn = RS.Heartbeat:Connect(function()
            if not autoHealOn then return end
            local c = LP.Character
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local maxH = hum.MaxHealth > 0 and hum.MaxHealth or 100
                local currentPct = (hum.Health / maxH) * 100
                if currentPct <= healthThresholdPct then
                    autoUseHealthPotion()
                end
            end
        end)
        
        sNotif("Defense & Combat", "Auto-Cura contínua ativada e monitorando vida!", "Success")
    else
        if autoHealConn then autoHealConn:Disconnect() autoHealConn = nil end
        sNotif("Defense & Combat", "Auto-Cura desativada.", "Info")
    end
end, "AutoHeal")

cSli("Em Que Momento Usar O Item", "60 (%)", 0, 100, healthThresholdPct, sDC, function(v)
    healthThresholdPct = v
    HC.HealthThreshold = v
    saveC()
end, "HealthThreshold")

-- [AUTO-CLICK NA POÇÃO DE VIDA OTIMIZADO E SEM LAG] --
local autoClickPotionConn = nil
cTog("🧪 Auto-Click Poção De vida", sDC, autoClickPotionOn, function(s)
    autoClickPotionOn = s
    HC.AutoClickPotion = s
    saveC()
    if s then
        if autoClickPotionConn then task.cancel(autoClickPotionConn) end
        autoClickPotionConn = task.spawn(function()
            while autoClickPotionOn do
                task.wait(1.5)
                pcall(function()
                    for _, obj in ipairs(W:GetDescendants()) do
                        if not autoClickPotionOn then break end
                        if obj and obj.Parent then
                            if isHealthPotionStrict(obj.Name, obj.Parent.Name) then
                                local cd = obj:FindFirstChildOfClass("ClickDetector") or obj.Parent:FindFirstChildOfClass("ClickDetector")
                                if not cd and obj:IsA("Model") then
                                    cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
                                end
                                if cd then
                                    fireclickdetector(cd)
                                end
                            end
                        end
                    end
                end)
            end
        end)
        sNotif("Defense & Combat", "Auto-Click Poção de Vida ativado!", "Success")
    else
        if autoClickPotionConn then task.cancel(autoClickPotionConn) autoClickPotionConn = nil end
        sNotif("Defense & Combat", "Auto-Click Poção de Vida desativado.", "Info")
    end
end, "AutoClickPotion")

-- [AUTO-GRAB: TELEPORT INSTANTÂNEO EM CIMA DA POÇÃO DE VIDA PARA PEGAR ANTES DE TODOS] --
local autoGrabTask = nil

cTog("🎒 Auto-Grab", sDC, autoCollectPotionOn, function(s)
    autoCollectPotionOn = s
    HC.AutoCollectPotion = s
    saveC()
    if s then
        if autoGrabTask then task.cancel(autoGrabTask) end
        autoGrabTask = task.spawn(function()
            while autoCollectPotionOn do
                task.wait(0.08) -- Checagem ultra rápida para agarrar a poção instantaneamente
                pcall(function()
                    local char = LP.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    
                    local targetPart = nil
                    local targetCD = nil
                    
                    for _, obj in ipairs(W:GetDescendants()) do
                        if not autoCollectPotionOn then break end
                        if obj and obj.Parent then
                            if isHealthPotionStrict(obj.Name, obj.Parent.Name) then
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
                    
                    if targetCD then
                        fireclickdetector(targetCD)
                    elseif targetPart then
                        -- TELEPORTE INSTANTÂNEO EXATAMENTE EM CIMA DA POÇÃO PARA GARANTIR A COLETA IMEDIATA
                        hrp.CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 0.5, 0))
                        pcall(function()
                            firetouchinterest(hrp, targetPart, 0)
                            task.wait()
                            firetouchinterest(hrp, targetPart, 1)
                        end)
                    end
                end)
            end
        end)
        sNotif("Auto-Grab", "Auto-Grab de poções de vida ativado!", "Success")
    else
        if autoGrabTask then task.cancel(autoGrabTask) autoGrabTask = nil end
        sNotif("Auto-Grab", "Auto-Grab desativado.", "Info")
    end
end, "AutoCollectPotion")

-- [ABA VIEWER & LOOP PLAYERS COM WHITELIST E LOOP EXPLOSION] --
cST("👥 VIEWER & LOOP PLAYERS",sV)
local uPL 
cTog("🛡️ Whitelist de Amigos",sV,wlOn,function(s)
    wlOn=s 
    if uPL then uPL() end 
    uESP()
end,"Whitelist")

local sPly=nil
local disconnectedTarget=nil

P.PlayerRemoving:Connect(function(p)
    if sPly == p then
        disconnectedTarget = {
            Name = p.Name,
            DisplayName = p.DisplayName,
            UserId = p.UserId,
        }
    end
    aLH(p,"EXIT")
    uPL()
end)

P.PlayerAdded:Connect(function(p)
    if disconnectedTarget and p.Name == disconnectedTarget.Name then
        disconnectedTarget = nil
    end
    aLH(p,"JOIN")
    uPL()
end)

local TgtF=Instance.new("Frame",sV)
TgtF.Size,TgtF.BackgroundColor3=UDim2.new(1,0,0,50),Color3.fromRGB(35,35,40)
Instance.new("UICorner",TgtF).CornerRadius=UDim.new(0,8)
Instance.new("UIStroke",TgtF).Color=Color3.fromRGB(60,60,65)

local TarName=Instance.new("TextLabel",TgtF)
TarName.Size,TarName.Position,TarName.BackgroundTransparency,TarName.Text,TarName.TextColor3,TarName.Font,TarName.TextSize,TarName.TextXAlignment=UDim2.new(0.4,0,1,0),UDim2.new(0,15,0,0),1,"Select Player",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,Enum.TextXAlignment.Left
table.insert(TE.Txs,TarName)

local SelectSearchIcon = Instance.new("ImageLabel", TgtF)
SelectSearchIcon.Size, SelectSearchIcon.Position, SelectSearchIcon.BackgroundTransparency, SelectSearchIcon.Image = UDim2.new(0,18,0,18), UDim2.new(1,-115,0.5,-9), 1, "rbxassetid://6031094667"
SelectSearchIcon.ImageColor3 = Color3.fromRGB(255,255,255)

local SelText = Instance.new("TextLabel", TgtF)
SelText.Size, SelText.Position, SelText.BackgroundTransparency, SelText.Text, SelText.TextColor3, SelText.Font, SelText.TextSize, SelText.TextXAlignment = UDim2.new(0,60,0,18), UDim2.new(1,-95,0.5,-9), 1, "Selected", Color3.fromRGB(180,180,180), Enum.Font.Gotham, 13, Enum.TextXAlignment.Left
SelText.TextTruncate = Enum.TextTruncate.AtEnd
table.insert(TE.Txs, SelText)

local Arrow = Instance.new("TextLabel", TgtF)
Arrow.Size, Arrow.Position, Arrow.BackgroundTransparency, Arrow.Text, Arrow.TextColor3, Arrow.Font, Arrow.TextSize = UDim2.new(0,18,0,18), UDim2.new(1,-25,0.5,-9), 1, "▼", Color3.fromRGB(150,150,150), Enum.Font.GothamBold, 12

local TgtBtn=Instance.new("TextButton",TgtF)
TgtBtn.Size,TgtBtn.BackgroundTransparency,TgtBtn.Text=UDim2.new(1,0,1,0),1,""

local PLContainer=Instance.new("Frame",sV)PLContainer.Size,PLContainer.BackgroundTransparency,PLContainer.Visible=UDim2.new(1,0,0,225),1,false

local SBF=Instance.new("Frame",PLContainer)SBF.Size,SBF.BackgroundColor3=UDim2.new(1,0,0,35),Color3.fromRGB(30,30,35)Instance.new("UICorner",SBF).CornerRadius=UDim.new(0,6)
local SIc=Instance.new("ImageLabel",SBF)
SIc.Size, SIc.Position, SIc.BackgroundTransparency, SIc.Image = UDim2.new(0,18,0,18), UDim2.new(0,10,0.5,-9), 1, "rbxassetid://6031094667"
SIc.ImageColor3 = Color3.fromRGB(255,255,255)
local SInp=Instance.new("TextBox",SBF)SInp.Size,SInp.Position,SInp.BackgroundTransparency,SInp.Text,SInp.PlaceholderText,SInp.TextColor3,SInp.Font,SInp.TextSize,SInp.TextXAlignment=UDim2.new(1,-45,1,0),UDim2.new(0,35,0,0),1,"","Pesquisar jogador...",Color3.fromRGB(255,255,255),Enum.Font.Gotham,13,Enum.TextXAlignment.Left

local PLF=Instance.new("ScrollingFrame",PLContainer)PLF.Size,PLF.Position,PLF.BackgroundColor3,PLF.BorderSizePixel,PLF.ScrollBarThickness=UDim2.new(1,0,1,-45),UDim2.new(0,0,0,45),Color3.fromRGB(30,30,35),0,4 
Instance.new("UICorner",PLF).CornerRadius=UDim.new(0,6)
local UIL=Instance.new("UIListLayout",PLF)UIL.Padding,UIL.HorizontalAlignment,UIL.SortOrder=UDim.new(0,6),Enum.HorizontalAlignment.Center,Enum.SortOrder.Name 
UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()PLF.CanvasSize=UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y+10)end)
local pBD={}

TgtBtn.MouseButton1Click:Connect(function()
    PLContainer.Visible = not PLContainer.Visible
    Arrow.Text = PLContainer.Visible and "▲" or "▼"
end)

uPL=function()
    for _,d in pairs(pBD)do d.Btn:Destroy()end table.clear(pBD)
    local f=string.lower(SInp.Text or"")
    
    if disconnectedTarget then
        local p = disconnectedTarget
        local b=Instance.new("TextButton",PLF)
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
        
        local wifiIc = Instance.new("ImageLabel", b)
        wifiIc.Size, wifiIc.Position, wifiIc.BackgroundTransparency, wifiIc.Image = UDim2.new(0,22,0,22), UDim2.new(1,-32,0.5,-11), 1, "rbxassetid://6035047409"
        wifiIc.ImageColor3 = Color3.fromRGB(255, 90, 90)
        
        b.MouseButton1Click:Connect(function()
            disconnectedTarget = nil
            uPL()
            sNotif("Viewer","Jogador offline removido da lista.","Info")
        end)
        table.insert(pBD,{Btn=b})
    end

    for _,p in ipairs(P:GetPlayers())do
        if p~=LP then
            if isFriend(p) then continue end 
            
            local b=Instance.new("TextButton",PLF)
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
                if sPly == p then
                    sPly = nil
                    SelText.Text = "Selected"
                    sNotif("Viewer","Jogador desmarcado.","Info")
                else
                    sPly=p 
                    disconnectedTarget = nil
                    TarName.Text="Select Player" 
                    SelText.Text = p.DisplayName 
                    sNotif("Alvo","Selecionado: "..p.Name,"Info")
                end
                PLContainer.Visible = false
                Arrow.Text = "▼"
            end)
            table.insert(pBD,{Btn=b,Player=p})
            local pn,pd=string.lower(p.Name),string.lower(p.DisplayName)
            if f==""or string.find(pn,f)or string.find(pd,f)then b.Visible=true else b.Visible=false end
        end
    end
end
SInp:GetPropertyChangedSignal("Text"):Connect(uPL)uPL()

-- [SISTEMA LOOP EXPLOSION COM TELEPORTE PARA A PLACA DA MOTO (WALLDELANTERA2 / wallgenen3)] --
cST("💥 LOOP EXPLOSION SYSTEM",sV)

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

local loopExplosionTask = nil

cTog("💥 Loop Explosion", sV, loopExplosionOn, function(s)
    loopExplosionOn = s
    HC.LoopExplosion = s
    saveC()
    
    if s then
        if not sPly and not disconnectedTarget then
            sNotif("Aviso", "Selecione um jogador na lista do Viewer primeiro!", "Error")
            loopExplosionOn = false
            return
        end
        
        sNotif("Loop Explosion", "Sistema iniciado com placa da moto (WALLDELANTERA2)!", "Success")
        
        if loopExplosionTask then task.cancel(loopExplosionTask) end
        loopExplosionTask = task.spawn(function()
            while loopExplosionOn do
                task.wait(0.3)
                pcall(function()
                    local char = LP.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if not hrp or not hum or hum.Health <= 0 then return end
                    
                    -- Passo 1: Se NÃO TEM A MOTO NO INVENTÁRIO, teleportar para a placa gigante (WALLDELANTERA2)
                    if not hasMotoItem() then
                        local platePart = getMotoPlatePart()
                        if platePart then
                            hrp.CFrame = platePart.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.2)
                        end
                        
                        for _, obj in ipairs(W:GetDescendants()) do
                            if not loopExplosionOn then break end
                            if obj and obj.Parent then
                                local nm = string.lower(obj.Name)
                                local pNm = string.lower(obj.Parent.Name or "")
                                
                                local isExcluded = string.find(nm, "feedback") or string.find(pNm, "feedback") or string.find(nm, "report") or string.find(pNm, "report") or string.find(nm, "health") or string.find(nm, "potion")
                                
                                if not isExcluded and (string.find(nm, "wallgenen3") or string.find(nm, "call tool moto no dmg") or string.find(pNm, "walldelantera") or string.find(nm, "call tool moto")) then
                                    local cd = obj:FindFirstChildOfClass("ClickDetector") or obj.Parent:FindFirstChildOfClass("ClickDetector")
                                    if not cd and obj:IsA("Model") then
                                        cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
                                    end
                                    if cd then
                                        fireclickdetector(cd)
                                    end
                                    local pp = obj:FindFirstChildOfClass("ProximityPrompt") or obj.Parent:FindFirstChildOfClass("ProximityPrompt")
                                    if pp then
                                        pcall(function() fireproximityprompt(pp) end)
                                    end
                                end
                            end
                        end
                        
                        local motoPart = nil
                        for _, obj in ipairs(W:GetDescendants()) do
                            if not loopExplosionOn then break end
                            if obj and obj.Parent then
                                local nm = string.lower(obj.Name)
                                local pNm = string.lower(obj.Parent.Name or "")
                                local isExcluded = string.find(nm, "feedback") or string.find(pNm, "feedback") or string.find(nm, "health") or string.find(nm, "potion")
                                if not isExcluded and (isMotoStrict(obj.Name) or string.find(nm, "call tool moto no dmg")) then
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
                            task.wait(0.1)
                            pcall(function()
                                firetouchinterest(hrp, motoPart, 0)
                                task.wait()
                                firetouchinterest(hrp, motoPart, 1)
                            end)
                        end
                        
                    else
                        -- Passo 2: QUANDO DETECTAR A MOTO NO INVENTÁRIO, EQUIPAR E USAR
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
                            pcall(function() 
                                motoTool:Activate() 
                            end)
                            task.wait(0.15)
                            pcall(function() 
                                motoTool:Activate() 
                            end)
                            task.wait(0.2)
                        end
                        
                        -- Passo 3: TELEPORTAR NO PLAYER ALVO COM A MOTO NA MÃO
                        local targetHRP = nil
                        if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart") then
                            targetHRP = sPly.Character.HumanoidRootPart
                        end
                        
                        if targetHRP then
                            hrp.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.25)
                            
                            -- Passo 4: AUTO-RESET DO PERSONAGEM PARA GERAR A EXPLOSÃO
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
        if loopExplosionTask then task.cancel(loopExplosionTask) loopExplosionTask = nil end
        sNotif("Loop Explosion", "Sistema desativado com segurança.", "Info")
    end
end, "LoopExplosion")

-- [SISTEMA LOOP DEATH (FLING COM CORREÇÃO DE PING/LATÊNCIA)] --
cST("💀 LOOP DEATH",sV)
local flingLoop, flingOrigCF
cTog("🌪️ Loop <font color='#39FF14'><b>Fling</b></font> [OWNERSHIP]",sV,false,function(s)
    if s then
        if not sPly and not disconnectedTarget then sNotif("Aviso","Selecione um jogador primeiro!","Error") return end
        if not sPly and disconnectedTarget then sNotif("Aviso","O jogador selecionado está offline!","Error") return end
        local c = LP.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            flingOrigCF = c.HumanoidRootPart.CFrame 
        end
        flingLoop = RS.Heartbeat:Connect(function()
            local c = LP.Character
            if c and sPly and sPly.Character and c:FindFirstChild("HumanoidRootPart") and sPly.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = c.HumanoidRootPart
                local tHrp = sPly.Character.HumanoidRootPart
                hrp.RotVelocity = Vector3.new(30000, 30000, 30000)
                hrp.AssemblyLinearVelocity = tHrp.AssemblyLinearVelocity + Vector3.new(0, 50, 0)
                for _, part in ipairs(c:GetChildren()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
                local predictedCF = tHrp.CFrame + (tHrp.AssemblyLinearVelocity * 0.15)
                hrp.CFrame = predictedCF
            end
        end)
        sNotif("Fling","Fling (Kill) ativado com correção de ping/latência em "..sPly.Name,"Success")
    else
        if flingLoop then flingLoop:Disconnect() flingLoop = nil end
        local c = LP.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local hrp = c.HumanoidRootPart
            hrp.RotVelocity = Vector3.new(0,0,0)
            for _, part in ipairs(c:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
            hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
            hrp.AssemblyAngularVelocity = Vector3.new(0,0,0)
            pcall(function()
                hrp.Velocity = Vector3.new(0,0,0)
                hrp.RotVelocity = Vector3.new(0,0,0)
            end)
            if flingOrigCF then
                hrp.CFrame = flingOrigCF + Vector3.new(0, 3, 0) 
            end
        end
        sNotif("Fling","Fling desativado. Posição restaurada com segurança.","Info")
    end
end,nil)

-- [OPERAÇÕES GERAIS] --
cST("⚙️ LOOP ANNOY / AÇÕES",sV)
local function cAB(n,p,cb)local B=Instance.new("TextButton",p)B.Size,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(1,0,0,38),Color3.fromRGB(45,45,45),n,Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13 Instance.new("UICorner",B).CornerRadius=UDim.new(0,6)B.MouseButton1Click:Connect(function()if sPly then cb(sPly)else sNotif("Aviso","Selecione um jogador na lista acima primeiro!","Error")end end)end
cAB("🚀 Teleport",sV,function(t)if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)sNotif("Teleport","Teleportado para "..t.Name,"Success")end end)
local vCn cTog("👁️ View (Spectate)",sV,false,function(s)if s then if sPly and sPly.Character and sPly.Character:FindFirstChild("Humanoid")then W.CurrentCamera.CameraSubject=sPly.Character.Humanoid sNotif("View","Assistindo "..sPly.Name,"Info")else sNotif("Aviso","O alvo não tem um personagem válido.","Error")end else if LP.Character and LP.Character:FindFirstChild("Humanoid")then W.CurrentCamera.CameraSubject=LP.Character.Humanoid end end end,nil)
local lgCn cTog("🔁 Loopgoto",sV,false,function(s)if s then if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end if lgCn then lgCn:Disconnect()end lgCn=RS.Heartbeat:Connect(function()if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=sPly.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)end end)else if lgCn then lgCn:Disconnect()lgCn=nil end end end,nil)
local fCn cTog("🏃 Follow Player",sV,false,function(s)if s then if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end if fCn then fCn:Disconnect()end fCn=RS.Heartbeat:Connect(function()if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("Humanoid")then LP.Character.Humanoid:MoveTo(sPly.Character.HumanoidRootPart.Position)end end)else if fCn then fCn:Disconnect()fCn=nil end end end,nil)

-- [HEADPET] --
local hpCn,hpOrigCF cTog("🐶 Headpet",sV,false,function(s)
    if s then 
        if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end 
        local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then hpOrigCF=c.HumanoidRootPart.CFrame end 
        if hpCn then hpCn:Disconnect()end 
        hpCn=RS.RenderStepped:Connect(function()
            if sPly and sPly.Character and sPly.Character:FindFirstChild("Head") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then 
                local hrp=LP.Character.HumanoidRootPart 
                local hum=LP.Character:FindFirstChildOfClass("Humanoid")
                local targetHead=sPly.Character.Head 
                if hum then hum.PlatformStand=true end 
                hrp.CFrame=targetHead.CFrame*CFrame.new(0,1.15,0) 
                hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
                hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)
            end 
        end)
        sNotif("Headpet","Ativado no alvo: "..sPly.Name,"Info")
    else 
        if hpCn then hpCn:Disconnect()hpCn=nil end 
        if LP.Character then 
            local hum=LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand=false end 
        end
        if hpOrigCF and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=hpOrigCF end 
        sNotif("Headpet","Desativado.","Info")
    end 
end,nil)

cAB("📋 Copiar Username",sV,function(t)if setclipboard then setclipboard(t.Name)sNotif("Copiado","Username ("..t.Name..") copiado!","Success")else sNotif("Erro","Seu executor não suporta setclipboard.","Error")end end)cAB("📋 Copiar ID",sV,function(t)if setclipboard then setclipboard(tostring(t.UserId))sNotif("Copiado","ID ("..tostring(t.UserId)..") copiado!","Success")else sNotif("Erro","Seu executor não suporta setclipboard.","Error")end end)cAB("📋 Copiar Name",sV,function(t)if setclipboard then setclipboard(t.DisplayName)sNotif("Copiado","Display Name ("..t.DisplayName..") copiado!","Success")else sNotif("Erro","Seu executor não suporta setclipboard.","Error")end end)

task.spawn(function()if not LP.Character then LP.CharacterAdded:Wait()end task.wait(0.5)local sT=HC.SelectedTheme if sT=="Vampiro"then appT(Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50))elseif sT=="Tóxico"then appT(Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100))elseif sT=="Ametista"then appT(Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182))elseif sT=="Ouro"then appT(Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15))elseif sT=="Sakura"then appT(Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204))elseif sT=="Neon"then appT(Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255))elseif sT=="Magma"then appT(Color3.fromRGB(40,20,10),Color3.fromRGB(40,20,10))elseif sT=="Cyberpunk"then appT(Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0))elseif sT=="Oceano"then appT(Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255))elseif sT=="Inferno"then appT(Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0))elseif sT=="Fantasma"then appT(Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230))elseif sT=="Floresta"then appT(Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100))end for _,iF in pairs(IC)do pcall(function()iF()end)end uLig()end)
