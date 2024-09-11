local VORP = exports.vorp_core:vorpAPI()

RegisterServerEvent('msg:checkJob')
AddEventHandler('msg:checkJob', function()
    local src = source
    print("Command /msg was called by the player:", src) -- Debugging

-- Try to take the player's job
    local Character = VORP.getCharacter(src)
    if Character then
        local job = Character.job -- Character work
        print("Player Job:", job) -- Debugging

        if job == 'medico' or job == 'policial' then
            TriggerClientEvent('msg:openInput', src)
            print("Opening input for the player:", src) -- Debugging
        else
            TriggerClientEvent('chat:addMessage', src, {
                color = { 255, 0, 0 },
                multiline = true,
                args = { "System", "You do not have permission to use this command." }
            })
        end
    else
        print("Error recovering player character") -- Debugging
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
            local color = { 255, 255, 255 } -- Standard color, white

            if job == 'medico' then
                jobPrefix = "[Medico] "
                color = { 255, 0, 0 } -- Red for doctors
            elseif job == 'policial' then
                jobPrefix = "[Cavalaria] "
                color = { 0, 0, 255 } -- Blue for police officers
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
