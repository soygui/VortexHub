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
    if tT then pcall(function() tT:Destroy() end) tT=nil end 
    if LP:FindFirstChild("Backpack")then local b=LP.Backpack:FindFirstChild("TeleportTool")if b then pcall(function() b:Destroy() end) end end 
    if LP.Character then local c=LP.Character:FindFirstChild("TeleportTool")if c then pcall(function() c:Destroy() end) end end 
end
local function gTT()
    rTT()if not ttOn then return end 
    local T=Instance.new("Tool")T.Name,T.RequiresHandle,T.CanBeDropped="TeleportTool",false,false 
    T.Activated:Connect(function()local m=LP:GetMouse()if m and m.Hit and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then LP.Character.HumanoidRootPart.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0))sNotif("✨","Teleporte realizado!","Success")end end)
    local bp=LP:WaitForChild("Backpack",3)if bp then T.Parent=bp tT=T end 
end

-- [SISTEMA DE VERIFICAÇÃO RIGOROSA DE POÇÃO] --
local function isHealthPotionStrict(name, parentName)
    local n = string.lower(name or "")
    local p = string.lower(parentName or "")
    local hasHealth = string.find(n, "health") or string.find(n, "heal") or string.find(n, "vida") or string.find(n, "hp") or string.find(n, "poção") or string.find(n, "pocao") or string.find(n, "cura") or string.find(n, "potion") or string.find(n, "remedy") or
                      string.find(p, "health") or string.find(p, "heal") or string.find(p, "vida") or string.find(p, "hp") or string.find(p, "poção") or string.find(p, "pocao") or string.find(p, "cura") or string.find(p, "potion") or string.find(p, "remedy")
    local isExcluded = string.find(n, "fire") or string.find(n, "speed") or string.find(n, "jump") or string.find(n, "sword") or string.find(n, "rainbow") or string.find(n, "carpet") or string.find(n, "launcher") or string.find(n, "spellbook") or string.find(n, "bat") or string.find(n, "rocket") or string.find(n, "thunder") or string.find(n, "moto") or
                       string.find(p, "fire") or string.find(p, "speed") or string.find(p, "
