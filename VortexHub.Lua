local CG=Pcall and game:GetService("CoreGui") or game:GetService("CoreGui")
local P=game:GetService("Players")
local L=game:GetService("Lighting")
local W=game:GetService("Workspace")
local TS=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local VU=game:GetService("VirtualUser")
local PPS=game:GetService("ProximityPromptService")
local HS=game:GetService("HttpService")
local SG=game:GetService("StarterGui")
local TeleportService=game:GetService("TeleportService")
local GuiService=game:GetService("GuiService")

local LP=P.LocalPlayer
local TP=(gethui and gethui())or CG

if TP:FindFirstChild("VortexGraphicsHub")then
    TP.VortexGraphicsHub:Destroy()
end

local SFName="VortexHub_Config.json"
local HC={
    Shaders=false,
    FpsBoost=false,
    WallBlur=true,
    Fog=false,
    MotionBlur=false,
    Fullbright=false,
    PlayerLight=false,
    AutoTime=false,
    RandomRain=false,
    ESPPlayer=false,
    ESPNPC=false,
    DangerESP=false,
    ESPItems=false,
    TeleportTool=false,
    InstantInteract=false,
    PlayerMods=false,
    NoCooldown=false,
    InfJump=false,
    Noclip=false,
    WalkSpeed=16,
    JumpPower=50,
    FOV=70,
    AntiFling=false,
    AntiVoid=false,
    AntiAfk=false,
    AutoRejoin=false,
    Notifications=true,
    SelectedTheme="Orion",
    Whitelist=true,
    InfiniteZoom=false,
    AntiExploitDetector=true,
    AutoAntiFling=true
}

local function loadC()
    if readfile and isfile and isfile(SFName)then
        local ok,data=pcall(function()
            return HS:JSONDecode(readfile(SFName))
        end)
        if ok and type(data)=="table"then
            for k,v in pairs(data)do
                HC[k]=v
            end
        end
    end
end

local function saveC()
    if writefile then
        pcall(function()
            writefile(SFName,HS:JSONEncode(HC))
        end)
    end
end

loadC()

local ijc,nlc,avc,pmc,aac,arc,atc,sLp,iic,fbLp,plc,mbc,afc,ncc,izc,adCn
local afToggle
local ozm=LP.CameraMaxZoomDistance
local tpLockUntil=0
local antiVoidLastCF=nil
local antiVoidLastTime=0
local teleportBusy=false
local freecamOn=false
local freecamConn
local freecamCam
local freecamPos
local freecamYaw=0
local freecamPitch=0

local eUp
local iUp
local dUp
local lUp
local ligPart

local eP={}
local iP={}
local dP={}
local ligP={}
local NData={}
local EData={}

local CurrentTarget=nil
local LoopGotoState=false
local ViewSpectateState=false

local HRec={}
local DetState={}
local historyCards={}
local detConnection
local afConnection
local toolConnection
local charConnection
local promptConnection
local noclipConnection
local zoomConnection
local afkConnection
local fpsConnection
local rainParts={}

local themes={
    Orion={
        Main=Color3.fromRGB(115,0,255),
        Bg=Color3.fromRGB(15,16,21),
        Card=Color3.fromRGB(23,24,31),
        Text=Color3.fromRGB(240,240,245),
        Sub=Color3.fromRGB(160,160,175)
    },
    Crimson={
        Main=Color3.fromRGB(220,45,60),
        Bg=Color3.fromRGB(18,13,15),
        Card=Color3.fromRGB(30,20,23),
        Text=Color3.fromRGB(245,240,242),
        Sub=Color3.fromRGB(180,155,165)
    },
    Ocean={
        Main=Color3.fromRGB(35,150,255),
        Bg=Color3.fromRGB(11,17,24),
        Card=Color3.fromRGB(18,28,38),
        Text=Color3.fromRGB(235,245,255),
        Sub=Color3.fromRGB(155,180,205)
    },
    Emerald={
        Main=Color3.fromRGB(40,210,125),
        Bg=Color3.fromRGB(10,18,14),
        Card=Color3.fromRGB(17,30,23),
        Text=Color3.fromRGB(235,250,240),
        Sub=Color3.fromRGB(155,190,170)
    }
}

local Theme=themes[HC.SelectedTheme]or themes.Orion

local function notify(txt,dur)
    if not HC.Notifications then return end
    pcall(function()
        SG:SetCore("SendNotification",{
            Title="Vortex Hub",
            Text=txt,
            Duration=dur or 3
        })
    end)
end

local function isFriend(plr)
    if not HC.Whitelist then return false end
    if plr==LP then return true end
    local ok,res=pcall(function()
        return LP:IsFriendsWith(plr.UserId)
    end)
    return ok and res
end

local function getChar()
    local c=LP.Character
    if not c then return nil,nil,nil end
    local h=c:FindFirstChildOfClass("Humanoid")
    local r=c:FindFirstChild("HumanoidRootPart")
    return c,h,r
end

local function getRoot(plr)
    if not plr then return nil end
    local c=plr.Character
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end

local function cInd(parent,col,txt)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(0,9,0,9)
    f.BackgroundColor3=col
    f.BorderSizePixel=0

    local cr=Instance.new("UICorner",f)
    cr.CornerRadius=UDim.new(1,0)

    local t=Instance.new("TextLabel",parent)
    t.BackgroundTransparency=1
    t.Size=UDim2.new(1,-16,1,0)
    t.Position=UDim2.new(0,16,0,0)
    t.Text=txt
    t.TextColor3=Theme.Text
    t.Font=Enum.Font.Gotham
    t.TextSize=12
    t.TextXAlignment=Enum.TextXAlignment.Left

    return f,t
end

local function cST(parent,text)
    local l=Instance.new("TextLabel",parent)
    l.BackgroundTransparency=1
    l.Size=UDim2.new(1,-20,0,28)
    l.Position=UDim2.new(0,10,0,0)
    l.Text=text
    l.TextColor3=Theme.Text
    l.Font=Enum.Font.GothamBold
    l.TextSize=13
    l.TextXAlignment=Enum.TextXAlignment.Left
    return l
end

local function cSection(parent,text)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,-14,0,28)
    f.BackgroundTransparency=1
    f.Position=UDim2.new(0,7,0,0)

    local l=Instance.new("TextLabel",f)
    l.BackgroundTransparency=1
    l.Size=UDim2.new(1,0,1,0)
    l.Text=text
    l.TextColor3=Theme.Main
    l.Font=Enum.Font.GothamBold
    l.TextSize=12
    l.TextXAlignment=Enum.TextXAlignment.Left

    return f
end

local function cBtn(parent,text,cb)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(1,-12,0,34)
    b.BackgroundColor3=Theme.Card
    b.BorderSizePixel=0
    b.Text=text
    b.TextColor3=Theme.Text
    b.Font=Enum.Font.GothamSemibold
    b.TextSize=12
    b.AutoButtonColor=false

    local cr=Instance.new("UICorner",b)
    cr.CornerRadius=UDim.new(0,8)

    b.MouseEnter:Connect(function()
        TS:Create(b,TweenInfo.new(.15),{BackgroundColor3=Theme.Main}):Play()
    end)

    b.MouseLeave:Connect(function()
        TS:Create(b,TweenInfo.new(.15),{BackgroundColor3=Theme.Card}):Play()
    end)

    b.Activated:Connect(function()
        pcall(cb)
    end)

    return b
end

local function cTog(name,parent,val,cb,key)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(1,-12,0,36)
    b.BackgroundColor3=Theme.Card
    b.BorderSizePixel=0
    b.Text=""
    b.AutoButtonColor=false

    local cr=Instance.new("UICorner",b)
    cr.CornerRadius=UDim.new(0,8)

    local l=Instance.new("TextLabel",b)
    l.BackgroundTransparency=1
    l.Position=UDim2.new(0,10,0,0)
    l.Size=UDim2.new(1,-65,1,0)
    l.Text=name
    l.TextColor3=Theme.Text
    l.Font=Enum.Font.GothamMedium
    l.TextSize=12
    l.TextXAlignment=Enum.TextXAlignment.Left

    local sw=Instance.new("Frame",b)
    sw.Size=UDim2.new(0,42,0,22)
    sw.Position=UDim2.new(1,-52,.5,-11)
    sw.BackgroundColor3=val and Theme.Main or Color3.fromRGB(55,57,65)
    sw.BorderSizePixel=0

    local scr=Instance.new("UICorner",sw)
    scr.CornerRadius=UDim.new(1,0)

    local knob=Instance.new("Frame",sw)
    knob.Size=UDim2.new(0,18,0,18)
    knob.Position=val and UDim2.new(1,-20,.5,-9) or UDim2.new(0,2,.5,-9)
    knob.BackgroundColor3=Color3.fromRGB(245,245,245)
    knob.BorderSizePixel=0

    local kcr=Instance.new("UICorner",knob)
    kcr.CornerRadius=UDim.new(1,0)

    local st=val

    local function sVS(ns)
        st=ns and true or false
        sw.BackgroundColor3=st and Theme.Main or Color3.fromRGB(55,57,65)
        TS:Create(knob,TweenInfo.new(.15),{
            Position=st and UDim2.new(1,-20,.5,-9) or UDim2.new(0,2,.5,-9)
        }):Play()

        if key then
            HC[key]=st
            saveC()
        end

        pcall(function()
            cb(st)
        end)
    end

    b.Activated:Connect(function()
        sVS(not st)
    end)

    return sVS,b
end

local function cSli(name,minv,maxv,val,parent,cb,key)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,-12,0,52)
    f.BackgroundColor3=Theme.Card
    f.BorderSizePixel=0

    local cr=Instance.new("UICorner",f)
    cr.CornerRadius=UDim.new(0,8)

    local lab=Instance.new("TextLabel",f)
    lab.BackgroundTransparency=1
    lab.Position=UDim2.new(0,10,0,5)
    lab.Size=UDim2.new(1,-20,0,18)
    lab.Text=name
    lab.TextColor3=Theme.Text
    lab.Font=Enum.Font.GothamMedium
    lab.TextSize=12
    lab.TextXAlignment=Enum.TextXAlignment.Left

    local valueLab=Instance.new("TextLabel",f)
    valueLab.BackgroundTransparency=1
    valueLab.Position=UDim2.new(1,-70,0,5)
    valueLab.Size=UDim2.new(0,60,0,18)
    valueLab.TextColor3=Theme.Sub
    valueLab.Font=Enum.Font.Gotham
    valueLab.TextSize=11
    valueLab.Text=tostring(math.floor(val*100)/100)
    valueLab.TextXAlignment=Enum.TextXAlignment.Right

    local bar=Instance.new("Frame",f)
    bar.Position=UDim2.new(0,10,0,31)
    bar.Size=UDim2.new(1,-20,0,8)
    bar.BackgroundColor3=Color3.fromRGB(45,47,54)
    bar.BorderSizePixel=0

    local br=Instance.new("UICorner",bar)
    br.CornerRadius=UDim.new(1,0)

    local fill=Instance.new("Frame",bar)
    fill.Size=UDim2.new((val-minv)/(maxv-minv),0,1,0)
    fill.BackgroundColor3=Theme.Main
    fill.BorderSizePixel=0

    local fr=Instance.new("UICorner",fill)
    fr.CornerRadius=UDim.new(1,0)

    local knob=Instance.new("TextButton",bar)
    knob.Size=UDim2.new(0,18,0,18)
    knob.Position=UDim2.new((val-minv)/(maxv-minv),-9,.5,-9)
    knob.BackgroundColor3=Color3.fromRGB(245,245,245)
    knob.BorderSizePixel=0
    knob.Text=""

    local kr=Instance.new("UICorner",knob)
    kr.CornerRadius=UDim.new(1,0)

    local dragging=false
    local current=val

    local function setVal(v)
        v=math.clamp(v,minv,maxv)
        current=v
        local a=(v-minv)/(maxv-minv)
        fill.Size=UDim2.new(a,0,1,0)
        knob.Position=UDim2.new(a,-9,.5,-9)
        valueLab.Text=tostring(math.floor(v*100)/100)

        if key then
            HC[key]=v
            saveC()
        end

        pcall(function()
            cb(v)
        end)
    end

    local function updateFromX(x)
        local a=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
        setVal(minv+(maxv-minv)*a)
    end

    knob.MouseButton1Down:Connect(function()
        dragging=true
    end)

    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dragging=false
        end
    end)

    UIS.InputChanged:Connect(function(i)
        if dragging and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
            updateFromX(i.Position.X)
        end
    end)

    return setVal
end

local function cEGui(tM)
    if not tM then return nil end

    local r=tM:FindFirstChild("HumanoidRootPart")or tM.PrimaryPart
    local h=tM:FindFirstChildOfClass("Humanoid")
    if not r then return nil end

    local bg=Instance.new("BillboardGui")
    bg.Name="VortexESP"
    bg.Size=UDim2.new(0,180,0,45)
    bg.StudsOffset=Vector3.new(0,3.2,0)
    bg.AlwaysOnTop=true
    bg.Adornee=r
    bg.Parent=r

    local el=Instance.new("TextLabel",bg)
    el.BackgroundTransparency=1
    el.Size=UDim2.new(1,0,1,0)
    el.Text=tM.Name
    el.TextColor3=Color3.fromRGB(255,255,255)
    el.TextStrokeTransparency=.25
    el.Font=Enum.Font.GothamBold
    el.TextSize=13

    return{
        Gui=bg,
        Humanoid=h,
        Root=r,
        Label=el,
        Model=tM
    }
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
    if eUp then
        eUp:Disconnect()
        eUp=nil
    end

    if not HC.ESPPlayer then
        return
    end

    eP={}
    for _,plr in ipairs(P:GetPlayers())do
        if plr~=LP and not isFriend(plr)and plr.Character then
            local d=cEGui(plr.Character)
            if d then
                eP[plr]=d
            end
        end
    end

    eUp=RS.RenderStepped:Connect(function()
        local _,_,lr=getChar()
        for plr,d in pairs(eP)do
            if not plr.Parent then
                if d.Gui then d.Gui:Destroy()end
                eP[plr]=nil
            else
                local ch=plr.Character
                local root=ch and ch:FindFirstChild("HumanoidRootPart")
                if root and d.Gui then
                    d.Gui.Adornee=root
                    local dist=lr and math.floor((lr.Position-root.Position).Magnitude)or 0
                    d.Label.Text=plr.Name.." ["..dist.." Studs]"
                elseif d.Gui then
                    d.Gui.Enabled=false
                end
            end
        end

        for _,plr in ipairs(P:GetPlayers())do
            if plr~=LP and not isFriend(plr)and plr.Character and not eP[plr]then
                local d=cEGui(plr.Character)
                if d then
                    eP[plr]=d
                end
            end
        end
    end)
end

local function cItemGui(itemPart)
    local g=Instance.new("BillboardGui")
    g.Name="VortexItemESP"
    g.Size=UDim2.new(0,180,0,42)
    g.StudsOffset=Vector3.new(0,1.8,0)
    g.AlwaysOnTop=true
    g.Adornee=itemPart
    g.Parent=itemPart

    local l=Instance.new("TextLabel",g)
    l.BackgroundTransparency=1
    l.Size=UDim2.new(1,0,1,0)
    l.TextColor3=Color3.fromRGB(255,230,80)
    l.TextStrokeTransparency=.2
    l.Font=Enum.Font.GothamBold
    l.TextSize=12
    l.Text=itemPart.Name

    return{
        Gui=g,
        Label=l,
        Part=itemPart
    }
end

local function uItemESP()
    cETb(iP)

    if not HC.ESPItems then
        if iUp then iUp:Disconnect()iUp=nil end
        return
    end

    local function scan()
        cETb(iP)

        for _,obj in ipairs(W:GetDescendants())do
            if obj:IsA("BasePart")and(obj.Name:lower():find("item")or obj.Name:lower():find("coin")or obj.Name:lower():find("tool")or obj.Name:lower():find("key")or obj.Name:lower():find("gem"))then
                local d=cItemGui(obj)
                if d then
                    iP[#iP+1]=d
                end
            end
        end
    end

    scan()

    if iUp then iUp:Disconnect()end
    iUp=task.spawn(function()
        while HC.ESPItems do
            task.wait(2.5)
            if HC.ESPItems then
                scan()
            end
        end
    end)
end

local function iHN(n)
    local s=tostring(n):lower()
    return s:find("npc")or s:find("enemy")or s:find("monster")or s:find("bot")or s:find("dummy")or s:find("guard")
end

local function cDEsp(m)
    local r=m:FindFirstChild("HumanoidRootPart")or m.PrimaryPart
    if not r then return nil end

    local g=Instance.new("BillboardGui")
    g.Name="VortexDangerESP"
    g.Size=UDim2.new(0,200,0,46)
    g.StudsOffset=Vector3.new(0,3,0)
    g.AlwaysOnTop=true
    g.Adornee=r
    g.Parent=r

    local l=Instance.new("TextLabel",g)
    l.BackgroundTransparency=1
    l.Size=UDim2.new(1,0,1,0)
    l.Text="⚠ "..m.Name
    l.TextColor3=Color3.fromRGB(255,85,65)
    l.TextStrokeTransparency=.15
    l.Font=Enum.Font.GothamBold
    l.TextSize=13

    return{
        Gui=g,
        Label=l,
        Root=r,
        Model=m
    }
end

local function uDEsp()
    cETb(dP)

    if not HC.DangerESP and not HC.ESPNPC then
        if dUp then dUp:Disconnect()dUp=nil end
        return
    end

    for _,obj in ipairs(W:GetDescendants())do
        if obj:IsA("Model")and obj~=LP.Character and obj:FindFirstChildOfClass("Humanoid")then
            local isDanger=iHN(obj.Name)
            if(HC.DangerESP and isDanger)or(HC.ESPNPC and not isDanger)then
                local d=cDEsp(obj)
                if d then
                    dP[obj]=d
                end
            end
        end
    end

    if dUp then dUp:Disconnect()end
    dUp=RS.RenderStepped:Connect(function()
        for m,d in pairs(dP)do
            if not m.Parent then
                if d.Gui then d.Gui:Destroy()end
                dP[m]=nil
            else
                local r=m:FindFirstChild("HumanoidRootPart")or m.PrimaryPart
                if r then
                    d.Gui.Adornee=r
                    if HC.DangerESP and iHN(m.Name)then
                        d.Label.Text="⚠ "..m.Name
                        d.Label.TextColor3=Color3.fromRGB(255,75,65)
                    else
                        d.Label.Text=m.Name
                        d.Label.TextColor3=Color3.fromRGB(255,220,75)
                    end
                end
            end
        end
    end)
end

local function rLig()
    if ligPart then
        ligPart:Destroy()
        ligPart=nil
    end
    if lUp then
        lUp:Disconnect()
        lUp=nil
    end
end

local function uLig()
    rLig()

    if not HC.PlayerLight then
        return
    end

    local _,_,root=getChar()
    if not root then return end

    local p=Instance.new("PointLight")
    p.Name="VortexPlayerLight"
    p.Brightness=2
    p.Range=24
    p.Shadows=true
    p.Parent=root
    ligPart=p

    lUp=LP.CharacterAdded:Connect(function(ch)
        task.wait(.5)
        if HC.PlayerLight then
            uLig()
        end
    end)
end

local function applyLighting()
    if HC.Fullbright then
        L.Brightness=3
        L.ClockTime=14
        L.FogEnd=100000
        L.GlobalShadows=false
        L.OutdoorAmbient=Color3.fromRGB(200,200,200)
        L.Ambient=Color3.fromRGB(200,200,200)
    end

    if HC.Fog then
        L.FogStart=0
        L.FogEnd=150
    else
        L.FogEnd=100000
    end
end

local function clearLightingEffects()
    for _,v in ipairs(L:GetChildren())do
        if v.Name:sub(1,7)=="Vortex_"then
            v:Destroy()
        end
    end
end

local function updateGraphics()
    clearLightingEffects()

    if HC.WallBlur then
        local b=Instance.new("BlurEffect")
        b.Name="Vortex_WallBlur"
        b.Size=4
        b.Parent=L
    end

    if HC.MotionBlur then
        local b=Instance.new("BlurEffect")
        b.Name="Vortex_MotionBlur"
        b.Size=6
        b.Parent=L
    end

    if HC.Shaders then
        local cc=Instance.new("ColorCorrectionEffect")
        cc.Name="Vortex_Shader"
        cc.Contrast=.15
        cc.Saturation=.12
        cc.Brightness=.03
        cc.Parent=L

        local bloom=Instance.new("BloomEffect")
        bloom.Name="Vortex_Bloom"
        bloom.Intensity=.25
        bloom.Size=24
        bloom.Threshold=.8
        bloom.Parent=L
    end

    applyLighting()
end

local function setFpsBoost(on)
    if on then
        for _,obj in ipairs(W:GetDescendants())do
            if obj:IsA("ParticleEmitter")or obj:IsA("Trail")or obj:IsA("Smoke")or obj:IsA("Fire")then
                pcall(function()obj.Enabled=false end)
            elseif obj:IsA("BasePart")then
                pcall(function()
                    if obj.Material~=Enum.Material.Plastic and obj.Material~=Enum.Material.SmoothPlastic then
                        obj.Material=Enum.Material.Plastic
                    end
                end)
            end
        end
    end
end

local function addRain()
    for _,v in ipairs(rainParts)do
        if v and v.Parent then
            v:Destroy()
        end
    end
    table.clear(rainParts)

    if not HC.RandomRain then return end

    local folder=Instance.new("Folder",W)
    folder.Name="VortexRain"

    for i=1,80 do
        local p=Instance.new("Part")
        p.Anchored=true
        p.CanCollide=false
        p.CanQuery=false
        p.CanTouch=false
        p.Transparency=.45
        p.Size=Vector3.new(.05,2.5,.05)
        p.Material=Enum.Material.Neon
        p.Parent=folder
        rainParts[#rainParts+1]=p
    end

    task.spawn(function()
        while HC.RandomRain and folder.Parent do
            local _,_,root=getChar()
            if root then
                for _,p in ipairs(rainParts)do
                    p.Position=root.Position+Vector3.new(math.random(-55,55),math.random(18,45),math.random(-55,55))
                end
            end
            task.wait(.08)
        end
        if folder.Parent then
            folder:Destroy()
        end
    end)
end

local function teleportTo(cf)
    local _,hum,root=getChar()
    if not root then return false end

    tpLockUntil=os.clock()+1.5
    teleportBusy=true
    antiVoidLastCF=cf
    antiVoidLastTime=os.clock()

    root.AssemblyLinearVelocity=Vector3.zero
    root.AssemblyAngularVelocity=Vector3.zero
    root.CFrame=cf

    if hum then
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end

    task.delay(.35,function()
        local _,_,r=getChar()
        if r then
            r.AssemblyLinearVelocity=Vector3.zero
            r.AssemblyAngularVelocity=Vector3.zero
        end
        teleportBusy=false
    end)

    return true
end

local function createTeleportTool()
    if toolConnection then
        toolConnection:Disconnect()
        toolConnection=nil
    end

    local backpack=LP:FindFirstChildOfClass("Backpack")
    if not backpack then return end

    for _,v in ipairs(backpack:GetChildren())do
        if v.Name=="Vortex Teleport"then
            v:Destroy()
        end
    end

    local ch=LP.Character
    if ch then
        for _,v in ipairs(ch:GetChildren())do
            if v:IsA("Tool")and v.Name=="Vortex Teleport"then
                v:Destroy()
            end
        end
    end

    if not HC.TeleportTool then return end

    local tool=Instance.new("Tool")
    tool.Name="Vortex Teleport"
    tool.RequiresHandle=false
    tool.CanBeDropped=false
    tool.ToolTip="Toque no local para teleportar"
    tool.Parent=backpack

    local mouse=LP:GetMouse()

    toolConnection=tool.Activated:Connect(function()
        if not HC.TeleportTool then return end

        local hit=mouse.Hit
        if hit then
            local pos=hit.Position+Vector3.new(0,3,0)
            teleportTo(CFrame.new(pos))
            notify("Teleportado para "..math.floor(pos.X)..", "..math.floor(pos.Y)..", "..math.floor(pos.Z))
        end
    end)
end

local function maintainTeleportTool()
    if HC.TeleportTool then
        task.wait(.7)
        createTeleportTool()
    end
end

charConnection=LP.CharacterAdded:Connect(function()
    task.wait(1)
    maintainTeleportTool()

    local _,hum,root=getChar()
    if hum then
        hum.WalkSpeed=HC.WalkSpeed
        hum.UseJumpPower=true
        hum.JumpPower=HC.JumpPower
    end

    if root and antiVoidLastCF==nil then
        antiVoidLastCF=root.CFrame
    end

    if HC.PlayerLight then
        uLig()
    end
end)

local function toggleNoclip(state)
    if ncc then
        ncc:Disconnect()
        ncc=nil
    end

    if not state then
        local ch=LP.Character
        if ch then
            for _,v in ipairs(ch:GetDescendants())do
                if v:IsA("BasePart")then
                    pcall(function()
                        v.CanCollide=true
                    end)
                end
            end
        end
        return
    end

    ncc=RS.Stepped:Connect(function()
        local ch=LP.Character
        if not ch then return end
        for _,v in ipairs(ch:GetDescendants())do
            if v:IsA("BasePart")then
                pcall(function()
                    v.CanCollide=false
                end)
            end
        end
    end)
end

local function toggleInfJump(state)
    if ijc then
        ijc:Disconnect()
        ijc=nil
    end

    if not state then return end

    ijc=UIS.JumpRequest:Connect(function()
        local _,hum=getChar()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

local function togglePlayerMods(state)
    if pmc then
        pmc:Disconnect()
        pmc=nil
    end

    if not state then return end

    pmc=RS.RenderStepped:Connect(function()
        local _,hum=getChar()
        if hum then
            hum.WalkSpeed=HC.WalkSpeed
            hum.UseJumpPower=true
            hum.JumpPower=HC.JumpPower
        end
    end)
end

local function toggleInstantInteract(state)
    if iic then
        iic:Disconnect()
        iic=nil
    end

    if not state then return end

    for _,p in ipairs(W:GetDescendants())do
        if p:IsA("ProximityPrompt")then
            p.HoldDuration=0
        end
    end

    iic=RS.Heartbeat:Connect(function()
        for _,p in ipairs(W:GetDescendants())do
            if p:IsA("ProximityPrompt")then
                p.HoldDuration=0
                p.MaxActivationDistance=math.max(p.MaxActivationDistance,100)
            end
        end
    end)
end

local function toggleInfiniteZoom(state)
    if zoomConnection then
        zoomConnection:Disconnect()
        zoomConnection=nil
    end

    if state then
        ozm=LP.CameraMaxZoomDistance
        LP.CameraMaxZoomDistance=math.huge

        zoomConnection=RS.RenderStepped:Connect(function()
            if HC.InfiniteZoom then
                LP.CameraMaxZoomDistance=math.huge
            end
        end)
    else
        LP.CameraMaxZoomDistance=ozm or 128
    end
end

local function antiVoidStart()
    if avc then
        avc:Disconnect()
        avc=nil
    end

    if not HC.AntiVoid then return end

    avc=RS.Heartbeat:Connect(function()
        if not HC.AntiVoid then return end

        local _,hum,root=getChar()
        if not root or not hum then return end

        local now=os.clock()

        if now<tpLockUntil or teleportBusy then
            antiVoidLastCF=root.CFrame
            antiVoidLastTime=now
            return
        end

        if hum.Health<=0 then return end

        if root.Position.Y>8 and root.AssemblyLinearVelocity.Y>-120 then
            antiVoidLastCF=root.CFrame
            antiVoidLastTime=now
        end

        if root.Position.Y<-20 and antiVoidLastCF then
            teleportTo(antiVoidLastCF)
            notify("Anti-Void: retornando ao último local seguro")
        end
    end)
end

local function antiFlingStart()
    if afc then
        afc:Disconnect()
        afc=nil
    end

    if not HC.AntiFling then return end

    afc=RS.Heartbeat:Connect(function()
        if not HC.AntiFling then return end
        if os.clock()<tpLockUntil or teleportBusy then return end

        local _,_,root=getChar()
        if not root then return end

        local vel=root.AssemblyLinearVelocity
        if vel.Magnitude>180 then
            root.AssemblyLinearVelocity=Vector3.zero
            root.AssemblyAngularVelocity=Vector3.zero
            notify("Anti-Fling bloqueou uma velocidade anormal",2)
        end
    end)
end

local function antiAfkStart()
    if afkConnection then
        afkConnection:Disconnect()
        afkConnection=nil
    end

    if not HC.AntiAfk then return end

    afkConnection=LP.Idled:Connect(function()
        pcall(function()
            VU:CaptureController()
            VU:ClickButton2(Vector2.new())
        end)
    end)
end

local function applyFov()
    local cam=W.CurrentCamera
    if cam then
        cam.FieldOfView=HC.FOV
    end
end

local function autoRejoinStart()
    if arc then
        arc:Disconnect()
        arc=nil
    end

    if not HC.AutoRejoin then return end

    arc=GuiService.ErrorMessageChanged:Connect(function()
        if not HC.AutoRejoin then return end
        task.wait(1)
        pcall(function()
            TeleportService:Teleport(game.PlaceId,LP)
        end)
    end)
end

local function randomRainUpdate()
    addRain()
end

local function playerModsRefresh()
    local _,hum=getChar()
    if hum then
        hum.WalkSpeed=HC.WalkSpeed
        hum.UseJumpPower=true
        hum.JumpPower=HC.JumpPower
    end
end

local function hCard(parent,plr,joined)
    local card=Instance.new("Frame",parent)
    card.Size=UDim2.new(1,-12,0,72)
    card.BackgroundColor3=Theme.Card
    card.BorderSizePixel=0

    local cr=Instance.new("UICorner",card)
    cr.CornerRadius=UDim.new(0,8)

    local dot=Instance.new("Frame",card)
    dot.Size=UDim2.new(0,10,0,10)
    dot.Position=UDim2.new(0,10,0,12)
    dot.BackgroundColor3=joined and Color3.fromRGB(45,220,110)or Color3.fromRGB(255,100,70)
    dot.BorderSizePixel=0

    local dr=Instance.new("UICorner",dot)
    dr.CornerRadius=UDim.new(1,0)

    local title=Instance.new("TextLabel",card)
    title.BackgroundTransparency=1
    title.Position=UDim2.new(0,28,0,5)
    title.Size=UDim2.new(1,-38,0,20)
    title.Text=plr.Name
    title.TextColor3=Theme.Text
    title.Font=Enum.Font.GothamBold
    title.TextSize=12
    title.TextXAlignment=Enum.TextXAlignment.Left

    local time=Instance.new("TextLabel",card)
    time.BackgroundTransparency=1
    time.Position=UDim2.new(0,28,0,27)
    time.Size=UDim2.new(1,-38,0,17)
    time.Text=(joined and"Entrada: "or"Saída: ")..os.date("%H:%M:%S")
    time.TextColor3=Theme.Sub
    time.Font=Enum.Font.Gotham
    time.TextSize=10
    time.TextXAlignment=Enum.TextXAlignment.Left

    local status=Instance.new("TextLabel",card)
    status.BackgroundTransparency=1
    status.Position=UDim2.new(0,28,0,45)
    status.Size=UDim2.new(1,-38,0,18)
    status.Text=joined and"Jogador entrou no servidor"or"Jogador saiu do servidor"
    status.TextColor3=joined and Color3.fromRGB(70,220,125)or Color3.fromRGB(255,130,85)
    status.Font=Enum.Font.GothamMedium
    status.TextSize=9
    status.TextXAlignment=Enum.TextXAlignment.Left

    historyCards[plr.UserId]=card

    return card
end

local function addHistory(plr,joined)
    local rec={
        UserId=plr.UserId,
        Name=plr.Name,
        Joined=joined,
        Time=os.date("%H:%M:%S"),
        Timestamp=os.time()
    }

    HRec[#HRec+1]=rec
end

local function closeHistoryCard(plr)
    local card=historyCards[plr.UserId]
    if card then
        local status=card:FindFirstChildOfClass("TextLabel")
        if status then
            status.Text="Saída: "..os.date("%H:%M:%S")
        end
    else
        addHistory(plr,false)
    end
    historyCards[plr.UserId]=nil
end

local function leftNotify(title,text,kind)
    if not HC.Notifications then return end

    local holder=UI:FindFirstChild("NotifyHolder")
    if not holder then return end

    local f=Instance.new("Frame",holder)
    f.AnchorPoint=Vector2.new(1,0)
    f.Position=UDim2.new(1,280,0,0)
    f.Size=UDim2.new(0,265,0,70)
    f.BackgroundColor3=Theme.Card
    f.BorderSizePixel=0

    local cr=Instance.new("UICorner",f)
    cr.CornerRadius=UDim.new(0,10)

    local bar=Instance.new("Frame",f)
    bar.Size=UDim2.new(0,4,1,0)
    bar.BackgroundColor3=kind=="join" and Color3.fromRGB(50,220,110)or Color3.fromRGB(255,100,70)
    bar.BorderSizePixel=0

    local a=Instance.new("TextLabel",f)
    a.BackgroundTransparency=1
    a.Position=UDim2.new(0,14,0,8)
    a.Size=UDim2.new(1,-25,0,21)
    a.Text=title
    a.TextColor3=Theme.Text
    a.Font=Enum.Font.GothamBold
    a.TextSize=12
    a.TextXAlignment=Enum.TextXAlignment.Left

    local b=Instance.new("TextLabel",f)
    b.BackgroundTransparency=1
    b.Position=UDim2.new(0,14,0,31)
    b.Size=UDim2.new(1,-25,0,29)
    b.Text=text
    b.TextColor3=Theme.Sub
    b.Font=Enum.Font.Gotham
    b.TextSize=10
    b.TextWrapped=true
    b.TextXAlignment=Enum.TextXAlignment.Left

    TS:Create(f,TweenInfo.new(.28,Enum.EasingStyle.Quart),{
        Position=UDim2.new(1,-10,0,0)
    }):Play()

    task.delay(3.5,function()
        if f.Parent then
            local tw=TS:Create(f,TweenInfo.new(.25,Enum.EasingStyle.Quart),{
                Position=UDim2.new(1,280,0,0)
            })
            tw:Play()
            tw.Completed:Wait()
            f:Destroy()
        end
    end)
end

local function detectorStart()
    if detConnection then
        detConnection:Disconnect()
        detConnection=nil
    end

    table.clear(DetState)

    if not HC.AntiExploitDetector then return end

    detConnection=RS.Heartbeat:Connect(function()
        for _,plr in ipairs(P:GetPlayers())do
            if plr~=LP and not isFriend(plr)then
                local root=getRoot(plr)
                if root then
                    local now=os.clock()
                    local pos=root.Position
                    local st=DetState[plr]

                    if not st then
                        DetState[plr]={
                            pos=pos,
                            time=now,
                            lastAlert=0
                        }
                    else
                        local dt=math.max(now-st.time,.03)
                        local dist=(pos-st.pos).Magnitude
                        local speed=dist/dt
                        local vertical=math.abs(pos.Y-st.pos.Y)

                        local anomaly=false
                        local reason=""

                        if speed>150 then
                            anomaly=true
                            reason="movimento muito rápido"
                        elseif vertical>45 and speed>70 then
                            anomaly=true
                            reason="movimento vertical anormal"
                        end

                        if anomaly and now-st.lastAlert>4 then
                            st.lastAlert=now
                            leftNotify(
                                "⚠ Possível anomalia",
                                plr.Name.." • "..reason,
                                "exit"
                            )

                            if HC.AutoAntiFling and afToggle then
                                pcall(function()
                                    afToggle(true)
                                end)
                            end
                        end

                        st.pos=pos
                        st.time=now
                    end
                end
            end
        end
    end)
end

local function autoAntiFling(state)
    if state then
        if not HC.AntiFling then
            HC.AntiFling=true
            saveC()
            antiFlingStart()
        end
    end
end

local function gotoTarget(plr)
    if not plr then return end
    local r=getRoot(plr)
    if not r then
        notify("Jogador sem personagem carregado")
        return
    end

    teleportTo(r.CFrame*CFrame.new(0,0,5))
    notify("Teleportado para "..plr.Name)
end

local function spectateTarget(plr)
    if not plr then return end
    local hum=plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
    local cam=W.CurrentCamera

    if ViewSpectateState then
        ViewSpectateState=false
        if cam then
            local _,lh=getChar()
            if lh then
                cam.CameraSubject=lh
            end
        end
        notify("Spectate desativado")
    else
        if hum and cam then
            ViewSpectateState=true
            cam.CameraSubject=hum
            notify("Observando "..plr.Name)
        end
    end
end

local function loopGoto(plr,state)
    if not plr then return end

    LoopGotoState=state

    if not state then
        notify("Loop Goto desativado")
        return
    end

    notify("Loop Goto ativado")

    task.spawn(function()
        while LoopGotoState and plr.Parent do
            local r=getRoot(plr)
            if r then
                teleportTo(r.CFrame*CFrame.new(0,0,5))
            end
            task.wait(.5)
        end
    end)
end

local function headpet(plr)
    local _,_,myRoot=getChar()
    local tr=getRoot(plr)
    if not myRoot or not tr then
        notify("Não foi possível usar Headpet")
        return
    end

    local hpOrigCF=myRoot.CFrame
    myRoot.CFrame=tr.CFrame*CFrame.new(0,3.2,0)
    notify("Headpet em "..plr.Name)

    task.delay(2,function()
        if hpOrigCF and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")then
            LP.Character.HumanoidRootPart.CFrame=hpOrigCF
        end
    end)
end

local function beginFreecam()
    if freecamOn then return end

    local cam=W.CurrentCamera
    if not cam then return end

    freecamOn=true
    freecamCam=cam
    freecamPos=cam.CFrame.Position
    freecamYaw=0
    freecamPitch=0

    local root=getRoot(LP)
    if root then
        freecamPos=root.Position+Vector3.new(0,5,0)
    end

    freecamConn=RS.RenderStepped:Connect(function(dt)
        if not freecamOn or not freecamCam then return end

        local move=Vector3.zero
        local cf=CFrame.Angles(0,freecamYaw,0)
        local forward=cf.LookVector
        local right=cf.RightVector

        if UIS:IsKeyDown(Enum.KeyCode.W)then move+=forward end
        if UIS:IsKeyDown(Enum.KeyCode.S)then move-=forward end
        if UIS:IsKeyDown(Enum.KeyCode.D)then move+=right end
        if UIS:IsKeyDown(Enum.KeyCode.A)then move-=right end
        if UIS:IsKeyDown(Enum.KeyCode.Space)then move+=Vector3.new(0,1,0)end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl)then move-=Vector3.new(0,1,0)end

        if move.Magnitude>0 then
            freecamPos+=move.Unit*80*dt
        end

        freecamCam.CameraType=Enum.CameraType.Scriptable
        freecamCam.CFrame=
            CFrame.new(freecamPos)*
            CFrame.Angles(freecamPitch,freecamYaw,0)
    end)

    notify("Freecam ativada")
end

local function endFreecam()
    freecamOn=false

    if freecamConn then
        freecamConn:Disconnect()
        freecamConn=nil
    end

    local cam=W.CurrentCamera
    if cam then
        cam.CameraType=Enum.CameraType.Custom
        local _,hum=getChar()
        if hum then
            cam.CameraSubject=hum
        end
    end

    notify("Freecam desativada")
end

local function addPlayerMods()
    playerModsRefresh()
    applyFov()
end

local function clearTab(sc)
    for _,v in ipairs(sc:GetChildren())do
        if not v:IsA("UIListLayout")then
            v:Destroy()
        end
    end
end

UI=Instance.new("ScreenGui")
UI.Name="VortexGraphicsHub"
UI.ResetOnSpawn=false
UI.IgnoreGuiInset=true
UI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
UI.Parent=TP

local notifyHolder=Instance.new("Frame",UI)
notifyHolder.Name="NotifyHolder"
notifyHolder.AnchorPoint=Vector2.new(1,0)
notifyHolder.Position=UDim2.new(1,-10,0,95)
notifyHolder.Size=UDim2.new(0,280,0,330)
notifyHolder.BackgroundTransparency=1
notifyHolder.ClipsDescendants=false

local nlay=Instance.new("UIListLayout",notifyHolder)
nlay.Padding=UDim.new(0,7)
nlay.HorizontalAlignment=Enum.HorizontalAlignment.Right
nlay.SortOrder=Enum.SortOrder.LayoutOrder

local Main=Instance.new("Frame",UI)
Main.Size=UDim2.new(0,480,0,530)
Main.Position=UDim2.new(.5,-240,.5,-265)
Main.BackgroundColor3=Theme.Bg
Main.BorderSizePixel=0
Main.Active=true
Main.Draggable=true

local mcr=Instance.new("UICorner",Main)
mcr.CornerRadius=UDim.new(0,12)

local stroke=Instance.new("UIStroke",Main)
stroke.Color=Theme.Main
stroke.Transparency=.35

local Top=Instance.new("Frame",Main)
Top.Size=UDim2.new(1,0,0,54)
Top.BackgroundColor3=Theme.Card
Top.BorderSizePixel=0

local tcr=Instance.new("UICorner",Top)
tcr.CornerRadius=UDim.new(0,12)

local title=Instance.new("TextLabel",Top)
title.BackgroundTransparency=1
title.Position=UDim2.new(0,15,0,5)
title.Size=UDim2.new(1,-60,0,25)
title.Text="⚡ Vortex Hub V18 - Supreme"
title.TextColor3=Theme.Text
title.Font=Enum.Font.GothamBold
title.TextSize=15
title.TextXAlignment=Enum.TextXAlignment.Left

local sub=Instance.new("TextLabel",Top)
sub.BackgroundTransparency=1
sub.Position=UDim2.new(0,16,0,30)
sub.Size=UDim2.new(1,-60,0,18)
sub.Text="Graphics • Player • Proteções • Viewer"
sub.TextColor3=Theme.Sub
sub.Font=Enum.Font.Gotham
sub.TextSize=9
sub.TextXAlignment=Enum.TextXAlignment.Left

local close=Instance.new("TextButton",Top)
close.Size=UDim2.new(0,35,0,35)
close.Position=UDim2.new(1,-45,.5,-17)
close.BackgroundColor3=Color3.fromRGB(40,40,47)
close.BorderSizePixel=0
close.Text="×"
close.TextColor3=Theme.Text
close.Font=Enum.Font.GothamBold
close.TextSize=20

local ccr=Instance.new("UICorner",close)
ccr.CornerRadius=UDim.new(0,8)

local Side=Instance.new("Frame",Main)
Side.Position=UDim2.new(0,8,0,62)
Side.Size=UDim2.new(0,125,1,-70)
Side.BackgroundColor3=Theme.Card
Side.BorderSizePixel=0

local scr=Instance.new("UICorner",Side)
scr.CornerRadius=UDim.new(0,9)

local sideList=Instance.new("UIListLayout",Side)
sideList.Padding=UDim.new(0,5)
sideList.HorizontalAlignment=Enum.HorizontalAlignment.Center
sideList.SortOrder=Enum.SortOrder.LayoutOrder

local Content=Instance.new("Frame",Main)
Content.Position=UDim2.new(0,141,0,62)
Content.Size=UDim2.new(1,-149,1,-70)
Content.BackgroundTransparency=1

local Pages={}
local TabButtons={}

local function createTab(name)
    local b=Instance.new("TextButton",Side)
    b.Size=UDim2.new(1,-10,0,39)
    b.BackgroundColor3=Theme.Bg
    b.BorderSizePixel=0
    b.Text=name
    b.TextColor3=Theme.Text
    b.Font=Enum.Font.GothamSemibold
    b.TextSize=10
    b.AutoButtonColor=false

    local br=Instance.new("UICorner",b)
    br.CornerRadius=UDim.new(0,7)

    local s=Instance.new("ScrollingFrame",Content)
    s.Size=UDim2.new(1,0,1,0)
    s.BackgroundTransparency=1
    s.BorderSizePixel=0
    s.ScrollBarThickness=3
    s.ScrollBarImageColor3=Theme.Main
    s.Visible=false
    s.CanvasSize=UDim2.new(0,0,0,0)
    s.AutomaticCanvasSize=Enum.AutomaticSize.Y

    local pad=Instance.new("UIPadding",s)
    pad.PaddingTop=UDim.new(0,4)
    pad.PaddingBottom=UDim.new(0,8)
    pad.PaddingLeft=UDim.new(0,2)
    pad.PaddingRight=UDim.new(0,2)

    local lay=Instance.new("UIListLayout",s)
    lay.Padding=UDim.new(0,6)
    lay.HorizontalAlignment=Enum.HorizontalAlignment.Center
    lay.SortOrder=Enum.SortOrder.LayoutOrder

    Pages[name]=s
    TabButtons[name]=b

    b.Activated:Connect(function()
        for _,pg in pairs(Pages)do
            pg.Visible=false
        end
        for _,tb in pairs(TabButtons)do
            tb.BackgroundColor3=Theme.Bg
        end
        s.Visible=true
        b.BackgroundColor3=Theme.Main
    end)

    return s
end

local sM=createTab("🔧 Princ.")
local sE=createTab("👁️ ESPS")
local sP=createTab("👤 Player")
local sPr=createTab("🛡️ Prot.")
local sH=createTab("📜 Hist.")
local sT=createTab("🎨 Temas")
local sV=createTab("👀 Viewer")

local function setMainVisible(v)
    Main.Visible=v
end

close.Activated:Connect(function()
    setMainVisible(false)
end)

local open=Instance.new("TextButton",UI)
open.Name="VortexOpen"
open.Size=UDim2.new(0,94,0,38)
open.Position=UDim2.new(0,15,.5,-19)
open.BackgroundColor3=Theme.Main
open.BorderSizePixel=0
open.Text="⚡ Vortex"
open.TextColor3=Theme.Text
open.Font=Enum.Font.GothamBold
open.TextSize=12
open.Visible=true
open.AutoButtonColor=false

local orc=Instance.new("UICorner",open)
orc.CornerRadius=UDim.new(0,9)

open.Activated:Connect(function()
    Main.Visible=not Main.Visible
end)

cST(sM,"✨ GRÁFICOS")

local function addGap(parent,h)
    local f=Instance.new("Frame",parent)
    f.Size=UDim2.new(1,-12,0,h)
    f.BackgroundTransparency=1
    return f
end

local shSet=cTog("Shaders",sM,HC.Shaders,function(v)
    HC.Shaders=v
    updateGraphics()
end,"Shaders")

local fpsSet=cTog("🚀 FPS Boost",sM,HC.FpsBoost,function(v)
    HC.FpsBoost=v
    setFpsBoost(v)
end,"FpsBoost")

local wallSet=cTog("🌀 Wall Blur",sM,HC.WallBlur,function(v)
    HC.WallBlur=v
    updateGraphics()
end,"WallBlur")

local fogSet=cTog("🌫 Fog",sM,HC.Fog,function(v)
    HC.Fog=v
    updateGraphics()
end,"Fog")

local mbSet=cTog("💨 Motion Blur",sM,HC.MotionBlur,function(v)
    HC.MotionBlur=v
    updateGraphics()
end,"MotionBlur")

local fbSet=cTog("☀ Fullbright",sM,HC.Fullbright,function(v)
    HC.Fullbright=v
    updateGraphics()
end,"Fullbright")

local plSet=cTog("🔦 Player Light",sM,HC.PlayerLight,function(v)
    HC.PlayerLight=v
    if v then
        uLig()
    else
        rLig()
    end
end,"PlayerLight")

local atSet=cTog("🕒 Auto Time",sM,HC.AutoTime,function(v)
    HC.AutoTime=v
    if atc then
        atc:Disconnect()
        atc=nil
    end
    if v then
        atc=RS.Heartbeat:Connect(function()
            L.ClockTime=(os.clock()*2)%24
        end)
    end
end,"AutoTime")

local rainSet=cTog("🌧 Random Rain",sM,HC.RandomRain,function(v)
    HC.RandomRain=v
    randomRainUpdate()
end,"RandomRain")

cST(sM,"⚙ CONFIGURAÇÕES")

cBtn(sM,"💾 Salvar Configuração",function()
    saveC()
    notify("Configuração salva")
end)

cBtn(sM,"🔄 Restaurar Configuração",function()
    loadC()
    notify("Configuração carregada")
end)

cBtn(sM,"📌 Resetar Interface",function()
    Main.Position=UDim2.new(.5,-240,.5,-265)
end)

cST(sE,"👁️ PLAYER ESP")

cTog("ESP Player",sE,HC.ESPPlayer,function(v)
    HC.ESPPlayer=v
    if not v then
        cETb(eP)
        if eUp then eUp:Disconnect()eUp=nil end
    end
    uESP()
end,"ESPPlayer")

cTog("NPC ESP",sE,HC.ESPNPC,function(v)
    HC.ESPNPC=v
    uDEsp()
end,"ESPNPC")

cTog("⚠ Danger ESP",sE,HC.DangerESP,function(v)
    HC.DangerESP=v
    uDEsp()
end,"DangerESP")

cTog("📦 Item ESP",sE,HC.ESPItems,function(v)
    HC.ESPItems=v
    uItemESP()
end,"ESPItems")

cST(sP,"👤 MOVIMENTO")

cTog("🛠 Player Mods",sP,HC.PlayerMods,function(v)
    HC.PlayerMods=v
    togglePlayerMods(v)
end,"PlayerMods")

cSli("WalkSpeed",1,250,HC.WalkSpeed,sP,function(v)
    HC.WalkSpeed=v
    playerModsRefresh()
end,"WalkSpeed")

cSli("JumpPower",1,300,HC.JumpPower,sP,function(v)
    HC.JumpPower=v
    playerModsRefresh()
end,"JumpPower")

cSli("FOV",40,120,HC.FOV,sP,function(v)
    HC.FOV=v
    applyFov()
end,"FOV")

cTog("♾ Infinite Zoom",sP,HC.InfiniteZoom,function(v)
    HC.InfiniteZoom=v
    toggleInfiniteZoom(v)
end,"InfiniteZoom")

cTog("🌀 Infinite Jump",sP,HC.InfJump,function(v)
    HC.InfJump=v
    toggleInfJump(v)
end,"InfJump")

cTog("👻 Noclip",sP,HC.Noclip,function(v)
    HC.Noclip=v
    toggleNoclip(v)
end,"Noclip")

cST(sP,"📍 TELEPORTE")

cTog("📍 TeleportTool",sP,HC.TeleportTool,function(v)
    HC.TeleportTool=v
    if v then
        createTeleportTool()
    else
        createTeleportTool()
    end
end,"TeleportTool")

cBtn(sP,"📌 Teleportar para Spawn",function()
    local spawn=W:FindFirstChildOfClass("SpawnLocation")
    if spawn then
        teleportTo(spawn.CFrame*CFrame.new(0,3,0))
    else
        notify("Spawn não encontrado")
    end
end)

cST(sPr,"🛡 PROTEÇÕES")

cTog("Anti-Fling",sPr,HC.AntiFling,function(v)
    HC.AntiFling=v
    antiFlingStart()
end,"AntiFling")

afToggle=select(1,cTog("⚡ Auto Anti-Fling",sPr,HC.AutoAntiFling,function(v)
    HC.AutoAntiFling=v
    if v and HC.AntiExploitDetector then
        detectorStart()
    end
end,"AutoAntiFling"))

cTog("🕳 Anti-Void",sPr,HC.AntiVoid,function(v)
    HC.AntiVoid=v
    antiVoidStart()
end,"AntiVoid")

cTog("💤 Anti-AFK",sPr,HC.AntiAfk,function(v)
    HC.AntiAfk=v
    antiAfkStart()
end,"AntiAfk")

cTog("🔄 Auto-Rejoin",sPr,HC.AutoRejoin,function(v)
    HC.AutoRejoin=v
    autoRejoinStart()
end,"AutoRejoin")

cTog("⚡ Instant Interact",sPr,HC.InstantInteract,function(v)
    HC.InstantInteract=v
    toggleInstantInteract(v)
end,"InstantInteract")

cTog("⏱ No Cooldown",sPr,HC.NoCooldown,function(v)
    HC.NoCooldown=v
    if v then
        notify("No Cooldown ativado")
    end
end,"NoCooldown")

cTog("🔔 Notificações",sPr,HC.Notifications,function(v)
    HC.Notifications=v
end,"Notifications")

cST(sH,"📜 HISTÓRICO")

local histInfo=Instance.new("TextLabel",sH)
histInfo.Size=UDim2.new(1,-12,0,38)
histInfo.BackgroundColor3=Theme.Card
histInfo.BorderSizePixel=0
histInfo.Text="Entradas e saídas aparecem aqui em tempo real."
histInfo.TextColor3=Theme.Sub
histInfo.Font=Enum.Font.Gotham
histInfo.TextSize=10
histInfo.TextWrapped=true

local hicr=Instance.new("UICorner",histInfo)
hicr.CornerRadius=UDim.new(0,8)

cTog("🔎 Detector de Anomalias",sH,HC.AntiExploitDetector,function(v)
    HC.AntiExploitDetector=v
    if v then
        detectorStart()
    elseif detConnection then
        detConnection:Disconnect()
        detConnection=nil
    end
end,"AntiExploitDetector")

cTog("⚡ Auto Anti-Fling",sH,HC.AutoAntiFling,function(v)
    HC.AutoAntiFling=v
end,"AutoAntiFling")

cBtn(sH,"🧹 Limpar Histórico",function()
    table.clear(HRec)
    for _,v in pairs(historyCards)do
        if v and v.Parent then
            v:Destroy()
        end
    end
    table.clear(historyCards)
    notify("Histórico limpo")
end)

local histList=Instance.new("Frame",sH)
histList.Size=UDim2.new(1,-12,0,10)
histList.BackgroundTransparency=1

local histLayout=Instance.new("UIListLayout",histList)
histLayout.Padding=UDim.new(0,6)

local function refreshHistoryCards()
    for _,v in ipairs(histList:GetChildren())do
        if v:IsA("Frame")then
            v:Destroy()
        end
    end

    for i=#HRec,math.max(1,#HRec-25),-1 do
        local r=HRec[i]
        local fake={
            Name=r.Name,
            UserId=r.UserId
        }
        hCard(histList,fake,r.Joined)
    end
end

P.PlayerAdded:Connect(function(plr)
    if plr==LP then return end

    addHistory(plr,true)
    refreshHistoryCards()

    leftNotify(
        "🟢 Jogador entrou",
        plr.Name.." entrou às "..os.date("%H:%M:%S"),
        "join"
    )
end)

P.PlayerRemoving:Connect(function(plr)
    if plr==LP then return end

    addHistory(plr,false)
    refreshHistoryCards()
    closeHistoryCard(plr)

    leftNotify(
        "🔴 Jogador saiu",
        plr.Name.." saiu às "..os.date("%H:%M:%S"),
        "exit"
    )

    DetState[plr]=nil
end)

for _,plr in ipairs(P:GetPlayers())do
    if plr~=LP then
        addHistory(plr,true)
    end
end

cST(sT,"🎨 TEMAS")

for themeName,_ in pairs(themes)do
    cBtn(sT,"🎨 "..themeName,function()
        HC.SelectedTheme=themeName
        Theme=themes[themeName]
        saveC()
        notify("Tema "..themeName.." selecionado. Reabra o Hub para aplicar totalmente.")
    end)
end

cBtn(sT,"🔄 Aplicar Tema Atual",function()
    Theme=themes[HC.SelectedTheme]or themes.Orion

    Main.BackgroundColor3=Theme.Bg
    stroke.Color=Theme.Main
    Top.BackgroundColor3=Theme.Card
    Side.BackgroundColor3=Theme.Card

    for _,v in pairs(TabButtons)do
        v.BackgroundColor3=Theme.Bg
    end

    TabButtons["🔧 Princ."].BackgroundColor3=Theme.Main
end)

cST(sV,"👀 VIEWER")

local targetBox=Instance.new("TextBox",sV)
targetBox.Size=UDim2.new(1,-12,0,36)
targetBox.BackgroundColor3=Theme.Card
targetBox.BorderSizePixel=0
targetBox.PlaceholderText="Nome do jogador..."
targetBox.PlaceholderColor3=Theme.Sub
targetBox.Text=""
targetBox.TextColor3=Theme.Text
targetBox.Font=Enum.Font.Gotham
targetBox.TextSize=11
targetBox.ClearTextOnFocus=false

local tbcr=Instance.new("UICorner",targetBox)
tbcr.CornerRadius=UDim.new(0,8)

cBtn(sV,"🎯 Selecionar Jogador",function()
    local q=targetBox.Text:lower()
    if q==""then
        notify("Digite um nome")
        return
    end

    local found
    for _,plr in ipairs(P:GetPlayers())do
        if plr~=LP and(plr.Name:lower():find(q,1,true)or plr.DisplayName:lower():find(q,1,true))then
            found=plr
            break
        end
    end

    if found then
        CurrentTarget=found
        notify("Alvo: "..found.Name)
    else
        notify("Jogador não encontrado")
    end
end)

cBtn(sV,"📍 Goto",function()
    gotoTarget(CurrentTarget)
end)

cBtn(sV,"👁 Spectate",function()
    spectateTarget(CurrentTarget)
end)

cBtn(sV,"🔁 Loop Goto ON/OFF",function()
    if not CurrentTarget then
        notify("Selecione um jogador primeiro")
        return
    end
    loopGoto(CurrentTarget,not LoopGotoState)
end)

cBtn(sV,"🧢 Headpet",function()
    headpet(CurrentTarget)
end)

cBtn(sV,"🎥 Freecam ON/OFF",function()
    if freecamOn then
        endFreecam()
    else
        beginFreecam()
    end
end)

cST(sV,"👥 JOGADORES ONLINE")

local playerList=Instance.new("Frame",sV)
playerList.Size=UDim2.new(1,-12,0,120)
playerList.BackgroundTransparency=1

local pLay=Instance.new("UIListLayout",playerList)
pLay.Padding=UDim.new(0,4)

local function refreshViewerPlayers()
    for _,v in ipairs(playerList:GetChildren())do
        if v:IsA("TextButton")then
            v:Destroy()
        end
    end

    for _,plr in ipairs(P:GetPlayers())do
        if plr~=LP then
            local b=Instance.new("TextButton",playerList)
            b.Size=UDim2.new(1,0,0,30)
            b.BackgroundColor3=Theme.Card
            b.BorderSizePixel=0
            b.Text="  "..plr.DisplayName.." @"..plr.Name
            b.TextColor3=Theme.Text
            b.Font=Enum.Font.GothamMedium
            b.TextSize=10
            b.TextXAlignment=Enum.TextXAlignment.Left

            local br=Instance.new("UICorner",b)
            br.CornerRadius=UDim.new(0,6)

            b.Activated:Connect(function()
                CurrentTarget=plr
                targetBox.Text=plr.Name
                notify("Alvo selecionado: "..plr.Name)
            end)
        end
    end
end

refreshViewerPlayers()

P.PlayerAdded:Connect(function()
    task.wait(.2)
    refreshViewerPlayers()
end)

P.PlayerRemoving:Connect(function()
    task.wait(.2)
    refreshViewerPlayers()
end)

local afState
if HC.AntiFling then
    antiFlingStart()
end

if HC.AntiVoid then
    antiVoidStart()
end

if HC.AntiAfk then
    antiAfkStart()
end

if HC.AutoRejoin then
    autoRejoinStart()
end

if HC.InstantInteract then
    toggleInstantInteract(true)
end

if HC.InfJump then
    toggleInfJump(true)
end

if HC.Noclip then
    toggleNoclip(true)
end

if HC.PlayerMods then
    togglePlayerMods(true)
end

if HC.InfiniteZoom then
    toggleInfiniteZoom(true)
end

if HC.PlayerLight then
    uLig()
end

if HC.ESPPlayer then
    uESP()
end

if HC.ESPNPC or HC.DangerESP then
    uDEsp()
end

if HC.ESPItems then
    uItemESP()
end

if HC.AntiExploitDetector then
    detectorStart()
end

if HC.TeleportTool then
    createTeleportTool()
end

updateGraphics()
applyFov()
playerModsRefresh()
setFpsBoost(HC.FpsBoost)
addRain()

local firstTab=Pages["🔧 Princ."]
for _,pg in pairs(Pages)do
    pg.Visible=false
end
firstTab.Visible=true

for _,tb in pairs(TabButtons)do
    tb.BackgroundColor3=Theme.Bg
end
TabButtons["🔧 Princ."].BackgroundColor3=Theme.Main

notify("Vortex Hub carregado com sucesso",4)
