-- [ VORTEX HUB - ARQUIVO PRINCIPAL ] --
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- ==========================================
-- 1. SISTEMA DE AUTO-SAVE AVANÇADO
-- ==========================================
local Config = {
    FolderName = "VortexHub_Configs",
    FileName = "VortexHub_Configs/SaveData.json",
    
    -- Tabela que armazenará o estado atual de tudo
    Flags = {
        Toggles = {},
        Sliders = {},
        Theme = "Default"
    }
}

local SaveManager = {}

function SaveManager:Init()
    if not isfolder(Config.FolderName) then
        makefolder(Config.FolderName)
    end
end

function SaveManager:SaveSettings()
    local success, err = pcall(function()
        local jsonData = HttpService:JSONEncode(Config.Flags)
        writefile(Config.FileName, jsonData)
    end)
    if not success then
        warn("VortexHub - Erro ao salvar configurações: " .. tostring(err))
    end
end

function SaveManager:LoadSettings()
    if isfile(Config.FileName) then
        local success, result = pcall(function()
            local fileData = readfile(Config.FileName)
            return HttpService:JSONDecode(fileData)
        end)
        
        if success and type(result) == "table" then
            -- Mescla os dados salvos com a tabela atual
            for category, data in pairs(result) do
                if type(data) == "table" then
                    for key, value in pairs(data) do
                        Config.Flags[category][key] = value
                    end
                else
                    Config.Flags[category] = data
                end
            end
            print("VortexHub - Configurações carregadas com sucesso!")
        else
            warn("VortexHub - Arquivo de save corrompido, iniciando com padrão.")
        end
    end
end

-- ==========================================
-- 2. FUNÇÕES CORE CORRIGIDAS
-- ==========================================

-- Correção do Raycast (Uso do ViewportPointToRay para alinhar o Inset)
local function getTeleportTarget()
    local pos = UIS:GetMouseLocation()
    -- Ignora o offset de 36 pixels do topo da tela do Roblox
    local ray = cam:ViewportPointToRay(pos.X, pos.Y)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    
    local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
    
    if raycastResult then
        return raycastResult.Position
    end
    return nil
end

-- ==========================================
-- 3. INICIALIZAÇÃO DA INTERFACE & INTEGRAÇÃO
-- ==========================================

-- Inicia as pastas e tenta carregar o último save antes de desenhar a UI
SaveManager:Init()
SaveManager:LoadSettings()

-- Exemplo de como aplicar o Tema Salvo na sua UI Library
local CurrentTheme = Config.Flags.Theme
-- Ex: Library:SetTheme(CurrentTheme)

-- MANTENHA TODO O SEU CÓDIGO DA UI AQUI (Abas, Janelas, etc)
-- -----------------------------------------------------------
-- Exemplo de implementação segura das funções (Corrigido para evitar erro de sintaxe)
-- Note o uso do ponto e vírgula ou separação de linhas para a variável local.

local spectateConn; 
spectateConn = cTog("👁️ View (Spectate)", sV, Config.Flags.Toggles["Spectate"] or false, function(state)
    Config.Flags.Toggles["Spectate"] = state
    SaveManager:SaveSettings()
    
    if state then
        -- Lógica de ativar spectate
    else
        -- Lógica de desativar
    end
end)

local loopGotoConn; 
loopGotoConn = cTog("🔁 Loopgoto", sV, Config.Flags.Toggles["Loopgoto"] or false, function(state)
    Config.Flags.Toggles["Loopgoto"] = state
    SaveManager:SaveSettings()
    
    -- Lógica do loopgoto
end)

-- Exemplo para Sliders (Barras)
--[[
cSlider("Velocidade", 16, 100, Config.Flags.Sliders["WalkSpeed"] or 16, function(value)
    Config.Flags.Sliders["WalkSpeed"] = value
    SaveManager:SaveSettings()
    LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
]]--
-- -----------------------------------------------------------

-- Loop de segurança para auto-save em segundo plano a cada 10 segundos
-- (Garante que se o jogo fechar abruptamente, os dados mais recentes estejam salvos)
task.spawn(function()
    while task.wait(10) do
        SaveManager:SaveSettings()
    end
end)

-- IMPORTANTE: A linha 'loadstring(...)()' final que duplicava o hub foi removida permanentemente.
