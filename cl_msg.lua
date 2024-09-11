local isInputActive = false

RegisterCommand('msg', function()
    print("Client: /msg command called") -- Debug: confirms that the command was called on the client
    TriggerServerEvent('msg:checkJob')
end, false)

RegisterNetEvent('msg:openInput')
AddEventHandler('msg:openInput', function()
    if not isInputActive then
        print("Client: Opening NUI for input") -- Debug: confirms that the input will be opened
        
        SetNuiFocus(false, false) -- Remove focus from NUI
        ClearPedTasksImmediately(PlayerPedId()) --For animation
        
        -- Start writing animation
        local playerPed = PlayerPedId()
        RequestAnimDict("amb_work@world_human_write_notebook@male_a@base")
        while not HasAnimDictLoaded("amb_work@world_human_write_notebook@male_a@base") do
            Citizen.Wait(100)
        end
        print("Client: Starting writing animation") -- Debug: confirms that the animation is starting
        TaskPlayAnim(playerPed, "amb_work@world_human_write_notebook@male_a@base", "base", 8.0, -8.0, -1, 49, 0, false, false, false)
        
        SetNuiFocus(true, true) -- Enables focus on NUI to enable interaction
        SendNUIMessage({
            type = 'openInput',
            placeholder = 'Write your message',
        })
        isInputActive = true
    else
        print("Client: Input is already active") -- Debugging: checks if the input is already active
    end
end)

RegisterNUICallback('submitInput', function(data, cb)
    local message = data.message
    print("Client: Message sent: ", message) -- Debug: confirms that the message was sent
    if message and message ~= '' then
        TriggerServerEvent('msg:sendMessage', message) -- Send the message to the server
    end
    SetNuiFocus(false, false) -- Remove focus from NUI after submission
    ClearPedTasksImmediately(PlayerPedId()) -- Stops animation immediately
    print("Client: Animation canceled after sending message") -- Debug: confirms that the animation has been canceled
    isInputActive = false
    cb('ok')
end)

RegisterNUICallback('closeInput', function(data, cb)
    print("Client: Input closed") -- Debug: confirms that the input has been closed
    SetNuiFocus(false, false) -- Remove focus from NUI
    ClearPedTasksImmediately(PlayerPedId()) -- Stops animation immediately
    print("Client: Animation canceled after closing input") -- Debug: confirms that the animation has been canceled
    isInputActive = false
    cb('ok')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/msg', 'Send a private message to the group of doctors or police.')
end)
