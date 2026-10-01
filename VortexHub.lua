-- ═══════════════════════════════════════════════════════
-- VORTEX HUB V19 - SUPREME EDITION
-- Sistema de Idiomas, Anti-Staff, Freecam, Tracers, etc
-- ═══════════════════════════════════════════════════════

local CoreGui=game:GetService("CoreGui")
local Players=game:GetService("Players")
local Lighting=game:GetService("Lighting")
local Workspace=game:GetService("Workspace")
local TweenService=game:GetService("TweenService")
local UserInputService=game:GetService("UserInputService")
local RunService=game:GetService("RunService")
local VirtualUser=game:GetService("VirtualUser")
local ProximityPromptService=game:GetService("ProximityPromptService")
local HttpService=game:GetService("HttpService")
local TeleportService=game:GetService("TeleportService")
local LocalPlayer=Players.LocalPlayer
local TargetParent=(gethui and gethui())or CoreGui
if TargetParent:FindFirstChild("VortexGraphicsHub")then TargetParent.VortexGraphicsHub:Destroy()end

-- ═══ CONFIG ═══
local SaveFileName="VortexHub_Config.json"
local HubConfig={Shaders=false,FpsBoost=false,WallBlur=true,Fog=false,MotionBlur=false,Fullbright=false,PlayerLight=false,AutoTime=false,ESPPlayer=false,ESPNPC=false,DangerESP=false,ItemESP=false,Chams=false,Tracers=false,XRay=false,TeleportTool=false,InstantInteract=false,PlayerMods=false,NoCooldown=false,InfJump=false,Noclip=false,NoclipRaycast=false,Freecam=false,MaxZoom=false,WalkSpeed=16,JumpPower=50,FOV=70,AntiFling=false,AntiVoid=false,AntiAfk=false,Notifications=true,JoinLogs=false,ChatLogs=false,StaffDetector=false,AutoLeave=false,ChatCommands=false,MemoryCleaner=false,LowGraphics=false,RealFPSBoost=false,TargetInfo=false,PlayerInspector=false,SelectedTheme="Orion"}

local function saveConfig()pcall(function()if writefile then writefile(SaveFileName,HttpService:JSONEncode(HubConfig))end end)end
local function loadConfig()pcall(function()if readfile and isfile and isfile(SaveFileName)then local d=HttpService:JSONDecode(readfile(SaveFileName))if type(d)=="table"then for k,v in pairs(d)do if HubConfig[k]~=nil then HubConfig[k]=v end end end end end)end
loadConfig()

-- ═══ SISTEMA DE IDIOMA ═══
local SelectedLanguage="pt"
pcall(function()if readfile and isfile and isfile("VortexHub_Lang.txt")then local l=readfile("VortexHub_Lang.txt")if l=="en"or l=="pt"then SelectedLanguage=l end end end)

local Trans={
pt={title="🌍 Selecione o Idioma",pt="🇧🇷 Português",en="🇺🇸 English",
tab_main="🔧 Principal",tab_esp="👁️ ESPS",tab_player="👤 Player",tab_prot="🛡️ Proteção",tab_hist="📜 Logs",tab_theme="🎨 Temas",tab_view="👀 Viewer",tab_stats="📊 Stats",tab_opt="⚡ Otimização",tab_sec="🔒 Anti-Staff",tab_remote="🎮 Controle",
chams="✨ Chams",tracers="📏 Tracers",item_esp="📦 Item ESP",xray="👁️ X-Ray",freecam="🎥 Freecam",maxzoom="🔍 Max Zoom",target_info="📊 Info do Alvo",inspector="🔎 Inspector",
joinlog="📥 JoinLogs",chatlog="💬 ChatLogs",confirm_title="Tem Certeza?",yes="✅ Sim",no="❌ Não",warn="Você perderá o histórico anterior!",
staff="🚨 Detector Staff",autoleave="🚪 Auto-Leave",chatcmd="💬 Comandos Chat",serverage="⏱️ Idade Servidor",realfps="🥔 FPS Booster Real",memclean="🧹 Memory Cleaner",lowgfx="📉 Low Graphics",serverhop="🌐 Server Hop",hop_empty="🔇 Servidores Vazios",hop_ping="⚡ Baixo Ping",nocliprc="🧠 Noclip Raycast",fps="FPS",ping="Ping",server_id="Servidor",uptime="Tempo",players="Jogadores"},
en={title="🌍 Select Language",pt="🇧🇷 Portuguese",en="🇺🇸 English",
tab_main="🔧 Main",tab_esp="👁️ ESPS",tab_player="👤 Player",tab_prot="🛡️ Protect",tab_hist="📜 Logs",tab_theme="🎨 Themes",tab_view="👀 Viewer",tab_stats="📊 Stats",tab_opt="⚡ Optimization",tab_sec="🔒 Anti-Staff",tab_remote="🎮 Remote",
chams="✨ Chams",tracers="📏 Tracers",item_esp="📦 Item ESP",xray="👁️ X-Ray",freecam="🎥 Freecam",maxzoom="🔍 Max Zoom",target_info="📊 Target Info",inspector="🔎 Inspector",
joinlog="📥 JoinLogs",chatlog="💬 ChatLogs",confirm_title="Are you sure?",yes="✅ Yes",no="❌ No",warn="You will lose previous history!",
staff="🚨 Staff Detector",autoleave="🚪 Auto-Leave",chatcmd="💬 Chat Commands",serverage="⏱️ Server Age",realfps="🥔 Real FPS Booster",memclean="🧹 Memory Cleaner",lowgfx="📉 Low Graphics",serverhop="🌐 Server Hop",hop_empty="🔇 Empty Servers",hop_ping="⚡ Low Ping",nocliprc="🧠 Raycast Noclip",fps="FPS",ping="Ping",server_id="Server",uptime="Uptime",players="Players"}}
local function tx(k)return(Trans[SelectedLanguage]or Trans.pt)[k]or k end

-- ═══ UI SELEÇÃO DE IDIOMA ═══
local LangGui=Instance.new("ScreenGui",TargetParent)LangGui.Name="VortexLangGui"LangGui.ResetOnSpawn=false
local LF=Instance.new("Frame",LangGui)LF.Size=UDim2.new(0,340,0,200)LF.Position=UDim2.new(0.5,-170,0.5,-100)LF.BackgroundColor3=Color3.fromRGB(25,25,30)LF.BorderSizePixel=0
Instance.new("UICorner",LF).CornerRadius=UDim.new(0,12)
local LSk=Instance.new("UIStroke",LF)LSk.Color=Color3.fromRGB(52,152,219)LSk.Thickness=2
local LT=Instance.new("TextLabel",LF)LT.Size=UDim2.new(1,-20,0,40)LT.Position=UDim2.new(0,10,0,15)LT.BackgroundTransparency=1 LT.Text=tx("title")LT.TextColor3=Color3.fromRGB(255,255,255)LT.Font=Enum.Font.GothamBold LT.TextSize=16
local BP=Instance.new("TextButton",LF)BP.Size=UDim2.new(1,-40,0,50)BP.Position=UDim2.new(0,20,0,70)BP.BackgroundColor3=Color3.fromRGB(0,156,59)BP.Text=tx("pt")BP.TextColor3=Color3.fromRGB(255,255,255)BP.Font=Enum.Font.GothamBold BP.TextSize=16
Instance.new("UICorner",BP).CornerRadius=UDim.new(0,8)
local BE=Instance.new("TextButton",LF)BE.Size=UDim2.new(1,-40,0,50)BE.Position=UDim2.new(0,20,0,130)BE.BackgroundColor3=Color3.fromRGB(50,70,150)BE.Text=tx("en")BE.TextColor3=Color3.fromRGB(255,255,255)BE.Font=Enum.Font.GothamBold BE.TextSize=16
Instance.new("UICorner",BE).CornerRadius=UDim.new(0,8)

local function setLang(l)
SelectedLanguage=l
pcall(function()if writefile then writefile("VortexHub_Lang.txt",l)end end)
LangGui:Destroy()
end
BP.MouseButton1Click:Connect(function()setLang("pt")end)
BE.MouseButton1Click:Connect(function()setLang("en")end)

if SelectedLanguage=="pt"or SelectedLanguage=="en"then LangGui:Destroy()end
repeat task.wait(0.05)until not LangGui.Parent or LangGui.Parent~=TargetParent

-- ═══ LIGHTING RESET ═══
local OL={GS=Lighting.GlobalShadows,B=Lighting.Brightness,EDS=Lighting.EnvironmentDiffuseScale,ESS=Lighting.EnvironmentSpecularScale,FS=Lighting.FogStart,FE=Lighting.FogEnd,FC=Lighting.FogColor,A=Lighting.Ambient,OA=Lighting.OutdoorAmbient,T=Lighting.Technology,SS=Lighting.ShadowSoftness}
local function resetLighting()Lighting.GlobalShadows=OL.GS Lighting.Brightness=OL.B Lighting.EnvironmentDiffuseScale=OL.EDS Lighting.EnvironmentSpecularScale=OL.ESS Lighting.FogStart=OL.FS Lighting.FogEnd=OL.FE Lighting.FogColor=OL.FC Lighting.Ambient=OL.A Lighting.OutdoorAmbient=OL.OA pcall(function()Lighting.Technology=OL.T Lighting.ShadowSoftness=OL.SS end)if Lighting:FindFirstChild("VortexAtmosphere")then Lighting.VortexAtmosphere:Destroy()end end
local function clearFx()for _,v in pairs(Lighting:GetChildren())do if v.Name:match("Vortex")then v:Destroy()end end end

local deathFade=Instance.new("ColorCorrectionEffect",Lighting)deathFade.Name="VortexDeathFade"deathFade.Brightness=0 deathFade.Contrast=0
local isDead=false
local function setupDeath(c)if not c then return end local h=c:WaitForChild("Humanoid",5)if not h then return end h.Died:Connect(function()isDead=true local wb=Lighting:FindFirstChild("VortexWallBlur")if not wb then wb=Instance.new("BlurEffect",Lighting)wb.Name="VortexWallBlur"end TweenService:Create(wb,TweenInfo.new(2.5),{Size=45}):Play()TweenService:Create(deathFade,TweenInfo.new(2.5),{Brightness=-1,Contrast=-0.5}):Play()end)end
LocalPlayer.CharacterAdded:Connect(function(c)isDead=false deathFade.Brightness=0 deathFade.Contrast=0 local wb=Lighting:FindFirstChild("VortexWallBlur")if wb then wb.Size=0 end setupDeath(c)end)
if LocalPlayer.Character then setupDeath(LocalPlayer.Character)end

-- ═══ VARIÁVEIS ═══
local wallBlurOn=HubConfig.WallBlur
local shadersOn,fpsBoostOn,fogOn,fullbrightOn,playerLightOn=HubConfig.Shaders,HubConfig.FpsBoost,HubConfig.Fog,HubConfig.Fullbright,HubConfig.PlayerLight
local espNPCOn,espPlayerOn,dangerESPOn,itemESPOn,chamsOn,tracersOn,xrayOn=HubConfig.ESPNPC,HubConfig.ESPPlayer,HubConfig.DangerESP,HubConfig.ItemESP,HubConfig.Chams,HubConfig.Tracers,HubConfig.XRay
local antiVoidOn,noclipOn,noclipRaycastOn,infJumpOn,playerModsOn,antiAfkOn,autoTimeOn,noCooldownOn,antiFlingOn=HubConfig.AntiVoid,HubConfig.Noclip,HubConfig.NoclipRaycast,HubConfig.InfJump,HubConfig.PlayerMods,HubConfig.AntiAfk,HubConfig.AutoTime,HubConfig.NoCooldown,HubConfig.AntiFling
local freecamOn,maxZoomOn=HubConfig.Freecam,HubConfig.MaxZoom
local joinLogsOn,chatLogsOn,teleportToolOn,notifOn=HubConfig.JoinLogs,HubConfig.ChatLogs,HubConfig.TeleportTool,HubConfig.Notifications
local staffDetOn,autoLeaveOn,chatCmdOn,memCleanOn,lowGfxOn,realFpsOn=HubConfig.StaffDetector,HubConfig.AutoLeave,HubConfig.ChatCommands,HubConfig.MemoryCleaner,HubConfig.LowGraphics,HubConfig.RealFPSBoost
local targetInfoOn,inspectorOn=HubConfig.TargetInfo,HubConfig.PlayerInspector
local playerSpeed,playerJump,playerFOV=HubConfig.WalkSpeed,HubConfig.JumpPower,HubConfig.FOV
local conns={}
local EspColors={PName="#00FFFF",PHP="#32FF32",PDist="#FFAA00",NName="#FF4444",NHP="#32FF32",NDist="#FFAA00",Item="#00FFCC"}
local trackedNPCs,trackedPlayers,trackedDanger,trackedItems,trackedChams,trackedTracers,trackedHighlight={},{},{},{},{},{},{}
local CachedNPCs={}
local espUpd,dangerUpd,itemUpd,tracerUpd,xrayUpd

-- ═══ CACHE NPCs ═══
local function checkNPC(o)if o:IsA("Model")and o:FindFirstChild("Humanoid")and o:FindFirstChild("HumanoidRootPart")and not Players:GetPlayerFromCharacter(o)then CachedNPCs[o]=true end end
for _,o in ipairs(Workspace:GetDescendants())do checkNPC(o)end
Workspace.DescendantAdded:Connect(function(o)task.delay(0.2,function()if o and o.Parent then if o:IsA("Model")then checkNPC(o)end if o.Parent:IsA("Model")then checkNPC(o.Parent)end end end)end)
Workspace.DescendantRemoving:Connect(function(o)if CachedNPCs[o]then CachedNPCs[o]=nil end end)

-- ═══ TEMAS ═══
local CurrentTheme={MainBG=Color3.fromRGB(36,36,37),TopBar=Color3.fromRGB(30,30,30),Accent=Color3.fromRGB(52,152,219)}
local TE={Bg={},TB={},Ac={},Tg={},Tx={}}
local function applyTheme(m,t,a,name)CurrentTheme.MainBG=m CurrentTheme.TopBar=t CurrentTheme.Accent=a if name then HubConfig.SelectedTheme=name saveConfig()end for _,f in pairs(TE.Bg)do f.BackgroundColor3=m end for _,f in pairs(TE.TB)do f.BackgroundColor3=t end for _,o in pairs(TE.Ac)do if o:IsA("UIStroke")then o.Color=a else o.BackgroundColor3=a end end for _,x in pairs(TE.Tx)do x.TextColor3=a end for bg,f in pairs(TE.Tg)do if f()then TweenService:Create(bg,TweenInfo.new(0.2),{BackgroundColor3=a}):Play()end end end

-- ═══ UI PRINCIPAL ═══
local SG=Instance.new("ScreenGui",TargetParent)SG.Name="VortexGraphicsHub"SG.ResetOnSpawn=false
local notifs={}
local function notif(title,text,nt)if not notifOn and(nt=="Info"or nt==nil)then return end local cols={Error=Color3.fromRGB(255,75,75),Info=CurrentTheme.Accent,Success=Color3.fromRGB(75,255,75)}local cc=cols[nt]or cols.Info local ic=nt=="Error"and"⚠️"or(nt=="Success"and"✅"or"ℹ️")local NF=Instance.new("Frame",SG)NF.Size=UDim2.new(0,300,0,65)NF.Position=UDim2.new(1,20,1,-85-(#notifs*75))NF.BackgroundColor3=Color3.fromRGB(25,25,28)NF.BorderSizePixel=0 Instance.new("UICorner",NF).CornerRadius=UDim.new(0,6)local sk=Instance.new("UIStroke",NF)sk.Color=Color3.fromRGB(50,50,55)
local Sd=Instance.new("Frame",NF)Sd.Size=UDim2.new(0,4,1,0)Sd.BackgroundColor3=cc Sd.BorderSizePixel=0 Instance.new("UICorner",Sd).CornerRadius=UDim.new(0,6)
local Ic=Instance.new("TextLabel",NF)Ic.Size=UDim2.new(0,40,0,40)Ic.Position=UDim2.new(0,10,0.5,-20)Ic.BackgroundTransparency=1 Ic.Text=ic Ic.TextSize=24
local Tt=Instance.new("TextLabel",NF)Tt.Size=UDim2.new(1,-65,0,20)Tt.Position=UDim2.new(0,55,0,10)Tt.BackgroundTransparency=1 Tt.Text=title Tt.TextColor3=cc Tt.Font=Enum.Font.GothamBold Tt.TextSize=14 Tt.TextXAlignment=Enum.TextXAlignment.Left
local Ds=Instance.new("TextLabel",NF)Ds.Size=UDim2.new(1,-65,0,25)Ds.Position=UDim2.new(0,55,0,30)Ds.BackgroundTransparency=1 Ds.Text=text Ds.TextColor3=Color3.fromRGB(240,240,240)Ds.Font=Enum.Font.Gotham Ds.TextSize=12 Ds.TextWrapped=true Ds.TextXAlignment=Enum.TextXAlignment.Left
local PB=Instance.new("Frame",NF)PB.Size=UDim2.new(1,0,0,3)PB.Position=UDim2.new(0,0,1,-3)PB.BackgroundColor3=Color3.fromRGB(40,40,45)PB.BorderSizePixel=0 Instance.new("UICorner",PB).CornerRadius=UDim.new(0,6)
local Pg=Instance.new("Frame",PB)Pg.Size=UDim2.new(1,0,1,0)Pg.BackgroundColor3=cc Pg.BorderSizePixel=0 Instance.new("UICorner",Pg).CornerRadius=UDim.new(0,6)
table.insert(notifs,NF)TweenService:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-85-(#notifs-1)*75)}):Play()TweenService:Create(Pg,TweenInfo.new(4,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,1,0)}):Play()
task.delay(4,function()if NF and NF.Parent then local oT=TweenService:Create(NF,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,20,1,NF.Position.Y.Offset)})oT:Play()oT.Completed:Connect(function()NF:Destroy()for i,v in ipairs(notifs)do if v==NF then table.remove(notifs,i)break end end for i,v in ipairs(notifs)do TweenService:Create(v,TweenInfo.new(0.3),{Position=UDim2.new(1,-320,1,-85-((i-1)*75))}):Play()end end)end end)end

local OB=Instance.new("TextButton",SG)OB.Size=UDim2.new(0,50,0,50)OB.Position=UDim2.new(0,20,0,20)OB.BackgroundColor3=Color3.fromRGB(36,36,37)OB.Text="⚡\nOPEN"OB.TextColor3=Color3.fromRGB(255,255,255)OB.Font=Enum.Font.GothamBold OB.TextSize=12 OB.Visible=false Instance.new("UICorner",OB).CornerRadius=UDim.new(0,10)
table.insert(TE.Bg,OB)
local MF=Instance.new("Frame",SG)MF.Size=UDim2.new(0,520,0,560)MF.Position=UDim2.new(0.5,-260,0.5,-280)MF.BackgroundColor3=CurrentTheme.MainBG MF.Active=true MF.Draggable=true Instance.new("UICorner",MF).CornerRadius=UDim.new(0,8)table.insert(TE.Bg,MF)
local TB=Instance.new("Frame",MF)TB.Size=UDim2.new(1,0,0,40)TB.BackgroundColor3=CurrentTheme.TopBar Instance.new("UICorner",TB).CornerRadius=UDim.new(0,8)table.insert(TE.TB,TB)
local Ttl=Instance.new("TextLabel",TB)Ttl.Size=UDim2.new(1,-50,1,0)Ttl.Position=UDim2.new(0,15,0,0)Ttl.Text="⚡ Vortex Hub V19 - Supreme"Ttl.TextColor3=Color3.fromRGB(255,255,255)Ttl.Font=Enum.Font.GothamBold Ttl.TextSize=14 Ttl.BackgroundTransparency=1 Ttl.TextXAlignment=Enum.TextXAlignment.Left
local CB=Instance.new("TextButton",TB)CB.Size=UDim2.new(0,40,0,40)CB.Position=UDim2.new(1,-40,0,0)CB.BackgroundTransparency=1 CB.Text="X"CB.TextColor3=Color3.fromRGB(200,200,200)CB.Font=Enum.Font.GothamBold CB.TextSize=16
CB.MouseButton1Click:Connect(function()MF.Visible=false OB.Visible=true end)
OB.MouseButton1Click:Connect(function()MF.Visible=true OB.Visible=false end)

local TabC=Instance.new("Frame",MF)TabC.Size=UDim2.new(1,0,0,60)TabC.Position=UDim2.new(0,0,0,40)TabC.BackgroundTransparency=1
local function cTab(n,x,y,w)local b=Instance.new("TextButton",TabC)b.Size=UDim2.new(w,0,0.5,0)b.Position=UDim2.new(x,0,y,0)b.BackgroundColor3=Color3.fromRGB(30,30,30)b.Text=n b.TextColor3=Color3.fromRGB(150,150,150)b.Font=Enum.Font.GothamBold b.TextSize=9 return b end
local tMain=cTab(tx("tab_main"),0,0,0.181)
local tESP=cTab(tx("tab_esp"),0.181,0,0.181)
local tPlayer=cTab(tx("tab_player"),0.362,0,0.181)
local tProt=cTab(tx("tab_prot"),0.543,0,0.181)
local tHist=cTab(tx("tab_hist"),0.724,0,0.181)
local tTheme=cTab(tx("tab_theme"),0.905,0,0.095)
local tView=cTab(tx("tab_view"),0,0.5,0.181)
local tStats=cTab(tx("tab_stats"),0.181,0.5,0.181)
local tOpt=cTab(tx("tab_opt"),0.362,0.5,0.181)
local tSec=cTab(tx("tab_sec"),0.543,0.5,0.181)
local tRemote=cTab(tx("tab_remote"),0.724,0.5,0.276)

local function cScroll(cY)local S=Instance.new("ScrollingFrame",MF)S.Size=UDim2.new(1,-20,1,-110)S.Position=UDim2.new(0,10,0,105)S.BackgroundTransparency=1 S.ScrollBarThickness=4 S.CanvasSize=UDim2.new(0,0,0,cY)local L=Instance.new("UIListLayout",S)L.Padding=UDim.new(0,8)L.HorizontalAlignment=Enum.HorizontalAlignment.Center S.Visible=false return S end
local sMain=cScroll(900)
local sESP=cScroll(1000)
local sPlayer=cScroll(1200)
local sProt=cScroll(900)
local sHist=cScroll(1500)
local sTheme=cScroll(500)
local sView=cScroll(1200)
local sStats=cScroll(600)
local sOpt=cScroll(800)
local sSec=cScroll(600)
local sRemote=cScroll(800)

local allTabs={{tMain,sMain},{tESP,sESP},{tPlayer,sPlayer},{tProt,sProt},{tHist,sHist},{tTheme,sTheme},{tView,sView},{tStats,sStats},{tOpt,sOpt},{tSec,sSec},{tRemote,sRemote}}
local function switchTab(ab)for _,d in pairs(allTabs)do if d[1]==ab then d[1].BackgroundColor3=Color3.fromRGB(45,45,45)d[1].TextColor3=Color3.fromRGB(255,255,255)d[2].Visible=true else d[1].BackgroundColor3=Color3.fromRGB(30,30,30)d[1].TextColor3=Color3.fromRGB(150,150,150)d[2].Visible=false end end end
for _,d in pairs(allTabs)do d[1].MouseButton1Click:Connect(function()switchTab(d[1])end)end
sMain.Visible=true
tMain.BackgroundColor3=Color3.fromRGB(45,45,45)tMain.TextColor3=Color3.fromRGB(255,255,255)

-- ═══ COMPONENTES UI ═══
local function cTitle(n,p)local t=Instance.new("TextLabel",p)t.Size=UDim2.new(1,0,0,25)t.BackgroundTransparency=1 t.Text=n t.TextColor3=CurrentTheme.Accent t.Font=Enum.Font.GothamBlack t.TextSize=13 t.TextXAlignment=Enum.TextXAlignment.Left table.insert(TE.Tx,t)end
local function cTog(n,p,st,cb,ck)local f=Instance.new("Frame",p)f.Size=UDim2.new(1,0,0,42)f.BackgroundColor3=Color3.fromRGB(45,45,45)Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)local L=Instance.new("TextLabel",f)L.Size=UDim2.new(0.7,0,1,0)L.Position=UDim2.new(0.05,0,0,0)L.Text=n L.TextColor3=Color3.fromRGB(255,255,255)L.Font=Enum.Font.Gotham L.TextSize=13 L.BackgroundTransparency=1 L.TextXAlignment=Enum.TextXAlignment.Left local sb=Instance.new("Frame",f)sb.Size=UDim2.new(0,40,0,20)sb.Position=UDim2.new(1,-55,0.5,-10)sb.BackgroundColor3=st and CurrentTheme.Accent or Color3.fromRGB(70,70,70)Instance.new("UICorner",sb).CornerRadius=UDim.new(1,0)local sk=Instance.new("Frame",sb)sk.Size=UDim2.new(0,16,0,16)sk.Position=st and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8)sk.BackgroundColor3=Color3.fromRGB(255,255,255)Instance.new("UICorner",sk).CornerRadius=UDim.new(1,0)local state=st TE.Tg[sb]=function()return state end local function setS(ns)state=ns TweenService:Create(sb,TweenInfo.new(0.2),{BackgroundColor3=state and CurrentTheme.Accent or Color3.fromRGB(70,70,70)}):Play()TweenService:Create(sk,TweenInfo.new(0.2),{Position=state and UDim2.new(1,-18,0.5,-8)or UDim2.new(0,2,0.5,-8)}):Play()if ck then HubConfig[ck]=state saveConfig()end end local b=Instance.new("TextButton",f)b.Size=UDim2.new(1,0,1,0)b.BackgroundTransparency=1 b.Text=""b.MouseButton1Click:Connect(function()setS(not state)cb(state)end)return setS end
local function cSli(n,rt,mn,mx,cv,p,cb,ck)local f=Instance.new("Frame",p)f.Size=UDim2.new(1,0,0,65)f.BackgroundColor3=Color3.fromRGB(42,42,45)Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)local t=Instance.new("TextLabel",f)t.Size=UDim2.new(1,-20,0,20)t.Position=UDim2.new(0,12,0,6)t.Text=n.." [ "..tostring(cv).." ]"t.TextColor3=Color3.fromRGB(255,255,255)t.Font=Enum.Font.GothamBold t.TextSize=13 t.BackgroundTransparency=1 t.TextXAlignment=Enum.TextXAlignment.Left local r=Instance.new("TextLabel",f)r.Size=UDim2.new(1,-20,0,14)r.Position=UDim2.new(0,12,0,24)r.Text="Rec: "..rt r.TextColor3=Color3.fromRGB(160,160,165)r.Font=Enum.Font.Gotham r.TextSize=11 r.BackgroundTransparency=1 r.TextXAlignment=Enum.TextXAlignment.Left local tr=Instance.new("Frame",f)tr.Size=UDim2.new(1,-24,0,8)tr.Position=UDim2.new(0,12,0,46)tr.BackgroundColor3=Color3.fromRGB(25,25,28)Instance.new("UICorner",tr).CornerRadius=UDim.new(1,0)local pi=math.clamp((cv-mn)/(mx-mn),0,1)local fi=Instance.new("Frame",tr)fi.Size=UDim2.new(pi,0,1,0)fi.BackgroundColor3=CurrentTheme.Accent Instance.new("UICorner",fi).CornerRadius=UDim.new(1,0)table.insert(TE.Ac,fi)local kn=Instance.new("Frame",tr)kn.Size=UDim2.new(0,18,0,18)kn.AnchorPoint=Vector2.new(0.5,0.5)kn.Position=UDim2.new(pi,0,0.5,0)kn.BackgroundColor3=Color3.fromRGB(255,255,255)Instance.new("UICorner",kn).CornerRadius=UDim.new(1,0)local ks=Instance.new("UIStroke",kn)ks.Color=CurrentTheme.Accent ks.Thickness=2 table.insert(TE.Ac,ks)local hb=Instance.new("TextButton",f)hb.Size=UDim2.new(1,0,1,0)hb.BackgroundTransparency=1 hb.Text=""local dr=false local function upd(i)local px=math.clamp(i.Position.X-tr.AbsolutePosition.X,0,tr.AbsoluteSize.X)local pc=px/tr.AbsoluteSize.X local v=math.floor(mn+(mx-mn)*pc)TweenService:Create(fi,TweenInfo.new(0.05),{Size=UDim2.new(pc,0,1,0)}):Play()TweenService:Create(kn,TweenInfo.new(0.05),{Position=UDim2.new(pc,0,0.5,0)}):Play()t.Text=n.." [ "..tostring(v).." ]"if ck then HubConfig[ck]=v saveConfig()end cb(v)end hb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true upd(i)end end)UserInputService.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)UserInputService.InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then upd(i)end end)end
local function cBtn(n,p,cb)local b=Instance.new("TextButton",p)b.Size=UDim2.new(1,0,0,38)b.BackgroundColor3=Color3.fromRGB(45,45,45)b.Text=n b.TextColor3=Color3.fromRGB(255,255,255)b.Font=Enum.Font.GothamBold b.TextSize=13 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(cb)end

-- ═══ UI CONFIRMAÇÃO ═══
local function showConfirm(text,cb)
local Ov=Instance.new("Frame",SG)Ov.Size=UDim2.new(1,0,1,0)Ov.BackgroundColor3=Color3.fromRGB(0,0,0)Ov.BackgroundTransparency=0.5 Ov.BorderSizePixel=0 Ov.ZIndex=100
local Bx=Instance.new("Frame",Ov)Bx.Size=UDim2.new(0,340,0,200)Bx.Position=UDim2.new(0.5,-170,0.5,-100)Bx.BackgroundColor3=Color3.fromRGB(30,30,35)Bx.ZIndex=101 Instance.new("UICorner",Bx).CornerRadius=UDim.new(0,10)
local T1=Instance.new("TextLabel",Bx)T1.Size=UDim2.new(1,-20,0,40)T1.Position=UDim2.new(0,10,0,10)T1.BackgroundTransparency=1 T1.Text=tx("confirm_title")T1.TextColor3=Color3.fromRGB(255,255,255)T1.Font=Enum.Font.GothamBold T1.TextSize=18 T1.ZIndex=101
local T2=Instance.new("TextLabel",Bx)T2.Size=UDim2.new(1,-20,0,40)T2.Position=UDim2.new(0,10,0,50)T2.BackgroundTransparency=1 T2.Text=tx("warn")T2.TextColor3=Color3.fromRGB(255,200,100)T2.Font=Enum.Font.Gotham T2.TextSize=12 T2.TextWrapped=true T2.ZIndex=101
local Y=Instance.new("TextButton",Bx)Y.Size=UDim2.new(0,140,0,40)Y.Position=UDim2.new(0,20,1,-60)Y.BackgroundColor3=Color3.fromRGB(50,180,80)Y.Text=tx("yes")Y.TextColor3=Color3.fromRGB(255,255,255)Y.Font=Enum.Font.GothamBold Y.TextSize=14 Y.ZIndex=101 Instance.new("UICorner",Y).CornerRadius=UDim.new(0,6)
local N=Instance.new("TextButton",Bx)N.Size=UDim2.new(0,140,0,40)N.Position=UDim2.new(1,-160,1,-60)N.BackgroundColor3=Color3.fromRGB(200,60,60)N.Text=tx("no")N.TextColor3=Color3.fromRGB(255,255,255)N.Font=Enum.Font.GothamBold N.TextSize=14 N.ZIndex=101 Instance.new("UICorner",N).CornerRadius=UDim.new(0,6)
Y.MouseButton1Click:Connect(function()Ov:Destroy()cb(true)end)
N.MouseButton1Click:Connect(function()Ov:Destroy()cb(false)end)
end

-- ═══ ESP GUI ═══
local function cESP(m)local r=m:FindFirstChild("HumanoidRootPart")local h=m:FindFirstChildOfClass("Humanoid")if not r or not h then return nil end local bg=Instance.new("BillboardGui")bg.Size=UDim2.new(0,400,0,50)bg.Adornee=r bg.StudsOffset=Vector3.new(0,3.5,0)bg.AlwaysOnTop=true bg.Parent=SG local el=Instance.new("TextLabel",bg)el.Size=UDim2.new(1,0,1,0)el.BackgroundTransparency=1 el.RichText=true el.TextStrokeTransparency=0.5 el.Font=Enum.Font.GothamBold el.TextSize=13 return{Gui=bg,Hum=h,Root=r,Lbl=el,Model=m}end
local function clESP(t)for _,d in pairs(t)do if d.Gui then d.Gui:Destroy()end end table.clear(t)end

local function updESP()if espUpd then espUpd:Disconnect()end if not espNPCOn and not espPlayerOn then return end espUpd=RunService.RenderStepped:Connect(function()local lc=LocalPlayer.Character local lr=lc and lc:FindFirstChild("HumanoidRootPart")
if espPlayerOn then for _,p in pairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart")and p.Character:FindFirstChild("Humanoid")then if not trackedPlayers[p]or trackedPlayers[p].Model~=p.Character then if trackedPlayers[p]and trackedPlayers[p].Gui then trackedPlayers[p].Gui:Destroy()end trackedPlayers[p]=cESP(p.Character)end end end for p,d in pairs(trackedPlayers)do if not p or not p.Parent or not p.Character or not d.Hum or d.Hum.Health<=0 or d.Model~=p.Character then if d.Gui then d.Gui:Destroy()end trackedPlayers[p]=nil else local hs=math.floor(d.Hum.Health)local ds=lr and d.Root and tostring(math.floor((lr.Position-d.Root.Position).Magnitude))or"???"d.Lbl.Text=string.format('<b><font color="%s">%s</font> | <font color="%s">HP: %s</font> | <font color="%s">%s</font></b>',EspColors.PName,p.Name,EspColors.PHP,hs,EspColors.PDist,ds)end end end
if espNPCOn then for m in pairs(CachedNPCs)do if m.Parent and not trackedNPCs[m]then trackedNPCs[m]=cESP(m)end end for m,d in pairs(trackedNPCs)do if not m or not m.Parent or not d.Hum or d.Hum.Health<=0 or not CachedNPCs[m]then if d.Gui then d.Gui:Destroy()end trackedNPCs[m]=nil else local ds=lr and d.Root and(lr.Position-d.Root.Position).Magnitude or 9999 if ds>2500 then d.Gui.Enabled=false else d.Gui.Enabled=true d.Lbl.Text=string.format('<b><font color="%s">%s</font><br /><font color="%s">HP: %s</font><br /><font color="%s">D: %s</font></b>',EspColors.NName,m.Name,EspColors.NHP,math.floor(d.Hum.Health),EspColors.NDist,math.floor(ds))end end end end end)end

-- ═══ CHAMS ═══
local function cChams(m)if not m:FindFirstChildOfClass("Humanoid")then return nil end local hl=Instance.new("Highlight")hl.Name="VortexChams"hl.Adornee=m hl.FillColor=Color3.fromRGB(255,50,50)hl.FillTransparency=0.5 hl.OutlineColor=Color3.fromRGB(255,0,0)hl.OutlineTransparency=0 hl.Parent=SG return hl end
local function updChams()for _,h in pairs(trackedChams)do h:Destroy()end table.clear(trackedChams)if not chamsOn then return end for _,p in pairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character then trackedChams[p]=cChams(p.Character)end end end
Players.PlayerAdded:Connect(function(p)p.CharacterAdded:Connect(function()task.wait(1)if chamsOn and p~=LocalPlayer then trackedChams[p]=cChams(p.Character)end end)end)

-- ═══ TRACERS ═══
local function cTracer(m)local r=m:FindFirstChild("HumanoidRootPart")if not r then return nil end local l=Drawing.new("Line")l.Thickness=1 l.Color=Color3.fromRGB(255,0,0)l.Transparency=1 l.Visible=true return{L=l,Model=m}end
local function updTracers()if tracerUpd then tracerUpd:Disconnect()end if not tracersOn then for _,t in pairs(trackedTracers)do if t.L then t.L:Remove()end end table.clear(trackedTracers)return end tracerUpd=RunService.RenderStepped:Connect(function()local cam=Workspace.CurrentCamera if not cam then return end for _,p in pairs(Players:GetPlayers())do if p~=LocalPlayer and p.Character then local r=p.Character:FindFirstChild("HumanoidRootPart")if r then if not trackedTracers[p]then trackedTracers[p]=cTracer(p.Character)end if trackedTracers[p]and trackedTracers[p].L then local sp,onS=cam:WorldToViewportPoint(r.Position)if onS then local vs=cam.ViewportSize trackedTracers[p].L.From=Vector2.new(vs.X/2,vs.Y)trackedTracers[p].L.To=Vector2.new(sp.X,sp.Y)trackedTracers[p].L.Visible=true else trackedTracers[p].L.Visible=false end end end end end for p,t in pairs(trackedTracers)do if not p.Parent or not p.Character then if t.L then t.L:Remove()end trackedTracers[p]=nil end end end)end

-- ═══ ITEM ESP ═══
local function cItemESP(part)local bg=Instance.new("BillboardGui")bg.Size=UDim2.new(0,250,0,40)bg.Adornee=part bg.StudsOffset=Vector3.new(0,2,0)bg.AlwaysOnTop=true bg.Parent=SG local el=Instance.new("TextLabel",bg)el.Size=UDim2.new(1,0,1,0)el.BackgroundTransparency=1 el.RichText=true el.TextStrokeTransparency=0.5 el.Font=Enum.Font.GothamBold el.TextSize=12 return{Gui=bg,Part=part,Lbl=el}end
local function updItemESP()if itemUpd then itemUpd:Disconnect()itemUpd=nil end for _,d in pairs(trackedItems)do if d.Gui then d.Gui:Destroy()end end table.clear(trackedItems)if not itemESPOn then return end itemUpd=RunService.RenderStepped:Connect(function()local lc=LocalPlayer.Character local lr=lc and lc:FindFirstChild("HumanoidRootPart")for _,v in ipairs(Workspace:GetDescendants())do local root=nil if v:IsA("Tool")and v.Parent==Workspace then root=v:FindFirstChild("Handle")elseif v:IsA("Model")and v.Parent==Workspace and(v:FindFirstChildOfClass("Tool")or v:FindFirstChildOfClass("MeshPart")or v.Name:lower():find("coin")or v.Name:lower():find("chest"))then root=v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")end if root and not trackedItems[v]then trackedItems[v]=cItemESP(root)end end for v,d in pairs(trackedItems)do if not v or not v.Parent or not d.Part or not d.Part.Parent then if d.Gui then d.Gui:Destroy()end trackedItems[v]=nil else local ds=lr and(lr.Position-d.Part.Position).Magnitude or 0 d.Lbl.Text=string.format('<b><font color="%s">%s</font> | <font color="%s">%d</font></b>',EspColors.Item,v.Name,EspColors.PDist,math.floor(ds))end end end)end

-- ═══ X-RAY ═══
local originalTransparency={}
local function updXRay()if xrayUpd then xrayUpd:Disconnect()xrayUpd=nil end if xrayOn then xrayUpd=RunService.Heartbeat:Connect(function()for _,v in ipairs(Workspace:GetDescendants())do if v:IsA("BasePart")and v.Name~="HumanoidRootPart"and not v:FindFirstChildOfClass("Humanoid")then if originalTransparency[v]==nil then originalTransparency[v]=v.LocalTransparencyModifier end if v.Transparency<1 and v ~= LocalPlayer.Character then v.LocalTransparencyModifier=0.7 end end end end)else for v,t in pairs(originalTransparency)do if v and v.Parent then v.LocalTransparencyModifier=t end end table.clear(originalTransparency)end end

-- ═══ ANTI-FLING ═══
local afConn
local function enableAF()if afConn then afConn:Disconnect()end afConn=RunService.Stepped:Connect(function()if not antiFlingOn then return end local c=LocalPlayer.Character if not c then return end for _,p in pairs(c:GetChildren())do if p:IsA("BasePart")then if p.Velocity.Magnitude>1000 then p.Velocity=Vector3.new(0,0,0)end if p.RotVelocity.Magnitude>1000 then p.RotVelocity=Vector3.new(0,0,0)end end end for _,op in pairs(Players:GetPlayers())do if op~=LocalPlayer and op.Character then for _,oprt in pairs(op.Character:GetChildren())do if oprt:IsA("BasePart")then oprt.CanCollide=false end end end end end)end

-- ═══ FREECAM ═══
local freecamConn,freecamPos,freecamRot
local function enableFreecam()
if freecamConn then freecamConn:Disconnect()end
local cam=Workspace.CurrentCamera
freecamPos=cam.CFrame.Position
freecamRot=Vector2.new(cam.CFrame:ToEulerAnglesYXZ())
local speed=1
local keys={}
local function onKey(i,g)if i.KeyCode==Enum.KeyCode.W or i.KeyCode==Enum.KeyCode.A or i.KeyCode==Enum.KeyCode.S or i.KeyCode==Enum.KeyCode.D or i.KeyCode==Enum.KeyCode.Space or i.KeyCode==Enum.KeyCode.LeftShift or i.KeyCode==Enum.KeyCode.E or i.KeyCode==Enum.KeyCode.Q then keys[i.KeyCode]=g end end
UserInputService.InputBegan:Connect(function(i,g)onKey(i,true)end)
UserInputService.InputEnded:Connect(function(i,g)onKey(i,false)end)
freecamConn=RunService.RenderStepped:Connect(function(dt)
local move=Vector3.new(0,0,0)
if keys[Enum.KeyCode.W]then move=move+Vector3.new(0,0,-1)end
if keys[Enum.KeyCode.S]then move=move+Vector3.new(0,0,1)end
if keys[Enum.KeyCode.A]then move=move+Vector3.new(-1,0,0)end
if keys[Enum.KeyCode.D]then move=move+Vector3.new(1,0,0)end
if keys[Enum.KeyCode.Space]then move=move+Vector3.new(0,1,0)end
if keys[Enum.KeyCode.LeftShift]then move=move+Vector3.new(0,-1,0)end
local newCF=CFrame.new(freecamPos)*CFrame.Angles(freecamRot.Y,freecamRot.X,0)
if move.Magnitude>0 then freecamPos=freecamPos+(newCF.VectorToWorldSpace(move*speed*dt*20)).Position end
cam.CFrame=CFrame.new(freecamPos)*CFrame.Angles(freecamRot.Y,freecamRot.X,0)
cam.CameraType=Enum.CameraType.Scriptable
end)
UserInputService.InputChanged:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseMovement and freecamOn then
freecamRot=Vector2.new(freecamRot.X-i.Delta.X*0.005,math.clamp(freecamRot.Y-i.Delta.Y*0.005,-math.pi/2,math.pi/2))
end end)
end
local function disableFreecam()if freecamConn then freecamConn:Disconnect()freecamConn=nil end local cam=Workspace.CurrentCamera cam.CameraType=Enum.CameraType.Custom if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")then cam.CameraSubject=LocalPlayer.Character.Humanoid end end

-- ═══ MAX ZOOM ═══
local function setMaxZoom(s)
local cam=Workspace.CurrentCamera
if s then
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")then
UserInputService.MouseBehavior=Enum.MouseBehavior.Default
LocalPlayer.CameraMaxZoomDistance=999999
LocalPlayer.CameraMinZoomDistance=0.5
end
else
LocalPlayer.CameraMaxZoomDistance=128
LocalPlayer.CameraMinZoomDistance=0.5
end end

-- ═══ NOCLIP RAYCAST ═══
local noclipRC
local function enableNoclipRC()
if noclipRC then noclipRC:Disconnect()end
noclipRC=RunService.Stepped:Connect(function()
if not noclipRaycastOn then return end
local c=LocalPlayer.Character if not c then return end
local hrp=c:FindFirstChild("HumanoidRootPart")if not hrp then return end
local h=c:FindFirstChildOfClass("Humanoid")if not h then return end
local moveDir=h.MoveDirection
if moveDir.Magnitude>0.1 then
local rp=RaycastParams.new()rp.FilterType=Enum.RaycastFilterType.Exclude rp.FilterDescendantsInstances={c}
local hit=Workspace:Raycast(hrp.Position,moveDir*2.5,rp)
if hit then
local wall=hit.Instance
if wall and wall.CanCollide then
wall.CanCollide=false
task.delay(0.3,function()if wall and wall.Parent then wall.CanCollide=true end end)
end
end
end
end)
end

-- ═══ SERVER STATS ═══
local statsLabels={}
local function startStats()
task.spawn(function()
local startTime=tick()
local sLbl=Instance.new("TextLabel",sStats)sLbl.Size=UDim2.new(1,0,0,30)sLbl.BackgroundColor3=Color3.fromRGB(40,40,45)sLbl.TextColor3=Color3.fromRGB(255,255,255)sLbl.Font=Enum.Font.GothamBold sLbl.TextSize=13 Instance.new("UICorner",sLbl).CornerRadius=UDim.new(0,6)
local sLbl2=Instance.new("TextLabel",sStats)sLbl2.Size=UDim2.new(1,0,0,30)sLbl2.BackgroundColor3=Color3.fromRGB(40,40,45)sLbl2.TextColor3=Color3.fromRGB(255,255,255)sLbl2.Font=Enum.Font.Gotham sLbl2.TextSize=13 Instance.new("UICorner",sLbl2).CornerRadius=UDim.new(0,6)
local sLbl3=Instance.new("TextLabel",sStats)sLbl3.Size=UDim2.new(1,0,0,30)sLbl3.BackgroundColor3=Color3.fromRGB(40,40,45)sLbl3.TextColor3=Color3.fromRGB(255,255,255)sLbl3.Font=Enum.Font.Gotham sLbl3.TextSize=13 Instance.new("UICorner",sLbl3).CornerRadius=UDim.new(0,6)
local sLbl4=Instance.new("TextLabel",sStats)sLbl4.Size=UDim2.new(1,0,0,30)sLbl4.BackgroundColor3=Color3.fromRGB(40,40,45)sLbl4.TextColor3=Color3.fromRGB(255,255,255)sLbl4.Font=Enum.Font.Gotham sLbl4.TextSize=13 Instance.new("UICorner",sLbl4).CornerRadius=UDim.new(0,6)
local sLbl5=Instance.new("TextLabel",sStats)sLbl5.Size=UDim2.new(1,0,0,30)sLbl5.BackgroundColor3=Color3.fromRGB(40,40,45)sLbl5.TextColor3=Color3.fromRGB(255,255,255)sLbl5.Font=Enum.Font.Gotham sLbl5.TextSize=13 Instance.new("UICorner",sLbl5).CornerRadius=UDim.new(0,6)
while true do
task.wait(1)
local fps=math.floor(1/RunService.RenderStepped:Wait()or 60)
local ping=0
pcall(function()ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())end)
local up=math.floor(tick()-startTime)
local hrs=math.floor(up/3600)local mns=math.floor((up%3600)/60)
sLbl.Text="FPS: "..fps
sLbl2.Text="Ping: "..ping.."ms"
sLbl3.Text="Server ID: "..game.JobId
sLbl4.Text="Uptime: "..hrs.."h "..mns.."m"
sLbl5.Text="Players: "..#Players:GetPlayers().."/"..Players.MaxPlayers
end
end)
end
startStats()

-- ═══ CHAT COMMANDS ═══
local function startChatCmd()
LocalPlayer.Chatted:Connect(function(msg)
if not chatCmdOn then return end
local args=string.split(msg," ")
local cmd=args[1]:lower()
if cmd=="/speed"and args[2]then playerSpeed=tonumber(args[2])or 16 if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")then LocalPlayer.Character.Humanoid.WalkSpeed=playerSpeed end end
if cmd=="/jump"and args[2]then playerJump=tonumber(args[2])or 50 if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")then LocalPlayer.Character.Humanoid.JumpPower=playerJump end end
if cmd=="/fov"and args[2]then playerFOV=tonumber(args[2])or 70 if Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView=playerFOV end end
if cmd=="/esp"and args[2]then espPlayerOn=args[2]=="true" updESP()end
if cmd=="/fly"then if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then local bv=Instance.new("BodyVelocity",LocalPlayer.Character.HumanoidRootPart)bv.MaxForce=Vector3.new(9e9,9e9,9e9)bv.Velocity=Vector3.new(0,50,0)task.wait(3)bv:Destroy()end end
end)
end
startChatCmd()

-- ═══ CHAT LOGS ═══
local chatHistory={}
local function startChatLogs()
task.spawn(function()
pcall(function()
game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(msg,from)
if not chatLogsOn then return end
table.insert(chatHistory,{user=from,msg=msg,time=os.date("%H:%M:%S")})
if #chatHistory>200 then table.remove(chatHistory,1)end
end)
end)
end)
end
startChatLogs()

local function addChatLogUI(user,msg)
local f=Instance.new("Frame",sHist)f.Size=UDim2.new(1,-10,0,45)f.BackgroundColor3=Color3.fromRGB(30,30,35)Instance.new("UICorner",f).CornerRadius=UDim.new(0,8)
local t=Instance.new("TextLabel",f)t.Size=UDim2.new(1,-10,1,0)t.Position=UDim2.new(0,5,0,0)t.BackgroundTransparency=1 t.Text="["..user.."]: "..msg t.TextColor3=Color3.fromRGB(255,255,255)t.Font=Enum.Font.Gotham t.TextSize=11 t.TextWrapped=true t.TextXAlignment=Enum.TextXAlignment.Left
end

-- ═══ STAFF DETECTOR ═══
local STAFF_IDS={[1]=true,[2]=true,[3]=true}-- IDs oficiais Roblox (exemplo)
local function startStaffDet()
Players.PlayerAdded:Connect(function(p)
if not staffDetOn then return end
if STAFF_IDS[p.UserId]then
notif("🚨 STAFF","Staff "..p.Name.." entrou!","Error")
pcall(function()
local s=Instance.new("Sound",SG)s.SoundId="rbxassetid://138080043"local vol=Instance.new("NumberValue")s.Volume=2 s:Play()
end)
end
if autoLeaveOn and STAFF_IDS[p.UserId]then
task.wait(1)LocalPlayer:Kick("Auto-Leave: Staff detectado!")
end
end)
end
startStaffDet()

-- ═══ SISTEMA JOIN/EXIT LOGS ═══
local joinExitToasts={}
local function showJoinToast(p,et)if not joinLogsOn then return end local isJ=et=="JOIN"local ac=isJ and Color3.fromRGB(0,255,150)or Color3.fromRGB(255,70,90)local tt=isJ and"🟢 ENTROU"or"🔴 SAIU"local F=Instance.new("Frame",SG)F.Size=UDim2.new(0,280,0,60)F.BackgroundColor3=Color3.fromRGB(20,20,25)F.BorderSizePixel=0 Instance.new("UICorner",F).CornerRadius=UDim.new(0,10)local Sk=Instance.new("UIStroke",F)Sk.Color=ac Sk.Thickness=1.5 local Ab=Instance.new("Frame",F)Ab.Size=UDim2.new(0,4,1,0)Ab.BackgroundColor3=ac Ab.BorderSizePixel=0 Instance.new("UICorner",Ab).CornerRadius=UDim.new(0,10)local T=Instance.new("TextLabel",F)T.Size=UDim2.new(1,-50,0,20)T.Position=UDim2.new(0,50,0,10)T.BackgroundTransparency=1 T.Text=tt T.TextColor3=ac T.Font=Enum.Font.GothamBold T.TextSize=12 T.TextXAlignment=Enum.TextXAlignment.Left local T2=Instance.new("TextLabel",F)T2.Size=UDim2.new(1,-50,0,25)T2.Position=UDim2.new(0,50,0,30)T2.BackgroundTransparency=1 T2.Text=p.DisplayName.." (@"..p.Name..")"T2.TextColor3=Color3.fromRGB(240,240,240)T2.Font=Enum.Font.Gotham T2.TextSize=11 T2.TextXAlignment=Enum.TextXAlignment.Left table.insert(joinExitToasts,F)local tY=-85-(#joinExitToasts-1)*68 F.Position=UDim2.new(1,20,1,tY)TweenService:Create(F,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Position=UDim2.new(1,-295,1,tY)}):Play()task.delay(4,function()if F.Parent then F:Destroy()table.remove(joinExitToasts,table.find(joinExitToasts,F)or 1)end end)end
Players.PlayerAdded:Connect(function(p)showJoinToast(p,"JOIN")if joinLogsOn then addChatLogUI("LOG","Entrou: "..p.Name)end end)
Players.PlayerRemoving:Connect(function(p)showJoinToast(p,"EXIT")if joinLogsOn then addChatLogUI("LOG","Saiu: "..p.Name)end end)

-- ═══ SERVER HOP ═══
local function hopEmpty()
notif("🌐","Procurando servidor vazio...","Info")
local ok,servers=pcall(function()return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))end)
if ok and servers and servers.data then
for _,s in ipairs(servers.data)do if s.playing<s.maxPlayers and s.id~=game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId,s.id,LocalPlayer)return end end
end
notif("Erro","Nenhum servidor vazio encontrado","Error")
end
local function hopLowPing()
notif("🌐","Procurando servidor de baixo ping...","Info")
pcall(function()TeleportService:Teleport(game.PlaceId,LocalPlayer)end)
end

-- ═══ MEMORY CLEANER ═══
local function startMemClean()
task.spawn(function()while memCleanOn do task.wait(30)pcall(function()collectgarbage("collect")end)end end)
end

-- ═══ LOW GFX ═══
local function applyLowGfx(s)
if s then
pcall(function()Lighting.GlobalShadows=false Lighting.FogEnd=1e6 Lighting.EnvironmentDiffuseScale=0 Lighting.EnvironmentSpecularScale=0 Lighting.ShadowSoftness=0 end)
for _,v in ipairs(Workspace:GetDescendants())do if v:IsA("BasePart")then v.Material=Enum.Material.SmoothPlastic end if v:IsA("ParticleEmitter")then v.Enabled=false end end
else
resetLighting()
end end

-- ═══ REAL FPS BOOSTER ═══
local function applyRealFps(s)
if s then
pcall(function()
settings().Rendering.QualityLevel=Enum.QualityLevel.Level01
for _,v in ipairs(Lighting:GetChildren())do if v:IsA("PostEffect")or v:IsA("Atmosphere")then v.Enabled=false end end
end)
for _,v in ipairs(Workspace:GetDescendants())do if v:IsA("ParticleEmitter")or v:IsA("Trail")or v:IsA("Beam")or v:IsA("Fire")or v:IsA("Smoke")or v:IsA("Sparkles")then v.Enabled=false end end
else pcall(function()settings().Rendering.QualityLevel=Enum.QualityLevel.Automatic end)end end

-- ═══ UI: ABA PRINCIPAL ═══
cTitle("✨ GRÁFICOS",sMain)
local stU,ftU
stU=cTog("✨ Shaders",sMain,shadersOn,function(s)shadersOn=s end,"Shaders")
ftU=cTog("🥔 Booster FPS",sMain,fpsBoostOn,function(s)fpsBoostOn=s end,"FpsBoost")
cTog("🌫️ Desfoque",sMain,wallBlurOn,function(s)wallBlurOn=s end,"WallBlur")
cTog("🌫️ Neblina",sMain,fogOn,function(s)fogOn=s end,"Fog")
cTog("🌀 Motion Blur",sMain,HubConfig.MotionBlur,function(s)HubConfig.MotionBlur=s end,"MotionBlur")
cTog("☀️ Fullbright",sMain,fullbrightOn,function(s)fullbrightOn=s if s then local c=RunService.RenderStepped:Connect(function()Lighting.Ambient=Color3.new(1,1,1)Lighting.OutdoorAmbient=Color3.new(1,1,1)Lighting.Brightness=2 end)conns.fullbright=c end,"Fullbright")
cTog("🔦 Luz Player",sMain,playerLightOn,function(s)playerLightOn=s end,"PlayerLight")
cTitle("🔬 X-RAY",sMain)
cTog(tx("xray"),sMain,xrayOn,function(s)xrayOn=s updXRay()end,"XRay")

cTitle("⏰ TEMPO",sMain)
cTog("🔄 Auto Tempo",sMain,autoTimeOn,function(s)autoTimeOn=s end,"AutoTime")

-- ═══ UI: ABA ESPS ═══
cTitle("👁️ ESP",sESP)
cTog("👤 ESP Player",sESP,espPlayerOn,function(s)espPlayerOn=s if not s then clESP(trackedPlayers)end updESP()end,"ESPPlayer")
cTog("🤖 ESP NPC",sESP,espNPCOn,function(s)espNPCOn=s if not s then clESP(trackedNPCs)end updESP()end,"ESPNPC")
cTog("⚠️ Alerta Hostil",sESP,dangerESPOn,function(s)dangerESPOn=s end,"DangerESP")
cTog(tx("item_esp"),sESP,itemESPOn,function(s)itemESPOn=s updItemESP()end,"ItemESP")
cTitle("🎨 VISUAL",sESP)
cTog(tx("chams"),sESP,chamsOn,function(s)chamsOn=s updChams()end,"Chams")
cTog(tx("tracers"),sESP,tracersOn,function(s)tracersOn=s updTracers()end,"Tracers")

-- ═══ UI: ABA PLAYER ═══
cTitle("👤 MODS",sPlayer)
cTog("🌀 TeleportTool",sPlayer,teleportToolOn,function(s)teleportToolOn=s if s then if not LocalPlayer.Backpack:FindFirstChild("TeleportTool")then local T=Instance.new("Tool")T.Name="TeleportTool"T.RequiresHandle=false T.CanBeDropped=false T.Activated:Connect(function()local m=LocalPlayer:GetMouse()if m and m.Hit and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(m.Hit.Position+Vector3.new(0,3,0))end end)T.Parent=LocalPlayer.Backpack end end end,"TeleportTool")
cTog("⚡ Instant Interact",sPlayer,HubConfig.InstantInteract,function(s)HubConfig.InstantInteract=s end,"InstantInteract")
cTog("⚡ Mods Player",sPlayer,playerModsOn,function(s)playerModsOn=s if s then conns.pmods=RunService.Stepped:Connect(function()local c=LocalPlayer.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid.UseJumpPower=true c.Humanoid.WalkSpeed=playerSpeed c.Humanoid.JumpPower=playerJump end if Workspace.CurrentCamera then Workspace.CurrentCamera.FieldOfView=playerFOV end end)else if conns.pmods then conns.pmods:Disconnect()conns.pmods=nil end end end,"PlayerMods")
cTog("⚡ No Cooldown",sPlayer,noCooldownOn,function(s)noCooldownOn=s end,"NoCooldown")
cTog("🚀 Inf Jump",sPlayer,infJumpOn,function(s)infJumpOn=s if s then conns.ij=UserInputService.JumpRequest:Connect(function()local c=LocalPlayer.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)end end)else if conns.ij then conns.ij:Disconnect()conns.ij=nil end end end,"InfJump")
cTog("👻 Noclip",sPlayer,noclipOn,function(s)noclipOn=s if s then conns.nc=RunService.Stepped:Connect(function()local c=LocalPlayer.Character if c and c:FindFirstChildOfClass("Humanoid")then c.Humanoid:ChangeState(11)end end)else if conns.nc then conns.nc:Disconnect()conns.nc=nil end end end,"Noclip")
cTog(tx("nocliprc"),sPlayer,noclipRaycastOn,function(s)noclipRaycastOn=s if s then enableNoclipRC()end end,"NoclipRaycast")
cTog(tx("maxzoom"),sPlayer,maxZoomOn,function(s)maxZoomOn=s setMaxZoom(s)end,"MaxZoom")
cTog(tx("freecam"),sPlayer,freecamOn,function(s)freecamOn=s if s then enableFreecam()else disableFreecam()end end,"Freecam")
cSli("🏃 WalkSpeed","16-50",16,200,playerSpeed,sPlayer,function(v)playerSpeed=v end,"WalkSpeed")
cSli("🦘 JumpPower","50-100",50,300,playerJump,sPlayer,function(v)playerJump=v end,"JumpPower")
cSli("🔭 FOV","70-90",70,120,playerFOV,sPlayer,function(v)playerFOV=v end,"FOV")
cTitle(tx("serverhop"),sPlayer)
cBtn(tx("hop_empty"),sPlayer,hopEmpty)
cBtn(tx("hop_ping"),sPlayer,hopLowPing)

-- ═══ UI: ABA PROTEÇÃO ═══
cTitle("🛡️ PROTEÇÃO",sProt)
cTog("🛡️ Anti-Fling",sProt,antiFlingOn,function(s)antiFlingOn=s if s then enableAF()else if afConn then afConn:Disconnect()afConn=nil end end end,"AntiFling")
cTog("🌌 Anti-Void",sProt,antiVoidOn,function(s)antiVoidOn=s end,"AntiVoid")
cTog("🚫 Anti-AFK",sProt,antiAfkOn,function(s)antiAfkOn=s if s then conns.afk=LocalPlayer.Idled:Connect(function()VirtualUser:CaptureController()VirtualUser:ClickButton2(Vector2.new())end)else if conns.afk then conns.afk:Disconnect()conns.afk=nil end end end,"AntiAfk")
cTog(tx("chatlog"),sProt,chatLogsOn,function(s)
if s then showConfirm(tx("warn"),function(y)if y then chatLogsOn=true notif("💬","ChatLogs ativado!","Success")end end)else chatLogsOn=false end end,"ChatLogs")

-- ═══ UI: ABA HISTÓRICO ═══
cTitle("📜 "..tx("tab_hist"),sHist)
cTog(tx("joinlog"),sHist,joinLogsOn,function(s)
if s then showConfirm(tx("warn"),function(y)if y then joinLogsOn=true notif("📥","JoinLogs ativado!","Success")end end)else joinLogsOn=false end end,"JoinLogs")
cTog(tx("chatlog"),sHist,chatLogsOn,function(s)
if s then showConfirm(tx("warn"),function(y)if y then chatLogsOn=true notif("💬","ChatLogs ativado!","Success")end end)else chatLogsOn=false end end,"ChatLogs")
cTog("🔔 Notificações",sHist,notifOn,function(s)notifOn=s end,"Notifications")

-- ═══ UI: ABA TEMAS ═══
cTitle("🎨 TEMAS",sTheme)
local function cTBtn(n,m,t,a,k)local b=Instance.new("TextButton",sTheme)b.Size=UDim2.new(1,0,0,40)b.BackgroundColor3=Color3.fromRGB(45,45,45)b.Text="🎨 "..n b.TextColor3=a b.Font=Enum.Font.GothamBold b.TextSize=14 Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)b.MouseButton1Click:Connect(function()applyTheme(m,t,a,k)end)end
cTBtn("Orion",Color3.fromRGB(36,36,37),Color3.fromRGB(30,30,30),Color3.fromRGB(52,152,219),"Orion")
cTBtn("Vampiro",Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50),"Vampiro")
cTBtn("Tóxico",Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100),"Tóxico")
cTBtn("Ametista",Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182),"Ametista")
cTBtn("Neon",Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255),"Neon")
cTBtn("Sakura",Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204),"Sakura")

-- ═══ UI: ABA VIEWER ═══
cTitle("👥 SELECIONAR JOGADOR",sView)
local SelectedPlayer=nil
local TargetLbl=Instance.new("TextLabel",sView)TargetLbl.Size=UDim2.new(1,0,0,30)TargetLbl.BackgroundTransparency=1 TargetLbl.Text="Alvo: Nenhum"TargetLbl.TextColor3=CurrentTheme.Accent TargetLbl.Font=Enum.Font.GothamBold TargetLbl.TextSize=14 table.insert(TE.Tx,TargetLbl)
local PLF=Instance.new("ScrollingFrame",sView)PLF.Size=UDim2.new(1,0,0,180)PLF.BackgroundColor3=Color3.fromRGB(30,30,35)PLF.BorderSizePixel=0 PLF.ScrollBarThickness=4 Instance.new("UICorner",PLF).CornerRadius=UDim.new(0,6)
local UIL=Instance.new("UIListLayout",PLF)UIL.Padding=UDim.new(0,5)UIL.HorizontalAlignment=Enum.HorizontalAlignment.Center
local pBtns={}
local function updPL()
for _,b in pairs(pBtns)do b:Destroy()end table.clear(pBtns)
local ys=0
for _,p in ipairs(Players:GetPlayers())do if p~=LocalPlayer then local b=Instance.new("TextButton",PLF)b.Size=UDim2.new(1,-10,0,32)b.Position=UDim2.new(0,5,0,ys)b.BackgroundColor3=Color3.fromRGB(50,50,55)b.Text="  "..p.DisplayName.." (@"..p.Name..")"b.TextColor3=Color3.fromRGB(230,230,230)b.Font=Enum.Font.GothamBold b.TextSize=12 b.TextXAlignment=Enum.TextXAlignment.Left Instance.new("UICorner",b).CornerRadius=UDim.new(0,4)b.MouseButton1Click:Connect(function()SelectedPlayer=p TargetLbl.Text="Alvo: "..p.DisplayName notif("Alvo","Selecionado: "..p.Name,"Info")end)table.insert(pBtns,b)ys=ys+37 end end
PLF.CanvasSize=UDim2.new(0,0,0,ys+10)
end
Players.PlayerAdded:Connect(updPL)
Players.PlayerRemoving:Connect(function(p)if SelectedPlayer==p then SelectedPlayer=nil TargetLbl.Text="Alvo: Nenhum"end updPL()end)
updPL()
cTitle("⚙️ AÇÕES",sView)
cBtn("🚀 Teleport",sView,function()if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart")and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then LocalPlayer.Character.HumanoidRootPart.CFrame=SelectedPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)notif("TP","Teleportado!","Success")end end)
cTog("👁️ View",sView,false,function(s)if s then if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("Humanoid")then Workspace.CurrentCamera.CameraSubject=SelectedPlayer.Character.Humanoid end else if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")then Workspace.CurrentCamera.CameraSubject=LocalPlayer.Character.Humanoid end end end,nil)
cTog("🔁 Loopgoto",sView,false,function(s)if s then if SelectedPlayer then conns.lg=RunService.Heartbeat:Connect(function()if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart")and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")then LocalPlayer.Character.HumanoidRootPart.CFrame=SelectedPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,3)end end)end else if conns.lg then conns.lg:Disconnect()conns.lg=nil end end end,nil)
cTog("🏃 Follow",sView,false,function(s)if s then if SelectedPlayer then conns.fw=RunService.Heartbeat:Connect(function()if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart")and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")then LocalPlayer.Character.Humanoid:MoveTo(SelectedPlayer.Character.HumanoidRootPart.Position)end end)end else if conns.fw then conns.fw:Disconnect()conns.fw=nil end end end,nil)
cTog(tx("target_info"),sView,targetInfoOn,function(s)targetInfoOn=s end,"TargetInfo")
cTog(tx("inspector"),sView,inspectorOn,function(s)inspectorOn=s end,"PlayerInspector")
cBtn("📋 Copiar Username",sView,function()if SelectedPlayer and setclipboard then setclipboard(SelectedPlayer.Name)notif("Copiado","OK!","Success")end end)
cBtn("📋 Copiar ID",sView,function()if SelectedPlayer and setclipboard then setclipboard(tostring(SelectedPlayer.UserId))notif("Copiado","OK!","Success")end end)

-- ═══ UI: ABA STATS ═══
cTitle("📊 SERVER STATS",sStats)

-- ═══ UI: ABA OTIMIZAÇÃO ═══
cTitle("⚡ OTIMIZAÇÃO",sOpt)
cTog(tx("realfps"),sOpt,realFpsOn,function(s)realFpsOn=s applyRealFps(s)end,"RealFPSBoost")
cTog(tx("memclean"),sOpt,memCleanOn,function(s)memCleanOn=s if s then startMemClean()end end,"MemoryCleaner")
cTog(tx("lowgfx"),sOpt,lowGfxOn,function(s)lowGfxOn=s applyLowGfx(s)end,"LowGraphics")

-- ═══ UI: ABA ANTI-STAFF ═══
cTitle("🔒 SEGURANÇA AVANÇADA",sSec)
cTog(tx("staff"),sSec,staffDetOn,function(s)staffDetOn=s end,"StaffDetector")
cTog(tx("autoleave"),sSec,autoLeaveOn,function(s)autoLeaveOn=s end,"AutoLeave")

-- ═══ UI: ABA CONTROLE REMOTO ═══
cTitle("🎮 CONTROLE REMOTO",sRemote)
cTog(tx("chatcmd"),sRemote,chatCmdOn,function(s)chatCmdOn=s end,"ChatCommands")
cTitle("⏱️ SERVER INFO",sRemote)
local uptimeLbl=Instance.new("TextLabel",sRemote)uptimeLbl.Size=UDim2.new(1,0,0,30)uptimeLbl.BackgroundColor3=Color3.fromRGB(40,40,45)uptimeLbl.TextColor3=Color3.fromRGB(255,255,255)uptimeLbl.Font=Enum.Font.GothamBold uptimeLbl.TextSize=13 Instance.new("UICorner",uptimeLbl).CornerRadius=UDim.new(0,6)
task.spawn(function()local st=tick()while true do task.wait(1)uptimeLbl.Text="Server aberto há: "..math.floor((tick()-st)/60).." minutos"end end)

-- ═══ INIT ═══
task.spawn(function()
task.wait(0.5)
if SelectedLanguage=="pt"then notif("🌍","Idioma: Português","Success")else notif("🌍","Language: English","Success")end
task.wait(1)
if HubConfig.SelectedTheme=="Vampiro"then applyTheme(Color3.fromRGB(20,10,10),Color3.fromRGB(15,5,5),Color3.fromRGB(220,50,50))
elseif HubConfig.SelectedTheme=="Tóxico"then applyTheme(Color3.fromRGB(15,25,15),Color3.fromRGB(10,15,10),Color3.fromRGB(50,220,100))
elseif HubConfig.SelectedTheme=="Ametista"then applyTheme(Color3.fromRGB(30,20,40),Color3.fromRGB(20,10,30),Color3.fromRGB(155,89,182))
elseif HubConfig.SelectedTheme=="Neon"then applyTheme(Color3.fromRGB(15,30,35),Color3.fromRGB(10,20,25),Color3.fromRGB(0,255,255))
elseif HubConfig.SelectedTheme=="Sakura"then applyTheme(Color3.fromRGB(40,25,30),Color3.fromRGB(30,15,20),Color3.fromRGB(255,153,204))end
end)

notif("⚡ Vortex Hub V19","Carregado com sucesso!","Success")
