local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
local LP=P.LocalPlayer local TP=(gethui and gethui())or CG if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end
local SFName="VortexHub_Config.json" local HC={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,RandomRain=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,ESPItems=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,AutoRejoin=false,Notifications=true,SelectedTheme="Orion",Whitelist=true,InfiniteZoom=false,AntiExploitDetector=true,AutoAntiFling=true}
local IC={} local function saveC()pcall(function()if writefile then writefile(SFName,HS:JSONEncode(HC))end end)end
local function loadC()if readfile and isfile and isfile(SFName)then local s,d=pcall(function()return HS:JSONDecode(readfile(SFName))end)if s and type(d)=="table"then for k,v in pairs(d)do if HC[k]~=nil then HC[k]=v end end end end end loadC()
local shOn,fpsOn,wbOn,fgOn,mbOn,fbOn,plOn,atOn,rrOn,epOn,enOn,dEspOn,espiOn,ttOn,iiOn,pmOn,ncOn,ijOn,nclOn,pSpd,pJmp,pFov,afOn,avOn,aaOn,arOn,jelOn,wlOn,izOn,adOn,aafOn=HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.ESPItems,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip,HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist,HC.InfiniteZoom,HC.AntiExploitDetector,HC.AutoAntiFling
local ijc,nlc,avc,pmc,aac,arc,atc,sLp,iic,fbLp,plc,mbc,afc,ncc,izc,adCn local afToggle local ozm=LP.CameraMaxZoomDistance local lSCf=nil local lCR=CFrame.new()local ECol={PName="#00FFFF",PHP="#32FF32",PDist="#FFAA00",NName="#FF4444",NHP="#32FF32",NDist="#FFAA00",ItemName="#00FFCC",ItemDist="#FFAA00"}
local tNPC,tPly,tDNPC,tItems={},{},{},{} local eUp,dUp,itemUp
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
local CNPCs={} local function cNPC(o)if o:IsA("Model")and o:FindFirstChild("Humanoid")and o:FindFirstChild("HumanoidRootPart")and not P:GetPlayerFromCharacter(o)then CNPCs[o]=true end end for _,o in ipairs(W:GetDescendants())do cNPC(o)end W.DescendantAdded:Connect(function(o)task.delay(0.2,function()if o and o.Parent then if o:IsA("Model")then cNPC(o)end if o.Parent:IsA("Model")then cNPC(o.Parent)end end end)end)W.DescendantRemoving:Connect(function(o)if CNPCs[o]then CNPCs[o]=nil end end)

local CTh={MBG=Color3.fromRGB(36,36,37),TB=Color3.fromRGB(30,30,30),A=Color3.fromRGB(52,152,219)}local TE={Bgs={},TBs={},Accs={},Tgls={},Txs={}}
local function appT(m,t,a,tn)CTh.MBG,CTh.TB,CTh.A=m,t,a if tn then HC.SelectedTheme=tn saveC()end for _,f in pairs(TE.Bgs)do f.BackgroundColor3=m end for _,f in pairs(TE.TBs)do f.BackgroundColor3=t end for _,o in pairs(TE.Accs)do if o:IsA("UIStroke")then o.Color=a else o.BackgroundColor3=a end end for _,tx in pairs(TE.Txs)do tx.TextColor3=a end for bg,sF in pairs(TE.Tgls)do if sF()then TS:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=a}):Play()end end end
local SG=Instance.new("ScreenGui",TP)SG.Name="VortexGraphicsHub"SG.ResetOnSpawn=false local ANotif={}

local function sNotif(tl,tx,nt)
    if not jelOn and nt~="Security" and tl~="Alvo" then return end
    if tl=="Alvo" then
        for i=#ANotif,1,-1 do
            local v=ANotif[i]
            if v:FindFirstChild("NTitle")and v.NTitle.Text=="Alvo"then
                v:Destroy()
                table.remove(ANotif,i)
            end
        end
    end
    local cls={
        Error=Color3.fromRGB(255,75,75),
        Info=CTh.A,
        Success=Color3.fromRGB(75,255,75),
        Join=Color3.fromRGB(0,255,90),
        Exit=Color3.fromRGB(255,80,20),
        Security=Color3.fromRGB(255,145,0)
    }
    local cc=cls[nt]or cls.Info
    local icn=nt=="Error"and"⚠️"or(nt=="Success"and"✅"or(nt=="Join"and"🟢"or(nt=="Exit"and"🔴"or(nt=="Security"and"🛡️"or"ℹ️"))))
    local NF=Instance.new("Frame",SG)
    NF.Name="VortexNotification"
    NF.Size=UDim2.new(0,320,0,74)
    NF.Position=UDim2.new(0,-345,1,-100-(#ANotif*84))
    NF.BackgroundColor3=Color3.fromRGB(20,22,26)
    NF.BackgroundTransparency=0.08
    NF.BorderSizePixel=0
    NF.ClipsDescendants=true
    Instance.new("UICorner",NF).CornerRadius=UDim.new(0,10)
    local sk=Instance.new("UIStroke",NF)
    sk.Color=cc
    sk.Thickness=1.5
    sk.Transparency=0.15
    local grad=Instance.new("UIGradient",NF)
    grad.Rotation=0
    grad.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.02),NumberSequenceKeypoint.new(1,0.22)})
    local Sd=Instance.new("Frame",NF)
    Sd.Size=UDim2.new(0,5,1,0)
    Sd.BackgroundColor3=cc
    Sd.BorderSizePixel=0
    Instance.new("UICorner",Sd).CornerRadius=UDim.new(0,10)
    local Ic=Instance.new("TextLabel",NF)
    Ic.Size=UDim2.new(0,42,0,42)
    Ic.Position=UDim2.new(0,12,0.5,-21)
    Ic.BackgroundTransparency=1
    Ic.Text=icn
    Ic.TextSize=23
    local Txt=Instance.new("TextLabel",NF)
    Txt.Name="NTitle"
    Txt.Size=UDim2.new(1,-72,0,22)
    Txt.Position=UDim2.new(0,62,0,10)
    Txt.BackgroundTransparency=1
    Txt.Text=tl
    Txt.TextColor3=cc
    Txt.Font=Enum.Font.GothamBold
    Txt.TextSize=14
    Txt.TextXAlignment=Enum.TextXAlignment.Left
    Txt.TextTruncate=Enum.TextTruncate.AtEnd
    local Dsc=Instance.new("TextLabel",NF)
    Dsc.Size=UDim2.new(1,-72,0,27)
    Dsc.Position=UDim2.new(0,62,0,32)
    Dsc.BackgroundTransparency=1
    Dsc.Text=tx
    Dsc.TextColor3=Color3.fromRGB(240,240,245)
    Dsc.Font=Enum.Font.Gotham
    Dsc.TextSize=11
    Dsc.TextWrapped=true
    Dsc.TextXAlignment=Enum.TextXAlignment.Left
    local PBg=Instance.new("Frame",NF)
    PBg.Size=UDim2.new(1,0,0,3)
    PBg.Position=UDim2.new(0,0,1,-3)
    PBg.BackgroundColor3=Color3.fromRGB(45,48,55)
    PBg.BorderSizePixel=0
    local PBar=Instance.new("Frame",PBg)
    PBar.Size=UDim2.new(1,0,1,0)
    PBar.BackgroundColor3=cc
    PBar.BorderSizePixel=0
    local UISC=Instance.new("UIScale",NF)
    UISC.Scale=0.86
    table.insert(ANotif,NF)
    local tgtY=-100-((#ANotif-1)*84)
    TS:Create(NF,TweenInfo.new(0.48,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(0,20,1,tgtY)}):Play()
    TS:Create(UISC,TweenInfo.new(0.42,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
    TS:Create(PBar,TweenInfo.new(4.5,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()
    task.delay(4.5,function()
        if NF.Parent then
            local oT=TS:Create(NF,TweenInfo.new(0.38,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(0,-345,1,NF.Position.Y.Offset),BackgroundTransparency=1})
            oT:Play()
            oT.Completed:Connect(function()
                NF:Destroy()
                for i,v in ipairs(ANotif)do
                    if v==NF then table.remove(ANotif,i)break end
                end
                for i,v in ipairs(ANotif)do
                    TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(0,20,1,-100-((i-1)*84))}):Play()
                end
            end)
        end
    end)
end

local OBtn=Instance.new("TextButton",SG)OBtn.Size,OBtn.Position,OBtn.BackgroundColor3,OBtn.Text,OBtn.TextColor3,OBtn.Font,OBtn.TextSize,OBtn.Visible=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),Color3.fromRGB(36,36,37),"⚡\nOPEN",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,false Instance.new("UICorner",OBtn).CornerRadius=UDim.new(0,10)table.insert(TE.Bgs,OBtn)
local MF=Instance.new("Frame",SG)MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,480,0,530),UDim2.new(0.5,-240,0.5,-265),CTh.MBG,true,true Instance.new("UICorner",MF).CornerRadius=UDim.new(0,8)table.insert(TE.Bgs,MF)
local TB=Instance.new("Frame",MF)TB.Size,TB.BackgroundColor3=UDim2.new(1,0,0,40),CTh.TB Instance.new("UICorner",TB).CornerRadius=UDim.new(0,8)table.insert(TE.TBs,TB)
local PIco=Instance.new("ImageLabel",TB)PIco.Size,PIco.Position,PIco.BackgroundColor3,PIco.BorderSizePixel,PIco.ClipsDescendants=UDim2.new(0,26,0,26),UDim2.new(0,10,0.5,-13),Color3.fromRGB(50,50,50),0,true Instance.new("UICorner",PIco).CornerRadius=UDim.new(1,0)
task.spawn(function()pcall(function()PIco.Image=P:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)end)
local Ttl=Instance.new("TextLabel",TB)Ttl.Size,Ttl.Position,Ttl.Text,Ttl.TextColor3,Ttl.Font,Ttl.TextSize,Ttl.BackgroundTransparency,Ttl.TextXAlignment=UDim2.new(1,-80,1,0),UDim2.new(0,45,0,0),"⚡ Vortex Hub V18 - Supreme",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,1,Enum.TextXAlignment.Left
local CBn=Instance.new("TextButton",TB)CBn.Size,CBn.Position,CBn.BackgroundTransparency,CBn.Text,CBn.TextColor3,CBn.Font,CBn.TextSize=UDim2.new(0,40,0,40),UDim2.new(1,-40,0,0),1,"X",Color3.fromRGB(200,200,200),Enum.Font.GothamBold,16 CBn.MouseButton1Click:Connect(function()MF.Visible=false OBtn.Visible=true end)OBtn.MouseButton1Click:Connect(function()MF.Visible=true OBtn.Visible=false end)
local TC=Instance.new("Frame",MF)TC.Size,TC.Position,TC.BackgroundTransparency=UDim2.new(1,0,0,30),UDim2.new(0,0,0,40),1
local function cTB(n,px,w)local B=Instance.new("TextButton",TC)B.Size,B.Position,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(w or 0.142,0,1,0),UDim2.new(px,0,0,0),Color3.fromRGB(30,30,30),n,Color3.fromRGB(150,150,150),Enum.Font.GothamBold,10 return B end
local tMB,tEB,tPB,tPrB,tHB,tThB,tVB=cTB("🔧 Princ.",0,0.142),cTB("👁️ ESPS",0.142,0.142),cTB("👤 Player",0.284,0.142),cTB("🛡️ Prot.",0.426,0.142),cTB("📜 Hist.",0.568,0.142),cTB("🎨 Temas",0.710,0.142),cTB("👀 Viewer",0.852,0.148)tMB.BackgroundColor3=Color3.fromRGB(45,45,45)tMB.TextColor3=Color3.fromRGB(255,255,255)
local function cScr(n,cY)local S=Instance.new("ScrollingFrame",MF)S.Size,S.Position,S.BackgroundTransparency,S.ScrollBarThickness,S.CanvasSize,S.Visible=UDim2.new(1,-20,1,-80),UDim2.new(0,10,0,75),1,4,UDim2.new(0,0,0,cY),false local L=Instance.new("UIListLayout",S)L.Padding,L.HorizontalAlignment,L.SortOrder=UDim.new(0,10),Enum.HorizontalAlignment.Center,Enum.SortOrder.LayoutOrder return S end
local sM,sE,sP,sPr,sH,sTh,sV=cScr("SM",950),cScr("SE",850),cScr("SP",720),cScr("SPr",460),cScr("SH",1200),cScr("STh",650),cScr("SV",850)sM.Visible=true
local hLay=sH:FindFirstChildOfClass("UIListLayout")if hLay then hLay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()sH.CanvasSize=UDim2.new(0,0,0,hLay.AbsoluteContentSize.Y+15)end)end
local function sTab(aB,aS)local t={{tMB,sM},{tEB,sE},{tPB,sP},{tPrB,sPr},{tHB,sH},{tThB,sTh},{tVB,sV}}for _,d in pairs(t)do local b,s=d[1],d[2]if b==aB then b.BackgroundColor3=Color3.fromRGB(45,45,45)b.TextColor3=Color3.fromRGB(255,255,255)s.Visible=true else b.BackgroundColor3=Color3.fromRGB(30,30,30)b.TextColor3=Color3.fromRGB(150,150,150)s.Visible=false end end end
tMB.MouseButton1Click:Connect(function()sTab(tMB,sM)end)tEB.MouseButton1Click:Connect(function()sTab(tEB,sE)end)tPB.MouseButton1Click:Connect(function()sTab(tPB,sP)end)tPrB.MouseButton1Click:Connect(function()sTab(tPrB,sPr)end)tHB.MouseButton1Click:Connect(function()sTab(tHB,sH)end)tThB.MouseButton1Click:Connect(function()sTab(tThB,sTh)end)tVB.MouseButton1Click:Connect(function()sTab(tVB,sV)end)
local function cST(n,p)local T=Instance.new("TextLabel",p)T.Size,T.BackgroundTransparency,T.Text,T.TextColor3,T.Font,T.TextSize,T.TextXAlignment=UDim2.new(1,0,0,25),1,n,CTh.A,Enum.Font.GothamBlack,13,Enum.TextXAlignment.Left table.insert(TE.Txs,T)end
local function cTog(n,p,iS,cb,ck)local F=Instance.new("Frame",p)F.Size,F.BackgroundColor3=UDim2.new(1,0,0,42),Color3.fromRGB(45,45,45)Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)local L=Instance.new("TextLabel",F)L.Size,L.Position,L.Text,L.TextColor3,L.Font,L.TextSize,L.BackgroundTransparency,L.TextXAlignment=UDim2.new(0.7,0,1,0),UDim2.new(0.05,0,0,0),n,Color3.fromRGB(255,255,255),Enum.Font.Gotham,13,1,Enum.TextXAlignment.Left local SB=Instance.new("Frame",F)SB.Size,SB.Position,SB.BackgroundColor3=UDim2.new(0,40,0,20),UDim2.new(1,-55,0.5,-10),iS and CTh.A or Color3.fromRGB(70,70,70)Instance.new("UICorner",SB).CornerRadius=UDim.new(1,0)local SK=Instance.new("Frame",SB)SK.Size,SK.Position,SK.BackgroundColor3=UDim2.new(0,16,0,16),iS and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8),Color3.fromRGB(255,255,255)Instance.new("UICorner",SK).CornerRadius=UDim.new(1,0)local st=iS TE.Tgls[SB]=function()return st end local function sVS(ns)st=ns TS:Create(SB,TweenInfo.new(0.2),{BackgroundColor3=st and CTh.A or Color3.fromRGB(70,70,70)}):Play()TS:Create(SK,TweenInfo.new(0.2),{Position=st and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8)}):Play()if ck then HC[ck]=st saveC()end cb(st)end local B=Instance.new("TextButton",F)B.Size,B.BackgroundTransparency,B.Text=UDim2.new(1,0,1,0),1,""B.MouseButton1Click:Connect(function()sVS(not st)end)if ck then IC[ck]=function()if st then cb(true)end end end return sVS end

local HRec={} local DetState={}
local function hTime()return os.date("%H:%M:%S")end

local function cHCard(p,entry)
    local IF=Instance.new("Frame",sH)
    IF.Size=UDim2.new(1,-10,0,0)
    IF.BackgroundColor3=Color3.fromRGB(28,31,38)
    IF.BackgroundTransparency=0.15
    IF.ClipsDescendants=true
    Instance.new("UICorner",IF).CornerRadius=UDim.new(0,10)
    local sk=Instance.new("UIStroke",IF)
    sk.Color=Color3.fromRGB(65,70,80)
    sk.Thickness=1
    local AB=Instance.new("Frame",IF)
    AB.Name="Accent"
    AB.Size=UDim2.new(0,5,1,0)
    AB.BackgroundColor3=Color3.fromRGB(0,255,90)
    AB.BorderSizePixel=0
    Instance.new("UICorner",AB).CornerRadius=UDim.new(0,10)
    local Im=Instance.new("ImageLabel",IF)
    Im.Size=UDim2.new(0,44,0,44)
    Im.Position=UDim2.new(0,12,0,11)
    Im.BackgroundColor3=Color3.fromRGB(36,40,48)
    Im.BackgroundTransparency=0
    Im.BorderSizePixel=0
    Im.ClipsDescendants=true
    Instance.new("UICorner",Im).CornerRadius=UDim.new(1,0)
    Instance.new("UIStroke",Im).Color=Color3.fromRGB(90,95,105)
    task.spawn(function()pcall(function()local c=P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)if c then Im.Image=c end end)end)
    local NL=Instance.new("TextLabel",IF)
    NL.Size=UDim2.new(1,-135,0,19)
    NL.Position=UDim2.new(0,66,0,8)
    NL.BackgroundTransparency=1
    NL.Text=p.DisplayName.." (@"..p.Name..")"
    NL.TextColor3=Color3.fromRGB(255,255,255)
    NL.Font=Enum.Font.GothamBold
    NL.TextSize=12
    NL.TextXAlignment=Enum.TextXAlignment.Left
    NL.TextTruncate=Enum.TextTruncate.AtEnd
    local IDL=Instance.new("TextLabel",IF)
    IDL.Size=UDim2.new(1,-135,0,15)
    IDL.Position=UDim2.new(0,66,0,27)
    IDL.BackgroundTransparency=1
    IDL.Text="🆔 ID: "..tostring(p.UserId)
    IDL.TextColor3=Color3.fromRGB(145,150,160)
    IDL.Font=Enum.Font.Gotham
    IDL.TextSize=9
    IDL.TextXAlignment=Enum.TextXAlignment.Left
    local EntryL=Instance.new("TextLabel",IF)
    EntryL.Name="Entry"
    EntryL.Size=UDim2.new(0.48,-10,0,18)
    EntryL.Position=UDim2.new(0,12,0,57)
    EntryL.BackgroundTransparency=1
    EntryL.Text="🟢 Entrada: "..entry
    EntryL.TextColor3=Color3.fromRGB(0,255,90)
    EntryL.Font=Enum.Font.GothamBold
    EntryL.TextSize=10
    EntryL.TextXAlignment=Enum.TextXAlignment.Left
    local ExitL=Instance.new("TextLabel",IF)
    ExitL.Name="Exit"
    ExitL.Size=UDim2.new(0.48,-10,0,18)
    ExitL.Position=UDim2.new(0.48,0,0,57)
    ExitL.BackgroundTransparency=1
    ExitL.Text="🔴 Saída: —"
    ExitL.TextColor3=Color3.fromRGB(255,145,110)
    ExitL.Font=Enum.Font.GothamBold
    ExitL.TextSize=10
    ExitL.TextXAlignment=Enum.TextXAlignment.Left
    local Sec=Instance.new("TextLabel",IF)
    Sec.Name="Security"
    Sec.Size=UDim2.new(1,-130,0,16)
    Sec.Position=UDim2.new(0,12,0,76)
    Sec.BackgroundTransparency=1
    Sec.Text="🛡️ Segurança: Sem anomalias observadas"
    Sec.TextColor3=Color3.fromRGB(125,220,165)
    Sec.Font=Enum.Font.Gotham
    Sec.TextSize=9
    Sec.TextXAlignment=Enum.TextXAlignment.Left
    local Status=Instance.new("TextLabel",IF)
    Status.Name="Status"
    Status.Size=UDim2.new(0,105,0,28)
    Status.Position=UDim2.new(1,-118,0,14)
    Status.BackgroundColor3=Color3.fromRGB(15,80,42)
    Status.BackgroundTransparency=0.15
    Status.Text="🟢 ONLINE"
    Status.TextColor3=Color3.fromRGB(0,255,90)
    Status.Font=Enum.Font.GothamBlack
    Status.TextSize=9
    Status.TextXAlignment=Enum.TextXAlignment.Center
    Instance.new("UICorner",Status).CornerRadius=UDim.new(0,7)
    Instance.new("UIStroke",Status).Color=Color3.fromRGB(0,255,90)
    local rec={Player=p,UserId=p.UserId,Frame=IF,Accent=AB,Entry=entry,Exit=nil,Status=Status,Security=Sec,Anomalias=0,Active=true}
    HRec[p.UserId]=HRec[p.UserId]or{}
    table.insert(HRec[p.UserId],rec)
    TS:Create(IF,TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(1,-10,0,94)}):Play()
    return rec
end

local function hAnomaly(p,kind,detail)
    local arr=HRec[p.UserId]
    if not arr then return end
    local rec=arr[#arr]
    if not rec then return end
    rec.Anomalias=rec.Anomalias+1
    if rec.Security then
        rec.Security.Text="⚠️ Segurança: "..kind.." | "..detail.." | Eventos: "..rec.Anomalias
        rec.Security.TextColor3=Color3.fromRGB(255,170,70)
    end
    if rec.Accent then rec.Accent.BackgroundColor3=Color3.fromRGB(255,145,0)end
end

local function closeHCard(p,exitTime)
    local arr=HRec[p.UserId]
    if not arr then return false end
    local rec
    for i=#arr,1,-1 do
        if arr[i].Active then rec=arr[i]break end
    end
    if not rec then return false end
    rec.Active=false
    rec.Exit=exitTime
    if rec.Exit then
        local ex=rec.Frame:FindFirstChild("Exit")
        if ex then ex.Text="🔴 Saída: "..exitTime end
    end
    if rec.Status then
        rec.Status.Text="🔴 SAIU"
        rec.Status.TextColor3=Color3.fromRGB(255,95,40)
        rec.Status.BackgroundColor3=Color3.fromRGB(80,33,22)
        local st=rec.Status:FindFirstChildOfClass("UIStroke")
        if st then st.Color=Color3.fromRGB(255,95,40)end
    end
    if rec.Accent then rec.Accent.BackgroundColor3=Color3.fromRGB(255,80,25)end
    return true
end

local function sJET(p,et,showNotif)
    if showNotif==false then return end
    if et=="JOIN" then
        sNotif("ENTRADA",p.DisplayName.." entrou no servidor • "..p.Name.." • "..hTime(),"Join")
    else
        sNotif("SAÍDA",p.DisplayName.." saiu do servidor • "..p.Name.." • "..hTime(),"Exit")
    end
end

local function aLH(p,et,showNotif)
    local ts=hTime()
    if et=="JOIN" then
        cHCard(p,ts)
        sJET(p,et,showNotif~=false)
    else
        local found=closeHCard(p,ts)
        if not found then
            cHCard(p,"—")
            closeHCard(p,ts)
        end
        sJET(p,et,showNotif~=false)
    end
end

local function autoAntiFling(p,detail)
    if not aafOn then return end
    if not afOn and afToggle then
        afToggle(true)
        sNotif("🛡️","Anti-Fling ativado automaticamente • "..p.Name.." • "..detail,"Security")
    end
end

local function detectorStart()
    if adCn then adCn:Disconnect()adCn=nil end
    if not adOn then return end
    adCn=RS.Heartbeat:Connect(function()
        local now=os.clock()
        for _,p in ipairs(P:GetPlayers())do
            if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")and p.Character:FindFirstChildOfClass("Humanoid")then
                if isFriend(p) then continue end
                local c=p.Character
                local r=c:FindFirstChild("HumanoidRootPart")
                local h=c:FindFirstChildOfClass("Humanoid")
                local st=DetState[p]or{t=now,pos=r.Position,air=0,lastReport=0,lastGroundY=r.Position.Y}
                local dt=math.max(now-st.t,0.016)
                local delta=r.Position-st.pos
                local stepSpeed=delta.Magnitude/dt
                local hSpeed=Vector3.new(delta.X,0,delta.Z).Magnitude/dt
                local vel=r.AssemblyLinearVelocity
                local vMag=vel.Magnitude
                local anomaly=nil
                local detail=nil
                if stepSpeed>300 or hSpeed>280 then
                    anomaly="Velocidade extrema"
                    detail=string.format("%.0f studs/s",math.max(stepSpeed,hSpeed))
                elseif vMag>260 then
                    local nearPlayer=false
                    for _,q in ipairs(P:GetPlayers())do
                        if q~=p and q.Character and q.Character:FindFirstChild("HumanoidRootPart")then
                            local qr=q.Character.HumanoidRootPart
                            if(qr.Position-r.Position).Magnitude<16 then nearPlayer=true break end
                        end
                    end
                    if nearPlayer then
                        anomaly="Possível fling"
                        detail=string.format("velocidade %.0f",vMag)
                    elseif vMag>340 then
                        anomaly="Impulso extremo"
                        detail=string.format("velocidade %.0f",vMag)
                    end
                elseif delta.Magnitude>55 and dt<0.2 then
                    anomaly="Movimento brusco"
                    detail=string.format("%.0f studs em %.2fs",delta.Magnitude,dt)
                end
                if h.FloorMaterial==Enum.Material.Air then
                    if math.abs(vel.Y)<5 and math.abs(hSpeed)<18 then
                        st.air=st.air+dt
                    else
                        st.air=0
                    end
                else
                    st.air=0
                    st.lastGroundY=r.Position.Y
                end
                if st.air>1.6 and r.Position.Y>st.lastGroundY+7 and not anomaly then
                    anomaly="Possível fly/hover"
                    detail=string.format("sem contato por %.1fs",st.air)
                end
                if anomaly then
                    if now-st.lastReport>1.2 then
                        st.lastReport=now
                        hAnomaly(p,anomaly,detail)
                        sNotif("⚠️ "..anomaly,p.DisplayName.." • "..detail,"Security")
                    end
                    if anomaly=="Possível fling"or anomaly=="Velocidade extrema"or anomaly=="Impulso extremo"then
                        autoAntiFling(p,detail)
                    end
                end
                st.t=now
                st.pos=r.Position
                DetState[p]=st
            else
                DetState[p]=nil
            end
        end
    end)
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
        for _,op in pairs(P:GetPlayers())do
            if op~=LP and op.Character then
                if isFriend(op) then continue end
                for _,oprt in pairs(op.Character:GetChildren())do
                    if oprt:IsA("BasePart")then
                        oprt.CanCollide=false
                        if oprt.Velocity.Magnitude>100 then oprt.Velocity=Vector3.new(0,0,0)end
                        if oprt.RotVelocity.Magnitude>100 then oprt.RotVelocity=Vector3.new(0,0,0)end
                    end
                end
            end
        end
    end)
end

local function cTSli(mV,mxV,cV,p,cb)local SF=Instance.new("Frame",p)SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,65),Color3.fromRGB(42,42,45)Instance.new("UICorner",SF).CornerRadius=UDim.new(0,8)Instance.new("UIStroke",SF).Color=Color3.fromRGB(60,60,65)local TL=Instance.new("TextLabel",SF)TL.Size,TL.Position,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0,12,0,6),Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left local TiL=Instance.new("TextLabel",SF)TiL.Size,TiL.Position,TiL.TextColor3,TiL.Font,TiL.TextSize,TiL.BackgroundTransparency,TiL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0.5,0,0,6),CTh.A,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Right table.insert(TE.Txs,TiL)local RL=Instance.new("TextLabel",SF)RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,24),"Arraste para ajustar",Color3.fromRGB(160,160,165),Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left local Tk=Instance.new("Frame",SF)Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,46),Color3.fromRGB(25,25,28)Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)local pI=math.clamp((cV-mV)/(mxV-mV),0,1)local F=Instance.new("Frame",Tk)F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),CTh.A Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)table.insert(TE.Accs,F)local K=Instance.new("Frame",Tk)K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)local KS=Instance.new("UIStroke",K)KS.Color,KS.Thickness=CTh.A,2 table.insert(TE.Accs,KS)local function fUI(v)local h,m=math.floor(v),math.floor((v-math.floor(v))*60)local pt="Noite 🌙"if h>=6 and h<13 then pt="Dia ☀️"elseif h>=13 and h<18 then pt="Tarde 🌤️"end TL.Text="Período: "..pt TiL.Text=string.format("%02d:%02d",h,m)end fUI(cV)local HB=Instance.new("TextButton",SF)HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""local d=false local function upd(ip)local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)local pc=pX/Tk.AbsoluteSize.X local vl=mV+(mxV-mV)*pc TS:Create(F,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(pc,0,1,0)}):Play()TS:Create(K,TweenInfo.new(0.05,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(pc,0,0.5,0)}):Play()fUI(vl)cb(vl)end HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)UIS.InputChanged:Connect(function(ip)if d and(ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch)then upd(ip)end end)return function(nV,ig)if d and ig then return end local pc=math.clamp((nV-mV)/(mxV-mV),0,1)F.Size=UDim2.new(pc,0,1,0)K.Position=UDim2.new(pc,0,0.5,0)fUI(nV)end end

cST("✨ GRÁFICOS",sM)local stU,ftU stU=cTog("✨ Shaders",sM,shOn,function(s)shOn=s uLig()end,"Shaders")ftU=cTog("🥔 Booster FPS",sM,fpsOn,function(s)if s and shOn then sNotif("Erro","Desative Shaders primeiro.","Error")fpsOn=false if ftU then ftU(false)end return end fpsOn=s uLig()end,"FpsBoost")
cTog("🌫️ Desfoque Parede",sM,wbOn,function(s)wbOn=s if not s then local b=L:FindFirstChild("VortexWallBlur")if b then b.Size=0 end end end,"WallBlur")cTog("🌫️ Neblina",sM,fgOn,function(s)fgOn=s uLig()end,"Fog")
cTog("🌀 Motion Blur",sM,mbOn,function(s)if s then local b=Instance.new("BlurEffect",L)b.Name,b.Size="VortexMotionBlur",0 local c=W.CurrentCamera if c then lCR=c.CFrame-c.CFrame.Position end mbc=RS.RenderStepped:Connect(function()local cam=W.CurrentCamera if not cam then return end local rot=cam.CFrame-cam.CFrame.Position local d=rot.LookVector:Dot(lCR.LookVector)local a=math.acos(math.clamp(d,-1,1))local tB=math.clamp(math.deg(a)*1.5,0,30)b.Size,lCR=b.Size+(tB-b.Size)*0.2,rot end)else if mbc then mbc:Disconnect()mbc=nil end local b=L:FindFirstChild("VortexMotionBlur")if b then b:Destroy()end end end,"MotionBlur")
cTog("☀️ Fullbright",sM,fbOn,function(s)fbOn=s if s then fbLp=RS.RenderStepped:Connect(function()L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.FogEnd=Color3.new(1,1,1),Color3.new(1,1,1),2,false,100000 end)else if fbLp then fbLp:Disconnect()fbLp=nil end uLig()end end,"Fullbright")
cTog("🔦 Luz Player",sM,plOn,function(s)plOn=s if s then plc=RS.Heartbeat:Connect(function()local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local h=c.HumanoidRootPart if not h:FindFirstChild("VortexPlayerLight")then local l=Instance.new("PointLight",h)l.Name,l.Brightness,l.Range,l.Shadows,l.Color="VortexPlayerLight",3,60,false,Color3.new(1,1,1)end end end)else if plc then plc:Disconnect()plc=nil end local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local l=c.HumanoidRootPart:FindFirstChild("VortexPlayerLight")if l then l:Destroy()end end end end,"PlayerLight")
cST("⏰ TEMPO",sM)local uTSUI cTog("🔄 Auto Tempo",sM,atOn,function(s)atOn=s if s then atc=RS.RenderStepped:Connect(function(dt)L.ClockTime=(L.ClockTime+(0.4*dt))%24 if uTSUI then uTSUI(L.ClockTime,true)end end)else if atc then atc:Disconnect()atc=nil end end end,"AutoTime")
uTSUI=cTSli(0,24,L.ClockTime,sM,function(v)if not atOn then L.ClockTime=v end end)
local rainLoop=nil local rPrt=nil local rEmt=nil
local function stpR()if rEmt then rEmt.Enabled=false end end
local function stRt()if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart")then return end if not rPrt then rPrt=Instance.new("Part")rPrt.Name="VtxRain"rPrt.Anchored=true rPrt.CanCollide=false rPrt.Transparency=1 rPrt.Size=Vector3.new(150,1,150)rPrt.Parent=W rEmt=Instance.new("ParticleEmitter",rPrt)rEmt.Texture="rbxassetid://2273224484"rEmt.Rate=600 rEmt.Speed=NumberRange.new(60,80)rEmt.Lifetime=NumberRange.new(1.5,2.5)rEmt.EmissionDirection=Enum.NormalId.Bottom rEmt.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,0.3)})rEmt.Color=ColorSequence.new(Color3.fromRGB(150,170,200))rEmt.Transparency=NumberSequence.new(0.5)end task.spawn(function()rEmt.Enabled=true local d=math.random(10,20)local sT=tick()while rrOn and(tick()-sT<d)and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")do rPrt.CFrame=LP.Character.HumanoidRootPart.CFrame*CFrame.new(0,50,0)task.wait(0.1)end stpR()end)end
cTog("🌧️ Chuva Aleatória (15% Chance)",sM,rrOn,function(s)rrOn=s if s then rainLoop=task.spawn(function()while rrOn do task.wait(5)if math.random(1,100)<=15 then stRt()task.wait(25)end end end)else if rainLoop then task.cancel(rainLoop)rainLoop=nil end stpR()end end,"RandomRain")

cST("👁️ ESP",sE)
cTog("👤 ESP Player",sE,epOn,function(s)epOn=s if not s then cETb(tPly)end uESP()end,"ESPPlayer")
cTog("🤖 ESP NPC",sE,enOn,function(s)enOn=s if not s then cETb(tNPC)end uESP()end,"ESPNPC")
cTog("⚠️ Alerta NPC Hostil",sE,dEspOn,function(s)dEspOn=s if not s then cETb(tDNPC)end uDEsp()end,"DangerESP")
cTog("📦 ESP de Itens",sE,espiOn,function(s)espiOn=s if not s then for _,d in pairs(tItems) do if d.Gui then d.Gui:Destroy() end end table.clear(tItems) end uItemESP() end,"ESPItems")

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
cTog("👻 Noclip",sP,nclOn,function(s)nclOn=s if s then nlc=RS.Stepped:Connect(function()local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(11)end end end)else if nlc then nlc:Disconnect()nlc=nil end end end,"Noclip")

cTog("🔭 Infinite Zoom",sP,izOn,function(s)
    izOn=s
    if s then
        ozm=LP.CameraMaxZoomDistance
        pcall(function()LP.CameraMaxZoomDistance=math.huge end)
        if izc then izc:Disconnect()izc=nil end
        izc=RS.RenderStepped:Connect(function()
            if izOn then pcall(function()LP.CameraMaxZoomDistance=math.huge end)end
        end)
    else
        if izc then izc:Disconnect()izc=nil end
        pcall(function()LP.CameraMaxZoomDistance=ozm or 400 end)
    end
end,"InfiniteZoom")

cSli("🏃 WalkSpeed","16 a 50",16,200,pSpd,sP,function(v)pSpd=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed=v end end end,"WalkSpeed")cSli("🦘 JumpPower","50 a 100",50,300,pJmp,sP,function(v)pJmp=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.JumpPower=v end end end,"JumpPower")cSli("🔭 FOV","70 a 90",70,120,pFov,sP,function(v)pFov=v end,"FOV")

cST("🛡️ PROTEÇÃO",sPr)
afToggle=cTog("🛡️ Anti-Fling",sPr,afOn,function(s)afOn=s if s then eAF()else if afc then afc:Disconnect()afc=nil end end end,"AntiFling")
cTog("🌌 Anti-Void",sPr,avOn,function(s)avOn=s if s then local rp=RaycastParams.new()rp.FilterType=Enum.RaycastFilterType.Exclude avc=RS.Heartbeat:Connect(function()if not avOn then return end local c=LP.Character if not c then return end local h,hu=c:FindFirstChild("HumanoidRootPart"),c:FindFirstChildOfClass("Humanoid")if not h or not hu or hu.Health<=0 then return end rp.FilterDescendantsInstances={c}if hu.FloorMaterial~=Enum.Material.Air then lSCf=h.CFrame end local hD,hU=W:Raycast(h.Position,Vector3.new(0,-2500,0),rp),W:Raycast(h.Position,Vector3.new(0,2500,0),rp)if not hD and not hU and h.Position.Y<-50 then h.AssemblyLinearVelocity,h.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)pcall(function()h.Velocity,h.RotVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)end)local sCF if lSCf and lSCf.Position.Y>-20 then sCF=lSCf+Vector3.new(0,3,0)end if not sCF then local sl=W:FindFirstChildWhichIsA("SpawnLocation",true)if sl then sCF=sl.CFrame+Vector3.new(0,5,0)end end if not sCF then local cr=W:Raycast(Vector3.new(0,500,0),Vector3.new(0,-1000,0),rp)if cr and cr.Position then sCF=CFrame.new(cr.Position+Vector3.new(0,5,0))end end if not sCF then sCF=CFrame.new(0,50,0)end h.CFrame=sCF sNotif("🛡️","Salvo do Void!","Success")end end)else if avc then avc:Disconnect()avc=nil end end end,"AntiVoid")
cTog("🚫 Anti-AFK",sPr,aaOn,function(s)aaOn=s if s then aac=LP.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)else if aac then aac:Disconnect()aac=nil end end end,"AntiAfk")
cTog("🔄 Auto-Rejoin (Anti-Disconnect)",sPr,arOn,function(s)arOn=s if s then arc=game:GetService("GuiService").ErrorMessageChanged:Connect(function()task.wait(1.5)game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)else if arc then arc:Disconnect()arc=nil end end end,"AutoRejoin")

cST("📜 HISTÓRICO • SESSÕES & SEGURANÇA",sH)
cTog("🔔 Notificações",sH,jelOn,function(s)jelOn=s end,"Notifications")
cTog("🛡️ Detector de Anomalias",sH,adOn,function(s)adOn=s if s then detectorStart()else if adCn then adCn:Disconnect()adCn=nil end end end,"AntiExploitDetector")
cTog("⚡ Auto Anti-Fling",sH,aafOn,function(s)aafOn=s end,"AutoAntiFling")

local function cTBtn(n,mc,tc,ac,tk)local b=Instance.new("TextButton",sTh)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,40),Color3.fromRGB(45,45,45),"🎨 "..n,ac,Enum.Font.GothamBold,14 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(function()appT(mc,tc,ac,tk)end)end
cTBtn("Orion",Color3.fromRGB(36,36,37),Color3.fromRGB(30,30,30),Color3.fromRGB(52,152,219),"Orion")cTBtn("Vampiro",Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50),"Vampiro")cTBtn("Tóxico",Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100),"Tóxico")cTBtn("Ametista",Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182),"Ametista")cTBtn("Ouro",Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15),"Ouro")cTBtn("Sakura",Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204),"Sakura")cTBtn("Neon",Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255),"Neon")cTBtn("Magma",Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34),"Magma")
cTBtn("Cyberpunk",Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0),"Cyberpunk")cTBtn("Oceano",Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255),"Oceano")cTBtn("Inferno",Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0),"Inferno")cTBtn("Fantasma",Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230),"Fantasma")cTBtn("Floresta",Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100),"Floresta")

cST("👥 SELECIONAR JOGADOR",sV)
local uPL
cTog("🛡️ Whitelist de Amigos",sV,wlOn,function(s)
    wlOn=s
    if uPL then uPL()end
    uESP()
end,"Whitelist")

local sPly=nil
local TgtF=Instance.new("Frame",sV)TgtF.Size,TgtF.BackgroundTransparency=UDim2.new(1,0,0,50),1
local TarImg=Instance.new("ImageLabel",TgtF)TarImg.Size,TarImg.Position,TarImg.BackgroundColor3,TarImg.BorderSizePixel,TarImg.ClipsDescendants=UDim2.new(0,40,0,40),UDim2.new(0,12,0.5,-20),Color3.fromRGB(30,30,35),0,true Instance.new("UICorner",TarImg).CornerRadius=UDim.new(1,0)
local TarImgSk=Instance.new("UIStroke",TarImg)TarImgSk.Color=CTh.A table.insert(TE.Accs,TarImgSk)
local TarL=Instance.new("TextLabel",TgtF)TarL.Size,TarL.Position,TarL.BackgroundTransparency,TarL.Text,TarL.TextColor3,TarL.Font,TarL.TextSize,TarL.TextXAlignment=UDim2.new(1,-70,1,0),UDim2.new(0,60,0,0),1,"Alvo Atual: Nenhum",CTh.A,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left table.insert(TE.Txs,TarL)
local SBF=Instance.new("Frame",sV)SBF.Size,SBF.BackgroundColor3=UDim2.new(1,0,0,35),Color3.fromRGB(40,40,45)Instance.new("UICorner",SBF).CornerRadius=UDim.new(0,6)local SIc=Instance.new("TextLabel",SBF)SIc.Size,SIc.BackgroundTransparency,SIc.Text,SIc.TextSize=UDim2.new(0,30,1,0),1,"🔎",16 local SInp=Instance.new("TextBox",SBF)SInp.Size,SInp.Position,SInp.BackgroundTransparency,SInp.Text,SInp.PlaceholderText,SInp.TextColor3,SInp.Font,SInp.TextSize,SInp.TextXAlignment=UDim2.new(1,-35,1,0),UDim2.new(0,30,0,0),1,"","Pesquisar jogador...",Color3.fromRGB(255,255,255),Enum.Font.Gotham,13,Enum.TextXAlignment.Left
local PLF=Instance.new("ScrollingFrame",sV)PLF.Size,PLF.BackgroundColor3,PLF.BorderSizePixel,PLF.ScrollBarThickness=UDim2.new(1,0,0,180),Color3.fromRGB(30,30,35),0,4 Instance.new("UICorner",PLF).CornerRadius=UDim.new(0,6)local UIL=Instance.new("UIListLayout",PLF)UIL.Padding,UIL.HorizontalAlignment,UIL.SortOrder=UDim.new(0,6),Enum.HorizontalAlignment.Center,Enum.SortOrder.Name UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()PLF.CanvasSize=UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y+10)end)local pBD={}

uPL=function()
    for _,d in pairs(pBD)do d.Btn:Destroy()end table.clear(pBD)
    local f=string.lower(SInp.Text or"")
    for _,p in ipairs(P:GetPlayers())do
        if p~=LP then
            if isFriend(p) then continue end
            local b=Instance.new("TextButton",PLF)
            b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment=UDim2.new(1,-12,0,44),Color3.fromRGB(42,42,48),"              "..p.DisplayName.." (@"..p.Name..")",Color3.fromRGB(240,240,240),Enum.Font.GothamBold,13,Enum.TextXAlignment.Left
            Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
            Instance.new("UIStroke",b).Color=Color3.fromRGB(60,60,65)
            local avI=Instance.new("ImageLabel",b)avI.Size,avI.Position,avI.BackgroundTransparency,avI.BackgroundColor3=UDim2.new(0,32,0,32),UDim2.new(0,8,0.5,-16),1,Color3.fromRGB(30,30,35)
            Instance.new("UICorner",avI).CornerRadius=UDim.new(1,0)
            task.spawn(function()local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)if s and r then avI.Image=r end end)
            b.MouseButton1Click:Connect(function()
                sPly=p TarL.Text="Alvo Atual: "..p.DisplayName
                sNotif("Alvo","Selecionado: "..p.Name,"Info")
                task.spawn(function()local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)end)if s and r then TarImg.Image=r end end)
            end)
            table.insert(pBD,{Btn=b,Player=p})
            local pn,pd=string.lower(p.Name),string.lower(p.DisplayName)
            if f==""or string.find(pn,f)or string.find(pd,f)then b.Visible=true else b.Visible=false end
        end
    end
end
SInp:GetPropertyChangedSignal("Text"):Connect(uPL)
P.PlayerAdded:Connect(function(p)
    aLH(p,"JOIN",true)
    uPL()
end)
P.PlayerRemoving:Connect(function(p)
    aLH(p,"EXIT",true)
    DetState[p]=nil
    if sPly==p then sPly=nil TarL.Text="Alvo Atual: Nenhum" TarImg.Image=""end
    uPL()
end)
uPL()

for _,p in ipairs(P:GetPlayers())do
    if p~=LP then
        task.spawn(function()aLH(p,"JOIN",false)end)
    end
end

cST("⚙️ AÇÕES DO ALVO",sV)local function cAB(n,p,cb)local B=Instance.new("TextButton",p)B.Size,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(1,0,0,38),Color3.fromRGB(45,45,45),n,Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13 Instance.new("UICorner",B).CornerRadius=UDim.new(0,6)B.MouseButton1Click:Connect(function()if sPly then cb(sPly)else sNotif("Aviso","Selecione um jogador na lista acima primeiro!","Error")end end)end
cAB("🚀 Teleport",sV,function(t)if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)sNotif("Teleport","Teleportado para "..t.Name,"Success")end end)
local vCn cTog("👁️ View (Spectate)",sV,false,function(s)if s then if sPly and sPly.Character and sPly.Character:FindFirstChild("Humanoid")then W.CurrentCamera.CameraSubject=sPly.Character.Humanoid sNotif("View","Assistindo "..sPly.Name,"Info")else sNotif("Aviso","O alvo não tem um personagem válido.","Error")end else if LP.Character and LP.Character:FindFirstChild("Humanoid")then W.CurrentCamera.CameraSubject=LP.Character.Humanoid end end end,nil)
local lgCn cTog("🔁 Loopgoto",sV,false,function(s)if s then if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end if lgCn then lgCn:Disconnect()end lgCn=RS.Heartbeat:Connect(function()if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=sPly.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)end end)else if lgCn then lgCn:Disconnect()lgCn=nil end end end,nil)
local fCn cTog("🏃 Follow Player",sV,false,function(s)if s then if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end if fCn then fCn:Disconnect()end fCn=RS.Heartbeat:Connect(function()if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("Humanoid")then LP.Character:FindFirstChildOfClass("Humanoid"):MoveTo(sPly.Character.HumanoidRootPart.Position)end end)else if fCn then fCn:Disconnect()fCn=nil end end end,nil)

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
    elseif sT=="Magma"then appT(Color3.fromRGB(40,20,10),Color3.fromRGB(40,20,10))
    elseif sT=="Cyberpunk"then appT(Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0))
    elseif sT=="Oceano"then appT(Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255))
    elseif sT=="Inferno"then appT(Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0))
    elseif sT=="Fantasma"then appT(Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230))
    elseif sT=="Floresta"then appT(Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100))
    end
    for _,iF in pairs(IC)do pcall(function()iF()end)end
    if adOn then detectorStart()end
    uLig()
end)
