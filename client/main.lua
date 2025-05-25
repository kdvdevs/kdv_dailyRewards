ESX = exports['es_extended']:getSharedObject()

RegisterNUICallback("close", function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "hide" })
    cb('ok')
end)

RegisterNUICallback('give', function(data, cb)
    TriggerServerEvent('kdv_dailyRewards:give', data)
    cb({ success = true })
end)

RegisterNUICallback('checkall', function(data, cb)
    ESX.TriggerServerCallback('kdv_dailyRewards:checkall', function(statuses)
        cb({ statuses = statuses })
    end, data.rewards)
end)

RegisterCommand(Config.OpenCommand, function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "show",
        rewards = Config.DailyRewards,
        texts = Config.Texts,
        showTimer = Config.ShowTimer,
        showGlow = Config.ShowGlow
    })
end, false)

RegisterKeyMapping(Config.OpenCommand, 'Open daily rewards', 'keyboard', Config.OpenKey)