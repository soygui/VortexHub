local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
local LP=P.LocalPlayer local TP=(gethui and gethui())or CG if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end
local SFName="VortexHub_Config.json" local HC={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,RandomRain=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,AutoRejoin=false,Notifications=true,SelectedTheme="Orion",Whitelist=true}
local IC={} local function saveC()pcall(function()if writefile then writefile(SFName,HS:JSONEncode(HC))end end)end
local function loadC()if readfile and isfile and isfile(SFName)then local s,d=pcall(function()return HS:JSONDecode(readfile(SFName))end)if s and type(d)=="table"then for k,v in pairs(d)do if HC[k]~=nil then HC[k]=v end end end end end loadC()
local shOn,fpsOn,wbOn,fgOn,mbOn,fbOn,plOn,atOn,rrOn,epOn,enOn,dEspOn,ttOn,iiOn,pmOn,ncOn,ijOn,nclOn,pSpd,pJmp,pFov,afOn,avOn,aaOn,arOn,jelOn,wlOn=HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip,HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist
local ijc,nlc,avc,pmc,aac,arc,atc,sLp,iic,fbLp,plc,mbc,afc,ncc,nlDesc local lSCf=nil local lCR=CFrame.new()local ECol={PName="#00FFFF",PHP="#32FF32",PDist="#FFAA00",NName="#FF4444",NHP="#32FF32",NDist="#FFAA00"}
local tNPC,tPly,tDNPC={},{},{} local eUp,dUp local nclParts={}
local lightBoostCn=nil local lightCache={}
local Debris=game:GetService("Debris")
local SoundService=game:GetService("SoundService")
local TT_TELEPORT_SOUND=74715602103425
local TT_DEATH_SOUND=139316271339298
local TT_WAIT_SOUND=5047326951
local YT_LINK="https://youtube.com/@Soy_Gui_Oficial"
local function clrCE()for _,v in pairs(L:GetChildren())do if v.Name:match("Vortex")and v.Name~="VortexMotionBlur"and v.Name~="VortexWallBlur"and v.Name~="VortexDeathFade"then v:Destroy()end end end
local OL={GS=L.GlobalShadows,B=L.Brightness,EDS=L.EnvironmentDiffuseScale,ESS=L.EnvironmentSpecularScale,FS=L.FogStart,FE=L.FogEnd,FC=L.FogColor,CT=L.ClockTime,A=L.Ambient,OA=L.OutdoorAmbient,T=L.Technology,SS=L.ShadowSoftness,EC=L.ExposureCompensation}
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

local function playTTSound(id,volume)
local s=Instance.new("Sound")
s.Name="VortexTeleportEasterEgg"
s.SoundId="rbxassetid://"..tostring(id)
s.Volume=volume or 1
s.PlaybackSpeed=1
s.Parent=SoundService
pcall(function()s:Play()end)
Debris:AddItem(s,10)
end

local function emitTTParticles(c)
if not c then return end
local hrp=c:FindFirstChild("HumanoidRootPart")
if not hrp then return end
local a=Instance.new("Attachment")
a.Name="VortexTeleportParticles"
a.Position=Vector3.new(0,0,0)
a.Parent=hrp
local p=Instance.new("ParticleEmitter")
p.Name="EndermanParticles"
p.Texture="rbxasset://textures/particles/sparkles_main.dds"
p.Color=ColorSequence.new(Color3.fromRGB(170,0,255))
p.LightEmission=1
p.Brightness=2.5
p.Rate=0
p.Lifetime=NumberRange.new(0.3,0.75)
p.Speed=NumberRange.new(20,42)
p.Drag=3.5
p.SpreadAngle=Vector2.new(360,360)
p.Rotation=NumberRange.new(0,360)
p.RotSpeed=NumberRange.new(-220,220)
p.Acceleration=Vector3.new(0,6,0)
p.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.36),NumberSequenceKeypoint.new(0.6,0.2),NumberSequenceKeypoint.new(1,0)})
p.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.05),NumberSequenceKeypoint.new(0.72,0.35),NumberSequenceKeypoint.new(1,1)})
p.Parent=a
p:Emit(52)
Debris:AddItem(a,1.5)
end

local function stDE(c)
if not c then return end
local h=c:WaitForChild("Humanoid",5)
if not h then return end
h.Died:Connect(function()
local hasTT=c:FindFirstChild("TeleportTool")~=nil
pDead=true
local wb=L:FindFirstChild("VortexWallBlur")
if not wb then wb=Instance.new("BlurEffect",L)wb.Name="VortexWallBlur"end
local ti=TweenInfo.new(2.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
TS:Create(wb,ti,{Size=45}):Play()
TS:Create(dF,ti,{Brightness=-1,Contrast=-0.5}):Play()
if hasTT then task.defer(function()playTTSound(TT_DEATH_SOUND,1)end)end
end)
end

local tT=nil
local sNotif
local ttEquipped=false
local ttWaitPlayed=false
local ttUseToken=0

local function teleportTarget()
local c=LP.Character
if not c then return nil,"Personagem não encontrado."end
local hrp=c:FindFirstChild("HumanoidRootPart")
if not hrp then return nil,"HumanoidRootPart não encontrado."end
local cam=W.CurrentCamera
local mouse=LP:GetMouse()
if not cam or not mouse then return nil,"Câmera ou mouse indisponível."end
local sx,sy=mouse.X,mouse.Y
if (not sx or not sy)or(sx==0 and sy==0)then
local vp=UIS:GetMouseLocation()
sx,sy=vp.X,vp.Y
end
local ray
pcall(function()ray=cam:ViewportPointToRay(sx,sy)end)
if not ray then return nil,"Não foi possível detectar o alvo."end
local rp=RaycastParams.new()
rp.FilterType=Enum.RaycastFilterType.Exclude
rp.FilterDescendantsInstances={c}
rp.IgnoreWater=false
local hit=W:Raycast(ray.Origin,ray.Direction*2000,rp)
if not hit then return nil,"Nenhuma superfície foi encontrada nesse ponto."end
local inst=hit.Instance
local validSurface=false
if inst:IsA("Terrain") then
validSurface=hit.Material~=Enum.Material.Water
elseif inst:IsA("BasePart") then
validSurface=inst.CanCollide and inst.Transparency<0.95
end
if not validSurface then return nil,"Destino inválido: não há um bloco ou superfície sólida."end
if hit.Normal.Y<-0.45 then return nil,"Não é possível teleportar para uma superfície acima do personagem."end
local _,charSize=c:GetBoundingBox()
local halfY=math.max(charSize.Y*0.5,2)
local halfX=math.max(charSize.X*0.5,1.5)
local halfZ=math.max(charSize.Z*0.5,1.5)
local target
if hit.Normal.Y>=0.55 then
 target=hit.Position+Vector3.new(0,halfY+0.5,0)
else
 local side=math.max(halfX,halfZ)+1.25
 local base=hit.Position+hit.Normal*side+Vector3.new(0,6,0)
 local floorHit=W:Raycast(base,Vector3.new(0,-14,0),rp)
 if not floorHit then return nil,"Destino inválido: não existe chão seguro abaixo."end
 if floorHit.Instance:IsA("BasePart")and(not floorHit.Instance.CanCollide or floorHit.Instance.Transparency>=0.95)then return nil,"Destino inválido: o chão não é sólido."end
 if floorHit.Instance:IsA("Terrain")and floorHit.Material==Enum.Material.Water then return nil,"Destino inválido: água não é um ponto seguro."end
 target=floorHit.Position+Vector3.new(0,halfY+0.5,0)+hit.Normal*0.25
end
local floorCheck=W:Raycast(target+Vector3.new(0,6,0),Vector3.new(0,-14,0),rp)
if not floorCheck then return nil,"Destino inválido: sem apoio sólido para o personagem."end
if floorCheck.Instance:IsA("Terrain")and floorCheck.Material==Enum.Material.Water then return nil,"Destino inválido: o apoio é água."end
if floorCheck.Instance:IsA("BasePart")and(not floorCheck.Instance.CanCollide or floorCheck.Instance.Transparency>=0.95)then return nil,"Destino inválido: o apoio não é sólido."end
target=floorCheck.Position+Vector3.new(0,halfY+0.5,0)
local overlap=OverlapParams.new()
overlap.FilterType=Enum.RaycastFilterType.Exclude
overlap.FilterDescendantsInstances={c}
overlap.MaxParts=80
local boxSize=Vector3.new(math.max(charSize.X-0.4,2),math.max(charSize.Y-1,3.5),math.max(charSize.Z-0.4,2))
local blocked=W:GetPartBoundsInBox(CFrame.new(target),boxSize,overlap)
for _,part in ipairs(blocked)do
if part and part.Parent and part~=floorCheck.Instance and part:IsA("BasePart")and part.CanCollide and part.Transparency<0.95 then
return nil,"Destino bloqueado: não há espaço suficiente para o personagem."
end
end
local headOrigin=target+Vector3.new(0,math.max(halfY-0.5,2),0)
local headHit=W:Raycast(headOrigin,Vector3.new(0,math.max(halfY,2),0),rp)
if headHit and headHit.Instance then return nil,"Destino bloqueado: existe uma parede ou teto no caminho."end
return CFrame.new(target,Vector3.new(target.X,target.Y,target.Z)+hrp.CFrame.LookVector)
end

local function rTT()
ttEquipped=false
ttWaitPlayed=false
ttUseToken=ttUseToken+1
if tT then tT:Destroy()tT=nil end
if LP:FindFirstChild("Backpack")then local b=LP.Backpack:FindFirstChild("TeleportTool")if b then b:Destroy()end end
if LP.Character then local c=LP.Character:FindFirstChild("TeleportTool")if c then c:Destroy()end end
end

local function gTT()
rTT()if not ttOn then return end
local T=Instance.new("Tool")
T.Name,T.RequiresHandle,T.CanBeDropped="TeleportTool",false,false
T.Equipped:Connect(function()
ttEquipped=true
ttWaitPlayed=false
ttUseToken=ttUseToken+1
local token=ttUseToken
task.delay(8,function()
if ttEquipped and not ttWaitPlayed and tT==T and token==ttUseToken and LP.Character and T.Parent==LP.Character then
 ttWaitPlayed=true
 playTTSound(TT_WAIT_SOUND,1)
end
end)
end)
T.Unequipped:Connect(function()
ttEquipped=false
ttWaitPlayed=false
ttUseToken=ttUseToken+1
end)
T.Activated:Connect(function()
if not ttEquipped or T.Parent~=LP.Character then return end
local token=ttUseToken
local completed=false
task.delay(3,function()
if not completed and ttEquipped and not ttWaitPlayed and tT==T and token==ttUseToken and LP.Character and T.Parent==LP.Character then
 ttWaitPlayed=true
 playTTSound(TT_WAIT_SOUND,1)
end
end)
local target,reason=teleportTarget()
if not target then
sNotif("TeleportTool",reason or "Destino inválido.","Error")
return
end
local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if not hrp then return end
emitTTParticles(c)
playTTSound(TT_TELEPORT_SOUND,1)
hrp.CFrame=target
completed=true
task.defer(function()
if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then emitTTParticles(LP.Character)end
end)
sNotif("✨","Teleporte realizado com segurança!","Success")
end)
local bp=LP:WaitForChild("Backpack",3)
if bp then T.Parent=bp tT=T end
end

local function nclPart(v)
if not v or not v:IsA("BasePart")then return end
if nclParts[v]==nil then nclParts[v]=v.CanCollide end
v.CanCollide=false
end
local function startNcl()
if nlc then nlc:Disconnect()nlc=nil end
if nlDesc then nlDesc:Disconnect()nlDesc=nil end
table.clear(nclParts)
local c=LP.Character
if c then
for _,v in ipairs(c:GetDescendants())do nclPart(v)end
nlDesc=c.DescendantAdded:Connect(function(v)if nclOn then nclPart(v)end end)
end
nlc=RS.Stepped:Connect(function()
if not nclOn then return end
local c=LP.Character
if not c then return end
for _,v in ipairs(c:GetDescendants())do
if v:IsA("BasePart")and v.CanCollide then
if nclParts[v]==nil then nclParts[v]=v.CanCollide end
v.CanCollide=false
end
end
end)
end
local function stopNcl()
if nlc then nlc:Disconnect()nlc=nil end
if nlDesc then nlDesc:Disconnect()nlDesc=nil end
for v,old in pairs(nclParts)do if v and v.Parent then pcall(function()v.CanCollide=old end)end end
table.clear(nclParts)
end

local function boostLights()
if lightBoostCn then lightBoostCn:Disconnect()lightBoostCn=nil end
table.clear(lightCache)
local function boost(v)
if not v or not v:IsA("Light") then return end
if lightCache[v] then return end
local old={Brightness=v.Brightness,Range=v.Range}
lightCache[v]=old
pcall(function()v.Brightness=old.Brightness*1.35+0.25 end)
pcall(function()v.Range=old.Range*1.1 end)
end
for _,v in ipairs(W:GetDescendants())do boost(v)end
lightBoostCn=W.DescendantAdded:Connect(function(v)if shOn then task.defer(function()boost(v)end)end end)
end
local function restoreLights()
if lightBoostCn then lightBoostCn:Disconnect()lightBoostCn=nil end
for v,old in pairs(lightCache)do if v and v.Parent then pcall(function()v.Brightness=old.Brightness v.Range=old.Range end)end end
table.clear(lightCache)
end

LP.CharacterAdded:Connect(function(c)
pDead=false
ttEquipped=false
ttWaitPlayed=false
if dF then TS:Create(dF,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Brightness=0,Contrast=0}):Play()end
local wb=L:FindFirstChild("VortexWallBlur")if wb then TS:Create(wb,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Size=0}):Play()end
stDE(c)
if ttOn then task.spawn(function()task.wait(0.5)gTT()end)end
if nclOn then task.delay(0.2,function()if nclOn and LP.Character==c then startNcl()end end)end
end)
if LP.Character then stDE(LP.Character)end

local function gPB(cam,c)
if not wbOn then return 0 end
local mB,mD,cD=12,45,45
local rP=RaycastParams.new()
rP.FilterType=Enum.RaycastFilterType.Exclude
rP.FilterDescendantsInstances={c,cam}
local ang={CFrame.Angles(0,0,0),CFrame.Angles(0,math.rad(25),0),CFrame.Angles(0,math.rad(-25),0),CFrame.Angles(math.rad(15),0,0),CFrame.Angles(math.rad(-15),0,0)}
for _,a in ipairs(ang)do local dir=(cam.CFrame*a).LookVector local h=W:Raycast(cam.CFrame.Position,dir*mD,rP)if h and h.Instance and h.Instance.Transparency<0.8 and h.Instance.CanCollide and h.Distance<cD then cD=h.Distance end end
local vS=cam.ViewportSize
local function ckD(hrp,obj)
local d=(hrp.Position-cam.CFrame.Position).Magnitude
if d<mD then
local sP,oS=cam:WorldToViewportPoint(hrp.Position)
if oS and sP.X>=0 and sP.X<=vS.X and sP.Y>=0 and sP.Y<=vS.Y then
local ry=W:Raycast(cam.CFrame.Position,(hrp.Position-cam.CFrame.Position),rP)
if not ry or ry.Instance:IsDescendantOf(obj)then if d<cD then cD=d end end
end
end
end
for _,p in ipairs(P:GetPlayers())do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then ckD(p.Character.HumanoidRootPart,p.Character)end end
for _,o in ipairs(W:GetChildren())do if o:IsA("Model")and o~=c and o:FindFirstChildOfClass("Humanoid")then local tH=o:FindFirstChild("HumanoidRootPart")or o.PrimaryPart if tH then ckD(tH,o)end end end
if cD<mD then return(1-(cD/mD))*mB end
return 0
end
local function cInd(hrp,rP)if not hrp then return false end local hs=0 local off={Vector3.new(0,0,0),Vector3.new(8,0,0),Vector3.new(-8,0,0),Vector3.new(0,0,8),Vector3.new(0,0,-8)}for _,o in ipairs(off)do local h=W:Raycast(hrp.Position+o,Vector3.new(0,120,0),rP)if h and h.Instance and h.Instance.CanCollide and h.Instance.Transparency<0.5 then hs=hs+1 end end return hs>=3 end
local CNPCs={} local function cNPC(o)if o:IsA("Model")and o:FindFirstChild("Humanoid")and o:FindFirstChild("HumanoidRootPart")and not P:GetPlayerFromCharacter(o)then CNPCs[o]=true end end
for _,o in ipairs(W:GetDescendants())do cNPC(o)end
W.DescendantAdded:Connect(function(o)task.delay(0.2,function()if o and o.Parent then if o:IsA("Model")then cNPC(o)end if o.Parent:IsA("Model")then cNPC(o.Parent)end end end)end)
W.DescendantRemoving:Connect(function(o)if CNPCs[o]then CNPCs[o]=nil end end)

local CTh={MBG=Color3.fromRGB(30,23,39),TB=Color3.fromRGB(24,20,31),A=Color3.fromRGB(170,70,255)}
local TE={Bgs={},TBs={},Accs={},Tgls={},Txs={}}
local function appT(m,t,a,tn)
CTh.MBG,CTh.TB,CTh.A=m,t,a
if tn then HC.SelectedTheme=tn saveC()end
for _,f in pairs(TE.Bgs)do if f and f.Parent then f.BackgroundColor3=m end end
for _,f in pairs(TE.TBs)do if f and f.Parent then f.BackgroundColor3=t end end
for _,o in pairs(TE.Accs)do if o and o.Parent then if o:IsA("UIStroke")then o.Color=a else o.BackgroundColor3=a end end end
for _,tx in pairs(TE.Txs)do if tx and tx.Parent then tx.TextColor3=a end end
for bg,sF in pairs(TE.Tgls)do if bg and bg.Parent and sF()then TS:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=a}):Play()end end
end

local SG=Instance.new("ScreenGui",TP)
SG.Name="VortexGraphicsHub"
SG.ResetOnSpawn=false
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

local msgId=0
local function findJumpButton()
local roots={}
local pg=LP:FindFirstChildOfClass("PlayerGui")
if pg then table.insert(roots,pg)end
if TP and TP~=CG then table.insert(roots,TP)end
table.insert(roots,CG)
for _,root in ipairs(roots)do local ok,b=pcall(function()return root:FindFirstChild("JumpButton",true)end)if ok and b and b:IsA("GuiObject")and b.Visible then return b end end
end
local function placeMsg(lbl)
local cam=W.CurrentCamera
local jb=findJumpButton()
local x,y
if jb then x=jb.AbsolutePosition.X+(jb.AbsoluteSize.X/2) y=jb.AbsolutePosition.Y-8 else local vp=cam and cam.ViewportSize or Vector2.new(1920,1080)x=vp.X-125 y=vp.Y-185 end
lbl.Position=UDim2.fromOffset(math.floor(x),math.floor(y))
end
sNotif=function(tl,tx,nt)
msgId=msgId+1
local myId=msgId
local cc=nt=="Error"and Color3.fromRGB(255,75,95)or(nt=="Success"and Color3.fromRGB(150,255,190)or CTh.A)
local Txt=Instance.new("TextLabel",SG)
Txt.Name="VortexMessage"
Txt.Size=UDim2.new(0,320,0,56)
Txt.AnchorPoint=Vector2.new(0.5,1)
Txt.BackgroundTransparency=1
Txt.Text=string.format("<b>%s</b>\n%s",tl,tx)
Txt.TextColor3=cc
Txt.Font=Enum.Font.Gotham
Txt.TextSize=13
Txt.RichText=true
Txt.TextWrapped=true
Txt.TextXAlignment=Enum.TextXAlignment.Center
Txt.TextYAlignment=Enum.TextYAlignment.Bottom
Txt.TextStrokeTransparency=0.55
Txt.TextTransparency=1
Txt.ZIndex=200
placeMsg(Txt)
TS:Create(Txt,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextTransparency=0}):Play()
task.spawn(function()
local st=tick()
while Txt.Parent and myId==msgId and tick()-st<3.2 do placeMsg(Txt)task.wait(0.1)end
if Txt.Parent and myId==msgId then local tw=TS:Create(Txt,TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{TextTransparency=1})tw:Play()tw.Completed:Wait()end
if Txt.Parent then Txt:Destroy()end
end)
end

local function styleBtn(b,base,accent)
b.AutoButtonColor=false
b.BackgroundColor3=base
local st=Instance.new("UIStroke",b)
st.Color=accent or CTh.A
st.Thickness=1.4
st.Transparency=0.25
table.insert(TE.Accs,st)
local gd=Instance.new("UIGradient",b)
gd.Rotation=90
gd.Color=ColorSequence.new(base:Lerp(Color3.new(1,1,1),0.08),base:Lerp(Color3.new(0,0,0),0.18))
b.MouseEnter:Connect(function()TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=base:Lerp(Color3.new(1,1,1),0.08)}):Play()TS:Create(st,TweenInfo.new(0.15),{Transparency=0}):Play()end)
b.MouseLeave:Connect(function()TS:Create(b,TweenInfo.new(0.15),{BackgroundColor3=base}):Play()TS:Create(st,TweenInfo.new(0.15),{Transparency=0.25}):Play()end)
b.MouseButton1Down:Connect(function()TS:Create(b,TweenInfo.new(0.08),{BackgroundColor3=base:Lerp(Color3.new(1,1,1),0.14)}):Play()end)
b.MouseButton1Up:Connect(function()TS:Create(b,TweenInfo.new(0.12),{BackgroundColor3=base:Lerp(Color3.new(1,1,1),0.08)}):Play()end)
end

local function showIntro()
local F=Instance.new("Frame",SG)
F.Name="VortexLoadingScreen"
F.Size=UDim2.new(1,0,1,0)
F.Position=UDim2.new(0,0,0,0)
F.BackgroundColor3=Color3.fromRGB(9,7,14)
F.BackgroundTransparency=0.04
F.BorderSizePixel=0
F.ZIndex=500
local gd=Instance.new("UIGradient",F)
gd.Rotation=35
gd.Color=ColorSequence.new(Color3.fromRGB(24,10,40),Color3.fromRGB(8,11,25))
local ST=Instance.new("UIStroke",F)ST.Color=Color3.fromRGB(175,60,255)ST.Transparency=0.45 ST.Thickness=2
local scale=Instance.new("UIScale",F)scale.Scale=0.92
TS:Create(scale,TweenInfo.new(0.7,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
local Title=Instance.new("TextLabel",F)Title.Size=UDim2.new(1,-40,0,50)Title.Position=UDim2.new(0,20,0.5,-125)Title.BackgroundTransparency=1 Title.Text="⚡ VORTEX HUB V18"Title.TextColor3=Color3.fromRGB(245,235,255)Title.Font=Enum.Font.GothamBlack Title.TextSize=28 Title.TextXAlignment=Enum.TextXAlignment.Center Title.ZIndex=501 Title.TextTransparency=1
TS:Create(Title,TweenInfo.new(0.5,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency=0}):Play()
local By=Instance.new("TextLabel",F)By.Size=UDim2.new(1,-40,0,30)By.Position=UDim2.new(0,20,0.5,-78)By.BackgroundTransparency=1 By.Text="YouTube: Soy_Gui_Oficial"By.TextColor3=Color3.fromRGB(210,185,255)By.Font=Enum.Font.GothamBold By.TextSize=19 By.TextXAlignment=Enum.TextXAlignment.Center By.ZIndex=501 By.TextTransparency=1
TS:Create(By,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0.15),{TextTransparency=0}):Play()
local Info=Instance.new("TextLabel",F)Info.Size=UDim2.new(1,-70,0,36)Info.Position=UDim2.new(0,35,0.5,-35)Info.BackgroundTransparency=1 Info.Text="Não Achou O Meu <font color=\"#FF1F36\"><b>YOUTUBE</b></font>, Copie O Link:"Info.TextColor3=Color3.fromRGB(235,235,245)Info.Font=Enum.Font.Gotham Info.TextSize=14 Info.RichText=true Info.TextWrapped=true Info.TextXAlignment=Enum.TextXAlignment.Center Info.ZIndex=501 Info.TextTransparency=1
TS:Create(Info,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0.3),{TextTransparency=0}):Play()
task.spawn(function()
while F.Parent do TS:Create(Info,TweenInfo.new(0.65,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{TextStrokeTransparency=0.15}):Play()task.wait(0.65)TS:Create(Info,TweenInfo.new(0.65,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{TextStrokeTransparency=0.55}):Play()task.wait(0.65)end
end)
local Link=Instance.new("TextLabel",F)Link.Size=UDim2.new(1,-50,0,28)Link.Position=UDim2.new(0,25,0.5,4)Link.BackgroundTransparency=1 Link.Text=YT_LINKLink.TextColor3=Color3.fromRGB(255,255,255)Link.Font=Enum.Font.GothamMedium Link.TextSize=13 Link.TextXAlignment=Enum.TextXAlignment.Center Link.ZIndex=501 Link.TextTransparency=1
TS:Create(Link,TweenInfo.new(0.6,Enum.EasingStyle.Quint,Enum.EasingDirection.Out,0.45),{TextTransparency=0}):Play()
local Copy=Instance.new("TextButton",F)
Copy.Size=UDim2.new(0,180,0,42)
Copy.Position=UDim2.new(0.5,-90,0.5,45)
Copy.BackgroundColor3=Color3.fromRGB(48,22,65)
Copy.BorderSizePixel=0
Copy.Text="📋 COPIAR LINK"
Copy.TextColor3=Color3.fromRGB(255,255,255)
Copy.Font=Enum.Font.GothamBold
Copy.TextSize=13
Copy.ZIndex=501
Instance.new("UICorner",Copy).CornerRadius=UDim.new(0,10)
styleBtn(Copy,Color3.fromRGB(48,22,65),Color3.fromRGB(255,45,75))
Copy.MouseButton1Click:Connect(function()if setclipboard then setclipboard(YT_LINK)Copy.Text="✅ LINK COPIADO!"task.delay(1.4,function()if Copy.Parent then Copy.Text="📋 COPIAR LINK"end end)end end)
local BarBg=Instance.new("Frame",F)
BarBg.Size=UDim2.new(0,260,0,5)
BarBg.Position=UDim2.new(0.5,-130,0.5,102)
BarBg.BackgroundColor3=Color3.fromRGB(40,35,50)
BarBg.BorderSizePixel=0
BarBg.ZIndex=501
Instance.new("UICorner",BarBg).CornerRadius=UDim.new(1,0)
local Bar=Instance.new("Frame",BarBg)
Bar.Size=UDim2.new(0,0,1,0)
Bar.BackgroundColor3=Color3.fromRGB(198,70,255)
Bar.BorderSizePixel=0
Bar.ZIndex=502
Instance.new("UICorner",Bar).CornerRadius=UDim.new(1,0)
TS:Create(Bar,TweenInfo.new(4.2,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(1,0,1,0)}):Play()
task.delay(4.45,function()
if not F.Parent then return end
local out=TS:Create(F,TweenInfo.new(0.7,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{BackgroundTransparency=1})
for _,v in ipairs(F:GetDescendants())do if v:IsA("TextLabel")or v:IsA("TextButton")then TS:Create(v,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{TextTransparency=1,BackgroundTransparency=1}):Play()elseif v:IsA("UIStroke")then TS:Create(v,TweenInfo.new(0.5),{Transparency=1}):Play()end end
out:Play()out.Completed:Connect(function()F:Destroy()end)
end)
end

local function showPlayerEvent(p,isJoin)
if not p then return end
local cards={}
for _,v in ipairs(SG:GetChildren())do if v.Name=="VortexPlayerEvent"then table.insert(cards,v)end end
for i,v in ipairs(cards)do TS:Create(v,TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-325,0,90+(i-1)*96)}):Play()end
local F=Instance.new("Frame",SG)
F.Name="VortexPlayerEvent"
F.Size=UDim2.new(0,310,0,84)
F.Position=UDim2.new(1,20,0,90+(#cards)*96)
F.BackgroundColor3=Color3.fromRGB(20,18,25)
F.BorderSizePixel=0
F.ZIndex=350
Instance.new("UICorner",F).CornerRadius=UDim.new(0,12)
local accent=isJoin and Color3.fromRGB(45,255,155)or Color3.fromRGB(255,70,90)
local stroke=Instance.new("UIStroke",F)stroke.Color=accent stroke.Thickness=1.6 stroke.Transparency=0.15
table.insert(TE.Accs,stroke)
local gd=Instance.new("UIGradient",F)
gd.Rotation=25
gd.Color=ColorSequence.new(Color3.fromRGB(28,24,36),Color3.fromRGB(16,15,21))
local bar=Instance.new("Frame",F)
bar.Size=UDim2.new(0,4,1,0)
bar.BackgroundColor3=accent
bar.BorderSizePixel=0
bar.ZIndex=351
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,12)
local avatar=Instance.new("ImageLabel",F)
avatar.Size=UDim2.new(0,54,0,54)
avatar.Position=UDim2.new(0,14,0.5,-27)
avatar.BackgroundColor3=Color3.fromRGB(30,28,38)
avatar.BackgroundTransparency=0
avatar.BorderSizePixel=0
avatar.ZIndex=351
Instance.new("UICorner",avatar).CornerRadius=UDim.new(1,0)
local ast=Instance.new("UIStroke",avatar)
ast.Color=accent
ast.Thickness=2
ast.Transparency=0.2
task.spawn(function()local ok,img=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)if ok and img and avatar.Parent then avatar.Image=img end end)
local state=Instance.new("TextLabel",F)
state.Size=UDim2.new(0,105,0,20)
state.Position=UDim2.new(0,78,0,9)
state.BackgroundTransparency=1
state.Text=isJoin and"🟢 ENTROU NO SERVIDOR"or"🔴 SAIU DO SERVIDOR"
state.TextColor3=accent
state.Font=Enum.Font.GothamBlack
state.TextSize=10
state.TextXAlignment=Enum.TextXAlignment.Left
state.ZIndex=351
local name=Instance.new("TextLabel",F)
name.Size=UDim2.new(1,-92,0,23)
name.Position=UDim2.new(0,78,0,29)
name.BackgroundTransparency=1
name.Text=p.DisplayName.." ("..p.Name..")"
name.TextColor3=Color3.fromRGB(250,250,255)
name.Font=Enum.Font.GothamBold
name.TextSize=13
name.TextTruncate=Enum.TextTruncate.AtEnd
name.TextXAlignment=Enum.TextXAlignment.Left
name.ZIndex=351
local id=Instance.new("TextLabel",F)
id.Size=UDim2.new(1,-92,0,20)
id.Position=UDim2.new(0,78,0,53)
id.BackgroundTransparency=1
id.Text="ID: "..tostring(p.UserId)
id.TextColor3=Color3.fromRGB(175,170,185)
id.Font=Enum.Font.Gotham
id.TextSize=11
id.TextXAlignment=Enum.TextXAlignment.Left
id.ZIndex=351
TS:Create(F,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-325,0,90+(#cards)*96)}):Play()
task.delay(4.5,function()if F.Parent then local tw=TS:Create(F,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,20,0,F.Position.Y.Offset),BackgroundTransparency=1})tw:Play()tw.Completed:Connect(function()if F.Parent then F:Destroy()end end)end end)
end

local OBtn=Instance.new("TextButton",SG)
OBtn.Size,OBtn.Position,OBtn.BackgroundColor3,OBtn.Text,OBtn.TextColor3,OBtn.Font,OBtn.TextSize,OBtn.Visible=UDim2.new(0,50,0,50),UDim2.new(0,20,0,20),Color3.fromRGB(28,20,36),"⚡\nOPEN",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,12,false
Instance.new("UICorner",OBtn).CornerRadius=UDim.new(0,11)
styleBtn(OBtn,Color3.fromRGB(28,20,36),Color3.fromRGB(175,60,255))
table.insert(TE.Bgs,OBtn)

local MF=Instance.new("Frame",SG)
MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,480,0,530),UDim2.new(0.5,-240,0.5,-265),CTh.MBG,true,true
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,10)
local MFs=Instance.new("UIStroke",MF)MFs.Color=CTh.A MFs.Transparency=0.25 MFs.Thickness=1.4 table.insert(TE.Accs,MFs)
table.insert(TE.Bgs,MF)
local MFg=Instance.new("UIGradient",MF)MFg.Rotation=90 MFg.Color=ColorSequence.new(Color3.fromRGB(38,26,50),Color3.fromRGB(23,18,31))

local TB=Instance.new("Frame",MF)
TB.Size,TB.BackgroundColor3=UDim2.new(1,0,0,40),CTh.TB
Instance.new("UICorner",TB).CornerRadius=UDim.new(0,10)
table.insert(TE.TBs,TB)
local PIco=Instance.new("ImageLabel",TB)PIco.Size,PIco.Position,PIco.BackgroundColor3,PIco.BorderSizePixel,PIco.ClipsDescendants=UDim2.new(0,26,0,26),UDim2.new(0,10,0.5,-13),Color3.fromRGB(50,50,50),0,true
Instance.new("UICorner",PIco).CornerRadius=UDim.new(1,0)
local pIS=Instance.new("UIStroke",PIco)pIS.Color=CTh.A pIS.Thickness=1.5 table.insert(TE.Accs,pIS)
task.spawn(function()pcall(function()PIco.Image=P:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)end)
local Ttl=Instance.new("TextLabel",TB)Ttl.Size,Ttl.Position,Ttl.Text,Ttl.TextColor3,Ttl.Font,Ttl.TextSize,Ttl.BackgroundTransparency,Ttl.TextXAlignment=UDim2.new(1,-80,1,0),UDim2.new(0,45,0,0),"⚡ Vortex Hub V18 - Supreme",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,14,1,Enum.TextXAlignment.Left
local CBn=Instance.new("TextButton",TB)CBn.Size,CBn.Position,CBn.BackgroundTransparency,CBn.Text,CBn.TextColor3,CBn.Font,CBn.TextSize=UDim2.new(0,40,0,40),UDim2.new(1,-40,0,0),1,"X",Color3.fromRGB(220,210,230),Enum.Font.GothamBold,16
local cbs=Instance.new("UIStroke",CBn)cbs.Color=CTh.A cbs.Transparency=0.6 cbs.Thickness=1 table.insert(TE.Accs,cbs)
CBn.MouseButton1Click:Connect(function()MF.Visible=false OBtn.Visible=true end)
OBtn.MouseButton1Click:Connect(function()MF.Visible=true OBtn.Visible=false end)

local TC=Instance.new("Frame",MF)TC.Size,TC.Position,TC.BackgroundTransparency=UDim2.new(1,0,0,30),UDim2.new(0,0,0,40),1
local function cTB(n,px,w)
local B=Instance.new("TextButton",TC)B.Size,B.Position,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(w or 0.166,0,1,0),UDim2.new(px,0,0,0),Color3.fromRGB(30,26,34),n,Color3.fromRGB(175,165,190),Enum.Font.GothamBold,10
styleBtn(B,Color3.fromRGB(30,26,34),CTh.A)
return B
end
local tMB,tEB,tPB,tPrB,tThB,tVB=cTB("🔧 Princ.",0,0.166),cTB("👁️ ESPS",0.166,0.166),cTB("👤 Player",0.332,0.166),cTB("🛡️ Prot.",0.498,0.166),cTB("🎨 Temas",0.664,0.166),cTB("👀 Viewer",0.830,0.170)
tMB.BackgroundColor3=Color3.fromRGB(45,33,55)tMB.TextColor3=Color3.fromRGB(255,255,255)
local function cScr(n,cY)
local S=Instance.new("ScrollingFrame",MF)S.Name=n S.Size,S.Position,S.BackgroundTransparency,S.ScrollBarThickness,S.CanvasSize,S.Visible=UDim2.new(1,-20,1,-80),UDim2.new(0,10,0,75),1,4,UDim2.new(0,0,0,cY),false
local L=Instance.new("UIListLayout",S)L.Padding,L.HorizontalAlignment,L.SortOrder=UDim.new(0,10),Enum.HorizontalAlignment.Center,Enum.SortOrder.LayoutOrder
return S
end
local sM,sE,sP,sPr,sTh,sV=cScr("SM",950),cScr("SE",850),cScr("SP",720),cScr("SPr",460),cScr("STh",650),cScr("SV",850)sM.Visible=true
local function sTab(aB,aS)
local t={{tMB,sM},{tEB,sE},{tPB,sP},{tPrB,sPr},{tThB,sTh},{tVB,sV}}
for _,d in pairs(t)do local b,s=d[1],d[2]if b==aB then b.BackgroundColor3=Color3.fromRGB(45,33,55)b.TextColor3=Color3.fromRGB(255,255,255)s.Visible=true else b.BackgroundColor3=Color3.fromRGB(30,26,34)b.TextColor3=Color3.fromRGB(150,145,160)s.Visible=false end end
end
tMB.MouseButton1Click:Connect(function()sTab(tMB,sM)end)tEB.MouseButton1Click:Connect(function()sTab(tEB,sE)end)tPB.MouseButton1Click:Connect(function()sTab(tPB,sP)end)tPrB.MouseButton1Click:Connect(function()sTab(tPrB,sPr)end)tThB.MouseButton1Click:Connect(function()sTab(tThB,sTh)end)tVB.MouseButton1Click:Connect(function()sTab(tVB,sV)end)
local function cST(n,p)local T=Instance.new("TextLabel",p)T.Size,T.BackgroundTransparency,T.Text,T.TextColor3,T.Font,T.TextSize,T.TextXAlignment=UDim2.new(1,0,0,25),1,n,CTh.A,Enum.Font.GothamBlack,13,Enum.TextXAlignment.Left table.insert(TE.Txs,T)end

local function cTog(n,p,iS,cb,ck)
local F=Instance.new("Frame",p)
F.Size,F.BackgroundColor3=UDim2.new(1,0,0,46),Color3.fromRGB(44,40,48)
Instance.new("UICorner",F).CornerRadius=UDim.new(0,9)
local fS=Instance.new("UIStroke",F)
fS.Color=iS and CTh.A or Color3.fromRGB(72,68,78)
fS.Thickness=1.2
fS.Transparency=0.25
table.insert(TE.Accs,fS)
local g=Instance.new("UIGradient",F)g.Rotation=90 g.Color=ColorSequence.new(Color3.fromRGB(50,45,55),Color3.fromRGB(36,33,42))
local Lb=Instance.new("TextLabel",F)Lb.Size,Lb.Position,Lb.Text,Lb.TextColor3,Lb.Font,Lb.TextSize,Lb.BackgroundTransparency,Lb.TextXAlignment=UDim2.new(0.7,0,1,0),UDim2.new(0.05,0,0,0),n,Color3.fromRGB(250,248,255),Enum.Font.GothamMedium,13,1,Enum.TextXAlignment.Left
local SB=Instance.new("Frame",F)
SB.Size,SB.Position,SB.BackgroundColor3=UDim2.new(0,46,0,24),UDim2.new(1,-60,0.5,-12),iS and CTh.A or Color3.fromRGB(67,63,73)
Instance.new("UICorner",SB).CornerRadius=UDim.new(1,0)
local ss=Instance.new("UIStroke",SB)
ss.Color=iS and Color3.fromRGB(255,255,255)or Color3.fromRGB(120,115,125)
ss.Thickness=1
ss.Transparency=0.6
table.insert(TE.Accs,ss)
local SK=Instance.new("Frame",SB)SK.Size,SK.Position,SK.BackgroundColor3=UDim2.new(0,18,0,18),iS and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9),Color3.fromRGB(255,255,255)Instance.new("UICorner",SK).CornerRadius=UDim.new(1,0)
local st=iS TE.Tgls[SB]=function()return st end
local function sVS(ns)
st=ns
TS:Create(SB,TweenInfo.new(0.18,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundColor3=st and CTh.A or Color3.fromRGB(67,63,73)}):Play()
TS:Create(SK,TweenInfo.new(0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=st and UDim2.new(1,-20,0.5,-9)or UDim2.new(0,2,0.5,-9)}):Play()
TS:Create(fS,TweenInfo.new(0.18),{Color=st and CTh.A or Color3.fromRGB(72,68,78),Transparency=st and 0 or 0.25}):Play()
if ck then HC[ck]=st saveC()end
end
local B=Instance.new("TextButton",F)B.Size,B.BackgroundTransparency,B.Text=UDim2.new(1,0,1,0),1,""B.AutoButtonColor=false
B.MouseButton1Click:Connect(function()sVS(not st)cb(st)end)
if ck then IC[ck]=function()if st then cb(true)end end end
return sVS
end

P.PlayerAdded:Connect(function(p)showPlayerEvent(p,true)end)
P.PlayerRemoving:Connect(function(p)showPlayerEvent(p,false)end)

local function cSli(n,rT,mV,mxV,cV,p,cb,ck)
local SF=Instance.new("Frame",p)SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,65),Color3.fromRGB(42,38,47)Instance.new("UICorner",SF).CornerRadius=UDim.new(0,9)local ss=Instance.new("UIStroke",SF)ss.Color=Color3.fromRGB(74,67,84)ss.Thickness=1 table.insert(TE.Accs,ss)
local TL=Instance.new("TextLabel",SF)TL.Size,TL.Position,TL.Text,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(1,-20,0,20),UDim2.new(0,12,0,6),n.." [ "..tostring(cV).." ]",Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left
local RL=Instance.new("TextLabel",SF)RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,24),"Recomendado: "..rT,Color3.fromRGB(165,158,175),Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left
local Tk=Instance.new("Frame",SF)Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,46),Color3.fromRGB(25,23,29)Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)local pI=math.clamp((cV-mV)/(mxV-mV),0,1)local F=Instance.new("Frame",Tk)F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),CTh.A Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)table.insert(TE.Accs,F)local K=Instance.new("Frame",Tk)K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)local KS=Instance.new("UIStroke",K)KS.Color,KS.Thickness=CTh.A,2 table.insert(TE.Accs,KS)
local HB=Instance.new("TextButton",SF)HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""HB.AutoButtonColor=false local d=false
local function upd(ip)local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)local pc=pX/Tk.AbsoluteSize.X local vl=math.floor(mV+(mxV-mV)*pc)F.Size=UDim2.new(pc,0,1,0)K.Position=UDim2.new(pc,0,0.5,0)TL.Text=n.." [ "..tostring(vl).." ]"if ck then HC[ck]=vl saveC()end cb(vl)end
HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)
UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)
UIS.InputChanged:Connect(function(ip)if d and ip.UserInputType==Enum.UserInputType.MouseMovement then upd(ip)end end)
UIS.TouchMoved:Connect(function(ip)if d then upd(ip)end end)
if ck then IC[ck]=function()cb(cV)end end
end

local function cTSli(mV,mxV,cV,p,cb)
local SF=Instance.new("Frame",p)SF.Size,SF.BackgroundColor3=UDim2.new(1,0,0,65),Color3.fromRGB(42,38,47)Instance.new("UICorner",SF).CornerRadius=UDim.new(0,9)local ss=Instance.new("UIStroke",SF)ss.Color=Color3.fromRGB(74,67,84)ss.Thickness=1 table.insert(TE.Accs,ss)
local TL=Instance.new("TextLabel",SF)TL.Size,TL.Position,TL.TextColor3,TL.Font,TL.TextSize,TL.BackgroundTransparency,TL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0,12,0,6),Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Left
local TiL=Instance.new("TextLabel",SF)TiL.Size,TiL.Position,TiL.TextColor3,TiL.Font,TiL.TextSize,TiL.BackgroundTransparency,TiL.TextXAlignment=UDim2.new(0.5,-12,0,20),UDim2.new(0.5,0,0,6),CTh.A,Enum.Font.GothamBold,13,1,Enum.TextXAlignment.Right table.insert(TE.Txs,TiL)
local RL=Instance.new("TextLabel",SF)RL.Size,RL.Position,RL.Text,RL.TextColor3,RL.Font,RL.TextSize,RL.BackgroundTransparency,RL.TextXAlignment=UDim2.new(1,-20,0,14),UDim2.new(0,12,0,24),"Arraste para ajustar",Color3.fromRGB(160,155,170),Enum.Font.Gotham,11,1,Enum.TextXAlignment.Left
local Tk=Instance.new("Frame",SF)Tk.Size,Tk.Position,Tk.BackgroundColor3=UDim2.new(1,-24,0,8),UDim2.new(0,12,0,46),Color3.fromRGB(25,23,29)Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)local pI=math.clamp((cV-mV)/(mxV-mV),0,1)local F=Instance.new("Frame",Tk)F.Size,F.BackgroundColor3=UDim2.new(pI,0,1,0),CTh.A Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)table.insert(TE.Accs,F)local K=Instance.new("Frame",Tk)K.Size,K.AnchorPoint,K.Position,K.BackgroundColor3=UDim2.new(0,18,0,18),Vector2.new(0.5,0.5),UDim2.new(pI,0,0.5,0),Color3.fromRGB(255,255,255)Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)local KS=Instance.new("UIStroke",K)KS.Color,KS.Thickness=CTh.A,2 table.insert(TE.Accs,KS)
local function fUI(v)local h,m=math.floor(v),math.floor((v-math.floor(v))*60)local pt="Noite 🌙"if h>=6 and h<13 then pt="Dia ☀️"elseif h>=13 and h<18 then pt="Tarde 🌤️"end TL.Text="Período: "..pt TiL.Text=string.format("%02d:%02d",h,m)end
fUI(cV)
local HB=Instance.new("TextButton",SF)HB.Size,HB.BackgroundTransparency,HB.Text=UDim2.new(1,0,1,0),1,""HB.AutoButtonColor=false local d=false
local function upd(ip)local pX=math.clamp(ip.Position.X-Tk.AbsolutePosition.X,0,Tk.AbsoluteSize.X)local pc=(Tk.AbsoluteSize.X>0)and pX/Tk.AbsoluteSize.X or 0 local vl=mV+(mxV-mV)*pc F.Size=UDim2.new(pc,0,1,0)K.Position=UDim2.new(pc,0,0.5,0)fUI(vl)cb(vl)end
HB.InputBegan:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=true upd(ip)end end)
UIS.InputEnded:Connect(function(ip)if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then d=false end end)
UIS.InputChanged:Connect(function(ip)if d and ip.UserInputType==Enum.UserInputType.MouseMovement then upd(ip)end end)
UIS.TouchMoved:Connect(function(ip)if d then upd(ip)end end)
return function(nV,ig)if d and ig then return end local pc=math.clamp((nV-mV)/(mxV-mV),0,1)F.Size=UDim2.new(pc,0,1,0)K.Position=UDim2.new(pc,0,0.5,0)fUI(nV)end
end

local function cEGui(tM)
local r,h=tM:FindFirstChild("HumanoidRootPart"),tM:FindFirstChildOfClass("Humanoid")if not r or not h then return nil end
local bg=Instance.new("BillboardGui")bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="ESPGui",r,UDim2.new(0,400,0,45),Vector3.new(0,3.5,0),true,SG
local el=Instance.new("TextLabel",bg)el.Size,el.BackgroundTransparency,el.RichText,el.TextStrokeTransparency,el.Font,el.TextSize,el.TextYAlignment=UDim2.new(1,0,1,0),1,true,0.5,Enum.Font.GothamBold,13,Enum.TextYAlignment.Center
return{Gui=bg,Humanoid=h,Root=r,Label=el,Model=tM}
end
local function cETb(tb)for _,d in pairs(tb)do if d.Gui then d.Gui:Destroy()end end table.clear(tb)end
local function uESP()
if eUp then eUp:Disconnect()end if not enOn and not epOn then return end
eUp=RS.RenderStepped:Connect(function()
local lC=LP.Character local lR=lC and lC:FindFirstChild("HumanoidRootPart")
if epOn then
for _,p in pairs(P:GetPlayers())do if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")and p.Character:FindFirstChild("Humanoid")then if isFriend(p)then continue end if not tPly[p]or tPly[p].Model~=p.Character then if tPly[p]and tPly[p].Gui then tPly[p].Gui:Destroy()end tPly[p]=cEGui(p.Character)end end end
for p,d in pairs(tPly)do if not p or not p.Parent or not p.Character or not d.Humanoid or d.Humanoid.Health<=0 or d.Model~=p.Character or isFriend(p)then if d.Gui then d.Gui:Destroy()end tPly[p]=nil continue end local hS,dS=math.floor(d.Humanoid.Health),lR and d.Root and tostring(math.floor((lR.Position-d.Root.Position).Magnitude))or"???"d.Label.Text=string.format('<b><font color="%s">%s</font> | <font color="%s">HP: %s</font> | <font color="%s">%s studs</font></b>',ECol.PName,p.Name,ECol.PHP,hS,ECol.PDist,dS)end
end
if enOn then
for m in pairs(CNPCs)do if m.Parent and not tNPC[m]then tNPC[m]=cEGui(m)end end
for m,d in pairs(tNPC)do if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then if d.Gui then d.Gui:Destroy()end tNPC[m]=nil continue end local dist=lR and d.Root and(lR.Position-d.Root.Position).Magnitude or 9999 if dist>2500 then d.Gui.Enabled=false else d.Gui.Enabled=true d.Label.Text=string.format('<b><font color="%s">NAME: %s</font><br /><font color="%s">HP: %s</font><br /><font color="%s">Dist: %s</font></b>',ECol.NName,m.Name,ECol.NHP,math.floor(d.Humanoid.Health),ECol.NDist,math.floor(dist))end end
end
end)
end

local function iHN(n)if not n:FindFirstChild("Humanoid")or P:GetPlayerFromCharacter(n)or n.Humanoid.Health<=0 then return false end for _,c in ipairs(n:GetChildren())do if c:IsA("Tool")then return true end end local nm,h=string.lower(n.Name),{"zombie","enemy","boss","killer","monster","soldier","mutant","dummy","bot","hostile","demon","beast","guard","slayer","vampire","werewolf","criminal","thief","attacker","infect","scp","entity","nextbot"}for _,v in ipairs(h)do if string.find(nm,v)then return true end end if n.Humanoid.MaxHealth>105 and n.Humanoid.MaxHealth<math.huge then return true end for _,d in ipairs(n:GetDescendants())do if d:IsA("Script")or d:IsA("LocalScript")then local s=string.lower(d.Name)if string.find(s,"damage")or string.find(s,"kill")or string.find(s,"attack")then return true end end end return false end
local function cDEsp(m)local r=m:FindFirstChild("HumanoidRootPart")if not r then return end local bg=Instance.new("BillboardGui")bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="DangerESP",r,UDim2.new(0,40,0,40),Vector3.new(0,6,0),true,SG local ic=Instance.new("TextLabel",bg)ic.Size,ic.BackgroundTransparency,ic.Text,ic.TextSize=UDim2.new(1,0,1,0),1,"⚠️",16 task.spawn(function()while bg.Parent do TS:Create(ic,TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{TextSize=22}):Play()break end end)return{Gui=bg,Model=m,Humanoid=m:FindFirstChild("Humanoid")}end
local function uDEsp()if dUp then dUp:Disconnect()dUp=nil end if not dEspOn then return end dUp=RS.Heartbeat:Connect(function()for m in pairs(CNPCs)do if m.Parent and not tDNPC[m]and iHN(m)then tDNPC[m]=cDEsp(m)end end for m,d in pairs(tDNPC)do if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then if d.Gui then d.Gui:Destroy()end tDNPC[m]=nil end end end)end

local function rLig()
restoreLights()
L.FogStart,L.FogEnd,L.FogColor,L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale=OL.FS,OL.FE,OL.FC,OL.A,OL.OA,OL.B,OL.GS,OL.EDS,OL.ESS
pcall(function()L.ShadowSoftness,L.Technology,L.ExposureCompensation=OL.SS,OL.T,OL.EC end)
if L:FindFirstChild("VortexAtmosphere")then L.VortexAtmosphere:Destroy()end
end

local function uLig()
if fpsOn then
if sLp then sLp:Disconnect()sLp=nil end
restoreLights()
L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale,L.GlobalShadows=0,0,false
clrCE()rLig()
elseif shOn then
L.GlobalShadows=true
pcall(function()L.Technology,L.ShadowSoftness,L.ExposureCompensation=Enum.Technology.Future,0.06,0.32 end)
L.Brightness=math.max(OL.B,2.1)
L.EnvironmentSpecularScale,L.EnvironmentDiffuseScale=1.45,1.45
if not L:FindFirstChild("VortexCC")then local CC=Instance.new("ColorCorrectionEffect",L)CC.Name="VortexCC"local B=Instance.new("BloomEffect",L)B.Name="VortexBloom"local S=Instance.new("SunRaysEffect",L)S.Name="VortexSunRays"local A=Instance.new("Atmosphere",L)A.Name="VortexAtmosphere"end
local CC=L:FindFirstChild("VortexCC")if CC then CC.Contrast=0.25 CC.Saturation=0.45 CC.Brightness=0.035 CC.TintColor=Color3.fromRGB(255,248,255)end
local B=L:FindFirstChild("VortexBloom")if B then B.Intensity=0.32 B.Size=26 B.Threshold=0.85 end
local S=L:FindFirstChild("VortexSunRays")if S then S.Intensity=0.1 S.Spread=0.8 end
local A=L:FindFirstChild("VortexAtmosphere")if A then A.Density=0.025 A.Offset=0.2 A.Glare=0.85 A.Haze=0.65 A.Color=Color3.fromRGB(205,215,255)A.Decay=Color3.fromRGB(120,90,180)end
boostLights()
local wB=L:FindFirstChild("VortexWallBlur")if not wB then wB=Instance.new("BlurEffect",L)wB.Name,wB.Size="VortexWallBlur",0 end
if not sLp then
local rP=RaycastParams.new()rP.FilterType=Enum.RaycastFilterType.Exclude
sLp=RS.RenderStepped:Connect(function()
if pDead or fbOn then return end
local t,n,c,cam=L.ClockTime,false,W.CurrentCamera
if t>=18.2 or t<=6.2 then n=true end
local tB,i=0,false
if c and cam then rP.FilterDescendantsInstances={c,cam}local hrp=c:FindFirstChild("HumanoidRootPart")if hrp then i=cInd(hrp,rP)end local dB=gPB(cam,c)if dB>tB then tB=dB end end
local a,oa,fs,fe,fc,ad,ac
if i then a,oa=Color3.fromRGB(65,62,78),Color3.fromRGB(55,52,68)local cr=Color3.fromRGB(205,210,225)if fgOn then fs,fe,fc,ad,ac=150,1200,cr,0.13,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end
elseif n then a,oa=Color3.fromRGB(30,34,58),Color3.fromRGB(24,28,45)local cr=Color3.fromRGB(45,55,90)if fgOn then fs,fe,fc,ad,ac=120,2500,cr,0.22,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end
else a,oa=Color3.fromRGB(118,118,128),Color3.fromRGB(150,145,160)local cr=Color3.fromRGB(215,230,250)if fgOn then fs,fe,fc,ad,ac=200,4000,cr,0.12,cr else fs,fe,fc,ad,ac=2000,100000,cr,0,cr end end
L.Ambient,L.OutdoorAmbient,L.FogStart,L.FogEnd,L.FogColor=L.Ambient:Lerp(a,0.08),L.OutdoorAmbient:Lerp(oa,0.08),L.FogStart+(fs-L.FogStart)*0.08,L.FogEnd+(fe-L.FogEnd)*0.08,L.FogColor:Lerp(fc,0.08)
local atm=L:FindFirstChild("VortexAtmosphere")if atm then atm.Density=atm.Density+(ad-atm.Density)*0.08 atm.Color=atm.Color:Lerp(ac,0.08)end
local cb=L:FindFirstChild("VortexWallBlur")if cb then cb.Size=tB>cb.Size and tB or cb.Size+(tB-cb.Size)*0.2 end
end)
end
else
if sLp then sLp:Disconnect()sLp=nil end
clrCE()rLig()if fgOn then L.FogStart,L.FogEnd,L.FogColor=100,2000,Color3.fromRGB(200,215,230)end
end
end

local function eAF()
if afc then afc:Disconnect()end
afc=RS.Stepped:Connect(function()
if not afOn then return end
local c=LP.Character if not c then return end
for _,p in pairs(c:GetChildren())do if p:IsA("BasePart")then if p.Velocity.Magnitude>1000 then p.Velocity=Vector3.new()end if p.RotVelocity.Magnitude>1000 then p.RotVelocity=Vector3.new()end end end
for _,op in pairs(P:GetPlayers())do if op~=LP and op.Character then if isFriend(op)then continue end for _,oprt in pairs(op.Character:GetChildren())do if oprt:IsA("BasePart")then oprt.CanCollide=false if oprt.Velocity.Magnitude>100 then oprt.Velocity=Vector3.new()end if oprt.RotVelocity.Magnitude>100 then oprt.RotVelocity=Vector3.new()end end end end end
end)
end

cST("✨ GRÁFICOS",sM)
local stU,ftU
stU=cTog("✨ Shaders",sM,shOn,function(s)shOn=s uLig()end,"Shaders")
ftU=cTog("🥔 Booster FPS",sM,fpsOn,function(s)if s and shOn then sNotif("Erro","Desative Shaders primeiro.","Error")fpsOn=false if ftU then ftU(false)end return end fpsOn=s uLig()end,"FpsBoost")
cTog("🌫️ Desfoque Parede",sM,wbOn,function(s)wbOn=s if not s then local b=L:FindFirstChild("VortexWallBlur")if b then b.Size=0 end end end,"WallBlur")
cTog("🌫️ Neblina",sM,fgOn,function(s)fgOn=s uLig()end,"Fog")
cTog("🌀 Motion Blur",sM,mbOn,function(s)if s then local b=Instance.new("BlurEffect",L)b.Name,b.Size="VortexMotionBlur",0 local c=W.CurrentCamera if c then lCR=c.CFrame-c.CFrame.Position end mbc=RS.RenderStepped:Connect(function()local cam=W.CurrentCamera if not cam then return end local rot=cam.CFrame-cam.CFrame.Position local d=rot.LookVector:Dot(lCR.LookVector)local a=math.acos(math.clamp(d,-1,1))local tB=math.clamp(math.deg(a)*1.5,0,30)b.Size,lCR=b.Size+(tB-b.Size)*0.2,rot end)else if mbc then mbc:Disconnect()mbc=nil end local b=L:FindFirstChild("VortexMotionBlur")if b then b:Destroy()end end end,"MotionBlur")
cTog("☀️ Fullbright",sM,fbOn,function(s)fbOn=s if s then fbLp=RS.RenderStepped:Connect(function()L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.FogEnd=Color3.new(1,1,1),Color3.new(1,1,1),2,false,100000 end)else if fbLp then fbLp:Disconnect()fbLp=nil end uLig()end end,"Fullbright")
cTog("🔦 Luz Player",sM,plOn,function(s)plOn=s if s then plc=RS.Heartbeat:Connect(function()local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local h=c.HumanoidRootPart if not h:FindFirstChild("VortexPlayerLight")then local l=Instance.new("PointLight",h)l.Name,l.Brightness,l.Range,l.Shadows,l.Color="VortexPlayerLight",3,60,false,Color3.new(1,1,1)end end end)else if plc then plc:Disconnect()plc=nil end local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then local l=c.HumanoidRootPart:FindFirstChild("VortexPlayerLight")if l then l:Destroy()end end end end,"PlayerLight")

cST("⏰ TEMPO",sM)
local uTSUI
cTog("🔄 Auto Tempo",sM,atOn,function(s)atOn=s if s then atc=RS.RenderStepped:Connect(function(dt)L.ClockTime=(L.ClockTime+(0.4*dt))%24 if uTSUI then uTSUI(L.ClockTime,true)end end)else if atc then atc:Disconnect()atc=nil end end end,"AutoTime")
uTSUI=cTSli(0,24,L.ClockTime,sM,function(v)if not atOn then L.ClockTime=v end end)
local rainLoop=nil local rPrt=nil local rEmt=nil
local function stpR()if rEmt then rEmt.Enabled=false end end
local function stRt()if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart")then return end if not rPrt then rPrt=Instance.new("Part")rPrt.Name="VtxRain"rPrt.Anchored=true rPrt.CanCollide=false rPrt.Transparency=1 rPrt.Size=Vector3.new(150,1,150)rPrt.Parent=W rEmt=Instance.new("ParticleEmitter",rPrt)rEmt.Texture="rbxassetid://2273224484"rEmt.Rate=600 rEmt.Speed=NumberRange.new(60,80)rEmt.Lifetime=NumberRange.new(1.5,2.5)rEmt.EmissionDirection=Enum.NormalId.Bottom rEmt.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0.3),NumberSequenceKeypoint.new(1,0.3)})rEmt.Color=ColorSequence.new(Color3.fromRGB(150,170,200))rEmt.Transparency=NumberSequence.new(0.5)end task.spawn(function()rEmt.Enabled=true local d=math.random(10,20)local sT=tick()while rrOn and(tick()-sT<d)and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")do rPrt.CFrame=LP.Character.HumanoidRootPart.CFrame*CFrame.new(0,50,0)task.wait(0.1)end stpR()end)end
cTog("🌧️ Chuva Aleatória (15% Chance)",sM,rrOn,function(s)rrOn=s if s then rainLoop=task.spawn(function()while rrOn do task.wait(5)if math.random(1,100)<=15 then stRt()task.wait(25)end end end)else if rainLoop then task.cancel(rainLoop)rainLoop=nil end stpR()end end,"RandomRain")

cST("👁️ ESP",sE)
cTog("👤 ESP Player",sE,epOn,function(s)epOn=s if not s then cETb(tPly)end uESP()end,"ESPPlayer")
cTog("🤖 ESP NPC",sE,enOn,function(s)enOn=s if not s then cETb(tNPC)end uESP()end,"ESPNPC")
cTog("⚠️ Alerta NPC Hostil",sE,dEspOn,function(s)dEspOn=s if not s then cETb(tDNPC)end uDEsp()end,"DangerESP")
cST("🎨 CORES",sE)
local function cECBtn(n,c3,hc)local b=Instance.new("TextButton",sE)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,34),Color3.fromRGB(45,39,50),"🎨 "..n,c3,Enum.Font.GothamBold,12 Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)styleBtn(b,Color3.fromRGB(45,39,50),c3)b.MouseButton1Click:Connect(function()ECol.PName,ECol.NName=hc,hc end)end
cECBtn("Branco",Color3.fromRGB(255,255,255),"#FFFFFF")cECBtn("Amarelo",Color3.fromRGB(255,215,0),"#FFD700")cECBtn("Roxo",Color3.fromRGB(176,38,255),"#B026FF")cECBtn("Verde",Color3.fromRGB(50,205,50),"#32CD32")cECBtn("Rosa",Color3.fromRGB(255,20,147),"#FF1493")

cST("👤 MODS",sP)
cTog("🌀 TeleportTool",sP,ttOn,function(s)ttOn=s if s then gTT()else rTT()end end,"TeleportTool")
cTog("⚡ Instant Interact",sP,iiOn,function(s)iiOn=s if s then for _,p in pairs(W:GetDescendants())do if p:IsA("ProximityPrompt")then p.HoldDuration=0 end end iic=PPS.PromptShown:Connect(function(p)p.HoldDuration=0 end)else if iic then iic:Disconnect()iic=nil end end end,"InstantInteract")
cTog("⚡ Mods Player",sP,pmOn,function(s)pmOn=s if s then pmc=RS.Stepped:Connect(function()if W.CurrentCamera then W.CurrentCamera.FieldOfView=pFov end local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h.UseJumpPower=true if h.WalkSpeed~=pSpd then h.WalkSpeed=pSpd end if h.JumpPower~=pJmp then h.JumpPower=pJmp end end end end)else if pmc then pmc:Disconnect()pmc=nil end local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed,c.Humanoid.JumpPower=16,50 end if W.CurrentCamera then W.CurrentCamera.FieldOfView=70 end end end,"PlayerMods")
cTog("⚡ No Cooldown (Instantâneo)",sP,ncOn,function(s)ncOn=s if s then ncc=RS.Stepped:Connect(function()local c=LP.Character if c then for _,t in ipairs(c:GetChildren())do if t:IsA("Tool")then t.Enabled=true pcall(function()if t.Cooldown then t.Cooldown=0 end for _,v in ipairs(t:GetDescendants())do if v:IsA("NumberValue")or v:IsA("IntValue")then local ln=string.lower(v.Name)if string.find(ln,"cooldown")or string.find(ln,"cd")or string.find(ln,"time")or string.find(ln,"delay")then v.Value=0 end end end end)end end end if LP:FindFirstChild("Backpack")then for _,t in ipairs(LP.Backpack:GetChildren())do if t:IsA("Tool")then t.Enabled=true pcall(function()if t.Cooldown then t.Cooldown=0 end for _,v in ipairs(t:GetDescendants())do if v:IsA("NumberValue")or v:IsA("IntValue")then local ln=string.lower(v.Name)if string.find(ln,"cooldown")or string.find(ln,"cd")or string.find(ln,"time")or string.find(ln,"delay")then v.Value=0 end end end end)end end end end)else if ncc then ncc:Disconnect()ncc=nil end end end,"NoCooldown")
cTog("🚀 Inf Jump",sP,ijOn,function(s)ijOn=s if s then ijc=UIS.JumpRequest:Connect(function()local c=LP.Character if c then local h=c:FindFirstChildOfClass("Humanoid")if h then h:ChangeState(Enum.HumanoidStateType.Jumping)end end end)else if ijc then ijc:Disconnect()ijc=nil end end end,"InfJump")
cTog("👻 Noclip",sP,nclOn,function(s)nclOn=s if s then startNcl()else stopNcl()end end,"Noclip")
cSli("🏃 WalkSpeed","16 a 50",16,200,pSpd,sP,function(v)pSpd=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.WalkSpeed=v end end end,"WalkSpeed")
cSli("🦘 JumpPower","50 a 100",50,300,pJmp,sP,function(v)pJmp=v if pmOn then local c=LP.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.JumpPower=v end end end,"JumpPower")
cSli("🔭 FOV","70 a 90",70,120,pFov,sP,function(v)pFov=v end,"FOV")

local izCn,izMenu,izToggle=nil,nil,nil
local izMode="Normal"
local izSavedMaxZoom=nil
local izSavedMinZoom=nil
local izSavedOcclusion=nil
local izActive=false
local IZMax=1000000
local izGuard=false
local function closeIZMenu()if izMenu then izMenu:Destroy()izMenu=nil end end
local function restoreIZ()if izCn then izCn:Disconnect()izCn=nil end if izSavedMaxZoom~=nil then pcall(function()LP.CameraMaxZoomDistance=izSavedMaxZoom end)end if izSavedMinZoom~=nil then pcall(function()LP.CameraMinZoomDistance=izSavedMinZoom end)end if izSavedOcclusion~=nil then pcall(function()LP.DevCameraOcclusionMode=izSavedOcclusion end)end izSavedMaxZoom=nil izSavedMinZoom=nil izSavedOcclusion=nil end
local function disableIZ()izActive=false closeIZMenu()restoreIZ()izMode="Normal"end
local function applyIZ(mode)
if not izActive then izSavedMaxZoom=LP.CameraMaxZoomDistance izSavedMinZoom=LP.CameraMinZoomDistance izSavedOcclusion=LP.DevCameraOcclusionMode end
izMode=mode izActive=true closeIZMenu()
pcall(function()izGuard=true LP.CameraMinZoomDistance=0.5 LP.CameraMaxZoomDistance=IZMax LP.DevCameraOcclusionMode=mode=="Walls"and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom izGuard=false end)
if izCn then izCn:Disconnect()izCn=nil end
local maxCn=LP:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()if not izActive or izGuard then return end if LP.CameraMaxZoomDistance~=IZMax then izGuard=true pcall(function()LP.CameraMaxZoomDistance=IZMax end)izGuard=false end end)
local occlCn=LP:GetPropertyChangedSignal("DevCameraOcclusionMode"):Connect(function()if not izActive or izGuard then return end local wanted=izMode=="Walls"and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom if LP.DevCameraOcclusionMode~=wanted then izGuard=true pcall(function()LP.DevCameraOcclusionMode=wanted end)izGuard=false end end)
local minCn=LP:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()if not izActive or izGuard then return end if LP.CameraMinZoomDistance~=0.5 then izGuard=true pcall(function()LP.CameraMinZoomDistance=0.5 end)izGuard=false end end)
izCn={Disconnect=function()pcall(function()maxCn:Disconnect()end)pcall(function()occlCn:Disconnect()end)pcall(function()minCn:Disconnect()end)end}
sNotif("Infinite Zoom",mode=="Walls"and"Modo Atravessa Paredes ativado."or"Modo Normal ativado.","Success")
end
local function showIZMenu()
closeIZMenu()
local F=Instance.new("Frame",SG)izMenu=F F.Name="InfiniteZoomChoice"F.Size=UDim2.new(0,360,0,240)F.Position=UDim2.new(0.5,-180,0.5,-120)F.BackgroundColor3=Color3.fromRGB(20,16,27)F.BackgroundTransparency=0.04 F.BorderSizePixel=0 F.ZIndex=700 F.Active=true Instance.new("UICorner",F).CornerRadius=UDim.new(0,15)local st=Instance.new("UIStroke",F)st.Color=CTh.A st.Thickness=2 st.Transparency=0.1 local gr=Instance.new("UIGradient",F)gr.Rotation=40 gr.Color=ColorSequence.new(Color3.fromRGB(38,20,52),Color3.fromRGB(15,16,26))
local top=Instance.new("Frame",F)top.Size=UDim2.new(1,-20,0,48)top.Position=UDim2.new(0,10,0,10)top.BackgroundTransparency=1 top.ZIndex=701
local icon=Instance.new("TextLabel",top)icon.Size=UDim2.new(0,38,1,0)icon.BackgroundTransparency=1 icon.Text="🔭"icon.TextSize=25 icon.ZIndex=702
local T=Instance.new("TextLabel",top)
T.Size=UDim2.new(1,-50,0,25)
T.Position=UDim2.new(0,40,0,1)
T.BackgroundTransparency=1
T.Text="INFINITE ZOOM"
T.TextColor3=CTh.A
T.Font=Enum.Font.GothamBlack
T.TextSize=16
T.TextXAlignment=Enum.TextXAlignment.Left
T.ZIndex=702
a=Instance.new("TextLabel",top)a.Size=UDim2.new(1,-50,0,18)a.Position=UDim2.new(0,40,0,24)a.BackgroundTransparency=1 a.Text="Escolha o modo da câmera"a.TextColor3=Color3.fromRGB(180,170,195)a.Font=Enum.Font.GothamMedium a.TextSize=11 a.TextXAlignment=Enum.TextXAlignment.Left a.ZIndex=702
local X=Instance.new("TextButton",F)
X.Size=UDim2.new(0,34,0,34)
X.Position=UDim2.new(1,-44,0,8)
X.BackgroundTransparency=1
X.Text="×"
X.TextColor3=Color3.fromRGB(220,210,230)
X.Font=Enum.Font.GothamBold
X.TextSize=24
X.ZIndex=703
local function optButton(y,title,desc,iconText,mode)
local B=Instance.new("TextButton",F)B.Size=UDim2.new(1,-30,0,62)B.Position=UDim2.new(0,15,0,y)B.BackgroundColor3=Color3.fromRGB(42,36,49)B.BorderSizePixel=0 B.Text=""B.ZIndex=702 Instance.new("UICorner",B).CornerRadius=UDim.new(0,11)styleBtn(B,Color3.fromRGB(42,36,49),CTh.A)
local I=Instance.new("TextLabel",B)I.Size=UDim2.new(0,38,1,0)I.Position=UDim2.new(0,10,0,0)I.BackgroundTransparency=1 I.Text=iconText I.TextSize=21 I.ZIndex=703
local N=Instance.new("TextLabel",B)N.Size=UDim2.new(1,-64,0,22)N.Position=UDim2.new(0,54,0,8)N.BackgroundTransparency=1 N.Text=title N.TextColor3=Color3.fromRGB(255,255,255)N.Font=Enum.Font.GothamBold N.TextSize=13 N.TextXAlignment=Enum.TextXAlignment.Left N.ZIndex=703
local D=Instance.new("TextLabel",B)D.Size=UDim2.new(1,-64,0,20)D.Position=UDim2.new(0,54,0,31)D.BackgroundTransparency=1 D.Text=desc D.TextColor3=Color3.fromRGB(165,158,175)D.Font=Enum.Font.Gotham D.TextSize=10 D.TextXAlignment=Enum.TextXAlignment.Left D.ZIndex=703
B.MouseButton1Click:Connect(function()applyIZ(mode)end)
end
optButton(68,"Normal","Zoom máximo sem alterar a câmera através de paredes.","🔭","Normal")
optButton(138,"Atravessa Paredes","Invisicam mantém o personagem visível mesmo atrás de paredes.","🧱","Walls")
local tip=Instance.new("TextLabel",F)tip.Size=UDim2.new(1,-30,0,24)tip.Position=UDim2.new(0,15,1,-30)tip.BackgroundTransparency=1 tip.Text="O modo continua ativo até você desligar o toggle."tip.TextColor3=CTh.A tip.Font=Enum.Font.GothamMedium tip.TextSize=10 tip.TextXAlignment=Enum.TextXAlignment.Center tip.ZIndex=702
X.MouseButton1Click:Connect(function()if izToggle then izToggle(false)end end)
end
izToggle=cTog("🔭 Infinite Zoom",sP,false,function(s)if s then showIZMenu()else disableIZ()end end,nil)

cST("🛡️ PROTEÇÃO",sPr)
cTog("🛡️ Anti-Fling",sPr,afOn,function(s)afOn=s if s then eAF()else if afc then afc:Disconnect()afc=nil end end end,"AntiFling")
cTog("🌌 Anti-Void",sPr,avOn,function(s)avOn=s if s then local rp=RaycastParams.new()rp.FilterType=Enum.RaycastFilterType.Exclude avc=RS.Heartbeat:Connect(function()if not avOn then return end local c=LP.Character if not c then return end local h,hu=c:FindFirstChild("HumanoidRootPart"),c:FindFirstChildOfClass("Humanoid")if not h or not hu or hu.Health<=0 then return end rp.FilterDescendantsInstances={c}if hu.FloorMaterial~=Enum.Material.Air then lSCf=h.CFrame end local hD,hU=W:Raycast(h.Position,Vector3.new(0,-2500,0),rp),W:Raycast(h.Position,Vector3.new(0,2500,0),rp)if not hD and not hU and h.Position.Y<-50 then h.AssemblyLinearVelocity,h.AssemblyAngularVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)pcall(function()h.Velocity,h.RotVelocity=Vector3.new(0,0,0),Vector3.new(0,0,0)end)local sCF if lSCf and lSCf.Position.Y>-20 then sCF=lSCf+Vector3.new(0,3,0)end if not sCF then local sl=W:FindFirstChildWhichIsA("SpawnLocation",true)if sl then sCF=sl.CFrame+Vector3.new(0,5,0)end end if not sCF then local cr=W:Raycast(Vector3.new(0,500,0),Vector3.new(0,-1000,0),rp)if cr and cr.Position then sCF=CFrame.new(cr.Position+Vector3.new(0,5,0))end end if not sCF then sCF=CFrame.new(0,50,0)end h.CFrame=sCF sNotif("🛡️","Salvo do Void!","Success")end end)else if avc then avc:Disconnect()avc=nil end end end,"AntiVoid")
cTog("🚫 Anti-AFK",sPr,aaOn,function(s)aaOn=s if s then aac=LP.Idled:Connect(function()VU:CaptureController()VU:ClickButton2(Vector2.new())end)else if aac then aac:Disconnect()aac=nil end end end,"AntiAfk")
cTog("🔄 Auto-Rejoin (Anti-Disconnect)",sPr,arOn,function(s)arOn=s if s then arc=game:GetService("GuiService").ErrorMessageChanged:Connect(function()task.wait(1.5)game:GetService("TeleportService"):Teleport(game.PlaceId,LP)end)else if arc then arc:Disconnect()arc=nil end end end,"AutoRejoin")

local function cTBtn(n,mc,tc,ac,tk)
local b=Instance.new("TextButton",sTh)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize=UDim2.new(1,0,0,42),Color3.fromRGB(43,37,48),"🎨 "..n,ac,Enum.Font.GothamBold,14 Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)styleBtn(b,Color3.fromRGB(43,37,48),ac)b.MouseButton1Click:Connect(function()appT(mc,tc,ac,tk)end)end
cTBtn("Orion",Color3.fromRGB(36,36,37),Color3.fromRGB(30,30,30),Color3.fromRGB(52,152,219),"Orion")
cTBtn("Vampiro",Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50),"Vampiro")
cTBtn("Tóxico",Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100),"Tóxico")
cTBtn("Ametista",Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182),"Ametista")
cTBtn("Ouro",Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15),"Ouro")
cTBtn("Sakura",Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204),"Sakura")
cTBtn("Neon",Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255),"Neon")
cTBtn("Magma",Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34),"Magma")
cTBtn("Cyberpunk",Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0),"Cyberpunk")
cTBtn("Oceano",Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255),"Oceano")
cTBtn("Inferno",Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0),"Inferno")
cTBtn("Fantasma",Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230),"Fantasma")
cTBtn("Floresta",Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100),"Floresta")

cST("👥 SELECIONAR JOGADOR",sV)
local uPL
cTog("🛡️ Whitelist de Amigos",sV,wlOn,function(s)wlOn=s if uPL then uPL()end uESP()end,"Whitelist")
local sPly=nil
local TgtF=Instance.new("Frame",sV)TgtF.Size,TgtF.BackgroundTransparency=UDim2.new(1,0,0,50),1
local TarImg=Instance.new("ImageLabel",TgtF)TarImg.Size,TarImg.Position,TarImg.BackgroundColor3,TarImg.BorderSizePixel,TarImg.ClipsDescendants=UDim2.new(0,40,0,40),UDim2.new(0,12,0.5,-20),Color3.fromRGB(30,30,35),0,true Instance.new("UICorner",TarImg).CornerRadius=UDim.new(1,0)
local TarImgSk=Instance.new("UIStroke",TarImg)TarImgSk.Color=CTh.A TarImgSk.Thickness=2 table.insert(TE.Accs,TarImgSk)
local TarL=Instance.new("TextLabel",TgtF)TarL.Size,TarL.Position,TarL.BackgroundTransparency,TarL.Text,TarL.TextColor3,TarL.Font,TarL.TextSize,TarL.TextXAlignment=UDim2.new(1,-70,1,0),UDim2.new(0,60,0,0),1,"Alvo Atual: Nenhum",CTh.A,Enum.Font.GothamBold,14,Enum.TextXAlignment.Left table.insert(TE.Txs,TarL)
local SBF=Instance.new("Frame",sV)SBF.Size,SBF.BackgroundColor3=UDim2.new(1,0,0,35),Color3.fromRGB(40,36,45)Instance.new("UICorner",SBF).CornerRadius=UDim.new(0,8)
local SIc=Instance.new("TextLabel",SBF)SIc.Size,SIc.BackgroundTransparency,SIc.Text,SIc.TextSize=UDim2.new(0,30,1,0),1,"🔎",16
local SInp=Instance.new("TextBox",SBF)SInp.Size,SInp.Position,SInp.BackgroundTransparency,SInp.Text,SInp.PlaceholderText,SInp.TextColor3,SInp.Font,SInp.TextSize,SInp.TextXAlignment=UDim2.new(1,-35,1,0),UDim2.new(0,30,0,0),1,"","Pesquisar jogador...",Color3.fromRGB(255,255,255),Enum.Font.Gotham,13,Enum.TextXAlignment.Left
local PLF=Instance.new("ScrollingFrame",sV)PLF.Size,PLF.BackgroundColor3,PLF.BorderSizePixel,PLF.ScrollBarThickness=UDim2.new(1,0,0,180),Color3.fromRGB(30,28,35),0,4 Instance.new("UICorner",PLF).CornerRadius=UDim.new(0,8)
local UIL=Instance.new("UIListLayout",PLF)UIL.Padding,UIL.HorizontalAlignment,UIL.SortOrder=UDim.new(0,6),Enum.HorizontalAlignment.Center,Enum.SortOrder.Name UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()PLF.CanvasSize=UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y+10)end)
local pBD={}
uPL=function()
for _,d in pairs(pBD)do d.Btn:Destroy()end table.clear(pBD)local f=string.lower(SInp.Text or"")
for _,p in ipairs(P:GetPlayers())do if p~=LP then if isFriend(p)then continue end local b=Instance.new("TextButton",PLF)b.Size,b.BackgroundColor3,b.Text,b.TextColor3,b.Font,b.TextSize,b.TextXAlignment=UDim2.new(1,-12,0,46),Color3.fromRGB(42,38,48),"              "..p.DisplayName.." (@"..p.Name..")",Color3.fromRGB(240,240,245),Enum.Font.GothamBold,13,Enum.TextXAlignment.Left Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)styleBtn(b,Color3.fromRGB(42,38,48),CTh.A)local avI=Instance.new("ImageLabel",b)avI.Size,avI.Position,avI.BackgroundTransparency,avI.BackgroundColor3=UDim2.new(0,34,0,34),UDim2.new(0,8,0.5,-17),1,Color3.fromRGB(30,30,35)Instance.new("UICorner",avI).CornerRadius=UDim.new(1,0)task.spawn(function()local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)if s and r then avI.Image=r end end)b.MouseButton1Click:Connect(function()sPly=p TarL.Text="Alvo Atual: "..p.DisplayName sNotif("Alvo","Selecionado: "..p.Name,"Info")task.spawn(function()local s,r=pcall(function()return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)end)if s and r then TarImg.Image=r end end)end)table.insert(pBD,{Btn=b,Player=p})local pn,pd=string.lower(p.Name),string.lower(p.DisplayName)if f==""or string.find(pn,f)or string.find(pd,f)then b.Visible=true else b.Visible=false end end end end
SInp:GetPropertyChangedSignal("Text"):Connect(uPL)P.PlayerAdded:Connect(uPL)P.PlayerRemoving:Connect(function(p)if sPly==p then sPly=nil TarL.Text="Alvo Atual: Nenhum" TarImg.Image=""end uPL()end)uPL()
cST("⚙️ AÇÕES DO ALVO",sV)
local function cAB(n,p,cb)local B=Instance.new("TextButton",p)B.Size,B.BackgroundColor3,B.Text,B.TextColor3,B.Font,B.TextSize=UDim2.new(1,0,0,40),Color3.fromRGB(43,38,48),n,Color3.fromRGB(255,255,255),Enum.Font.GothamBold,13 Instance.new("UICorner",B).CornerRadius=UDim.new(0,9)styleBtn(B,Color3.fromRGB(43,38,48),CTh.A)B.MouseButton1Click:Connect(function()if sPly then cb(sPly)else sNotif("Aviso","Selecione um jogador na lista acima primeiro!","Error")end end)end
cAB("🚀 Teleport",sV,function(t)if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)sNotif("Teleport","Teleportado para "..t.Name,"Success")end end)
local vCn
cTog("👁️ View (Spectate)",sV,false,function(s)if s then if sPly and sPly.Character and sPly.Character:FindFirstChild("Humanoid")then W.CurrentCamera.CameraSubject=sPly.Character.Humanoid sNotif("View","Assistindo "..sPly.Name,"Info")else sNotif("Aviso","O alvo não tem um personagem válido.","Error")end else if LP.Character and LP.Character:FindFirstChild("Humanoid")then W.CurrentCamera.CameraSubject=LP.Character.Humanoid end end end,nil)
local lgCn
cTog("🔁 Loopgoto",sV,false,function(s)if s then if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end if lgCn then lgCn:Disconnect()end lgCn=RS.Heartbeat:Connect(function()if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=sPly.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)end end)else if lgCn then lgCn:Disconnect()lgCn=nil end end end,nil)
local fCn
cTog("🏃 Follow Player",sV,false,function(s)if s then if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end if fCn then fCn:Disconnect()end fCn=RS.Heartbeat:Connect(function()if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("Humanoid")then LP.Character:FindFirstChildOfClass("Humanoid"):MoveTo(sPly.Character.HumanoidRootPart.Position)end end)else if fCn then fCn:Disconnect()fCn=nil end end end,nil)
local hpCn,hpOrigCF
cTog("🐶 Headpet",sV,false,function(s)
if s then if not sPly then sNotif("Aviso","Selecione um jogador!","Error")return end local c=LP.Character if c and c:FindFirstChild("HumanoidRootPart")then hpOrigCF=c.HumanoidRootPart.CFrame end if hpCn then hpCn:Disconnect()end hpCn=RS.RenderStepped:Connect(function()if sPly and sPly.Character and sPly.Character:FindFirstChild("Head")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then local hrp=LP.Character.HumanoidRootPart local hum=LP.Character:FindFirstChildOfClass("Humanoid")local targetHead=sPly.Character.Head if hum then hum.PlatformStand=true end hrp.CFrame=targetHead.CFrame*CFrame.new(0,1.15,0)hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)end end)sNotif("Headpet","Ativado no alvo: "..sPly.Name,"Info")else if hpCn then hpCn:Disconnect()hpCn=nil end if LP.Character then local hum=LP.Character:FindFirstChildOfClass("Humanoid")if hum then hum.PlatformStand=false end end if hpOrigCF and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=hpOrigCF end sNotif("Headpet","Desativado.","Info")end
end,nil)
cAB("📋 Copiar Username",sV,function(t)if setclipboard then setclipboard(t.Name)sNotif("Copiado","Username ("..t.Name..") copiado!","Success")else sNotif("Erro","Seu executor não suporta setclipboard.","Error")end end)
cAB("📋 Copiar ID",sV,function(t)if setclipboard then setclipboard(tostring(t.UserId))sNotif("Copiado","ID ("..tostring(t.UserId)..") copiado!","Success")else sNotif("Erro","Seu executor não suporta setclipboard.","Error")end end)
cAB("📋 Copiar Name",sV,function(t)if setclipboard then setclipboard(t.DisplayName)sNotif("Copiado","Display Name ("..t.DisplayName..") copiado!","Success")else sNotif("Erro","Seu executor não suporta setclipboard.","Error")end end)

showIntro()

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
elseif sT=="Magma"then appT(Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34))
elseif sT=="Cyberpunk"then appT(Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0))
elseif sT=="Oceano"then appT(Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255))
elseif sT=="Inferno"then appT(Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0))
elseif sT=="Fantasma"then appT(Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230))
elseif sT=="Floresta"then appT(Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100))end
for _,iF in pairs(IC)do pcall(function()iF()end)end
uLig()
end)
