local CG,P,L,W,TS,UIS,RS,VU,PPS,HS=game:GetService("CoreGui"),game:GetService("Players"),game:GetService("Lighting"),game:GetService("Workspace"),game:GetService("TweenService"),game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("VirtualUser"),game:GetService("ProximityPromptService"),game:GetService("HttpService")
local LP=P.LocalPlayer
local TP=(gethui and gethui())or CG
if TP:FindFirstChild("VortexGraphicsHub")then TP.VortexGraphicsHub:Destroy()end

local Debris=game:GetService("Debris")
local SoundService=game:GetService("SoundService")
local GuiService=game:GetService("GuiService")

local SFName="VortexHub_Config.json"
local HC={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,RandomRain=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,AutoRejoin=false,Notifications=true,SelectedTheme="Orion",Whitelist=true}

local IC={}
local function saveC()
pcall(function()
if writefile then writefile(SFName,HS:JSONEncode(HC))end
end)
end

local function loadC()
if readfile and isfile and isfile(SFName)then
local s,d=pcall(function()return HS:JSONDecode(readfile(SFName))end)
if s and type(d)=="table"then
for k,v in pairs(d)do
if HC[k]~=nil then HC[k]=v end
end
end
end
end
loadC()

local shOn,fpsOn,wbOn,fgOn,mbOn,fbOn,plOn,atOn,rrOn,epOn,enOn,dEspOn,ttOn,iiOn,pmOn,ncOn,ijOn,nclOn,pSpd,pJmp,pFov,afOn,avOn,aaOn,arOn,jelOn,wlOn=HC.Shaders,HC.FpsBoost,HC.WallBlur,HC.Fog,HC.MotionBlur,HC.Fullbright,HC.PlayerLight,HC.AutoTime,HC.RandomRain,HC.ESPPlayer,HC.ESPNPC,HC.DangerESP,HC.TeleportTool,HC.InstantInteract,HC.PlayerMods,HC.NoCooldown,HC.InfJump,HC.Noclip,HC.WalkSpeed,HC.JumpPower,HC.FOV,HC.AntiFling,HC.AntiVoid,HC.AntiAfk,HC.AutoRejoin,HC.Notifications,HC.Whitelist

local ijc,nlc,avc,pmc,aac,arc,atc,sLp,iic,fbLp,plc,mbc,afc,ncc,nlDesc local lSCf=nil local lCR=CFrame.new()
local ECol={PName="#00FFFF",PHP="#32FF32",PDist="#FFAA00",NName="#FF4444",NHP="#32FF32",NDist="#FFAA00"}

local tNPC,tPly,tDNPC={},{},{} local eUp,dUp local nclParts={}
local OL={GS=L.GlobalShadows,B=L.Brightness,EDS=L.EnvironmentDiffuseScale,ESS=L.EnvironmentSpecularScale,FS=L.FogStart,FE=L.FogEnd,FC=L.FogColor,CT=L.ClockTime,A=L.Ambient,OA=L.OutdoorAmbient,T=L.Technology,SS=L.ShadowSoftness,EC=L.ExposureCompensation}

local TT_TELEPORT_SOUND=74715602103425
local TT_DEATH_SOUND=139316271339298
local TT_WAIT_SOUND=5047326951
local YT_LINK="https://www.youtube.com/@Soy_Gui_Oficial"

local function clrCE()
for _,v in pairs(L:GetChildren())do
if v.Name:match("Vortex")and v.Name~="VortexMotionBlur"and v.Name~="VortexWallBlur"and v.Name~="VortexDeathFade"then
v:Destroy()
end
end
end

local dF=L:FindFirstChild("VortexDeathFade")
if not dF then
dF=Instance.new("ColorCorrectionEffect",L)
dF.Name="VortexDeathFade"
dF.Brightness=0
dF.Contrast=0
end

local pDead=false
local fCache={}

local function isFriend(plr)
if not wlOn then return false end
if not plr or plr==LP then return false end
if fCache[plr.UserId]~=nil then return fCache[plr.UserId]end
local suc,res=pcall(function()return LP:IsFriendsWith(plr.UserId)end)
if suc then
fCache[plr.UserId]=res
return res
end
return false
end

local function playTTSound(id,volume,speed)
local s=Instance.new("Sound")
s.Name="VortexEasterEggSound"
s.SoundId="rbxassetid://"..tostring(id)
s.Volume=volume or 1
s.PlaybackSpeed=speed or 1
s.RollOffMaxDistance=100
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
p.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,Color3.fromRGB(90,0,150)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(190,0,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(120,0,255))
})
p.LightEmission=1
p.Brightness=3
p.Rate=0
p.Lifetime=NumberRange.new(0.3,0.8)
p.Speed=NumberRange.new(20,44)
p.Drag=4
p.SpreadAngle=Vector2.new(360,360)
p.Rotation=NumberRange.new(0,360)
p.RotSpeed=NumberRange.new(-220,220)
p.Acceleration=Vector3.new(0,8,0)
p.Size=NumberSequence.new({
NumberSequenceKeypoint.new(0,0.36),
NumberSequenceKeypoint.new(0.55,0.22),
NumberSequenceKeypoint.new(1,0)
})
p.Transparency=NumberSequence.new({
NumberSequenceKeypoint.new(0,0.03),
NumberSequenceKeypoint.new(0.72,0.3),
NumberSequenceKeypoint.new(1,1)
})
p.Parent=a
p:Emit(60)

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
if not wb then
wb=Instance.new("BlurEffect",L)
wb.Name="VortexWallBlur"
end

local ti=TweenInfo.new(2.5,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
TS:Create(wb,ti,{Size=45}):Play()
TS:Create(dF,ti,{Brightness=-1,Contrast=-0.5}):Play()

if hasTT then
task.defer(function()
playTTSound(TT_DEATH_SOUND,1)
end)
end
end)
end

local tT=nil
local sNotif
local ttEquipped=false
local ttWaitPlayed=false
local ttUseToken=0

local function rTT()
ttEquipped=false
ttWaitPlayed=false
ttUseToken=ttUseToken+1

if tT then
tT:Destroy()
tT=nil
end

if LP:FindFirstChild("Backpack")then
local b=LP.Backpack:FindFirstChild("TeleportTool")
if b then b:Destroy()end
end

if LP.Character then
local c=LP.Character:FindFirstChild("TeleportTool")
if c then c:Destroy()end
end
end

local function getTTTarget()
local c=LP.Character
if not c then return nil,"Personagem não encontrado."end

local hrp=c:FindFirstChild("HumanoidRootPart")
if not hrp then return nil,"HumanoidRootPart não encontrado."end

local cam=W.CurrentCamera
if not cam then return nil,"Câmera indisponível."end

local mouse=LP:GetMouse()
if not mouse then return nil,"Mouse indisponível."end

local sx,sy=mouse.X,mouse.Y
if not sx or not sy or(sx==0 and sy==0)then
local pos=UIS:GetMouseLocation()
sx,sy=pos.X,pos.Y
end

local ray
pcall(function()
ray=cam:ScreenPointToRay(sx,sy)
end)

if not ray then return nil,"Não foi possível detectar o alvo."end

local rp=RaycastParams.new()
rp.FilterType=Enum.RaycastFilterType.Exclude
rp.FilterDescendantsInstances={c}
rp.IgnoreWater=false

local hit=W:Raycast(ray.Origin,ray.Direction*2500,rp)
if not hit then
return nil,"Nenhuma superfície sólida foi encontrada."
end

local inst=hit.Instance

if inst:IsA("BasePart")then
if not inst.CanCollide or inst.Transparency>=0.95 then
return nil,"Destino inválido: superfície não sólida."
end
elseif inst:IsA("Terrain")then
if hit.Material==Enum.Material.Water or hit.Material==Enum.Material.Air then
return nil,"Destino inválido."
end
else
return nil,"Destino inválido."
end

local _,charSize=c:GetBoundingBox()
local halfY=math.max(charSize.Y*0.5,2)
local halfX=math.max(charSize.X*0.5,1.5)
local halfZ=math.max(charSize.Z*0.5,1.5)

local target

if hit.Normal.Y>=0.6 then
target=hit.Position+Vector3.new(0,halfY+0.55,0)
else
local side=math.max(halfX,halfZ)+1.5
local base=hit.Position+hit.Normal*side+Vector3.new(0,8,0)

local floorHit=W:Raycast(base,Vector3.new(0,-18,0),rp)

if not floorHit then
return nil,"Destino inválido: não existe chão abaixo."
end

if floorHit.Instance:IsA("BasePart")then
if not floorHit.Instance.CanCollide or floorHit.Instance.Transparency>=0.95 then
return nil,"Destino inválido: chão não sólido."
end
elseif floorHit.Instance:IsA("Terrain")and floorHit.Material==Enum.Material.Water then
return nil,"Destino inválido: apoio em água."
end

target=floorHit.Position+Vector3.new(0,halfY+0.55,0)
end

local floorCheck=W:Raycast(
target+Vector3.new(0,5,0),
Vector3.new(0,-12,0),
rp
)

if not floorCheck then
return nil,"Destino bloqueado: sem apoio sólido."
end

if floorCheck.Instance:IsA("BasePart")then
if not floorCheck.Instance.CanCollide or floorCheck.Instance.Transparency>=0.95 then
return nil,"Destino bloqueado."
end
elseif floorCheck.Instance:IsA("Terrain")and floorCheck.Material==Enum.Material.Water then
return nil,"Destino bloqueado por água."
end

target=floorCheck.Position+Vector3.new(0,halfY+0.55,0)

local overlap=OverlapParams.new()
overlap.FilterType=Enum.RaycastFilterType.Exclude
overlap.FilterDescendantsInstances={c}
overlap.MaxParts=100

local boxSize=Vector3.new(
math.max(charSize.X-0.25,2),
math.max(charSize.Y-0.8,3.5),
math.max(charSize.Z-0.25,2)
)

local blocked=W:GetPartBoundsInBox(CFrame.new(target),boxSize,overlap)

for _,part in ipairs(blocked)do
if part
and part.Parent
and part:IsA("BasePart")
and part~=floorCheck.Instance
and part.CanCollide
and part.Transparency<0.95 then
return nil,"Destino bloqueado: não existe espaço suficiente."
end
end

local points={
Vector3.new(0,0,0),
Vector3.new(halfX,0,0),
Vector3.new(-halfX,0,0),
Vector3.new(0,0,halfZ),
Vector3.new(0,0,-halfZ)
}

for _,off in ipairs(points)do
local check=W:Raycast(
target+off+Vector3.new(0,2,0),
Vector3.new(0,4,0),
rp
)

if check then
return nil,"Destino bloqueado por uma parede ou teto."
end
end

local groundTest=W:Raycast(
target+Vector3.new(0,1,0),
Vector3.new(0,-3,0),
rp
)

if not groundTest then
return nil,"Destino inválido: superfície não confirmada."
end

return CFrame.new(target,target+hrp.CFrame.LookVector)
end

local function gTT()
rTT()
if not ttOn then return end

local T=Instance.new("Tool")
T.Name="TeleportTool"
T.RequiresHandle=false
T.CanBeDropped=false

T.Equipped:Connect(function()
ttEquipped=true
ttWaitPlayed=false
ttUseToken=ttUseToken+1

local token=ttUseToken

task.delay(8,function()
if ttEquipped
and not ttWaitPlayed
and tT==T
and token==ttUseToken
and LP.Character
and T.Parent==LP.Character then
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
local done=false

task.delay(3,function()
if not done
and ttEquipped
and not ttWaitPlayed
and tT==T
and token==ttUseToken
and LP.Character
and T.Parent==LP.Character then
ttWaitPlayed=true
playTTSound(TT_WAIT_SOUND,1)
end
end)

local target,reason=getTTTarget()

if not target then
sNotif("TeleportTool",reason or"Destino inválido.","Error")
return
end

local c=LP.Character
local hrp=c and c:FindFirstChild("HumanoidRootPart")
if not hrp then return end

emitTTParticles(c)
playTTSound(TT_TELEPORT_SOUND,1)

hrp.CFrame=target
done=true

task.defer(function()
if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then
emitTTParticles(LP.Character)
end
end)

sNotif("✨","Teleporte realizado com segurança!","Success")
end)

local bp=LP:WaitForChild("Backpack",3)
if bp then
T.Parent=bp
tT=T
end
end

local function nclPart(v)
if not v or not v:IsA("BasePart")then return end
if nclParts[v]==nil then
nclParts[v]=v.CanCollide
end
v.CanCollide=false
end

local function startNcl()
if nlc then nlc:Disconnect()nlc=nil end
if nlDesc then nlDesc:Disconnect()nlDesc=nil end

table.clear(nclParts)

local c=LP.Character
if c then
for _,v in ipairs(c:GetDescendants())do
nclPart(v)
end

nlDesc=c.DescendantAdded:Connect(function(v)
if nclOn then
nclPart(v)
end
end)
end

nlc=RS.Stepped:Connect(function()
if not nclOn then return end
local c=LP.Character
if not c then return end

for _,v in ipairs(c:GetDescendants())do
if v:IsA("BasePart")then
if nclParts[v]==nil then
nclParts[v]=v.CanCollide
end
v.CanCollide=false
end
end
end)
end

local function stopNcl()
if nlc then nlc:Disconnect()nlc=nil end
if nlDesc then nlDesc:Disconnect()nlDesc=nil end

for v,old in pairs(nclParts)do
if v and v.Parent then
pcall(function()
v.CanCollide=old
end)
end
end

table.clear(nclParts)
end

LP.CharacterAdded:Connect(function(c)
pDead=false

if dF then
TS:Create(dF,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Brightness=0,Contrast=0}):Play()
end

local wb=L:FindFirstChild("VortexWallBlur")
if wb then
TS:Create(wb,TweenInfo.new(0.2,Enum.EasingStyle.Sine),{Size=0}):Play()
end

stDE(c)

if ttOn then
task.spawn(function()
task.wait(0.5)
gTT()
end)
end

if nclOn then
task.delay(0.2,function()
if nclOn and LP.Character==c then
startNcl()
end
end)
end
end)

if LP.Character then
stDE(LP.Character)
end

local function gPB(cam,c)
if not wbOn then return 0 end

local mB,mD,cD=12,45,45
local rP=RaycastParams.new()
rP.FilterType=Enum.RaycastFilterType.Exclude
rP.FilterDescendantsInstances={c,cam}

local ang={
CFrame.Angles(0,0,0),
CFrame.Angles(0,math.rad(25),0),
CFrame.Angles(0,math.rad(-25),0),
CFrame.Angles(math.rad(15),0,0),
CFrame.Angles(math.rad(-15),0,0)
}

for _,a in ipairs(ang)do
local dir=(cam.CFrame*a).LookVector
local h=W:Raycast(cam.CFrame.Position,dir*mD,rP)

if h and h.Instance and h.Instance.Transparency<0.8 and h.Instance.CanCollide and h.Distance<cD then
cD=h.Distance
end
end

local vS=cam.ViewportSize

local function ckD(hrp,obj)
local d=(hrp.Position-cam.CFrame.Position).Magnitude
if d<mD then
local sP,oS=cam:WorldToViewportPoint(hrp.Position)

if oS and sP.X>=0 and sP.X<=vS.X and sP.Y>=0 and sP.Y<=vS.Y then
local ry=W:Raycast(cam.CFrame.Position,(hrp.Position-cam.CFrame.Position),rP)

if not ry or ry.Instance:IsDescendantOf(obj)then
if d<cD then
cD=d
end
end
end
end
end

for _,p in ipairs(P:GetPlayers())do
if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")then
ckD(p.Character.HumanoidRootPart,p.Character)
end
end

for _,o in ipairs(W:GetChildren())do
if o:IsA("Model")and o~=c and o:FindFirstChildOfClass("Humanoid")then
local tH=o:FindFirstChild("HumanoidRootPart")or o.PrimaryPart
if tH then
ckD(tH,o)
end
end
end

if cD<mD then
return(1-(cD/mD))*mB
end

return 0
end

local function cInd(hrp,rP)
if not hrp then return false end

local hs=0
local off={
Vector3.new(0,0,0),
Vector3.new(8,0,0),
Vector3.new(-8,0,0),
Vector3.new(0,0,8),
Vector3.new(0,0,-8)
}

for _,o in ipairs(off)do
local h=W:Raycast(hrp.Position+o,Vector3.new(0,120,0),rP)

if h and h.Instance and h.Instance.CanCollide and h.Instance.Transparency<0.5 then
hs=hs+1
end
end

return hs>=3
end

local CNPCs={}

local function cNPC(o)
if o:IsA("Model")
and o:FindFirstChild("Humanoid")
and o:FindFirstChild("HumanoidRootPart")
and not P:GetPlayerFromCharacter(o)then
CNPCs[o]=true
end
end

for _,o in ipairs(W:GetDescendants())do
cNPC(o)
end

W.DescendantAdded:Connect(function(o)
task.delay(0.2,function()
if o and o.Parent then
if o:IsA("Model")then cNPC(o)end
if o.Parent:IsA("Model")then cNPC(o.Parent)end
end
end)
end)

W.DescendantRemoving:Connect(function(o)
if CNPCs[o]then
CNPCs[o]=nil
end
end)

local CTh={
MBG=Color3.fromRGB(20,16,28),
TB=Color3.fromRGB(25,20,34),
A=Color3.fromRGB(178,70,255)
}

local TE={
Bgs={},
TBs={},
Accs={},
Tgls={},
Txs={}
}

local function appT(m,t,a,tn)
CTh.MBG,CTh.TB,CTh.A=m,t,a

if tn then
HC.SelectedTheme=tn
saveC()
end

for _,f in pairs(TE.Bgs)do
pcall(function()f.BackgroundColor3=m end)
end

for _,f in pairs(TE.TBs)do
pcall(function()f.BackgroundColor3=t end)
end

for _,o in pairs(TE.Accs)do
pcall(function()
if o:IsA("UIStroke")then
o.Color=a
else
o.BackgroundColor3=a
end
end)
end

for _,tx in pairs(TE.Txs)do
pcall(function()tx.TextColor3=a end)
end

for bg,sF in pairs(TE.Tgls)do
if sF()then
TS:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=a}):Play()
end
end
end

local SG=Instance.new("ScreenGui",TP)
SG.Name="VortexGraphicsHub"
SG.ResetOnSpawn=false
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
SG.DisplayOrder=999999

local function addGradient(obj,c1,c2,rot)
local g=Instance.new("UIGradient",obj)
g.Color=ColorSequence.new({
ColorSequenceKeypoint.new(0,c1),
ColorSequenceKeypoint.new(1,c2)
})
g.Rotation=rot or 0
return g
end

local loadFrame=Instance.new("Frame",SG)
loadFrame.Size=UDim2.fromScale(1,1)
loadFrame.BackgroundColor3=Color3.fromRGB(7,5,12)
loadFrame.BorderSizePixel=0
loadFrame.ZIndex=1000

local loadGlow=Instance.new("Frame",loadFrame)
loadGlow.AnchorPoint=Vector2.new(0.5,0.5)
loadGlow.Position=UDim2.fromScale(0.5,0.38)
loadGlow.Size=UDim2.new(0,220,0,220)
loadGlow.BackgroundColor3=Color3.fromRGB(140,0,255)
loadGlow.BackgroundTransparency=0.86
loadGlow.ZIndex=1001
Instance.new("UICorner",loadGlow).CornerRadius=UDim.new(1,0)

local lgStroke=Instance.new("UIStroke",loadGlow)
lgStroke.Color=Color3.fromRGB(210,90,255)
lgStroke.Thickness=3
lgStroke.Transparency=0.2

local loadTitle=Instance.new("TextLabel",loadFrame)
loadTitle.AnchorPoint=Vector2.new(0.5,0)
loadTitle.Position=UDim2.fromScale(0.5,0.22)
loadTitle.Size=UDim2.new(0,600,0,55)
loadTitle.BackgroundTransparency=1
loadTitle.Text="⚡ VORTEX HUB V18"
loadTitle.TextColor3=Color3.fromRGB(255,255,255)
loadTitle.Font=Enum.Font.GothamBlack
loadTitle.TextSize=32
loadTitle.ZIndex=1002

local loadOwner=Instance.new("TextLabel",loadFrame)
loadOwner.AnchorPoint=Vector2.new(0.5,0)
loadOwner.Position=UDim2.fromScale(0.5,0.30)
loadOwner.Size=UDim2.new(0,600,0,40)
loadOwner.BackgroundTransparency=1
loadOwner.Text="Soy_Gui_Oficial"
loadOwner.TextColor3=Color3.fromRGB(190,80,255)
loadOwner.Font=Enum.Font.GothamBold
loadOwner.TextSize=22
loadOwner.ZIndex=1002

local ytText=Instance.new("TextLabel",loadFrame)
ytText.AnchorPoint=Vector2.new(0.5,0)
ytText.Position=UDim2.fromScale(0.5,0.57)
ytText.Size=UDim2.new(0,720,0,70)
ytText.BackgroundTransparency=1
ytText.RichText=true
ytText.Text='Não Achou O Meu <font color="#FF2020"><b><u>YOUTUBE</u></b></font>, Copie O Link:'
ytText.TextColor3=Color3.fromRGB(235,235,245)
ytText.Font=Enum.Font.GothamBold
ytText.TextSize=19
ytText.TextWrapped=true
ytText.ZIndex=1002

local ytLink=Instance.new("TextLabel",loadFrame)
ytLink.AnchorPoint=Vector2.new(0.5,0)
ytLink.Position=UDim2.fromScale(0.5,0.65)
ytLink.Size=UDim2.new(0,720,0,36)
ytLink.BackgroundTransparency=1
ytLink.RichText=true
ytLink.Text='<font color="#FF3030"><b>https://www.youtube.com/@Soy_Gui_Oficial</b></font>'
ytLink.TextColor3=Color3.fromRGB(255,255,255)
ytLink.Font=Enum.Font.GothamBold
ytLink.TextSize=16
ytLink.TextWrapped=true
ytLink.ZIndex=1002

local ytBtn=Instance.new("TextButton",loadFrame)
ytBtn.AnchorPoint=Vector2.new(0.5,0)
ytBtn.Position=UDim2.fromScale(0.5,0.73)
ytBtn.Size=UDim2.new(0,260,0,45)
ytBtn.BackgroundColor3=Color3.fromRGB(90,20,120)
ytBtn.BackgroundTransparency=0.08
ytBtn.Text="📋 COPIAR LINK DO YOUTUBE"
ytBtn.TextColor3=Color3.fromRGB(255,255,255)
ytBtn.Font=Enum.Font.GothamBlack
ytBtn.TextSize=13
ytBtn.ZIndex=1003
Instance.new("UICorner",ytBtn).CornerRadius=UDim.new(0,10)
local ytBs=Instance.new("UIStroke",ytBtn)
ytBs.Color=Color3.fromRGB(220,80,255)
ytBs.Thickness=2
addGradient(ytBtn,Color3.fromRGB(110,20,160),Color3.fromRGB(50,10,80),0)

ytBtn.Activated:Connect(function()
if setclipboard then
pcall(function()
setclipboard(YT_LINK)
end)
ytBtn.Text="✅ LINK COPIADO!"
task.delay(1.5,function()
if ytBtn.Parent then
ytBtn.Text="📋 COPIAR LINK DO YOUTUBE"
end
end)
end
end)

local loadBarBg=Instance.new("Frame",loadFrame)
loadBarBg.AnchorPoint=Vector2.new(0.5,0)
loadBarBg.Position=UDim2.fromScale(0.5,0.84)
loadBarBg.Size=UDim2.new(0,420,0,8)
loadBarBg.BackgroundColor3=Color3.fromRGB(35,30,45)
loadBarBg.BorderSizePixel=0
loadBarBg.ZIndex=1002
Instance.new("UICorner",loadBarBg).CornerRadius=UDim.new(1,0)

local loadBar=Instance.new("Frame",loadBarBg)
loadBar.Size=UDim2.new(0,0,1,0)
loadBar.BackgroundColor3=Color3.fromRGB(190,0,255)
loadBar.BorderSizePixel=0
loadBar.ZIndex=1003
Instance.new("UICorner",loadBar).CornerRadius=UDim.new(1,0)
addGradient(loadBar,Color3.fromRGB(120,20,255),Color3.fromRGB(255,50,220),0)

local loadStatus=Instance.new("TextLabel",loadFrame)
loadStatus.AnchorPoint=Vector2.new(0.5,0)
loadStatus.Position=UDim2.fromScale(0.5,0.87)
loadStatus.Size=UDim2.new(0,500,0,30)
loadStatus.BackgroundTransparency=1
loadStatus.Text="Inicializando sistemas..."
loadStatus.TextColor3=Color3.fromRGB(150,150,165)
loadStatus.Font=Enum.Font.Gotham
loadStatus.TextSize=12
loadStatus.ZIndex=1002

task.spawn(function()
TS:Create(loadGlow,TweenInfo.new(1.2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{Size=UDim2.new(0,280,0,280),BackgroundTransparency=0.78}):Play()
TS:Create(lgStroke,TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{Transparency=0.75}):Play()

local stages={
{0.18,"Carregando Vortex Hub..."},
{0.34,"Preparando sistemas gráficos..."},
{0.50,"Preparando ESP e Player..."},
{0.68,"Preparando TeleportTool..."},
{0.82,"Carregando interface..."},
{1,"Tudo pronto! 🔥"}
}

for _,d in ipairs(stages)do
loadStatus.Text=d[2]
TS:Create(loadBar,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=UDim2.new(d[1],0,1,0)}):Play()
task.wait(0.25)
end

task.wait(0.5)

local out1=TS:Create(loadFrame,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency=1})
out1:Play()

for _,v in ipairs(loadFrame:GetDescendants())do
pcall(function()
if v:IsA("TextLabel")or v:IsA("TextButton")then
TS:Create(v,TweenInfo.new(0.35),{TextTransparency=1,BackgroundTransparency=1}):Play()
elseif v:IsA("Frame")then
TS:Create(v,TweenInfo.new(0.35),{BackgroundTransparency=1}):Play()
elseif v:IsA("UIStroke")then
TS:Create(v,TweenInfo.new(0.35),{Transparency=1}):Play()
end
end)
end

task.wait(0.45)
loadFrame:Destroy()
end)

local msgId=0

local function findJumpButton()
local roots={}
local pg=LP:FindFirstChildOfClass("PlayerGui")
if pg then table.insert(roots,pg)end
if TP and TP~=CG then table.insert(roots,TP)end
table.insert(roots,CG)

for _,root in ipairs(roots)do
local ok,b=pcall(function()
return root:FindFirstChild("JumpButton",true)
end)

if ok and b and b:IsA("GuiObject")and b.Visible then
return b
end
end
end

local function placeMsg(lbl)
local cam=W.CurrentCamera
local jb=findJumpButton()
local x,y

if jb then
x=jb.AbsolutePosition.X+(jb.AbsoluteSize.X/2)
y=jb.AbsolutePosition.Y-10
else
local vp=cam and cam.ViewportSize or Vector2.new(1920,1080)
x=vp.X-135
y=vp.Y-185
end

lbl.Position=UDim2.fromOffset(math.floor(x),math.floor(y))
end

sNotif=function(tl,tx,nt)
msgId=msgId+1
local myId=msgId

local cc=nt=="Error"and Color3.fromRGB(255,80,95)or(nt=="Success"and Color3.fromRGB(100,255,155)or CTh.A)

local Txt=Instance.new("TextLabel",SG)
Txt.Name="VortexMessage"
Txt.Size=UDim2.new(0,300,0,58)
Txt.AnchorPoint=Vector2.new(0.5,1)
Txt.BackgroundTransparency=1
Txt.RichText=true
Txt.Text=string.format("<b>%s</b>\n%s",tl,tx)
Txt.TextColor3=cc
Txt.Font=Enum.Font.Gotham
Txt.TextSize=13
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

while Txt.Parent and myId==msgId and tick()-st<3.2 do
placeMsg(Txt)
task.wait(0.08)
end

if Txt.Parent and myId==msgId then
local tw=TS:Create(Txt,TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{TextTransparency=1})
tw:Play()
tw.Completed:Wait()
end

if Txt.Parent then
Txt:Destroy()
end
end)
end

local playerEventFrames={}
local function showPlayerEvent(p,joined)
if not p then return end

local card=Instance.new("Frame",SG)
card.Name="VortexPlayerEvent"
card.Size=UDim2.new(0,330,0,86)
card.Position=UDim2.new(1,25,0.28,0)
card.BackgroundColor3=Color3.fromRGB(16,14,22)
card.BackgroundTransparency=0.05
card.BorderSizePixel=0
card.ZIndex=250
Instance.new("UICorner",card).CornerRadius=UDim.new(0,12)

local stroke=Instance.new("UIStroke",card)
stroke.Color=joined and Color3.fromRGB(70,255,170)or Color3.fromRGB(255,70,95)
stroke.Thickness=2
stroke.Transparency=0.12

local bar=Instance.new("Frame",card)
bar.Size=UDim2.new(0,5,1,0)
bar.BackgroundColor3=stroke.Color
bar.BorderSizePixel=0
bar.ZIndex=251
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,12)

local avatar=Instance.new("ImageLabel",card)
avatar.Size=UDim2.new(0,54,0,54)
avatar.Position=UDim2.new(0,16,0.5,-27)
avatar.BackgroundColor3=Color3.fromRGB(30,27,40)
avatar.BackgroundTransparency=0.15
avatar.BorderSizePixel=0
avatar.ZIndex=252
Instance.new("UICorner",avatar).CornerRadius=UDim.new(1,0)

local avStroke=Instance.new("UIStroke",avatar)
avStroke.Color=stroke.Color
avStroke.Thickness=2

task.spawn(function()
local ok,img=pcall(function()
return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)
end)
if ok and img and avatar.Parent then
avatar.Image=img
end
end)

local status=Instance.new("TextLabel",card)
status.Size=UDim2.new(1,-105,0,20)
status.Position=UDim2.new(0,82,0,9)
status.BackgroundTransparency=1
status.Text=joined and"🟢 JOGADOR ENTROU"or"🔴 JOGADOR SAIU"
status.TextColor3=stroke.Color
status.Font=Enum.Font.GothamBlack
status.TextSize=11
status.TextXAlignment=Enum.TextXAlignment.Left
status.ZIndex=252

local nameLabel=Instance.new("TextLabel",card)
nameLabel.Size=UDim2.new(1,-105,0,22)
nameLabel.Position=UDim2.new(0,82,0,30)
nameLabel.BackgroundTransparency=1
nameLabel.Text=p.DisplayName.." ("..p.Name..")"
nameLabel.TextColor3=Color3.fromRGB(255,255,255)
nameLabel.Font=Enum.Font.GothamBold
nameLabel.TextSize=14
nameLabel.TextTruncate=Enum.TextTruncate.AtEnd
nameLabel.TextXAlignment=Enum.TextXAlignment.Left
nameLabel.ZIndex=252

local idLabel=Instance.new("TextLabel",card)
idLabel.Size=UDim2.new(1,-105,0,20)
idLabel.Position=UDim2.new(0,82,0,53)
idLabel.BackgroundTransparency=1
idLabel.Text="🆔 ID: "..tostring(p.UserId)
idLabel.TextColor3=Color3.fromRGB(175,175,190)
idLabel.Font=Enum.Font.Gotham
idLabel.TextSize=11
idLabel.TextXAlignment=Enum.TextXAlignment.Left
idLabel.ZIndex=252

table.insert(playerEventFrames,card)

local offset=(#playerEventFrames-1)*95
card.Position=UDim2.new(1,25,0.28,offset)

TS:Create(card,TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-350,0.28,offset)}):Play()

task.delay(4.5,function()
if not card.Parent then return end

TS:Create(card,TweenInfo.new(0.35,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1,25,0.28,card.Position.Y.Offset),BackgroundTransparency=1}):Play()

task.wait(0.38)

if card.Parent then
card:Destroy()
end

for i,v in ipairs(playerEventFrames)do
if v==card then
table.remove(playerEventFrames,i)
break
end
end

for i,v in ipairs(playerEventFrames)do
if v.Parent then
TS:Create(v,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-350,0.28,(i-1)*95)}):Play()
end
end
end)
end

local OBtn=Instance.new("TextButton",SG)
OBtn.Name="OpenButton"
OBtn.Size=UDim2.new(0,62,0,62)
OBtn.Position=UDim2.new(0,18,0,115)
OBtn.BackgroundColor3=Color3.fromRGB(26,17,31)
OBtn.Text="⚡\nOPEN"
OBtn.TextColor3=Color3.fromRGB(255,255,255)
OBtn.Font=Enum.Font.GothamBlack
OBtn.TextSize=12
OBtn.Visible=false
OBtn.AutoButtonColor=false
Instance.new("UICorner",OBtn).CornerRadius=UDim.new(0,14)
local oStroke=Instance.new("UIStroke",OBtn)
oStroke.Color=Color3.fromRGB(190,70,255)
oStroke.Thickness=2
addGradient(OBtn,Color3.fromRGB(48,25,60),Color3.fromRGB(18,14,22),45)
table.insert(TE.Bgs,OBtn)

OBtn.MouseEnter:Connect(function()
TS:Create(OBtn,TweenInfo.new(0.15),{Size=UDim2.new(0,66,0,66)}):Play()
end)

OBtn.MouseLeave:Connect(function()
TS:Create(OBtn,TweenInfo.new(0.15),{Size=UDim2.new(0,62,0,62)}):Play()
end)

local MF=Instance.new("Frame",SG)
MF.Size=UDim2.new(0,500,0,560)
MF.Position=UDim2.new(0.5,-250,0.5,-280)
MF.BackgroundColor3=CTh.MBG
MF.Active=true
MF.Draggable=true
MF.BorderSizePixel=0
Instance.new("UICorner",MF).CornerRadius=UDim.new(0,12)
local mfStroke=Instance.new("UIStroke",MF)
mfStroke.Color=Color3.fromRGB(110,50,150)
mfStroke.Thickness=1.5
table.insert(TE.Bgs,MF)

local TB=Instance.new("Frame",MF)
TB.Size=UDim2.new(1,0,0,48)
TB.BackgroundColor3=CTh.TB
TB.BorderSizePixel=0
Instance.new("UICorner",TB).CornerRadius=UDim.new(0,12)
table.insert(TE.TBs,TB)

addGradient(TB,Color3.fromRGB(45,23,58),Color3.fromRGB(20,18,27),0)

local PIco=Instance.new("ImageLabel",TB)
PIco.Size=UDim2.new(0,31,0,31)
PIco.Position=UDim2.new(0,10,0.5,-15)
PIco.BackgroundColor3=Color3.fromRGB(50,50,55)
PIco.BorderSizePixel=0
PIco.ClipsDescendants=true
Instance.new("UICorner",PIco).CornerRadius=UDim.new(1,0)
task.spawn(function()
pcall(function()
PIco.Image=P:GetUserThumbnailAsync(LP.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)
end)
end)

local Ttl=Instance.new("TextLabel",TB)
Ttl.Size=UDim2.new(1,-100,1,0)
Ttl.Position=UDim2.new(0,50,0,0)
Ttl.Text="⚡ Vortex Hub V18 - Supreme"
Ttl.TextColor3=Color3.fromRGB(255,255,255)
Ttl.Font=Enum.Font.GothamBlack
Ttl.TextSize=15
Ttl.BackgroundTransparency=1
Ttl.TextXAlignment=Enum.TextXAlignment.Left

local ownerMini=Instance.new("TextLabel",TB)
ownerMini.Size=UDim2.new(0,115,0,18)
ownerMini.Position=UDim2.new(1,-155,0,24)
ownerMini.BackgroundTransparency=1
ownerMini.Text="Soy_Gui_Oficial"
ownerMini.TextColor3=Color3.fromRGB(190,90,255)
ownerMini.Font=Enum.Font.GothamBold
ownerMini.TextSize=9
ownerMini.TextXAlignment=Enum.TextXAlignment.Right

local CBn=Instance.new("TextButton",TB)
CBn.Size=UDim2.new(0,42,0,42)
CBn.Position=UDim2.new(1,-44,0,3)
CBn.BackgroundTransparency=1
CBn.Text="×"
CBn.TextColor3=Color3.fromRGB(220,220,225)
CBn.Font=Enum.Font.GothamBlack
CBn.TextSize=24
CBn.AutoButtonColor=false

local TC=Instance.new("Frame",MF)
TC.Size=UDim2.new(1,0,0,32)
TC.Position=UDim2.new(0,0,0,48)
TC.BackgroundTransparency=1

local function cTB(n,px,w)
local B=Instance.new("TextButton",TC)
B.Size=UDim2.new(w or 0.166,0,1,0)
B.Position=UDim2.new(px,0,0,0)
B.BackgroundColor3=Color3.fromRGB(26,23,31)
B.Text=n
B.TextColor3=Color3.fromRGB(155,150,165)
B.Font=Enum.Font.GothamBold
B.TextSize=10
B.AutoButtonColor=false
B.BorderSizePixel=0
local s=Instance.new("UIStroke",B)
s.Color=Color3.fromRGB(50,45,60)
s.Thickness=1
return B
end

local tMB,tEB,tPB,tPrB,tThB,tVB=cTB("🔧 Princ.",0,0.166),cTB("👁️ ESPS",0.166,0.166),cTB("👤 Player",0.332,0.166),cTB("🛡️ Prot.",0.498,0.166),cTB("🎨 Temas",0.664,0.166),cTB("👀 Viewer",0.830,0.170)

local function styleTabSelected(b,on)
b.BackgroundColor3=on and Color3.fromRGB(54,27,67)or Color3.fromRGB(26,23,31)
b.TextColor3=on and Color3.fromRGB(255,255,255)or Color3.fromRGB(155,150,165)
local s=b:FindFirstChildOfClass("UIStroke")
if s then
s.Color=on and CTh.A or Color3.fromRGB(50,45,60)
end
end

styleTabSelected(tMB,true)

for _,b in ipairs({tMB,tEB,tPB,tPrB,tThB,tVB})do
b.MouseEnter:Connect(function()
TS:Create(b,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(45,25,54)}):Play()
end)
b.MouseLeave:Connect(function()
local active=(b==tMB)
local map={{tMB,sM},{tEB,sE},{tPB,sP},{tPrB,sPr},{tThB,sTh},{tVB,sV}}
for _,d in ipairs(map)do
if d[1]==b then
active=d[2].Visible
end
end
styleTabSelected(b,active)
end)
end

local function cScr(n,cY)
local S=Instance.new("ScrollingFrame",MF)
S.Name=n
S.Size=UDim2.new(1,-20,1,-92)
S.Position=UDim2.new(0,10,0,82)
S.BackgroundTransparency=1
S.ScrollBarThickness=4
S.ScrollBarImageColor3=CTh.A
S.CanvasSize=UDim2.new(0,0,0,cY)
S.Visible=false
S.BorderSizePixel=0

local Ls=Instance.new("UIListLayout",S)
Ls.Padding=UDim.new(0,10)
Ls.HorizontalAlignment=Enum.HorizontalAlignment.Center
Ls.SortOrder=Enum.SortOrder.LayoutOrder

Ls:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
S.CanvasSize=UDim2.new(0,0,0,Ls.AbsoluteContentSize.Y+15)
end)

return S
end

local sM,sE,sP,sPr,sTh,sV=cScr("SM",1100),cScr("SE",850),cScr("SP",800),cScr("SPr",460),cScr("STh",650),cScr("SV",900)
sM.Visible=true

local function sTab(aB,aS)
local t={{tMB,sM},{tEB,sE},{tPB,sP},{tPrB,sPr},{tThB,sTh},{tVB,sV}}

for _,d in pairs(t)do
local b,s=d[1],d[2]
s.Visible=(b==aB)
styleTabSelected(b,b==aB)
end
end

tMB.Activated:Connect(function()sTab(tMB,sM)end)
tEB.Activated:Connect(function()sTab(tEB,sE)end)
tPB.Activated:Connect(function()sTab(tPB,sP)end)
tPrB.Activated:Connect(function()sTab(tPrB,sPr)end)
tThB.Activated:Connect(function()sTab(tThB,sTh)end)
tVB.Activated:Connect(function()sTab(tVB,sV)end)

CBn.Activated:Connect(function()
MF.Visible=false
OBtn.Visible=true
end)

OBtn.Activated:Connect(function()
MF.Visible=true
OBtn.Visible=false
end)

local function cST(n,p)
local T=Instance.new("TextLabel",p)
T.Size=UDim2.new(1,0,0,28)
T.BackgroundTransparency=1
T.Text=n
T.TextColor3=CTh.A
T.Font=Enum.Font.GothamBlack
T.TextSize=14
T.TextXAlignment=Enum.TextXAlignment.Left
T.TextYAlignment=Enum.TextYAlignment.Center
table.insert(TE.Txs,T)
end

local function cTog(n,p,iS,cb,ck)
local F=Instance.new("Frame",p)
F.Size=UDim2.new(1,0,0,54)
F.BackgroundColor3=Color3.fromRGB(37,34,42)
F.BorderSizePixel=0
F.ClipsDescendants=true
Instance.new("UICorner",F).CornerRadius=UDim.new(0,10)

local FS=Instance.new("UIStroke",F)
FS.Color=Color3.fromRGB(60,55,68)
FS.Thickness=1

local accent=Instance.new("Frame",F)
accent.Size=UDim2.new(0,4,1,0)
accent.BackgroundColor3=iS and CTh.A or Color3.fromRGB(70,65,75)
accent.BorderSizePixel=0
Instance.new("UICorner",accent).CornerRadius=UDim.new(0,10)

local Lb=Instance.new("TextLabel",F)
Lb.Size=UDim2.new(0.7,0,1,0)
Lb.Position=UDim2.new(0,18,0,0)
Lb.BackgroundTransparency=1
Lb.Text=n
Lb.TextColor3=Color3.fromRGB(250,250,255)
Lb.Font=Enum.Font.GothamBold
Lb.TextSize=13
Lb.TextXAlignment=Enum.TextXAlignment.Left

local status=Instance.new("TextLabel",F)
status.Size=UDim2.new(0,82,0,18)
status.Position=UDim2.new(1,-150,0.5,-9)
status.BackgroundTransparency=1
status.Text=iS and"ON"or"OFF"
status.TextColor3=iS and CTh.A or Color3.fromRGB(130,125,140)
status.Font=Enum.Font.GothamBlack
status.TextSize=9
status.TextXAlignment=Enum.TextXAlignment.Right

local SB=Instance.new("Frame",F)
SB.Size=UDim2.new(0,48,0,24)
SB.Position=UDim2.new(1,-62,0.5,-12)
SB.BackgroundColor3=iS and CTh.A or Color3.fromRGB(65,61,70)
SB.BorderSizePixel=0
Instance.new("UICorner",SB).CornerRadius=UDim.new(1,0)

local SK=Instance.new("Frame",SB)
SK.Size=UDim2.new(0,18,0,18)
SK.Position=iS and UDim2.new(1,-21,0.5,-9)or UDim2.new(0,3,0.5,-9)
SK.BackgroundColor3=Color3.fromRGB(255,255,255)
SK.BorderSizePixel=0
Instance.new("UICorner",SK).CornerRadius=UDim.new(1,0)

local glow=Instance.new("UIStroke",SK)
glow.Color=iS and CTh.A or Color3.fromRGB(120,115,130)
glow.Thickness=1.5

local st=iS
TE.Tgls[SB]=function()return st end

local function sVS(ns)
st=ns

TS:Create(SB,TweenInfo.new(0.18,Enum.EasingStyle.Quad),{BackgroundColor3=st and CTh.A or Color3.fromRGB(65,61,70)}):Play()
TS:Create(SK,TweenInfo.new(0.18,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=st and UDim2.new(1,-21,0.5,-9)or UDim2.new(0,3,0.5,-9)}):Play()
TS:Create(accent,TweenInfo.new(0.18),{BackgroundColor3=st and CTh.A or Color3.fromRGB(70,65,75)}):Play()

status.Text=st and"ON"or"OFF"
status.TextColor3=st and CTh.A or Color3.fromRGB(130,125,140)
glow.Color=st and CTh.A or Color3.fromRGB(120,115,130)

if ck then
HC[ck]=st
saveC()
end
end

local B=Instance.new("TextButton",F)
B.Size=UDim2.fromScale(1,1)
B.BackgroundTransparency=1
B.Text=""
B.AutoButtonColor=false

B.Activated:Connect(function()
sVS(not st)
cb(st)
end)

B.MouseEnter:Connect(function()
TS:Create(F,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(45,41,51)}):Play()
end)

B.MouseLeave:Connect(function()
TS:Create(F,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(37,34,42)}):Play()
end)

if ck then
IC[ck]=function()
if st then
cb(true)
end
end
end

return sVS
end

P.PlayerAdded:Connect(function(p)
showPlayerEvent(p,true)
end)

P.PlayerRemoving:Connect(function(p)
showPlayerEvent(p,false)
end)

local function cSli(n,rT,mV,mxV,cV,p,cb,ck)
local SF=Instance.new("Frame",p)
SF.Size=UDim2.new(1,0,0,72)
SF.BackgroundColor3=Color3.fromRGB(40,37,45)
SF.BorderSizePixel=0
Instance.new("UICorner",SF).CornerRadius=UDim.new(0,10)
Instance.new("UIStroke",SF).Color=Color3.fromRGB(60,55,68)

local TL=Instance.new("TextLabel",SF)
TL.Size=UDim2.new(1,-20,0,20)
TL.Position=UDim2.new(0,12,0,7)
TL.Text=n.." [ "..tostring(cV).." ]"
TL.TextColor3=Color3.fromRGB(255,255,255)
TL.Font=Enum.Font.GothamBold
TL.TextSize=13
TL.BackgroundTransparency=1
TL.TextXAlignment=Enum.TextXAlignment.Left

local RL=Instance.new("TextLabel",SF)
RL.Size=UDim2.new(1,-20,0,18)
RL.Position=UDim2.new(0,12,0,27)
RL.Text="Recomendado: "..rT
RL.TextColor3=Color3.fromRGB(155,150,165)
RL.Font=Enum.Font.Gotham
RL.TextSize=10
RL.BackgroundTransparency=1
RL.TextXAlignment=Enum.TextXAlignment.Left

local Tk=Instance.new("Frame",SF)
Tk.Size=UDim2.new(1,-28,0,9)
Tk.Position=UDim2.new(0,14,0,54)
Tk.BackgroundColor3=Color3.fromRGB(24,22,29)
Tk.BorderSizePixel=0
Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)

local pI=math.clamp((cV-mV)/(mxV-mV),0,1)

local F=Instance.new("Frame",Tk)
F.Size=UDim2.new(pI,0,1,0)
F.BackgroundColor3=CTh.A
F.BorderSizePixel=0
Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)
table.insert(TE.Accs,F)

local K=Instance.new("Frame",Tk)
K.Size=UDim2.new(0,20,0,20)
K.AnchorPoint=Vector2.new(0.5,0.5)
K.Position=UDim2.new(pI,0,0.5,0)
K.BackgroundColor3=Color3.fromRGB(255,255,255)
K.BorderSizePixel=0
Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)

local KS=Instance.new("UIStroke",K)
KS.Color=CTh.A
KS.Thickness=2
table.insert(TE.Accs,KS)

local HB=Instance.new("TextButton",SF)
HB.Size=UDim2.fromScale(1,1)
HB.BackgroundTransparency=1
HB.Text=""
HB.AutoButtonColor=false

local dragging=false

local function updateSlider(x)
local width=math.max(Tk.AbsoluteSize.X,1)
local pX=math.clamp(x-Tk.AbsolutePosition.X,0,width)
local pc=pX/width
local vl=math.floor(mV+(mxV-mV)*pc)

F.Size=UDim2.new(pc,0,1,0)
K.Position=UDim2.new(pc,0,0.5,0)
TL.Text=n.." [ "..tostring(vl).." ]"

if ck then
HC[ck]=vl
saveC()
end

cb(vl)
end

local function inputX(ip)
if not ip then return nil end
return ip.Position and ip.Position.X
end

HB.InputBegan:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dragging=true
local x=inputX(ip)
if x then
updateSlider(x)
end
end
end)

HB.InputEnded:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

UIS.InputEnded:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

UIS.InputChanged:Connect(function(ip)
if not dragging then return end

if ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch then
local x=inputX(ip)
if x then
updateSlider(x)
end
end
end)

if ck then
IC[ck]=function()
cb(HC[ck] or cV)
end
end
end

local function cTSli(mV,mxV,cV,p,cb)
local SF=Instance.new("Frame",p)
SF.Size=UDim2.new(1,0,0,72)
SF.BackgroundColor3=Color3.fromRGB(40,37,45)
SF.BorderSizePixel=0
Instance.new("UICorner",SF).CornerRadius=UDim.new(0,10)
Instance.new("UIStroke",SF).Color=Color3.fromRGB(60,55,68)

local TL=Instance.new("TextLabel",SF)
TL.Size=UDim2.new(0.55,0,0,22)
TL.Position=UDim2.new(0,12,0,7)
TL.BackgroundTransparency=1
TL.TextColor3=Color3.fromRGB(255,255,255)
TL.Font=Enum.Font.GothamBold
TL.TextSize=13
TL.TextXAlignment=Enum.TextXAlignment.Left

local TiL=Instance.new("TextLabel",SF)
TiL.Size=UDim2.new(0.38,0,0,22)
TiL.Position=UDim2.new(0.58,0,0,7)
TiL.BackgroundTransparency=1
TiL.TextColor3=CTh.A
TiL.Font=Enum.Font.GothamBlack
TiL.TextSize=13
TiL.TextXAlignment=Enum.TextXAlignment.Right
table.insert(TE.Txs,TiL)

local RL=Instance.new("TextLabel",SF)
RL.Size=UDim2.new(1,-20,0,18)
RL.Position=UDim2.new(0,12,0,28)
RL.Text="Arraste para ajustar o horário"
RL.TextColor3=Color3.fromRGB(155,150,165)
RL.Font=Enum.Font.Gotham
RL.TextSize=10
RL.BackgroundTransparency=1
RL.TextXAlignment=Enum.TextXAlignment.Left

local Tk=Instance.new("Frame",SF)
Tk.Size=UDim2.new(1,-28,0,9)
Tk.Position=UDim2.new(0,14,0,54)
Tk.BackgroundColor3=Color3.fromRGB(24,22,29)
Tk.BorderSizePixel=0
Instance.new("UICorner",Tk).CornerRadius=UDim.new(1,0)

local pI=math.clamp((cV-mV)/(mxV-mV),0,1)

local F=Instance.new("Frame",Tk)
F.Size=UDim2.new(pI,0,1,0)
F.BackgroundColor3=CTh.A
F.BorderSizePixel=0
Instance.new("UICorner",F).CornerRadius=UDim.new(1,0)
table.insert(TE.Accs,F)

local K=Instance.new("Frame",Tk)
K.Size=UDim2.new(0,20,0,20)
K.AnchorPoint=Vector2.new(0.5,0.5)
K.Position=UDim2.new(pI,0,0.5,0)
K.BackgroundColor3=Color3.fromRGB(255,255,255)
K.BorderSizePixel=0
Instance.new("UICorner",K).CornerRadius=UDim.new(1,0)

local KS=Instance.new("UIStroke",K)
KS.Color=CTh.A
KS.Thickness=2
table.insert(TE.Accs,KS)

local function fUI(v)
v=math.clamp(v,mV,mxV)
local h=math.floor(v)
local mins=math.floor((v-h)*60)
local pt="Noite 🌙"

if h>=6 and h<13 then
pt="Dia ☀️"
elseif h>=13 and h<18 then
pt="Tarde 🌤️"
end

TL.Text="Período: "..pt
TiL.Text=string.format("%02d:%02d",h,mins)
end

fUI(cV)

local HB=Instance.new("TextButton",SF)
HB.Size=UDim2.fromScale(1,1)
HB.BackgroundTransparency=1
HB.Text=""
HB.AutoButtonColor=false

local dragging=false

local function updateSlider(x)
local width=math.max(Tk.AbsoluteSize.X,1)
local pX=math.clamp(x-Tk.AbsolutePosition.X,0,width)
local pc=pX/width
local vl=mV+(mxV-mV)*pc

F.Size=UDim2.new(pc,0,1,0)
K.Position=UDim2.new(pc,0,0.5,0)
fUI(vl)
cb(vl)
end

HB.InputBegan:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dragging=true

local x=ip.Position and ip.Position.X
if x then
updateSlider(x)
end
end
end)

HB.InputEnded:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

UIS.InputEnded:Connect(function(ip)
if ip.UserInputType==Enum.UserInputType.MouseButton1 or ip.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)

UIS.InputChanged:Connect(function(ip)
if not dragging then return end

if ip.UserInputType==Enum.UserInputType.MouseMovement or ip.UserInputType==Enum.UserInputType.Touch then
local x=ip.Position and ip.Position.X
if x then
updateSlider(x)
end
end
end)

return function(nV)
nV=math.clamp(nV,mV,mxV)
local pc=math.clamp((nV-mV)/(mxV-mV),0,1)
F.Size=UDim2.new(pc,0,1,0)
K.Position=UDim2.new(pc,0,0.5,0)
fUI(nV)
end
end

local function cEGui(tM)
local r,h=tM:FindFirstChild("HumanoidRootPart"),tM:FindFirstChildOfClass("Humanoid")
if not r or not h then return nil end

local bg=Instance.new("BillboardGui")
bg.Name,bg.Adornee,bg.Size,bg.StudsOffset,bg.AlwaysOnTop,bg.Parent="ESPGui",r,UDim2.new(0,400,0,45),Vector3.new(0,3.5,0),true,SG

local el=Instance.new("TextLabel",bg)
el.Size,el.BackgroundTransparency,el.RichText,el.TextStrokeTransparency,el.Font,el.TextSize,el.TextYAlignment=UDim2.new(1,0,1,0),1,true,0.5,Enum.Font.GothamBold,13,Enum.TextYAlignment.Center

return{Gui=bg,Humanoid=h,Root=r,Label=el,Model=tM}
end

local function cETb(tb)
for _,d in pairs(tb)do
if d.Gui then
d.Gui:Destroy()
end
end
table.clear(tb)
end

local function uESP()
if eUp then eUp:Disconnect()end
if not enOn and not epOn then return end

eUp=RS.RenderStepped:Connect(function()
local lC=LP.Character
local lR=lC and lC:FindFirstChild("HumanoidRootPart")

if epOn then
for _,p in pairs(P:GetPlayers())do
if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart")and p.Character:FindFirstChild("Humanoid")then
if isFriend(p)then continue end

if not tPly[p]or tPly[p].Model~=p.Character then
if tPly[p]and tPly[p].Gui then
tPly[p].Gui:Destroy()
end
tPly[p]=cEGui(p.Character)
end
end
end

for p,d in pairs(tPly)do
if not p or not p.Parent or not p.Character or not d.Humanoid or d.Humanoid.Health<=0 or d.Model~=p.Character or isFriend(p)then
if d.Gui then
d.Gui:Destroy()
end
tPly[p]=nil
continue
end

local hS=math.floor(d.Humanoid.Health)
local dS=lR and d.Root and tostring(math.floor((lR.Position-d.Root.Position).Magnitude))or"???"

d.Label.Text=string.format('<b><font color="%s">%s</font> | <font color="%s">HP: %s</font> | <font color="%s">%s studs</font></b>',ECol.PName,p.Name,ECol.PHP,hS,ECol.PDist,dS)
end
end

if enOn then
for m in pairs(CNPCs)do
if m.Parent and not tNPC[m]then
tNPC[m]=cEGui(m)
end
end

for m,d in pairs(tNPC)do
if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then
if d.Gui then
d.Gui:Destroy()
end
tNPC[m]=nil
continue
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

local function iHN(n)
if not n:FindFirstChild("Humanoid")or P:GetPlayerFromCharacter(n)or n.Humanoid.Health<=0 then return false end

for _,c in ipairs(n:GetChildren())do
if c:IsA("Tool")then
return true
end
end

local nm,h=string.lower(n.Name),{"zombie","enemy","boss","killer","monster","soldier","mutant","dummy","bot","hostile","demon","beast","guard","slayer","vampire","werewolf","criminal","thief","attacker","infect","scp","entity","nextbot"}

for _,v in ipairs(h)do
if string.find(nm,v)then
return true
end
end

if n.Humanoid.MaxHealth>105 and n.Humanoid.MaxHealth<math.huge then
return true
end

for _,d in ipairs(n:GetDescendants())do
if d:IsA("Script")or d:IsA("LocalScript")then
local s=string.lower(d.Name)
if string.find(s,"damage")or string.find(s,"kill")or string.find(s,"attack")then
return true
end
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

task.spawn(function()
while bg.Parent do
TS:Create(ic,TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),{TextSize=22}):Play()
break
end
end)

return{Gui=bg,Model=m,Humanoid=m:FindFirstChild("Humanoid")}
end

local function uDEsp()
if dUp then
dUp:Disconnect()
dUp=nil
end

if not dEspOn then return end

dUp=RS.Heartbeat:Connect(function()
for m in pairs(CNPCs)do
if m.Parent and not tDNPC[m]and iHN(m)then
tDNPC[m]=cDEsp(m)
end
end

for m,d in pairs(tDNPC)do
if not m or not m.Parent or not d.Humanoid or d.Humanoid.Health<=0 or not CNPCs[m]then
if d.Gui then
d.Gui:Destroy()
end
tDNPC[m]=nil
end
end
end)
end

local lightCache={}
local lightEnhanced=false

local function enhanceLights()
for _,obj in ipairs(W:GetDescendants())do
if obj:IsA("PointLight")or obj:IsA("SpotLight")or obj:IsA("SurfaceLight")then
if lightCache[obj]==nil then
lightCache[obj]={
Brightness=obj.Brightness,
Range=obj.Range,
Enabled=obj.Enabled
}
end

if obj.Enabled then
obj.Brightness=math.clamp(lightCache[obj].Brightness*1.45,0,12)
obj.Range=math.clamp(lightCache[obj].Range*1.18,0,100)
end
end
end

lightEnhanced=true
end

local function restoreLights()
for obj,data in pairs(lightCache)do
if obj and obj.Parent then
pcall(function()
obj.Brightness=data.Brightness
obj.Range=data.Range
obj.Enabled=data.Enabled
end)
end
end

table.clear(lightCache)
lightEnhanced=false
end

local function rLig()
L.FogStart,L.FogEnd,L.FogColor,L.Ambient,L.OutdoorAmbient,L.Brightness,L.GlobalShadows,L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale,L.ExposureCompensation=OL.FS,OL.FE,OL.FC,OL.A,OL.OA,OL.B,OL.GS,OL.EDS,OL.ESS,OL.EC

pcall(function()
L.ShadowSoftness,L.Technology=OL.SS,OL.T
end)

restoreLights()

if L:FindFirstChild("VortexAtmosphere")then
L.VortexAtmosphere:Destroy()
end
end

local function uLig()
if fpsOn then
if sLp then
sLp:Disconnect()
sLp=nil
end

L.EnvironmentDiffuseScale,L.EnvironmentSpecularScale,L.GlobalShadows=0,0,false

clrCE()
rLig()

elseif shOn then

L.GlobalShadows=true
L.ExposureCompensation=0.35

pcall(function()
L.Technology=Enum.Technology.Future
L.ShadowSoftness=0.08
end)

L.EnvironmentSpecularScale=1.35
L.EnvironmentDiffuseScale=1.3

enhanceLights()

if not L:FindFirstChild("VortexCC")then
local CC=Instance.new("ColorCorrectionEffect",L)
CC.Name="VortexCC"
CC.Contrast=0.22
CC.Saturation=0.38
CC.Brightness=0.045

local B=Instance.new("BloomEffect",L)
B.Name="VortexBloom"
B.Intensity=0.3
B.Size=32
B.Threshold=1

local S=Instance.new("SunRaysEffect",L)
S.Name="VortexSunRays"
S.Intensity=0.08
S.Spread=0.9

local A=Instance.new("Atmosphere",L)
A.Name="VortexAtmosphere"
A.Density=0.015
A.Offset=0.25
A.Glare=1.4
A.Haze=1
A.Color=Color3.fromRGB(205,220,255)
A.Decay=Color3.fromRGB(90,80,130)
end

local wB=L:FindFirstChild("VortexWallBlur")
if not wB then
wB=Instance.new("BlurEffect",L)
wB.Name="VortexWallBlur"
wB.Size=0
end

if not sLp then
local rP=RaycastParams.new()
rP.FilterType=Enum.RaycastFilterType.Exclude

sLp=RS.RenderStepped:Connect(function()
if pDead or fbOn then return end

local t=L.ClockTime
local n=(t>=18.2 or t<=6.2)
local c=LP.Character
local cam=W.CurrentCamera
local tB=0
local i=false

if c and cam then
rP.FilterDescendantsInstances={c,cam}

local hrp=c:FindFirstChild("HumanoidRootPart")
if hrp then
i=cInd(hrp,rP)
end

local dB=gPB(cam,c)
if dB>tB then
tB=dB
end
end

local a,oa,fs,fe,fc,ad,ac

if i then
a,oa=Color3.fromRGB(65,65,75),Color3.fromRGB(55,55,65)
local cr=Color3.fromRGB(210,220,235)

if fgOn then
fs,fe,fc,ad,ac=140,1200,cr,0.12,cr
else
fs,fe,fc,ad,ac=2000,100000,cr,0,cr
end

elseif n then
a,oa=Color3.fromRGB(28,32,52),Color3.fromRGB(22,26,42)
local cr=Color3.fromRGB(45,55,90)

if fgOn then
fs,fe,fc,ad,ac=110,2600,cr,0.18,cr
else
fs,fe,fc,ad,ac=2000,100000,cr,0,cr
end

else
a,oa=Color3.fromRGB(120,120,125),Color3.fromRGB(150,155,170)
local cr=Color3.fromRGB(215,230,255)

if fgOn then
fs,fe,fc,ad,ac=180,4200,cr,0.1,cr
else
fs,fe,fc,ad,ac=2000,100000,cr,0,cr
end
end

L.Ambient=L.Ambient:Lerp(a,0.1)
L.OutdoorAmbient=L.OutdoorAmbient:Lerp(oa,0.1)
L.FogStart=L.FogStart+(fs-L.FogStart)*0.1
L.FogEnd=L.FogEnd+(fe-L.FogEnd)*0.1
L.FogColor=L.FogColor:Lerp(fc,0.1)

local atm=L:FindFirstChild("VortexAtmosphere")
if atm then
atm.Density=atm.Density+(ad-atm.Density)*0.1
atm.Color=atm.Color:Lerp(ac,0.1)
end

local cb=L:FindFirstChild("VortexWallBlur")
if cb then
cb.Size=tB>cb.Size and tB or cb.Size+(tB-cb.Size)*0.25
end

if not lightEnhanced then
enhanceLights()
end
end)
end

else

if sLp then
sLp:Disconnect()
sLp=nil
end

clrCE()
rLig()

if fgOn then
L.FogStart,L.FogEnd,L.FogColor=100,2000,Color3.fromRGB(210,225,240)
end
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
if p.Velocity.Magnitude>1000 then
p.Velocity=Vector3.new(0,0,0)
end

if p.RotVelocity.Magnitude>1000 then
p.RotVelocity=Vector3.new(0,0,0)
end
end
end

for _,op in pairs(P:GetPlayers())do
if op~=LP and op.Character then
if isFriend(op)then continue end

for _,oprt in pairs(op.Character:GetChildren())do
if oprt:IsA("BasePart")then
oprt.CanCollide=false

if oprt.Velocity.Magnitude>100 then
oprt.Velocity=Vector3.new(0,0,0)
end

if oprt.RotVelocity.Magnitude>100 then
oprt.RotVelocity=Vector3.new(0,0,0)
end
end
end
end
end
end)
end

cST("✨ GRÁFICOS",sM)

local stU,ftU

stU=cTog("✨ Shaders",sM,shOn,function(s)
shOn=s
uLig()
end,"Shaders")

ftU=cTog("🥔 Booster FPS",sM,fpsOn,function(s)
if s and shOn then
sNotif("Erro","Desative Shaders primeiro.","Error")
fpsOn=false
if ftU then
ftU(false)
end
return
end

fpsOn=s
uLig()
end,"FpsBoost")

cTog("🌫️ Desfoque Parede",sM,wbOn,function(s)
wbOn=s
if not s then
local b=L:FindFirstChild("VortexWallBlur")
if b then
b.Size=0
end
end
end,"WallBlur")

cTog("🌫️ Neblina",sM,fgOn,function(s)
fgOn=s
uLig()
end,"Fog")

cTog("🌀 Motion Blur",sM,mbOn,function(s)
if s then
local b=Instance.new("BlurEffect",L)
b.Name="VortexMotionBlur"
b.Size=0

local c=W.CurrentCamera
if c then
lCR=c.CFrame-c.CFrame.Position
end

mbc=RS.RenderStepped:Connect(function()
local cam=W.CurrentCamera
if not cam then return end

local rot=cam.CFrame-cam.CFrame.Position
local d=rot.LookVector:Dot(lCR.LookVector)
local a=math.acos(math.clamp(d,-1,1))
local tB=math.clamp(math.deg(a)*1.5,0,30)

b.Size,lCR=b.Size+(tB-b.Size)*0.2,rot
end)

else

if mbc then
mbc:Disconnect()
mbc=nil
end

local b=L:FindFirstChild("VortexMotionBlur")
if b then
b:Destroy()
end
end
end,"MotionBlur")

cTog("☀️ Fullbright",sM,fbOn,function(s)
fbOn=s

if s then
fbLp=RS.RenderStepped:Connect(function()
L.Ambient=Color3.new(1,1,1)
L.OutdoorAmbient=Color3.new(1,1,1)
L.Brightness=2.4
L.GlobalShadows=false
L.FogEnd=100000
end)

else

if fbLp then
fbLp:Disconnect()
fbLp=nil
end

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
local l=Instance.new("PointLight",h)
l.Name="VortexPlayerLight"
l.Brightness=3.5
l.Range=65
l.Shadows=false
l.Color=Color3.fromRGB(255,255,255)
end
end
end)

else

if plc then
plc:Disconnect()
plc=nil
end

local c=LP.Character

if c and c:FindFirstChild("HumanoidRootPart")then
local l=c.HumanoidRootPart:FindFirstChild("VortexPlayerLight")
if l then
l:Destroy()
end
end
end
end,"PlayerLight")

cST("⏰ TEMPO",sM)

local uTSUI

cTog("🔄 Auto Tempo",sM,atOn,function(s)
atOn=s

if s then
atc=RS.RenderStepped:Connect(function(dt)
L.ClockTime=(L.ClockTime+(0.4*dt))%24
if uTSUI then
uTSUI(L.ClockTime)
end
end)

else

if atc then
atc:Disconnect()
atc=nil
end
end
end,"AutoTime")

uTSUI=cTSli(0,24,L.ClockTime,sM,function(v)
if not atOn then
L.ClockTime=v
end
end)

local rainLoop=nil
local rPrt=nil
local rEmt=nil

local function stpR()
if rEmt then
rEmt.Enabled=false
end
end

local function stRt()
if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart")then return end

if not rPrt then
rPrt=Instance.new("Part")
rPrt.Name="VtxRain"
rPrt.Anchored=true
rPrt.CanCollide=false
rPrt.Transparency=1
rPrt.Size=Vector3.new(150,1,150)
rPrt.Parent=W

rEmt=Instance.new("ParticleEmitter",rPrt)
rEmt.Texture="rbxassetid://2273224484"
rEmt.Rate=600
rEmt.Speed=NumberRange.new(60,80)
rEmt.Lifetime=NumberRange.new(1.5,2.5)
rEmt.EmissionDirection=Enum.NormalId.Bottom
rEmt.Size=NumberSequence.new({
NumberSequenceKeypoint.new(0,0.3),
NumberSequenceKeypoint.new(1,0.3)
})
rEmt.Color=ColorSequence.new(Color3.fromRGB(150,170,200))
rEmt.Transparency=NumberSequence.new(0.5)
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

cTog("🌧️ Chuva Aleatória (15% Chance)",sM,rrOn,function(s)
rrOn=s

if s then

rainLoop=task.spawn(function()
while rrOn do
task.wait(5)

if math.random(1,100)<=15 then
stRt()
task.wait(25)
end
end
end)

else

if rainLoop then
task.cancel(rainLoop)
rainLoop=nil
end

stpR()
end
end,"RandomRain")

cST("👁️ ESP",sE)

cTog("👤 ESP Player",sE,epOn,function(s)
epOn=s
if not s then
cETb(tPly)
end
uESP()
end,"ESPPlayer")

cTog("🤖 ESP NPC",sE,enOn,function(s)
enOn=s
if not s then
cETb(tNPC)
end
uESP()
end,"ESPNPC")

cTog("⚠️ Alerta NPC Hostil",sE,dEspOn,function(s)
dEspOn=s
if not s then
cETb(tDNPC)
end
uDEsp()
end,"DangerESP")

cST("🎨 CORES",sE)

local function cECBtn(n,c3,hc)
local b=Instance.new("TextButton",sE)
b.Size=UDim2.new(1,0,0,42)
b.BackgroundColor3=Color3.fromRGB(42,38,48)
b.Text="🎨 "..n
b.TextColor3=c3
b.Font=Enum.Font.GothamBold
b.TextSize=12
b.AutoButtonColor=false
b.BorderSizePixel=0

Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
local st=Instance.new("UIStroke",b)
st.Color=c3
st.Thickness=1

b.MouseEnter:Connect(function()
TS:Create(b,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(55,50,62)}):Play()
end)

b.MouseLeave:Connect(function()
TS:Create(b,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(42,38,48)}):Play()
end)

b.Activated:Connect(function()
ECol.PName,ECol.NName=hc,hc
end)
end

cECBtn("Branco",Color3.fromRGB(255,255,255),"#FFFFFF")
cECBtn("Amarelo",Color3.fromRGB(255,215,0),"#FFD700")
cECBtn("Roxo",Color3.fromRGB(176,38,255),"#B026FF")
cECBtn("Verde",Color3.fromRGB(50,205,50),"#32CD32")
cECBtn("Rosa",Color3.fromRGB(255,20,147),"#FF1493")

cST("👤 MODS",sP)

cTog("🌀 TeleportTool",sP,ttOn,function(s)
ttOn=s

if s then
gTT()
else
rTT()
end
end,"TeleportTool")

cTog("⚡ Instant Interact",sP,iiOn,function(s)
iiOn=s

if s then

for _,p in pairs(W:GetDescendants())do
if p:IsA("ProximityPrompt")then
p.HoldDuration=0
end
end

iic=PPS.PromptShown:Connect(function(p)
p.HoldDuration=0
end)

else

if iic then
iic:Disconnect()
iic=nil
end
end
end,"InstantInteract")

cTog("⚡ Mods Player",sP,pmOn,function(s)
pmOn=s

if s then

pmc=RS.Stepped:Connect(function()
if W.CurrentCamera then
W.CurrentCamera.FieldOfView=pFov
end

local c=LP.Character

if c then
local h=c:FindFirstChildOfClass("Humanoid")

if h then
h.UseJumpPower=true

if h.WalkSpeed~=pSpd then
h.WalkSpeed=pSpd
end

if h.JumpPower~=pJmp then
h.JumpPower=pJmp
end
end
end
end)

else

if pmc then
pmc:Disconnect()
pmc=nil
end

local c=LP.Character

if c and c:FindFirstChildOfClass("Humanoid")then
c.Humanoid.WalkSpeed=16
c.Humanoid.JumpPower=50
end

if W.CurrentCamera then
W.CurrentCamera.FieldOfView=70
end
end
end,"PlayerMods")

cTog("⚡ No Cooldown (Instantâneo)",sP,ncOn,function(s)
ncOn=s

if s then

ncc=RS.Stepped:Connect(function()
local c=LP.Character

if c then
for _,t in ipairs(c:GetChildren())do
if t:IsA("Tool")then

t.Enabled=true

pcall(function()

if t.Cooldown then
t.Cooldown=0
end

for _,v in ipairs(t:GetDescendants())do
if v:IsA("NumberValue")or v:IsA("IntValue")then

local ln=string.lower(v.Name)

if string.find(ln,"cooldown")
or string.find(ln,"cd")
or string.find(ln,"time")
or string.find(ln,"delay")then

v.Value=0
end
end
end
end)
end
end
end

if LP:FindFirstChild("Backpack")then

for _,t in ipairs(LP.Backpack:GetChildren())do
if t:IsA("Tool")then

t.Enabled=true

pcall(function()

if t.Cooldown then
t.Cooldown=0
end

for _,v in ipairs(t:GetDescendants())do
if v:IsA("NumberValue")or v:IsA("IntValue")then

local ln=string.lower(v.Name)

if string.find(ln,"cooldown")
or string.find(ln,"cd")
or string.find(ln,"time")
or string.find(ln,"delay")then

v.Value=0
end
end
end
end)
end
end
end
end)

else

if ncc then
ncc:Disconnect()
ncc=nil
end
end
end,"NoCooldown")

cTog("🚀 Inf Jump",sP,ijOn,function(s)
ijOn=s

if s then

ijc=UIS.JumpRequest:Connect(function()
local c=LP.Character

if c then
local h=c:FindFirstChildOfClass("Humanoid")

if h then
h:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
end)

else

if ijc then
ijc:Disconnect()
ijc=nil
end
end
end,"InfJump")

cTog("👻 Noclip",sP,nclOn,function(s)
nclOn=s

if s then
startNcl()
else
stopNcl()
end
end,"Noclip")

cSli("🏃 WalkSpeed","16 a 50",16,200,pSpd,sP,function(v)
pSpd=v

if pmOn then
local c=LP.Character

if c and c:FindFirstChildOfClass("Humanoid")then
c.Humanoid.WalkSpeed=v
end
end
end,"WalkSpeed")

cSli("🦘 JumpPower","50 a 100",50,300,pJmp,sP,function(v)
pJmp=v

if pmOn then
local c=LP.Character

if c and c:FindFirstChildOfClass("Humanoid")then
c.Humanoid.JumpPower=v
end
end
end,"JumpPower")

cSli("🔭 FOV","70 a 90",70,120,pFov,sP,function(v)
pFov=v
end,"FOV")

local izCn,izMenu,izToggle=nil,nil,nil
local izMode="Normal"
local izSavedMaxZoom=nil
local izSavedMinZoom=nil
local izSavedOcclusion=nil
local izActive=false
local IZMax=1000000
local izGuard=false
local izWallParts={}

local function clearIZWalls()
for part in pairs(izWallParts)do
if part and part.Parent then
pcall(function()
part.LocalTransparencyModifier=0
end)
end
end
table.clear(izWallParts)
end

local function closeIZMenu()
if izMenu then
izMenu:Destroy()
izMenu=nil
end
end

local function restoreIZ()
if izCn then
izCn:Disconnect()
izCn=nil
end

clearIZWalls()

if izSavedMaxZoom~=nil then
pcall(function()
LP.CameraMaxZoomDistance=izSavedMaxZoom
end)
end

if izSavedMinZoom~=nil then
pcall(function()
LP.CameraMinZoomDistance=izSavedMinZoom
end)
end

if izSavedOcclusion~=nil then
pcall(function()
LP.DevCameraOcclusionMode=izSavedOcclusion
end)
end

izSavedMaxZoom=nil
izSavedMinZoom=nil
izSavedOcclusion=nil
end

local function disableIZ()
izActive=false
closeIZMenu()
restoreIZ()
izMode="Normal"
end

local function applyIZ(mode)
if not izActive then
izSavedMaxZoom=LP.CameraMaxZoomDistance
izSavedMinZoom=LP.CameraMinZoomDistance
izSavedOcclusion=LP.DevCameraOcclusionMode
end

izMode=mode
izActive=true
closeIZMenu()

pcall(function()
izGuard=true
LP.CameraMinZoomDistance=0.5
LP.CameraMaxZoomDistance=IZMax

if mode=="Walls" then
LP.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Invisicam
else
LP.DevCameraOcclusionMode=Enum.DevCameraOcclusionMode.Zoom
end

izGuard=false
end)

if izCn then
izCn:Disconnect()
izCn=nil
end

local maxCn=LP:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
if not izActive or izGuard then return end

if LP.CameraMaxZoomDistance~=IZMax then
izGuard=true
pcall(function()
LP.CameraMaxZoomDistance=IZMax
end)
izGuard=false
end
end)

local minCn=LP:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()
if not izActive or izGuard then return end

if LP.CameraMinZoomDistance~=0.5 then
izGuard=true
pcall(function()
LP.CameraMinZoomDistance=0.5
end)
izGuard=false
end
end)

local occlCn=LP:GetPropertyChangedSignal("DevCameraOcclusionMode"):Connect(function()
if not izActive or izGuard then return end

local wanted=izMode=="Walls"and Enum.DevCameraOcclusionMode.Invisicam or Enum.DevCameraOcclusionMode.Zoom

if LP.DevCameraOcclusionMode~=wanted then
izGuard=true

pcall(function()
LP.DevCameraOcclusionMode=wanted
end)

izGuard=false
end
end)

local wallCn

if mode=="Walls" then

local rp=RaycastParams.new()
rp.FilterType=Enum.RaycastFilterType.Exclude

wallCn=RS.RenderStepped:Connect(function()
if not izActive or izMode~="Walls" then return end

local cam=W.CurrentCamera
local char=LP.Character

if not cam or not char then return end

rp.FilterDescendantsInstances={char,cam}

clearIZWalls()

local origin=cam.CFrame.Position
local target=char:FindFirstChild("Head")or char:FindFirstChild("HumanoidRootPart")

if not target then return end

local direction=target.Position-origin
local distance=direction.Magnitude

if distance<=1 then return end

local currentOrigin=origin
local remaining=direction

for i=1,5 do

local hit=W:Raycast(
currentOrigin,
remaining,
rp
)

if not hit then
break
end

local part=hit.Instance

if part
and part:IsA("BasePart")
and part.CanCollide
and part.Transparency<0.95 then

pcall(function()
part.LocalTransparencyModifier=1
end)

izWallParts[part]=true

currentOrigin=hit.Position+direction.Unit*0.05
remaining=target.Position-currentOrigin

if remaining.Magnitude<=1 then
break
end

else
break
end
end
end)

else
wallCn=nil
end

izCn={
Disconnect=function()
pcall(function()
maxCn:Disconnect()
end)

pcall(function()
minCn:Disconnect()
end)

pcall(function()
occlCn:Disconnect()
end)

pcall(function()
if wallCn then
wallCn:Disconnect()
end
end)
end
}

sNotif("Infinite Zoom",mode=="Walls"and"Modo Atravessa Paredes ativado."or"Modo Normal ativado.","Success")
end

local function styledIZButton(parent,text,sub,y)
local B=Instance.new("TextButton",parent)
B.Size=UDim2.new(1,-32,0,62)
B.Position=UDim2.new(0,16,0,y)
B.BackgroundColor3=Color3.fromRGB(37,32,45)
B.BorderSizePixel=0
B.Text=""
B.AutoButtonColor=false
B.ZIndex=61

Instance.new("UICorner",B).CornerRadius=UDim.new(0,12)

local st=Instance.new("UIStroke",B)
st.Color=Color3.fromRGB(70,60,82)
st.Thickness=1.5

local icon=Instance.new("TextLabel",B)
icon.Size=UDim2.new(0,46,1,0)
icon.Position=UDim2.new(0,8,0,0)
icon.BackgroundTransparency=1
icon.Text=string.sub(text,1,2)
icon.TextColor3=CTh.A
icon.Font=Enum.Font.GothamBlack
icon.TextSize=22
icon.ZIndex=62

local title=Instance.new("TextLabel",B)
title.Size=UDim2.new(1,-70,0,24)
title.Position=UDim2.new(0,58,0,8)
title.BackgroundTransparency=1
title.Text=text
title.TextColor3=Color3.fromRGB(255,255,255)
title.Font=Enum.Font.GothamBlack
title.TextSize=13
title.TextXAlignment=Enum.TextXAlignment.Left
title.ZIndex=62

local desc=Instance.new("TextLabel",B)
desc.Size=UDim2.new(1,-70,0,20)
desc.Position=UDim2.new(0,58,0,33)
desc.BackgroundTransparency=1
desc.Text=sub
desc.TextColor3=Color3.fromRGB(160,155,170)
desc.Font=Enum.Font.Gotham
desc.TextSize=10
desc.TextXAlignment=Enum.TextXAlignment.Left
desc.ZIndex=62

B.MouseEnter:Connect(function()
TS:Create(B,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(52,42,62)}):Play()
TS:Create(st,TweenInfo.new(0.15),{Color=CTh.A,Thickness=2}):Play()
end)

B.MouseLeave:Connect(function()
TS:Create(B,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(37,32,45)}):Play()
TS:Create(st,TweenInfo.new(0.15),{Color=Color3.fromRGB(70,60,82),Thickness=1.5}):Play()
end)

return B
end

local function showIZMenu()
closeIZMenu()

local F=Instance.new("Frame",SG)
izMenu=F
F.Name="InfiniteZoomChoice"
F.Size=UDim2.new(0,370,0,300)
F.Position=UDim2.new(0.5,-185,0.5,-150)
F.BackgroundColor3=Color3.fromRGB(19,15,25)
F.BackgroundTransparency=0.02
F.BorderSizePixel=0
F.ZIndex=60
F.Active=true

Instance.new("UICorner",F).CornerRadius=UDim.new(0,16)

local fs=Instance.new("UIStroke",F)
fs.Color=CTh.A
fs.Thickness=2
fs.Transparency=0.12

addGradient(F,Color3.fromRGB(34,20,44),Color3.fromRGB(15,13,20),90)

local top=Instance.new("Frame",F)
top.Size=UDim2.new(1,0,0,72)
top.BackgroundTransparency=1
top.ZIndex=61

local ico=Instance.new("TextLabel",top)
ico.Size=UDim2.new(0,50,0,50)
ico.Position=UDim2.new(0,16,0,11)
ico.BackgroundColor3=Color3.fromRGB(45,25,58)
ico.Text="🔭"
ico.TextSize=25
ico.Font=Enum.Font.GothamBlack
ico.TextColor3=CTh.A
ico.ZIndex=62
Instance.new("UICorner",ico).CornerRadius=UDim.new(0,12)

local title=Instance.new("TextLabel",top)
title.Size=UDim2.new(1,-90,0,28)
title.Position=UDim2.new(0,78,0,12)
title.BackgroundTransparency=1
title.Text="INFINITE ZOOM"
title.TextColor3=Color3.fromRGB(255,255,255)
title.Font=Enum.Font.GothamBlack
title.TextSize=18
title.TextXAlignment=Enum.TextXAlignment.Left
title.ZIndex=62

local sub=Instance.new("TextLabel",top)
sub.Size=UDim2.new(1,-90,0,20)
sub.Position=UDim2.new(0,78,0,38)
sub.BackgroundTransparency=1
sub.Text="Escolha o modo da câmera"
sub.TextColor3=Color3.fromRGB(165,160,175)
sub.Font=Enum.Font.Gotham
sub.TextSize=10
sub.TextXAlignment=Enum.TextXAlignment.Left
sub.ZIndex=62

local X=Instance.new("TextButton",F)
X.Size=UDim2.new(0,34,0,34)
X.Position=UDim2.new(1,-46,0,11)
X.BackgroundColor3=Color3.fromRGB(35,30,42)
X.Text="×"
X.TextColor3=Color3.fromRGB(220,215,225)
X.Font=Enum.Font.GothamBlack
X.TextSize=22
X.AutoButtonColor=false
X.ZIndex=63
Instance.new("UICorner",X).CornerRadius=UDim.new(0,10)

local normal=styledIZButton(F,"🔭  Normal","Zoom máximo sem atravessar paredes.",82)
local walls=styledIZButton(F,"🧱  Atravessa Paredes","Oculta obstáculos para liberar a visão da câmera.",154)

local info=Instance.new("TextLabel",F)
info.Size=UDim2.new(1,-32,0,30)
info.Position=UDim2.new(0,16,1,-40)
info.BackgroundTransparency=1
info.Text="⚡ Até "..tostring(IZMax).." de distância"
info.TextColor3=Color3.fromRGB(155,150,165)
info.Font=Enum.Font.GothamBold
info.TextSize=10
info.TextXAlignment=Enum.TextXAlignment.Center
info.ZIndex=62

normal.Activated:Connect(function()
applyIZ("Normal")
end)

walls.Activated:Connect(function()
applyIZ("Walls")
end)

X.Activated:Connect(function()
if izToggle then
izToggle(false)
end
end)
end

izToggle=cTog("🔭 Infinite Zoom",sP,false,function(s)
if s then
showIZMenu()
else
disableIZ()
end
end,nil)

cST("🛡️ PROTEÇÃO",sPr)

cTog("🛡️ Anti-Fling",sPr,afOn,function(s)
afOn=s

if s then
eAF()
else
if afc then
afc:Disconnect()
afc=nil
end
end
end,"AntiFling")

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

if hu.FloorMaterial~=Enum.Material.Air then
lSCf=h.CFrame
end

local hD=W:Raycast(h.Position,Vector3.new(0,-2500,0),rp)
local hU=W:Raycast(h.Position,Vector3.new(0,2500,0),rp)

if not hD and not hU and h.Position.Y<-50 then

h.AssemblyLinearVelocity=Vector3.new(0,0,0)
h.AssemblyAngularVelocity=Vector3.new(0,0,0)

pcall(function()
h.Velocity=Vector3.new(0,0,0)
h.RotVelocity=Vector3.new(0,0,0)
end)

local sCF

if lSCf and lSCf.Position.Y>-20 then
sCF=lSCf+Vector3.new(0,3,0)
end

if not sCF then
local sl=W:FindFirstChildWhichIsA("SpawnLocation",true)

if sl then
sCF=sl.CFrame+Vector3.new(0,5,0)
end
end

if not sCF then
local cr=W:Raycast(Vector3.new(0,500,0),Vector3.new(0,-1000,0),rp)

if cr and cr.Position then
sCF=CFrame.new(cr.Position+Vector3.new(0,5,0))
end
end

if not sCF then
sCF=CFrame.new(0,50,0)
end

h.CFrame=sCF

sNotif("🛡️","Salvo do Void!","Success")
end
end)

else

if avc then
avc:Disconnect()
avc=nil
end
end
end,"AntiVoid")

cTog("🚫 Anti-AFK",sPr,aaOn,function(s)
aaOn=s

if s then

aac=LP.Idled:Connect(function()
VU:CaptureController()
VU:ClickButton2(Vector2.new())
end)

else

if aac then
aac:Disconnect()
aac=nil
end
end
end,"AntiAfk")

cTog("🔄 Auto-Rejoin (Anti-Disconnect)",sPr,arOn,function(s)
arOn=s

if s then

arc=GuiService.ErrorMessageChanged:Connect(function()
task.wait(1.5)
game:GetService("TeleportService"):Teleport(game.PlaceId,LP)
end)

else

if arc then
arc:Disconnect()
arc=nil
end
end
end,"AutoRejoin")

local function cTBtn(n,mc,tc,ac,tk)
local b=Instance.new("TextButton",sTh)
b.Size=UDim2.new(1,0,0,46)
b.BackgroundColor3=Color3.fromRGB(42,38,48)
b.Text="🎨 "..n
b.TextColor3=ac
b.Font=Enum.Font.GothamBold
b.TextSize=13
b.AutoButtonColor=false
b.BorderSizePixel=0

Instance.new("UICorner",b).CornerRadius=UDim.new(0,10)

local st=Instance.new("UIStroke",b)
st.Color=ac
st.Thickness=1.3

b.MouseEnter:Connect(function()
TS:Create(b,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(55,49,62)}):Play()
end)

b.MouseLeave:Connect(function()
TS:Create(b,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(42,38,48)}):Play()
end)

b.Activated:Connect(function()
appT(mc,tc,ac,tk)
end)
end

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

cTog("🛡️ Whitelist de Amigos",sV,wlOn,function(s)
wlOn=s
if uPL then
uPL()
end
uESP()
end,"Whitelist")

local sPly=nil

local TgtF=Instance.new("Frame",sV)
TgtF.Size=UDim2.new(1,0,0,54)
TgtF.BackgroundTransparency=1

local TarImg=Instance.new("ImageLabel",TgtF)
TarImg.Size=UDim2.new(0,44,0,44)
TarImg.Position=UDim2.new(0,10,0.5,-22)
TarImg.BackgroundColor3=Color3.fromRGB(30,30,35)
TarImg.BorderSizePixel=0
TarImg.ClipsDescendants=true
Instance.new("UICorner",TarImg).CornerRadius=UDim.new(1,0)

local TarImgSk=Instance.new("UIStroke",TarImg)
TarImgSk.Color=CTh.A
TarImgSk.Thickness=2
table.insert(TE.Accs,TarImgSk)

local TarL=Instance.new("TextLabel",TgtF)
TarL.Size=UDim2.new(1,-70,1,0)
TarL.Position=UDim2.new(0,62,0,0)
TarL.BackgroundTransparency=1
TarL.Text="Alvo Atual: Nenhum"
TarL.TextColor3=CTh.A
TarL.Font=Enum.Font.GothamBlack
TarL.TextSize=14
TarL.TextXAlignment=Enum.TextXAlignment.Left
table.insert(TE.Txs,TarL)

local SBF=Instance.new("Frame",sV)
SBF.Size=UDim2.new(1,0,0,40)
SBF.BackgroundColor3=Color3.fromRGB(35,31,41)
SBF.BorderSizePixel=0
Instance.new("UICorner",SBF).CornerRadius=UDim.new(0,10)
Instance.new("UIStroke",SBF).Color=Color3.fromRGB(58,52,66)

local SIc=Instance.new("TextLabel",SBF)
SIc.Size=UDim2.new(0,35,1,0)
SIc.BackgroundTransparency=1
SIc.Text="🔎"
SIc.TextSize=16

local SInp=Instance.new("TextBox",SBF)
SInp.Size=UDim2.new(1,-42,1,0)
SInp.Position=UDim2.new(0,36,0,0)
SInp.BackgroundTransparency=1
SInp.Text=""
SInp.PlaceholderText="Pesquisar jogador..."
SInp.TextColor3=Color3.fromRGB(255,255,255)
SInp.PlaceholderColor3=Color3.fromRGB(130,125,140)
SInp.Font=Enum.Font.Gotham
SInp.TextSize=13
SInp.TextXAlignment=Enum.TextXAlignment.Left

local PLF=Instance.new("ScrollingFrame",sV)
PLF.Size=UDim2.new(1,0,0,190)
PLF.BackgroundColor3=Color3.fromRGB(29,26,34)
PLF.BorderSizePixel=0
PLF.ScrollBarThickness=4
PLF.ScrollBarImageColor3=CTh.A
Instance.new("UICorner",PLF).CornerRadius=UDim.new(0,10)

local UIL=Instance.new("UIListLayout",PLF)
UIL.Padding=UDim.new(0,6)
UIL.HorizontalAlignment=Enum.HorizontalAlignment.Center
UIL.SortOrder=Enum.SortOrder.Name

UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
PLF.CanvasSize=UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y+10)
end)

local pBD={}

uPL=function()

for _,d in pairs(pBD)do
if d.Btn then
d.Btn:Destroy()
end
end

table.clear(pBD)

local f=string.lower(SInp.Text or"")

for _,p in ipairs(P:GetPlayers())do

if p~=LP then

if isFriend(p)then continue end

local b=Instance.new("TextButton",PLF)
b.Size=UDim2.new(1,-12,0,52)
b.BackgroundColor3=Color3.fromRGB(42,38,48)
b.Text=""
b.AutoButtonColor=false
b.BorderSizePixel=0

Instance.new("UICorner",b).CornerRadius=UDim.new(0,9)
Instance.new("UIStroke",b).Color=Color3.fromRGB(62,56,70)

local avI=Instance.new("ImageLabel",b)
avI.Size=UDim2.new(0,36,0,36)
avI.Position=UDim2.new(0,8,0.5,-18)
avI.BackgroundTransparency=1
avI.BorderSizePixel=0
Instance.new("UICorner",avI).CornerRadius=UDim.new(1,0)

task.spawn(function()
local s,r=pcall(function()
return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)
end)

if s and r and avI.Parent then
avI.Image=r
end
end)

local nm=Instance.new("TextLabel",b)
nm.Size=UDim2.new(1,-65,0,21)
nm.Position=UDim2.new(0,56,0,6)
nm.BackgroundTransparency=1
nm.Text=p.DisplayName
nm.TextColor3=Color3.fromRGB(255,255,255)
nm.Font=Enum.Font.GothamBold
nm.TextSize=12
nm.TextXAlignment=Enum.TextXAlignment.Left

local un=Instance.new("TextLabel",b)
un.Size=UDim2.new(1,-65,0,18)
un.Position=UDim2.new(0,56,0,27)
un.BackgroundTransparency=1
un.Text="@"..p.Name
un.TextColor3=Color3.fromRGB(160,155,170)
un.Font=Enum.Font.Gotham
un.TextSize=10
un.TextXAlignment=Enum.TextXAlignment.Left

b.Activated:Connect(function()
sPly=p
TarL.Text="Alvo Atual: "..p.DisplayName

sNotif("Alvo","Selecionado: "..p.Name,"Info")

task.spawn(function()
local s,r=pcall(function()
return P:GetUserThumbnailAsync(p.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size150x150)
end)

if s and r and TarImg.Parent then
TarImg.Image=r
end
end)
end)

table.insert(pBD,{Btn=b,Player=p})

local pn,pd=string.lower(p.Name),string.lower(p.DisplayName)

if f==""or string.find(pn,f)or string.find(pd,f)then
b.Visible=true
else
b.Visible=false
end
end
end
end

SInp:GetPropertyChangedSignal("Text"):Connect(uPL)
P.PlayerAdded:Connect(uPL)

P.PlayerRemoving:Connect(function(p)

if sPly==p then
sPly=nil
TarL.Text="Alvo Atual: Nenhum"
TarImg.Image=""
end

uPL()
end)

uPL()

cST("⚙️ AÇÕES DO ALVO",sV)

local function cAB(n,p,cb)
local B=Instance.new("TextButton",p)
B.Size=UDim2.new(1,0,0,44)
B.BackgroundColor3=Color3.fromRGB(42,38,48)
B.Text=n
B.TextColor3=Color3.fromRGB(255,255,255)
B.Font=Enum.Font.GothamBold
B.TextSize=12
B.AutoButtonColor=false
B.BorderSizePixel=0

Instance.new("UICorner",B).CornerRadius=UDim.new(0,10)

local st=Instance.new("UIStroke",B)
st.Color=Color3.fromRGB(62,56,70)
st.Thickness=1

B.MouseEnter:Connect(function()
TS:Create(B,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(55,49,62)}):Play()
TS:Create(st,TweenInfo.new(0.12),{Color=CTh.A}):Play()
end)

B.MouseLeave:Connect(function()
TS:Create(B,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(42,38,48)}):Play()
TS:Create(st,TweenInfo.new(0.12),{Color=Color3.fromRGB(62,56,70)}):Play()
end)

B.Activated:Connect(function()
if sPly then
cb(sPly)
else
sNotif("Aviso","Selecione um jogador na lista acima primeiro!","Error")
end
end)
end

cAB("🚀 Teleport",sV,function(t)
if t.Character and t.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then

LP.Character.HumanoidRootPart.CFrame=t.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)

sNotif("Teleport","Teleportado para "..t.Name,"Success")
end
end)

local vCn

cTog("👁️ View (Spectate)",sV,false,function(s)

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

local lgCn

cTog("🔁 Loopgoto",sV,false,function(s)

if s then

if not sPly then
sNotif("Aviso","Selecione um jogador!","Error")
return
end

if lgCn then
lgCn:Disconnect()
end

lgCn=RS.Heartbeat:Connect(function()

if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then

LP.Character.HumanoidRootPart.CFrame=sPly.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)

end
end)

else

if lgCn then
lgCn:Disconnect()
lgCn=nil
end
end
end,nil)

local fCn

cTog("🏃 Follow Player",sV,false,function(s)

if s then

if not sPly then
sNotif("Aviso","Selecione um jogador!","Error")
return
end

if fCn then
fCn:Disconnect()
end

fCn=RS.Heartbeat:Connect(function()

if sPly and sPly.Character and sPly.Character:FindFirstChild("HumanoidRootPart")and LP.Character and LP.Character:FindFirstChild("Humanoid")then

LP.Character:FindFirstChildOfClass("Humanoid"):MoveTo(sPly.Character.HumanoidRootPart.Position)

end
end)

else

if fCn then
fCn:Disconnect()
fCn=nil
end
end
end,nil)

local hpCn,hpOrigCF

cTog("🐶 Headpet",sV,false,function(s)

if s then

if not sPly then
sNotif("Aviso","Selecione um jogador!","Error")
return
end

local c=LP.Character

if c and c:FindFirstChild("HumanoidRootPart")then
hpOrigCF=c.HumanoidRootPart.CFrame
end

if hpCn then
hpCn:Disconnect()
end

hpCn=RS.RenderStepped:Connect(function()

if sPly and sPly.Character and sPly.Character:FindFirstChild("Head")and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then

local hrp=LP.Character.HumanoidRootPart
local hum=LP.Character:FindFirstChildOfClass("Humanoid")
local targetHead=sPly.Character.Head

if hum then
hum.PlatformStand=true
end

hrp.CFrame=targetHead.CFrame*CFrame.new(0,1.15,0)
hrp.AssemblyLinearVelocity=Vector3.new(0,0,0)
hrp.AssemblyAngularVelocity=Vector3.new(0,0,0)

end
end)

sNotif("Headpet","Ativado no alvo: "..sPly.Name,"Info")

else

if hpCn then
hpCn:Disconnect()
hpCn=nil
end

if LP.Character then

local hum=LP.Character:FindFirstChildOfClass("Humanoid")

if hum then
hum.PlatformStand=false
end
end

if hpOrigCF and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then
LP.Character.HumanoidRootPart.CFrame=hpOrigCF
end

sNotif("Headpet","Desativado.","Info")
end
end,nil)

cAB("📋 Copiar Username",sV,function(t)

if setclipboard then
setclipboard(t.Name)
sNotif("Copiado","Username ("..t.Name..") copiado!","Success")
else
sNotif("Erro","Seu executor não suporta setclipboard.","Error")
end
end)

cAB("📋 Copiar ID",sV,function(t)

if setclipboard then
setclipboard(tostring(t.UserId))
sNotif("Copiado","ID ("..tostring(t.UserId)..") copiado!","Success")
else
sNotif("Erro","Seu executor não suporta setclipboard.","Error")
end
end)

cAB("📋 Copiar Name",sV,function(t)

if setclipboard then
setclipboard(t.DisplayName)
sNotif("Copiado","Display Name ("..t.DisplayName..") copiado!","Success")
else
sNotif("Erro","Seu executor não suporta setclipboard.","Error")
end
end)

task.spawn(function()

if not LP.Character then
LP.CharacterAdded:Wait()
end

task.wait(0.5)

local sT=HC.SelectedTheme

if sT=="Vampiro"then
appT(Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50))
elseif sT=="Tóxico"then
appT(Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100))
elseif sT=="Ametista"then
appT(Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182))
elseif sT=="Ouro"then
appT(Color3.fromRGB(40,35,20),Color3.fromRGB(30,25,10),Color3.fromRGB(241,196,15))
elseif sT=="Sakura"then
appT(Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204))
elseif sT=="Neon"then
appT(Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255))
elseif sT=="Magma"then
appT(Color3.fromRGB(40,20,10),Color3.fromRGB(30,10,5),Color3.fromRGB(230,126,34))
elseif sT=="Cyberpunk"then
appT(Color3.fromRGB(20,20,25),Color3.fromRGB(15,15,20),Color3.fromRGB(255,255,0))
elseif sT=="Oceano"then
appT(Color3.fromRGB(10,25,40),Color3.fromRGB(5,15,30),Color3.fromRGB(0,190,255))
elseif sT=="Inferno"then
appT(Color3.fromRGB(25,5,5),Color3.fromRGB(15,0,0),Color3.fromRGB(255,80,0))
elseif sT=="Fantasma"then
appT(Color3.fromRGB(45,45,50),Color3.fromRGB(35,35,40),Color3.fromRGB(220,220,230))
elseif sT=="Floresta"then
appT(Color3.fromRGB(15,30,15),Color3.fromRGB(10,20,10),Color3.fromRGB(100,255,100))
end

for _,iF in pairs(IC)do
pcall(function()
iF()
end)
end

uLig()

if ttOn then
task.delay(0.5,function()
if LP.Character and LP:FindFirstChild("Backpack")then
gTT()
end
end)
end

if nclOn then
task.delay(0.5,function()
if LP.Character then
startNcl()
end
end)
end
end)
