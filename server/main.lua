ESX = exports['es_extended']:getSharedObject()

CreateThread(function()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS daily_rewards (
            identifier VARCHAR(64) NOT NULL,
            year INT NOT NULL,
            month INT NOT NULL,
            days_collected INT DEFAULT 0,
            last_login VARCHAR(32),
            PRIMARY KEY (identifier, year, month)
        )
    ]])
end)

RegisterNetEvent('kdv_dailyRewards:give', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local identifier = xPlayer.getIdentifier()
    local year = tonumber(os.date('%Y'))
    local month = tonumber(os.date('%m'))
    local today = os.date('%Y-%m-%d')
    MySQL.Async.fetchAll('SELECT * FROM daily_rewards WHERE identifier=@id AND year=@year AND month=@month', {
        ['@id'] = identifier, ['@year'] = year, ['@month'] = month
    }, function(result)
        local days_collected, last_login = 0, nil
        if result[1] then
            days_collected = tonumber(result[1].days_collected)
            last_login = result[1].last_login
        end
        if last_login == today then
            TriggerClientEvent('esx:showNotification', src, Config.Texts.already_claimed or "You have already claimed today!")
            return
        end

        local nextDay = days_collected + 1
        local reward = Config.DailyRewards[nextDay]
        if not reward then
            TriggerClientEvent('esx:showNotification', src, Config.Texts.all_claimed or "You have claimed all rewards for this month!")
            return
        end

        if reward.type == "item" then
            xPlayer.addInventoryItem(reward.item, reward.amount)
            TriggerClientEvent('esx:showNotification', src, 
                (Config.Texts.received_item or "You received ~b~%sx %s")
                :format(reward.amount, reward.label)
            )
        elseif reward.type == "money" then
            xPlayer.addMoney(reward.amount)
            TriggerClientEvent('esx:showNotification', src, 
                (Config.Texts.received_money or "You received ~g~$%s")
                :format(reward.amount)
            )
        elseif reward.type == "weapon" then
            xPlayer.addWeapon(reward.item, reward.amount)
            TriggerClientEvent('esx:showNotification', src, 
                (Config.Texts.received_weapon or "You received weapon ~y~%s ~s~x%s")
                :format(reward.label, reward.amount)
            )
        elseif reward.type == "vehicle" then
            AddVehicleToPlayer(src, reward)
        else
            print("[DailyRewards] Unknown type:", reward.type)
        end
    end)
end)

ESX.RegisterServerCallback('kdv_dailyRewards:checkall', function(src, cb, rewards)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return cb({}) end
    local identifier = xPlayer.getIdentifier()
    local year = tonumber(os.date('%Y'))
    local month = tonumber(os.date('%m'))
    local today = os.date('%Y-%m-%d')
    MySQL.Async.fetchAll('SELECT * FROM daily_rewards WHERE identifier=@id AND year=@year AND month=@month', {
        ['@id'] = identifier, ['@year'] = year, ['@month'] = month
    }, function(result)
        local days_collected, last_login = 0, nil
        if result[1] then
            days_collected = tonumber(result[1].days_collected)
            last_login = result[1].last_login
        end
        local statuses = {}
        for i = 1, #rewards do
            if i <= days_collected then
                statuses[i] = 'claimed'
            elseif i == days_collected + 1 and last_login ~= today then
                statuses[i] = 'collect'
            else
                statuses[i] = 'locked'
            end
        end
        cb(statuses)
    end)
end)

local NumberCharset, Charset = {}, {}
for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local function GetRandomNumber(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
    else
        return ''
    end
end

local function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end

local function GeneratePlate(cb)
    MySQL.Async.fetchAll("SELECT plate FROM owned_vehicles", {}, function(result)
        local plate
        while true do 
            local generatedPlate = string.upper(GetRandomLetter(4)..GetRandomNumber(4))
            local taken = false
            for i = 1, #result do 
                if generatedPlate == result[i].plate then 
                    taken = true
                    break
                end
            end
            if not taken then 
                plate = generatedPlate
                break
            end
        end
        cb(plate)
    end)
end

function AddVehicleToPlayer(src, reward)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    local model = reward.item
    local label = reward.label or model
    GeneratePlate(function(plate)
        local identifier = xPlayer.getIdentifier()
        local vehicleData = {model = GetHashKey(model), plate = plate}
        MySQL.Async.execute(
            'INSERT INTO owned_vehicles (owner, plate, vehicle, type, stored) VALUES (@owner, @plate, @vehicle, @type, @stored)',
            {
                ['@owner'] = identifier,
                ['@plate'] = plate,
                ['@vehicle'] = json.encode(vehicleData),
                ['@type'] = 'car',
                ['@stored'] = 1
            },
            function(rowsChanged)
                if rowsChanged > 0 then
                    TriggerClientEvent('esx:showNotification', src, 
                        (Config.Texts.received_vehicle or "You received the vehicle ~b~%s~s~ with plate ~y~%s")
                        :format(label, plate)
                    )
                else
                    TriggerClientEvent('esx:showNotification', src, Config.Texts.vehicle_error or "There was an error adding the vehicle, please contact admin!")
                end
            end
        )
    end)
end