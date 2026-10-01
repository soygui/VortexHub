local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
local LP=P.LocalPlayer local TP=(gethui and gethui())or CG if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end

local SFName="VortexHub_Config.json"
local HC={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,RandomRain=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,ESPItems=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,AutoRejoin=false,Notifications=true,SelectedTheme="Orion",Whitelist=true}
local IC={} local function saveC()pcall(function()if writefile then writefile(SFName,HS:JSONEncode(HC))end end)end
local function loadC()if readfile and isfile and isfile(SFName)then local s,d=pcall(function()return HS:JSONDecode(readfile(SFName))end)if s and type(d)=="table"then for k,v in pairs(d)do if HC[k]~=nil then HC[k]=v end end end end end loadC()

local shOn,fpsOn,wbOn,fgOn,mbOn,fbOn,plOn,atOn,rrOn,epOn,enOn,dEspOn,espiOn,ttOn,iiOn,pmOn,ncOn,ijOn,nclOn,pSpd,pJmp,pFov,afOn,avOn,aaOn,arOn,jelOn,wlOn=HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.ESPItems,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip,HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist
local ijc,nlc,avc,pmc,aac,arc,atc,sLp,iic,fbLp,plc,mbc,afc,ncc local lSCf=nil local lCR=CFrame.new()
local ECol={PName="#00FFFF",PHP="#32FF32",PDist="#FFAA00",NName="#FF4444",NHP="#32FF32",NDist="#FFAA00",ItemName="#00FFCC",ItemDist="#FFAA00"}

-- SISTEMA DE AUTO-DETECÇÃO EM TEMPO REAL (SEM PRECISAR ATIVAR/DESATIVAR)
local allPlayers, allNPCs, allItems = {}, {}, {}
local tNPC,tPly,tDNPC,tItems={},{},{},{}
local eUp,dUp,itemUp

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

LP.CharacterAdded:Connect(function(c)
    pDead=false
    if dF then TS:Create(dF,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Brightness=0,Contrast=0}):Play()end
    local wb=L:FindFirstChild("VortexWallBlur")if wb then TS:Create(wb,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Size=0}):Play()end
    stDE(c)
    if ttOn then task.spawn(function()task.wait(0.5)gTT()end)end
end)
if LP.Character then stDE(LP.Character)end

local function gPB(cam,c)if not wbOn then return 0 end local mB,mD,cD=12,45,45 local rP=RaycastParams.new()rP.FilterType=Enum.RaycastFilterType.Exclude rP.FilterDescendantsInstances={c,cam}local ang={CFrame.Angles(0,0,0),CFrame.Angles(0,math.rad(25),0),CFrame.Angles(0,math.rad(-25),0),CFrame.Angles(math.rad(15),0,0),CFrame.Angles(math.rad(-15),0,0)}for _,a in ipairs(ang)do local dir=(cam.CFrame*a).LookVector local h=W:Raycast(cam.CFrame.Position,dir*mD,rP)if h and h.Instance and h.Instance.Transparency<0.8 and h.Instance.CanCollide and h.Distance<cD then cD=h.Distance end end local vS=cam.ViewportSize local function ckD(hrp,obj)local d=(hrp.Position-cam.CFrame.Position).Magnitude if d<mD then local sP,oS=cam:WorldToViewportPoint(hrp.Position)if oS and sP.X>=0 and sP.X<=vS.X and sP.Y>=0 and sP.Y<=vS.Y then local ry=W:Raycast(cam.CFrame.Position,(hrp.Position-cam.CFrame.Position),rP)if not ry or ry.Instance:IsDescendantOf(obj)then if d<cD then cD=d end end end end end for _,p in ipairs(P:GetPlayers())do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then ckD(p.Character.HumanoidRootPart,p.Character)end end for _,o in ipairs(W:GetChildren())do if o:IsA("Model")and o~=c and o:FindFirstChildOfClass("Humanoid")then local tH=o:FindFirstChild("HumanoidRootPart")or o.PrimaryPart if tH then ckD(tH,o)end end end if cD<mD then return(1-(cD/mD))*mB end return 0 end
local function cInd(hrp,rP)if not hrp then return false end local hs=0 local off={Vector3.new(0,0,0),Vector3.new(8,0,0),Vector3.new(-8,0,0),Vector3.new(0,0,8),Vector3.new(0,0,-8)}for _,o in ipairs(off)do local h=W:Raycast(hrp.Position+o,Vector3.new(0,120,0),rP)if h and h.Instance and h.Instance.CanCollide and h.Instance.Transparency<0.5 then hs=hs+1 end end return hs>=3 end

local CNPCs={}
local function cNPC(o)
    if o:IsA("Model")and o:FindFirstChild("Humanoid")and o:FindFirstChild("HumanoidRootPart")and not P:GetPlayerFromCharacter(o)then
        CNPCs[o]=true
    end
end
for _,o in ipairs(W:GetDescendants())do cNPC(o)end
W.DescendantAdded:Connect(function(o)
    task.delay(0.2,function()
        if o and o.Parent then
            if o:IsA("Model")then cNPC(o)end
            if o.Parent:IsA("Model")then cNPC(o.Parent)end
        end
    end)
end)
W.DescendantRemoving:Connect(function(o)if CNPCs[o]then CNPCs[o]=nil end end)

-- TEMA MELHORADO (UI 1000X)
local CTh={
    MBG=Color3.fromRGB(18,18,22),
    TB=Color3.fromRGB(24,24,30),
    A=Color3.fromRGB(88,101,242),
    A2=Color3.fromRGB(138,43,226),
    Card=Color3.fromRGB(28,28,36),
    CardHover=Color3.fromRGB(38,38,48),
    Text=Color3.fromRGB(240,240,250),
    TextDim=Color3.fromRGB(150,155,175),
    Success=Color3.fromRGB(87,242,135),
    Danger=Color3.fromRGB(237,66,69),
    Warn=Color3.fromRGB(250,166,26)
}
local TE={Bgs={},TBs={},Accs={},Tgls={},Txs={},Cards={},Strokes={}}

local function appT(m,t,a,tn)
    CTh.MBG=m CTh.TB=t CTh.A=a
    if tn then HC.SelectedTheme=tn saveC()end
    for _,f in pairs(TE.Bgs)do TS:Create(f,TweenInfo.new(0.3),{BackgroundColor3=m}):Play()end
    for _,f in pairs(TE.TBs)do TS:Create(f,TweenInfo.new(0.3),{BackgroundColor3=t}):Play()end
    for _,o in pairs(TE.Accs)do
        if o:IsA("UIStroke")then TS:Create(o,TweenInfo.new(0.3),{Color=a}):Play()
        elseif o:IsA("TextLabel")then TS:Create(o,TweenInfo.new(0.3),{TextColor3=a}):Play()
        else TS:Create(o,TweenInfo.new(0.3),{BackgroundColor3=a}):Play()end
    end
    for _,tx in pairs(TE.Txs)do TS:Create(tx,TweenInfo.new(0.3),{TextColor3=a}):Play()end
end

local SG=Instance.new("ScreenGui",TP)SG.Name="VortexGraphicsHub"SG.ResetOnSpawn=false
local ANotif={}

local function sNotif(tl,tx,nt)
    if not jelOn and(nt=="Info"or tl=="🟢"or tl=="🔴")then return end
    if tl=="Alvo"then
        for i=#ANotif,1,-1 do
            local v=ANotif[i]
            if v:FindFirstChild("NTitle")and v.NTitle.Text=="Alvo"then v:Destroy()table.remove(ANotif,i)end
        end
    end
    local cls={Error=CTh.Danger,Info=CTh.A,Success=CTh.Success,Warn=CTh.Warn}
    local cc=cls[nt]or cls.Info
    local icn=nt=="Error"and"⚠️"or(nt=="Success"and"✅"or(nt=="Warn"and"⚡"or"ℹ️"))
    local NF=Instance.new("Frame",SG)
    NF.Size,NF.Position,NF.BackgroundColor3,NF.BorderSizePixel=UDim2.new(0,300,0,68),UDim2.new(1,20,1,-90-(#ANotif*78)),CTh.Card,0
    NF.BackgroundTransparency=0.05
    Instance.new("UICorner",NF).CornerRadius=UDim.new(0,10)
    local sk=Instance.new("UIStroke",NF)sk.Color=cc sk.Thickness=1.5 sk.Transparency=0.3
    local Sd=Instance.new("Frame",NF)Sd.Size,Sd.Position,Sd.BackgroundColor3,Sd.BorderSizePixel=UDim2.new(0,4,1,0),UDim2.new(0,0,0,0),cc,0
    Instance.new("UICorner",Sd).CornerRadius=UDim.new(0,10)
    local Ic=Instance.new("TextLabel",NF)Ic.Size,Ic.Position,Ic.BackgroundTransparency,Ic.Text,Ic.TextSize=UDim2.new(0,40,0,40),UDim2.new(0,12,0.5,-20),1,icn,24
    local Txt=Instance.new("TextLabel",NF)Txt.Name="NTitle"Txt.Size,Txt.Position,Txt.BackgroundTransparency,Txt.Text,Txt.TextColor3,Txt.Font,Txt.TextSize,Txt.TextXAlignment=UDim2.new(1,-65,0,20),UDim2.new(0,58,0,12),1,tl,cc,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left
    local Dsc=Instance.new("TextLabel",NF)Dsc.Size,Dsc.Position,Dsc.BackgroundTransparency,Dsc.Text,Dsc.TextColor3,Dsc.Font,Dsc.TextSize,Dsc.TextWrapped,Dsc.TextXAlignment=UDim2.new(1,-65,0,25),UDim2.new(0,58,0,32),1,tx,CTh.Text,Enum.Font.Gotham,12,true,Enum.TextXAlignment.Left
    local PBg=Instance.new("Frame",NF)PBg.Size,PBg.Position,PBg.BackgroundColor3,PBg.BorderSizePixel=UDim2.new(1,0,0,3),UDim2.new(0,0,1,-3),Color3.fromRGB(40,40,45),0
    Instance.new("UICorner",PBg).CornerRadius=UDim.new(0,6)
    local PBar=Instance.new("Frame",PBg)PBar.Size,PBar.BackgroundColor3,PBar.BorderSizePixel=UDim2.new(1,0,1,0),cc,0
    Instance.new("UICorner",PBar).CornerRadius=UDim.new(0,6)
    table.insert(ANotif,NF)
    TS:Create(NF,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-90-(#ANotif-1)*78)}):Play()
    TS:Create(PBar,TweenInfo.new(4,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()
    task.delay(4,function()if NF.Parent then local oT=TS:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,NF.Position.Y.Offset)})oT:Play()oT.Completed:Connect(function()NF:Destroy()for i,v in ipairs(ANotif)do if v==NF then table.remove(ANotif,i)break end end for i,v in ipairs(ANotif)do TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-90-((i-1)*78))}):Play()end end)end end)
end

-- BOTÃO OPEN
local OBtn=Instance.new("TextButton",SG)
OBtn.Size,OBtn.Position,OBtn.BackgroundColor3,OBtn.Text,OBtn.TextColor3,OBtn.Font,OBtn.TextSize,OBtn.Visible=UDim2.new(0,56,0,56),UDim2.new(0,20,0,20),CTh.MBG,"⚡\nOPEN",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,false
Instance.new("UICorner",OBtn).CornerRadius=UDim.new(0,12)
local obStr=Instance.new("UIStroke",OBtn)obStr.Color=CTh.A obStr.Thickness=2
table.insert(TE.Bgs,OBtn)

-- FRAME PRINCIPAL MELHORADO
local MF=Instance.new("Frame",SG)
MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,520,0,570),UDim2.new(0.5,-260,0.5,-285),CTh.MBG,true,true
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,14)
local mfStr=Instance.new("UIStroke",MF)mfStr.Color=CTh.A mfStr.Thickness=1.5 mfStr.Transparency=0.5
table.insert(TE.Bgs,MF)

-- TOPBAR MELHORADA
local TB=Instance.new("Frame",MF)
TB.Size,TB.BackgroundColor3=UDim2.new(1,0,0,48),CTh.TB
Instance.new("UICorner",TB).CornerRadius=UDim.new(0,14)
local tbCov=Instance.new("Frame",TB)tbCov.Size=UDim2.new(1,0,0.5,0)tbCov.Position=UDim2.new(0,0,1,0)tbCov.BackgroundColor3=CTh.TB tbCov.BorderSizePixel=0
table.insert(TE.TBs,TB)

local PIco=Instance.new("ImageLabel",TB)
PIco.Size,PIco.Position,PIco.BackgroundColor3,PIco.BorderSizePixel,PIco.ClipsDescendants=UDim2.new(0,32,0,32),UDim2.new(0,12,0.5,-16),CTh.A,0,true
Instance.new("UICorner",PIco).CornerRadius=UDim.new(1,0)
local pIcoStr=Instance.new("UIStroke",PIco)pIcoStr.Color=CTh.A pIcoStr.Thickness=2
table.insert(TE.Accs,pIcoStr)
task.spawn(function()pcall(function()PIco.Image=P:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)end)

local Ttl=Instance.new("TextLabel",TB)
Ttl.Size,Ttl.Position,Ttl.Text,Ttl.TextColor3,Ttl.Font,Ttl.TextSize,Ttl.BackgroundTransparency,Ttl.TextXAlignment=UDim2.new(1,-100,1,0),UDim2.new(0,54,0,0),"⚡ Vortex Hub V19 - Supreme",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,15,1,Enum.TextXAlignment.Left

local CBn=Instance.new("TextButton",TB)
CBn.Size,CBn.Position,CBn.BackgroundColor3,CBn.Text,CBn.TextColor3,CBn.Font,CBn.TextSize=UDim2.new(0,32,0,32),UDim2.new(1,-42,0.5,-16),CTh.Danger,"✕",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,16
Instance.new("UICorner",CBn).CornerRadius=UDim.new(0,8)
CBn.MouseButton1Click:Connect(function()TS:Create(MF,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{Position=UDim2.new(0.5,-260,0.5,400)}):Play()task.wait(0.3)MF.Visible=false OBtn.Visible=true end)
OBtn.MouseButton1Click:Connect(function()MF.Visible=true MF.Position=UDim2.new(0.5,-260,0.5,400)TS:Create(MF,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Position=UDim2.new(0.5,-260,0.5,-285)}):Play()OBtn.Visible=false end)

-- CONTAINER DE TABS MELHORADO
local TC=Instance.new("Frame",MF)
TC.Size,TC.Position,TC.BackgroundTransparency,TC.BackgroundColor3=UDim2.new(1,-16,0,74),UDim2.new(0,8,0,56),1,CTh.TB

local function cTB(n,px,py,w)
    local B=Instance.new("TextButton",TC)
    B.Size,B.Position,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(w or 0.142,0,0,32),UDim2.new(px,0,py,0),CTh.Card,n,CTh.TextDim,Enum.Font.GothamBold,10
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,8)
    return B
end
local tMB,tEB,tPB,tPrB,tHB,tThB,tVB=cTB("🔧 Princ.",0,0,0.142),cTB("👁️ ESPS",0.142,0,0.142),cTB("👤 Player",0.284,0,0.142),cTB("🛡️ Prot.",0.426,0,0.142),cTB("📜 Hist.",0.568,0,0.142),cTB("🎨 Temas",0.710,0,0.142),cTB("👀 Viewer",0.852,0.37,0.148)
tMB.BackgroundColor3=CTh.A tMB.TextColor3=Color3.fromRGB(255,255,255)

local function cScr(n,cY)
    local S=Instance.new("ScrollingFrame",MF)
    S.Size,S.Position,S.BackgroundTransparency,S.ScrollBarThickness,S.CanvasSize,S.Visible=UDim2.new(1,-16,1,-152),UDim2.new(0,8,0,140),1,4,UDim2.new(0,0,0,cY),false
    S.ScrollBarImageColor3=CTh.A
    local L=Instance.new("UIListLayout",S)L.Padding,L.HorizontalAlignment,L.SortOrder=UDim.new(0,10),Enum.HorizontalAlignment.Center,Enum.SortOrder.LayoutOrder
    return S
end
local sM,sE,sP,sPr,sH,sTh,sV=cScr("SM",950),cScr("SE",900),cScr("SP",850),cScr("SPr",500),cScr("SH",1300),cScr("STh",700),cScr("SV",1000)
sM.Visible=true

local function sTab(aB,aS)
    local t={{tMB,sM},{tEB,sE},{tPB,sP},{tPrB,sPr},{tHB,sH},{tThB,sTh},{tVB,sV}}
    for _,d in pairs(t)do
        local b,s=d[1],d[2]
        if b==aB then
            TS:Create(b,TweenInfo.new(0.2),{BackgroundColor3=CTh.A,TextColor3=Color3.fromRGB(255,255,255)}):Play()
            s.Visible=true
        else
            TS:Create(b,TweenInfo.new(0.2),{BackgroundColor3=CTh.Card,TextColor3=CTh.TextDim}):Play()
            s.Visible=false
        end
    end
end
tMB.MouseButton1Click:Connect(function()sTab(tMB,sM)end)
tEB.MouseButton1Click:Connect(function()sTab(tEB,sE)end)
tPB.MouseButton1Click:Connect(function()sTab(tPB,sP)end)
tPrB.MouseButton1Click:Connect(function()sTab(tPrB,sPr)end)
tHB.MouseButton1Click:Connect(function()sTab(tHB,sH)end)
tThB.MouseButton1Click:Connect(function()sTab(tThB,sTh)end)
tVB.MouseButton1Click:Connect(function()sTab(tVB,sV)end)

-- COMPONENTES MELHORADOS
local function cST(n,p)
    local T=Instance.new("TextLabel",p)
    T.Size,T.BackgroundTransparency,T.Text,T.TextColor3,T.Font,T.TextSize,T.TextXAlignment=UDim2.new(1,0,0,25),1,n,CTh.A,Enum.Font.GothamBlack,13,Enum.TextXAlignment.Left
    table.insert(TE.Txs,T)
end

local function cTog(n,p,iS,cb,ck)
    local F=Instance.new("Frame",p)
    F.Size,F.BackgroundColor3=UDim2.new(1,0,0,46),CTh.Card
    Instance.new("UICorner",F).CornerRadius=UDim.new(0,10)
    local s=Instance.new("UIStroke",F)s.Color=CTh.A s.Thickness=1 s.Transparency=0.8
    local L=Instance.new("TextLabel",F)
    L.Size,L.Position,L.Text,L.TextColor3,L.Font,L.TextSize,L.BackgroundTransparency,L.TextXAlignment=UDim2.new(0.7,0,1,0),UDim2.new(0.05,0,0,0),n,CTh.Text,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left
    local SB=Instance.new("Frame",F)
    SB.Size,SB.Position,SB.BackgroundColor3=UDim2.new(0,44,0,22),UDim2.new(1,-58,0.5,-11),iS and CTh.A or Color3.fromRGB(60,60,72)
    Instance.new("UICorner",SB).CornerRadius=UDim.new(1,0)
    local SK=Instance.new("Frame",SB)
    SK.Size,SK.Position,SK.BackgroundColor3=UDim2.new(0,18,0,18),iS and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9),Color3.fromRGB(255,255,255)
    Instance.new("UICorner",SK).CornerRadius=UDim.new(1,0)
    local st=iS
    TE.Tgls[SB]=function()return st end
    local function sVS(ns)
        st=ns
        TS:Create(SB,TweenInfo.new(0.25,Enum.EasingStyle.Quad),{BackgroundColor3=st and CTh.A or Color3.fromRGB(60,60,72)}):Play()
        TS:Create(SK,TweenInfo.new(0.25,Enum.EasingStyle.Quad),{Position=st and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9)}):Play()
        if ck then HC[ck]=st saveC()end
    end
    local B=Instance.new("TextButton",F)
    B.Size,B.BackgroundTransparency,B.Text=UDim2.new(1,0,1,0),1,""
    B.MouseButton1Click:Connect(function()sVS(not st)cb(st)end)
    if ck then IC[ck]=function()if st then cb(true)end end end
    return sVS
end

local function cSli(n,rT,mV,mxV,cV,p,cb,ck)
    local SF=Instance.new("Frame",p)
    SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,68),CTh.Card
    Instance.new("UICorner",SF).CornerRadius=UDim.new(0,10)
    local s=Instance.new("UIStroke",SF)s.Color=CTh.A s.Thickness=1 s.Transparency=0.8
    local TL=Instance.new("TextLabel",SF)
    TL.Size,TL.Position,TL.Text,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,12,0,6),n.."  [ "..tostring(cV).." ]",CTh.Text,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left
    local RL=Instance.new("TextLabel",SF)
    RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,26),"Recomendado: "..rT,CTh.TextDim,Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left
    local Tk=Instance.new("Frame",SF)
    Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,50),Color3.fromRGB(20,20,26)
    Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)
    local pI=math.clamp((cV-mV)/(mxV-mV),0,1)
    local F=Instance.new("Frame",Tk)
    F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),CTh.A
    Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)
    table.insert(TE.Accs,F)
    local K=Instance.new("Frame",Tk)
    K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)
    Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)
    local KS=Instance.new("UIStroke",K)KS.Color=CTh.A KS.Thickness=2
    table.insert(TE.Accs,KS)
    local HB=Instance.new("TextButton",SF)
    HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""
    local d=false
    local function upd(ip)
        local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)
        local pc=pX/Tk.AbsoluteSize.X
        local vl=math.floor(mV+(mxV-mV)*pc)
        TS:Create(F,TweenInfo.new(0.05),{Size=UDim2.new(pc,0,1,0)}):Play()
        TS:Create(K,TweenInfo.new(0.05),{Position=UDim2.new(pc,0,0.5,0)}):Play()
        TL.Text=n.."  [ "..tostring(vl).." ]"
        if ck then HC[ck]=vl saveC()end
        cb(vl)
    end
    HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)
    UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)
    UIS.InputChanged:Connect(function(ip)if d and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then upd(ip)end end)
    if ck then IC[ck]=function()cb(cV)end end
end

local function cTSli(mV,mxV,cV,p,cb)
    local SF=Instance.new("Frame",p)
    SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,68),CTh.Card
    Instance.new("UICorner",SF).CornerRadius=UDim.new(0,10)
    local s=Instance.new("UIStroke",SF)s.Color=CTh.A s.Thickness=1 s.Transparency=0.8
    local TL=Instance.new("TextLabel",SF)
    TL.Size,TL.Position,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0,12,0,6),CTh.Text,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left
    local TiL=Instance.new("TextLabel",SF)
    TiL.Size,TiL.Position,TiL.TextColor3,TiL.Font,TiL.TextSize,TiL.BackgroundTransparency,TiL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0.5,0,0,6),CTh.A,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Right
    table.insert(TE.Txs,TiL)
    local RL=Instance.new("TextLabel",SF)
    RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,26),"Arraste para ajustar",CTh.TextDim,Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left
    local Tk=Instance.new("Frame",SF)
    Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,50),Color3.fromRGB(20,20,26)
    Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)
    local pI=math.clamp((cV-mV)/(mxV-mV),0,1)
    local F=Instance.new("Frame",Tk)
    F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),CTh.A
    Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)
    local K=Instance.new("Frame",Tk)
    K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)
    Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)
    local function fUI(v)
        local h,m=math.floor(v),math.floor((v-math.floor(v))*60)
        local pt="Noite 🌙"if h>=6 and h<13 then pt="Dia ☀️"elseif h>=13 and h<18 then pt="Tarde 🌤️"end
        TL.Text="Período: "..pt
        TiL.Text=string.format("%02d:%02d",h,m)
    end
    fUI(cV)
    local HB=Instance.new("TextButton",SF)
    HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""
    local d=false
    local function upd(ip)
        local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)
        local pc=pX/Tk.AbsoluteSize.X
        local vl=mV+(mxV-mV)*pc
        TS:Create(F,TweenInfo.new(0.05),{Size=UDim2.new(pc,0,1,0)}):Play()
        TS:Create(K,TweenInfo.new(0.05),{Position=UDim2.new(pc,0,0.5,0)}):Play()
        fUI(vl)
        cb(vl)
    end
    HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)
    UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)
    UIS.InputChanged:Connect(function(ip)if d and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then upd(ip)end end)
    return function(nV,ig)if d and ig then return end local pc=math.clamp((nV-mV)/(mxV-mV),0,1)F.Size=UDim2.new(pc,0,1,0)K.Position=UDim2.new(pc,0,0.5,0)fUI(nV)end
end

-- ESP FUNCTIONS
local function cEGui(tM)
    local r,h=tM:FindFirstChild("HumanoidRootPart"),tM:FindFirstChildOfClass("Humanoid")
    if not r or not h then return nil end
    local bg=Instance.new("BillboardGui")
    bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="ESPGui",r,UDim2.new(0,400,0,48),Vector3.new(0,3.5,0),true,SG
    local el=Instance.new("TextLabel",bg)
    el.Size,el.BackgroundTransparency,el.RichText,el.TextStrokeTransparency,el.Font,el.TextSize,el.TextYAlignment=UDim2.new(1,0,1,0),1,true,0.5,Enum.Font.GothamBold,13,Enum.TextYAlignment.Center
    return{Gui=bg,Humanoid=h,Root=r,Label=el,Model=tM}
end
local function cETb(tb)for k,d in pairs(tb)do if d.Gui then d.Gui:Destroy()end end table.clear(tb)end

local function uESP()
    if eUp then eUp:Disconnect()end
    eUp=RS.RenderStepped:Connect(function()
        local lC=LP.Character
        local lR=lC and lC:FindFirstChild("HumanoidRootPart")
        
        -- AUTO-DETECÇÃO PLAYERS (sempre ativo)
        if epOn then
            for _,p in pairs(P:GetPlayers())do
                if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")and p.Character:FindFirstChild("Humanoid")then
                    if isFriend(p) then continue end
                    if not tPly[p]or tPly[p].Model~=p.Character then
                        if tPly[p]and tPly[p].Gui then tPly[p].Gui:Destroy()end
                        tPly[p]=cEGui(p.Character)
                    end
                end
            end
            for p,d in pairs(tPly)do
                if not p or not p.Parent or not p.Character or not d.Humanoid or d.Humanoid.Health<=0 or d.Model~=p.Character or isFriend(p) then
                    if d.Gui then d.Gui:Destroy()end
                    tPly[p]=nil continue
                end
                local hS,dS=math.floor(d.Humanoid.Health),lR and d.Root and tostring(math.floor((lR.Position-d.Root.Position).Magnitude))or"???"
                d.Label.Text=string.format('<b><font color="%s">%s</font> | <font color="%s">HP: %s</font> | <font color="%s">%s</font></b>',ECol.PName,p.Name,ECol.PHP,hS,ECol.PDist,dS)
            end
        end
        
        -- AUTO-DETECÇÃO NPCs (sempre ativo, verifica QUALQUER NPC do mapa)
        if enOn then
            for m in pairs(CNPCs)do
                if m.Parent and not tNPC[m]then tNPC[m]=cEGui(m)end
            end
            for m,d in pairs(tNPC)do
                if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then
                    if d.Gui then d.Gui:Destroy()end
                    tNPC[m]=nil continue
                end
                local dist=lR and d.Root and(lR.Position-d.Root.Position).Magnitude or 9999
                if dist>2500 then
                    d.Gui.Enabled=false
                else
                    d.Gui.Enabled=true
                    d.Label.Text=string.format('<b><font color="%s">NAME: %s</font><br /><font color="%s">HP: %s</font><br /><font color="%s">Dist: %s</font></b>',ECol.NName,m.Name,ECol.NHP,math.floor(d.Humanoid.Health),ECol.NDist,math.floor(dist))
                end
            end
        end
    end)
end

-- NPC Danger detection
local function iHN(n)
    if not n:FindFirstChild("Humanoid")or P:GetPlayerFromCharacter(n)or n.Humanoid.Health<=0 then return false end
    for _,c in ipairs(n:GetChildren())do if c:IsA("Tool")then return true end end
    local nm,h=string.lower(n.Name),{"zombie","enemy","boss","killer","monster","soldier","mutant","dummy","bot","hostile","demon","beast","guard","slayer","vampire","werewolf","criminal","thief","attacker","infect","scp","entity","nextbot"}
    for _,v in ipairs(h)do if string.find(nm,v)then return true end end
    if n.Humanoid.MaxHealth>105 and n.Humanoid.MaxHealth<math.huge then return true end
    for _,d in ipairs(n:GetDescendants())do
        if d:IsA("Script")or d:IsA("LocalScript")then
            local s=string.lower(d.Name)
            if string.find(s,"damage")or string.find(s,"kill")or string.find(s,"attack")then return true end
        end
    end
    return false
end
local function cDEsp(m)
    local r=m:FindFirstChild("HumanoidRootPart")
    if not r then return end
    local bg=Instance.new("BillboardGui")
    bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="DangerESP",r,UDim2.new(0,40,0,40),Vector3.new(0,6,0),true,SG
    local ic=Instance.new("TextLabel",bg)
    ic.Size,ic.BackgroundTransparency,ic.Text,ic.TextSize=UDim2.new(1,0,1,0),1,"⚠️",16
    task.spawn(function()while bg.Parent do TS:Create(ic,TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{TextSize=22}):Play()break end end)
    return{Gui=bg,Model=m,Humanoid=m:FindFirstChild("Humanoid")}
end
local function uDEsp()
    if dUp then dUp:Disconnect()dUp=nil end
    if not dEspOn then return end
    dUp=RS.Heartbeat:Connect(function()
        for m in pairs(CNPCs)do
            if m.Parent and not tDNPC[m]and iHN(m)then tDNPC[m]=cDEsp(m)end
        end
        for m,d in pairs(tDNPC)do
            if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then
                if d.Gui then d.Gui:Destroy()end
                tDNPC[m]=nil
            end
        end
    end)
end

-- Item ESP
local function cItemGui(itemPart)
    local bg=Instance.new("BillboardGui")
    bg.Name="ESPItem"bg.Adornee=itemPart bg.Size=UDim2.new(0,300,0,40)bg.StudsOffset=Vector3.new(0,2,0)bg.AlwaysOnTop=true bg.Parent=SG
    local el=Instance.new("TextLabel",bg)
    el.Size=UDim2.new(1,0,1,0)el.BackgroundTransparency=1 el.RichText=true el.TextStrokeTransparency=0.5 el.Font=Enum.Font.GothamBold el.TextSize=12 el.TextYAlignment=Enum.TextYAlignment.Center
    return{Gui=bg,Part=itemPart,Label=el}
end
local function uItemESP()
    if itemUp then itemUp:Disconnect()itemUp=nil end
    for _,d in pairs(tItems)do if d.Gui then d.Gui:Destroy()end end
    table.clear(tItems)
    if not espiOn then return end
    itemUp=RS.RenderStepped:Connect(function()
        local lC=LP.Character
        local lR=lC and lC:FindFirstChild("HumanoidRootPart")
        for _,v in ipairs(W:GetDescendants())do
            local isDrop=false
            local itemRoot=nil
            if v:IsA("Tool")and v.Parent==W then
                isDrop=true
                local h=v:FindFirstChild("Handle")or v:FindFirstChildOfClass("BasePart")
                if h then itemRoot=h end
            elseif v:IsA("Model")and v:FindFirstChildOfClass("Tool")and v.Parent==W then
                isDrop=true
                local h=v:FindFirstChild("PrimaryPart")or v:FindFirstChildOfClass("BasePart")
                if h then itemRoot=h end
            end
            if isDrop and itemRoot then
                if not tItems[v]then tItems[v]=cItemGui(itemRoot)end
            end
        end
        for v,d in pairs(tItems)do
            if not v or not v.Parent or v.Parent~=W or not d.Part or not d.Part.Parent then
                if d.Gui then d.Gui:Destroy()end
                tItems[v]=nil
            else
                local dist=lR and(lR.Position-d.Part.Position).Magnitude or 0
                d.Label.Text=string.format('<b><font color="%s">Nome: %s</font> | <font color="%s">Studs: %d</font></b>',ECol.ItemName,v.Name,ECol.ItemDist,math.floor(dist))
            end
        end
    end)
end

local function rLig()L.FogStart,L.FogEnd,L.FogColor,L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale=OL.FS,OL.FE,OL.FC,OL.A,OL.OA,OL.B,OL.GS,OL.EDS,OL.ESS pcall(function()L.ShadowSoftness,L.Technology=OL.SS,OL.T end)if L:FindFirstChild("VortexAtmosphere")then L.VortexAtmosphere:Destroy()end end

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
                if i then
                    a,oa=Color3.fromRGB(55,55,60),Color3.fromRGB(45,45,50)
                    local cr=Color3.fromRGB(190,195,205)
                    if fgOn then fs,fe,fc,ad,ac=150,1200,cr,0.15,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end
                elseif n then
                    a,oa=Color3.fromRGB(25,30,45),Color3.fromRGB(20,25,35)
                    local cr=Color3.fromRGB(35,45,65)
                    if fgOn then fs,fe,fc,ad,ac=120,2500,cr,0.25,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end
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

local function eAF()
    if afc then afc:Disconnect()end
    afc=RS.Stepped:Connect(function()
        if not afOn then return end
        local c=LP.Character
        if not c then return end
        for _,p in pairs(c:GetChildren())do
            if p:IsA("BasePart")then
                if p.Velocity.Magnitude>1000 then p.Velocity=Vector3.new(0,0,0)end
                if p.RotVelocity.Magnitude>1000 then p.RotVelocity=Vector3.new(0,0,0)end
            end
        end
    end)
end

-- UI PRINCIPAL
cST("✨ GRÁFICOS",sM)
local stU,ftU
stU=cTog("✨ Shaders",sM,shOn,function(s)shOn=s uLig()end,"Shaders")
ftU=cTog("🥔 Booster FPS",sM,fpsOn,function(s)if s and shOn then sNotif("Erro","Desative Shaders primeiro.","Error")fpsOn=false if ftU then ftU(false)end return end fpsOn=s uLig()end,"FpsBoost")
cTog("🌫️ Desfoque Parede",sM,wbOn,function(s)wbOn=s if not s then local b=L:FindFirstChild("VortexWallBlur")if b then b.Size=0 end end end,"WallBlur")
cTog("🌫️ Neblina",sM,fgOn,function(s)fgOn=s uLig()end,"Fog")
cTog("🌀 Motion Blur",sM,mbOn,function(s)
    if s then
        local b=Instance.new("BlurEffect",L)b.Name,b.Size="VortexMotionBlur",0
        local c=W.CurrentCamera if c then lCR=c.CFrame-c.CFrame.Position end
        mbc=RS.RenderStepped:Connect(function()
            local cam=W.CurrentCamera if not cam then return end
            local rot=cam.CFrame-cam.CFrame.Position
            local d=rot.LookVector:Dot(lCR.LookVector)
            local a=math.acos(math.clamp(d,-1,1))
            local tB=math.clamp(math.deg(a)*1.5,0,30)
            b.Size,lCR=b.Size+(tB-b.Size)*0.2,rot
        end)
    else
        if mbc then mbc:Disconnect()mbc=nil end
        local b=L:FindFirstChild("VortexMotionBlur")if b then b:Destroy()end
    end
end,"MotionBlur")
cTog("☀️ Fullbright",sM,fbOn,function(s)
    fbOn=s
    if s then
        fbLp=RS.RenderStepped:Connect(function()
            L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.FogEnd=Color3.new(1,1,1),Color3.new(1,1,1),2,false,100000
        end)
    else
        if fbLp then fbLp:Disconnect()fbLp=nil end
        uLig()
    end
end,"Fullbright")
cTog("🔦 Luz Player",sM,plOn,function(s)
    plOn=s
    if s then
        plc=RS.Heartbeat:Connect(function()
            local c=LP.Character
            if c and c:FindFirstChild("HumanoidRootPart")then
                local h=c.HumanoidRootPart
                if not h:FindFirstChild("VortexPlayerLight")then
                    local l=Instance.new("PointLight",h)l.Name,l.Brightness,l.Range,l.Shadows,l.Color="VortexPlayerLight",3,60,false,Color3.new(1,1,1)
                end
            end
        end)
    else
        if plc then plc:Disconnect()plc=nil end
        local c=LP.Character
        if c and c:FindFirstChild("HumanoidRootPart")then
            local l=c.HumanoidRootPart:FindFirstChild("VortexPlayerLight")if l then l:Destroy()end
        end
    end
end,"PlayerLight")

cST("⏰ TEMPO",sM)
local uTSUI
cTog("🔄 Auto Tempo",sM,atOn,function(s)atOn=s if s then atc=RS.RenderStepped:Connect(function(dt)L.ClockTime=(L.ClockTime+(0.4*dt))%24 if uTSUI then uTSUI(L.ClockTime,true)end end)else if atc then atc:Disconnect()atc=nil end end end,"AutoTime")
uTSUI=cTSli(0,24,L.ClockTime,sM,function(v)if not atOn then L.ClockTime=v end end)

local rainLoop=nil local rPrt=nil local rEmt=nil
local function stpR()if rEmt then rEmt.Enabled=false end end
local function stRt()
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart")then return end
    if not rPrt then
        rPrt=Instance.new("Part")rPrt.Name="VtxRain"rPrt.Anchored=true rPrt.CanCollide=false rPrt.Transparency=1 rPrt.Size=Vector3.new(150,1,150)rPrt.Parent=W
        rEmt=Instance.new("ParticleEmitter",rPrt)rEmt.Texture="rbxassetid://2273224484"rEmt.Rate=600 rEmt.Speed=NumberRange.new(60,80)rEmt.Lifetime=NumberRange.new(1.5,2.5)rEmt.EmissionDirection=Enum.NormalId.Bottom rEmt.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,0.3)})rEmt.Color=ColorSequence.new(Color3.fromRGB(150,170,200))rEmt.Transparency=NumberSequence.new(0.5)
    end
    task.spawn(function()
        rEmt.Enabled=true
        local d=math.random(10,20)
        local sT=tick()
        while rrOn and(tick()-sT<d)and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")do
            rPrt.CFrame=LP.Character.HumanoidRootPart.CFrame*CFrame.new(0,50,0)
            task.wait(0.1)
        end
        stpR()
    end)
end
cTog("🌧️ Chuva Aleatória (15%)",sM,rrOn,function(s)
    rrOn=s
    if s then
        rainLoop=task.spawn(function()
            while rrOn do
                task.wait(5)
                if math.random(1,100)<=15 then stRt()task.wait(25)end
            end
        end)
    else
        if rainLoop then task.cancel(rainLoop)rainLoop=nil end
        stpR()
    end
end,"RandomRain")

cST("👁️ ESP",sE)
cTog("👤 ESP Player",sE,epOn,function(s)epOn=s if not s then cETb(tPly)end uESP()end,"ESPPlayer")
cTog("🤖 ESP NPC (AUTO)",sE,enOn,function(s)enOn=s if not s then cETb(tNPC)end uESP()end,"ESPNPC")
cTog("⚠️ Alerta NPC Hostil",sE,dEspOn,function(s)dEspOn=s if not s then cETb(tDNPC)end uDEsp()end,"DangerESP")
cTog("📦 ESP de Itens",sE,espiOn,function(s)espiOn=s if not s then for _,d in pairs(tItems) do if d.Gui then d.Gui:Destroy() end end table.clear(tItems) end uItemESP() end,"ESPItems")

cST("🎨 CORES",sE)
local function cECBtn(n,c3,hc)
    local b=Instance.new("TextButton",sE)
    b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,38),CTh.Card,"🎨 "..n,c3,Enum.Font.GothamBold,12
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    b.MouseButton1Click:Connect(function()ECol.PName,ECol.NName=hc,hc end)
end
cECBtn("Branco",Color3.fromRGB(255,255,255),"#FFFFFF")
cECBtn("Amarelo",Color3.fromRGB(255,215,0),"#FFD700")
cECBtn("Roxo",Color3.fromRGB(176,38,255),"#B026FF")
cECBtn("Verde",Color3.fromRGB(50,205,50),"#32CD32")
cECBtn("Rosa",Color3.fromRGB(255,20,147),"#FF1493")

cST("👤 MODS",sP)
cTog("🌀 TeleportTool",sP,ttOn,function(s)ttOn=s if s then gTT()else rTT()end end,"TeleportTool")
cTog("⚡ Instant Interact",sP,iiOn,function(s)
    iiOn=s
    if s then
        for _,p in pairs(W:GetDescendants())do if p:IsA("ProximityPrompt")then p.HoldDuration=0 end end
        iic=PPS.PromptShown:Connect(function(p)p.HoldDuration=0 end)
    else
        if iic then iic:Disconnect()iic=nil end
    end
end,"InstantInteract")
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
        local c=LP.Character
        if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed,c.Humanoid.JumpPower=16,50 end
        if W.CurrentCamera then W.CurrentCamera.FieldOfView=70 end
    end
end,"PlayerMods")
cTog("⚡ No Cooldown",sP,ncOn,function(s)
    ncOn=s
    if s then
        ncc=RS.Stepped:Connect(function()
            local c=LP.Character
            if c then
                for _,t in ipairs(c:GetChildren())do
                    if t:IsA("Tool")then
                        t.Enabled=true
                        pcall(function()
                            if t.Cooldown then t.Cooldown=0 end
                            for _,v in ipairs(t:GetDescendants())do
                                if v:IsA("NumberValue")or v:IsA("IntValue")then
                                    local ln=string.lower(v.Name)
                                    if string.find(ln,"cooldown")or string.find(ln,"cd")or string.find(ln,"time")or string.find(ln,"delay")then v.Value=0 end
                                end
                            end
                        end)
                    end
                end
            end
        end)
    else
        if ncc then ncc:Disconnect()ncc=nil end
    end
end,"NoCooldown")
cTog("🚀 Inf Jump",sP,ijOn,function(s)
    ijOn=s
    if s then
        ijc=UIS.JumpRequest:Connect(function()
            local c=LP.Character
            if c then
                local h=c:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end
            end
        end)
    else
        if ijc then ijc:Disconnect()ijc=nil end
    end
end,"InfJump")
cTog("👻 Noclip",sP,nclOn,function(s)
    nclOn=s
    if s then
        nlc=RS.Stepped:Connect(function()
            local c=LP.Character
            if c then
                local h=c:FindFirstChildOfClass("Humanoid")
                if h then h:ChangeState(11)end
            end
        end)
    else
        if nlc then nlc:Disconnect()nlc=nil end
    end
end,"Noclip")
cSli("🏃 WalkSpeed","16 a 50",16,200,pSpd,sP,function(v)pSpd=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed=v end end end,"WalkSpeed")
cSli("🦘 JumpPower","50 a 100",50,300,pJmp,sP,function(v)pJmp=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.JumpPower=v end end end,"JumpPower")
cSli("🔭 FOV","70 a 90",70,120,pFov,sP,function(v)pFov=v end,"FOV")

cST("🛡️ PROTEÇÃO",sPr)
cTog("🛡️ Anti-Fling",sPr,afOn,function(s)afOn=s if s then eAF()else if afc then afc:Disconnect()afc=nil end end end,"AntiFling")
cTog("🌌 Anti-Void",sPr,avOn,function(s)
    avOn=s
    if s then
        local rp=RaycastParams.new()rp.FilterType=Enum.RaycastFilterType.Exclude
        avc=RS.Heartbeat:Connect(function()
            if not avOn then return end
            local c=LP.Character if not c then return end
            local h,hu=c:FindFirstChild("HumanoidRootPart"),c:FindFirstChildOfClass("Humanoid")
            if not h or not hu or hu.Health<=0 then return end
            rp.FilterDescendantsInstances={c}
            if hu.FloorMaterial~=Enum.Material.Air then lSCf=h.CFrame end
            local hD,hU=W:Raycast(h.Position,Vector3.new(0,-2500,0),rp),W:Raycast(h.Position,Vector3.new(0,2500,0),rp)
            if not hD and not hU and h.Position.Y<-50 then
                h.AssemblyLinearVelocity,h.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)
                pcall(function()h.Velocity,h.RotVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)end)
                local sCF
                if lSCf and lSCf.Position.Y>-20 then sCF=lSCf+Vector3.new(0,3,0)end
                if not sCF then local sl=W:FindFirstChildWhichIsA("SpawnLocation",true)if sl then sCF=sl.CFrame+Vector3.new(0,5,0)end end
                if not sCF then local cr=W:Raycast(Vector3.new(0,500,0),Vector3.new(0,-1000,0),rp)if cr and cr.Position then sCF=CFrame.new(cr.Position+Vector3.new(0,5,0))end end
                if not sCF then sCF=CFrame.new(0,50,0)end
                h.CFrame=sCF
                sNotif("🛡️","Salvo do Void!","Success")
            end
        end)
    else
        if avc then avc:Disconnect()avc=nil end
    end
end,"AntiVoid")
cTog("🚫 Anti-AFK",sPr,aaOn,function(s)
    aaOn=s
    if s then
        aac=LP.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)
    else
        if aac then aac:Disconnect()aac=nil end
    end
end,"AntiAfk")
cTog("🔄 Auto-Rejoin",sPr,arOn,function(s)
    arOn=s
    if s then
        arc=game:GetService("GuiService").ErrorMessageChanged:Connect(function()task.wait(1.5)game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)
    else
        if arc then arc:Disconnect()arc=nil end
    end
end,"AutoRejoin")

cST("📜 HISTÓRICO",sH)
cTog("🔔 Notificações",sH,jelOn,function(s)jelOn=s end,"Notifications")
local function cTBtn(n,mc,tc,ac,tk)
    local b=Instance.new("TextButton",sTh)
    b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,42),CTh.Card,"🎨 "..n,ac,Enum.Font.GothamBold,14
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
    b.MouseButton1Click:Connect(function()appT(mc,tc,ac,tk)end)
end
cTBtn("Orion",Color3.fromRGB(18,18,22),Color3.fromRGB(24,24,30),Color3.fromRGB(88,101,242),"Orion")
cTBtn("Vampiro",Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50),"Vampiro")
cTBtn("Tóxico",Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100),"Tóxico")
cTBtn("Ametista",Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182),"Ametista")
cTBtn("Ouro",Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15),"Ouro")
cTBtn("Sakura",Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204),"Sakura")
cTBtn("Neon",Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255),"Neon")
cTBtn("Magma",Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34),"Magma")

-- VIEWER MELHORADO
cST("👥 SELECIONAR JOGADOR",sV)
local uPL
cTog("🛡️ Whitelist de Amigos",sV,wlOn,function(s)wlOn=s if uPL then uPL()end uESP()end,"Whitelist")

local sPly=nil
local TgtF=Instance.new("Frame",sV)TgtF.Size,TgtF.BackgroundTransparency,TgtF.BackgroundColor3=UDim2.new(1,0,0,60),0,CTh.Card
Instance.new("UICorner",TgtF).CornerRadius=UDim.new(0,10)
local TarImg=Instance.new("ImageLabel",TgtF)
TarImg.Size,TarImg.Position,TarImg.BackgroundColor3,TarImg.BorderSizePixel,TarImg.ClipsDescendants=UDim2.new(0,46,0,46),UDim2.new(0,8,0.5,-23),CTh.A,0,true
Instance.new("UICorner",TarImg).CornerRadius=UDim.new(1,0)
local TarImgSk=Instance.new("UIStroke",TarImg)TarImgSk.Color=CTh.A TarImgSk.Thickness=2
table.insert(TE.Accs,TarImgSk)
local TarL=Instance.new("TextLabel",TgtF)
TarL.Size,TarL.Position,TarL.BackgroundTransparency,TarL.Text,TarL.TextColor3,TarL.Font,TarL.TextSize,TarL.TextXAlignment=UDim2.new(1,-70,1,0),UDim2.new(0,62,0,0),1,"Alvo Atual: Nenhum",CTh.A,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left
table.insert(TE.Txs,TarL)

local SBF=Instance.new("Frame",sV)SBF.Size,SBF.BackgroundColor3=UDim2.new(1,0,0,40),CTh.Card
Instance.new("UICorner",SBF).CornerRadius=UDim.new(0,8)
local SIc=Instance.new("TextLabel",SBF)SIc.Size,SIc.BackgroundTransparency,SIc.Text,SIc.TextSize=UDim2.new(0,36,1,0),1,"🔎",16
local SInp=Instance.new("TextBox",SBF)
SInp.Size,SInp.Position,SInp.BackgroundTransparency,SInp.Text,SInp.PlaceholderText,SInp.TextColor3,SInp.Font,SInp.TextSize,SInp.TextXAlignment=UDim2.new(1,-40,1,0),UDim2.new(0,36,0,0),1,"","Pesquisar jogador...",CTh.Text,Enum.Font.Gotham,13,Enum.TextXAlignment.Left

local PLF=Instance.new("ScrollingFrame",sV)
PLF.Size,PLF.BackgroundColor3,PLF.BorderSizePixel,PLF.ScrollBarThickness,PLF.ScrollBarImageColor3=UDim2.new(1,0,0,200),CTh.Card,0,4,CTh.A
Instance.new("UICorner",PLF).CornerRadius=UDim.new(0,10)
local UIL=Instance.new("UIListLayout",PLF)UIL.Padding,UIL.HorizontalAlignment,UIL.SortOrder=UDim.new(0,6),Enum.HorizontalAlignment.Center,Enum.SortOrder.Name
UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()PLF.CanvasSize=UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y+10)end)
local pBD={}

-- AUTO-REFRESH DA LISTA DE JOGADORES
uPL=function()
    for _,d in pairs(pBD)do d.Btn:Destroy()end
    table.clear(pBD)
    local f=string.lower(SInp.Text or"")
    for _,p in ipairs(P:GetPlayers())do
        if p~=LP then
            if isFriend(p) then continue end
            local b=Instance.new("TextButton",PLF)
            b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment=UDim2.new(1,-12,0,48),CTh.CardHover,"              "..p.DisplayName.." (@"..p.Name..")",CTh.Text,Enum.Font.GothamBold,13,Enum.TextXAlignment.Left
            Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)
            local bStr=Instance.new("UIStroke",b)bStr.Color=CTh.A bStr.Thickness=1 bStr.Transparency=0.7
            local avI=Instance.new("ImageLabel",b)
            avI.Size,avI.Position,avI.BackgroundTransparency,avI.BackgroundColor3=UDim2.new(0,36,0,36),UDim2.new(0,6,0.5,-18),1,CTh.Card
            Instance.new("UICorner",avI).CornerRadius=UDim.new(1,0)
            task.spawn(function()
                local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)
                if s and r then avI.Image=r end
            end)
            b.MouseButton1Click:Connect(function()
                sPly=p
                TarL.Text="Alvo Atual: "..p.DisplayName
                sNotif("Alvo","Selecionado: "..p.Name,"Info")
                task.spawn(function()
                    local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)end)
                    if s and r then TarImg.Image=r end
                end)
            end)
            table.insert(pBD,{Btn=b,Player=p})
            local pn,pd=string.lower(p.Name),string.lower(p.DisplayName)
            if f==""or string.find(pn,f)or string.find(pd,f)then b.Visible=true else b.Visible=false end
        end
    end
end

SInp:GetPropertyChangedSignal("Text"):Connect(uPL)
P.PlayerAdded:Connect(uPL)
P.PlayerRemoving:Connect(function(p)
    if sPly==p then sPly=nil TarL.Text="Alvo Atual: Nenhum" TarImg.Image="" end
    uPL()
end)
uPL()

-- AUTO-REFRESH A CADA 2 SEGUNDOS
task.spawn(function()
    while true do
        task.wait(2)
        pcall(uPL)
    end
end)

cST("⚙️ AÇÕES DO ALVO",sV)
local function cAB(n,p,cb)
    local B=Instance.new("TextButton",p)
    B.Size,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(1,0,0,40),CTh.Card,n,CTh.Text,Enum.Font.GothamBold,13
    Instance.new("UICorner",B).CornerRadius=UDim.new(0,8)
    B.MouseButton1Click:Connect(function()
        if sPly then cb(sPly)else sNotif("Aviso","Selecione um jogador na lista acima primeiro!","Error")end
    end)
end
cAB("🚀 Teleport",sV,function(t)
    if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then
        LP.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)
        sNotif("Teleport","Teleportado para "..t.Name,"Success")
    end
end)
local vCn cTog("👁️ View (Spectate)",sV,false,function(s)
    if s then
        if sPly and sPly.Character and sPly.Character:FindFirstChild("Humanoid")then
            W.CurrentCamera.CameraSubject=sPly.Character.Humanoid
            sNotif("View","Assistindo "..sPly.Name,"Info")
        else
            sNotif("Aviso","O alvo não tem um personagem válido.","Error")
        end
    else
        if LP.Character and LP.Character:FindFirstChild("Humanoid")then
            W.CurrentCamera.CameraSubject=LP.Character.Humanoid
        end
    end
end,nil)
local lgCn cTog("🔁 Loopgoto",sV,false,function(s)
    if s then
        if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end
        if lgCn then lgCn:Disconnect()end
        lgCn=RS.Heartbeat:Connect(function()
            if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then
                LP.Character.HumanoidRootPart.CFrame=sPly.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
            end
        end)
    else
        if lgCn then lgCn:Disconnect()lgCn=nil end
    end
end,nil)
local fCn cTog("🏃 Follow Player",sV,false,function(s)
    if s then
        if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end
        if fCn then fCn:Disconnect()end
        fCn=RS.Heartbeat:Connect(function()
            if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("Humanoid")then
                LP.Character.Humanoid:MoveTo(sPly.Character.HumanoidRootPart.Position)
            end
        end)
    else
        if fCn then fCn:Disconnect()fCn=nil end
    end
end,nil)
local hpCn,hpOrigCF
cTog("🐶 Headpet",sV,false,function(s)
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

cAB("📋 Copiar Username",sV,function(t)if setclipboard then setclipboard(t.Name)sNotif("Copiado","Username ("..t.Name..") copiado!","Success")end end)
cAB("📋 Copiar ID",sV,function(t)if setclipboard then setclipboard(tostring(t.UserId))sNotif("Copiado","ID copiado!","Success")end end)
cAB("📋 Copiar Name",sV,function(t)if setclipboard then setclipboard(t.DisplayName)sNotif("Copiado","Display Name copiado!","Success")end end)

-- INICIALIZAÇÃO
task.spawn(function()
    if not LP.Character then LP.CharacterAdded:Wait()end
    task.wait(0.5)
    local sT=HC.SelectedTheme
    if sT=="Vampiro"then appT(Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50))
    elseif sT=="Tóxico"then appT(Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100))
    elseif sT=="Ametista"then appT(Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182))
    elseif sT=="Ouro"then appT(Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15))
    elseif sT=="Sakura"then appT(Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204))
    elseif sT=="Neon"then appT(Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255))
    elseif sT=="Magma"then appT(Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34))end
    for _,iF in pairs(IC)do pcall(function()iF()end)end
    uLig()
    uESP()
    sNotif("⚡ Vortex Hub V19","Carregado com sucesso!","Success")
end)
