local isInputActive = false

RegisterCommand('msg', function()
    print("Cliente: Comando /msg chamado") -- Depuração: confirma que o comando foi chamado no cliente
    TriggerServerEvent('msg:checkJob')
end, false)

RegisterNetEvent('msg:openInput')
AddEventHandler('msg:openInput', function()
    if not isInputActive then
        print("Cliente: Abrindo NUI para input") -- Depuração: confirma que o input será aberto
        
        SetNuiFocus(false, false) -- Remove o foco do NUI
        ClearPedTasksImmediately(PlayerPedId()) -- Para a animação 
        
        -- Iniciar a animação de escrita
        local playerPed = PlayerPedId()
        RequestAnimDict("amb_work@world_human_write_notebook@male_a@base")
        while not HasAnimDictLoaded("amb_work@world_human_write_notebook@male_a@base") do
            Citizen.Wait(100)
        end
        print("Cliente: Iniciando animação de escrita") -- Depuração: confirma que a animação está sendo iniciada
        TaskPlayAnim(playerPed, "amb_work@world_human_write_notebook@male_a@base", "base", 8.0, -8.0, -1, 49, 0, false, false, false)
        
        SetNuiFocus(true, true) -- Ativa o foco no NUI para permitir a interação
        SendNUIMessage({
            type = 'openInput',
            placeholder = 'Escreva sua mensagem',
        })
        isInputActive = true
    else
        print("Cliente: Input já está ativo") -- Depuração: verifica se o input já está ativo
    end
end)

RegisterNUICallback('submitInput', function(data, cb)
    local message = data.message
    print("Cliente: Mensagem enviada: ", message) -- Depuração: confirma que a mensagem foi enviada
    if message and message ~= '' then
        TriggerServerEvent('msg:sendMessage', message) -- Envia a mensagem para o servidor
    end
    SetNuiFocus(false, false) -- Remove o foco do NUI após o envio
    ClearPedTasksImmediately(PlayerPedId()) -- Para a animação imediatamente
    print("Cliente: Animação cancelada após enviar a mensagem") -- Depuração: confirma que a animação foi cancelada
    isInputActive = false
    cb('ok')
end)

RegisterNUICallback('closeInput', function(data, cb)
    print("Cliente: Input fechado") -- Depuração: confirma que o input foi fechado
    SetNuiFocus(false, false) -- Remove o foco do NUI
    ClearPedTasksImmediately(PlayerPedId()) -- Para a animação imediatamente
    print("Cliente: Animação cancelada após fechar o input") -- Depuração: confirma que a animação foi cancelada
    isInputActive = false
    cb('ok')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/msg', 'Envia uma mensagem privada ao grupo de médicos ou policiais.')
end)