local VORP = exports.vorp_core:vorpAPI()

RegisterServerEvent('msg:checkJob')
AddEventHandler('msg:checkJob', function()
    local src = source
    print("Comando /msg foi chamado pelo jogador:", src) -- Depuração

    -- Tenta pegar o trabalho do jogador
    local Character = VORP.getCharacter(src)
    if Character then
        local job = Character.job -- O trabalho do personagem
        print("Job do jogador:", job) -- Depuração

        if job == 'medico' or job == 'policial' then
            TriggerClientEvent('msg:openInput', src)
            print("Abrindo input para o jogador:", src) -- Depuração
        else
            TriggerClientEvent('chat:addMessage', src, {
                color = { 255, 0, 0 },
                multiline = true,
                args = { "Sistema", "Você não tem permissão para usar este comando." }
            })
        end
    else
        print("Erro ao recuperar o personagem do jogador") -- Depuração
    end
end)

RegisterServerEvent('msg:sendMessage')
AddEventHandler('msg:sendMessage', function(message)
    local playerName = GetPlayerName(source)
    local players = GetPlayers()

    for _, playerId in ipairs(players) do
        local Character = VORP.getCharacter(playerId)
        if Character then
            local job = Character.job
            local jobPrefix = ""
            local color = { 255, 255, 255 } -- Cor padrão, branco

            if job == 'medico' then
                jobPrefix = "[Medico] "
                color = { 255, 0, 0 } -- Vermelho para médicos
            elseif job == 'policial' then
                jobPrefix = "[Cavalaria] "
                color = { 0, 0, 255 } -- Azul para policiais
            end

            if jobPrefix ~= "" then
                TriggerClientEvent('chat:addMessage', playerId, {
                    color = color,
                    multiline = true,
                    args = { jobPrefix .. playerName, message }
                })
            end
        end
    end
end)
