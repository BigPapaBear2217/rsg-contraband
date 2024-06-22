local RSGCore = exports['rsg-core']:GetCoreObject()

-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Rexshack-RedM/rsg-contraband/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

        --versionCheckPrint('success', ('Current Version: %s'):format(currentVersion))
        --versionCheckPrint('success', ('Latest Version: %s'):format(text))
        
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

RSGCore.Functions.CreateCallback('rsg-contraband:server:contrabandselling:getAvailableContraband', function(source, cb)
    local AvailableContraband = {}
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player then
        for i = 1, #Config.ContrabandList, 1 do
            local item = Player.Functions.GetItemByName(Config.ContrabandList[i])

            if item ~= nil then
                AvailableContraband[#AvailableContraband+1] = {
                    item = item.name,
                    amount = item.amount,
                    label = RSGCore.Shared.Items[item.name]["label"]
                }
            end
        end
        if next(AvailableContraband) ~= nil then
            cb(AvailableContraband)
        else
            cb(nil)
        end
    end
end)

RegisterNetEvent('rsg-contraband:server:sellContraband', function(item, amount, price)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player then
        local hasItem = Player.Functions.GetItemByName(item)
        local AvailableContraband = {}
        if hasItem.amount >= amount then
            TriggerClientEvent('ox_lib:notify', src, {title = Lang:t('success.offer_accepted'), type = 'success', duration = 5000 })
            Player.Functions.RemoveItem(item, amount)
            Player.Functions.AddMoney('cash', price, "sold-contraband")
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "remove")
            for i = 1, #Config.ContrabandList, 1 do
                item = Player.Functions.GetItemByName(Config.ContrabandList[i])

                if item ~= nil then
                    AvailableContraband[#AvailableContraband+1] = {
                        item = item.name,
                        amount = item.amount,
                        label = RSGCore.Shared.Items[item.name]["label"]
                    }
                end
            end
            TriggerClientEvent('rsg-contraband:client:refreshAvailableContraband', src, AvailableContraband)
        else
            TriggerClientEvent('rsg-contraband:client:contrabandselling', src)
        end
    end
end)

RegisterNetEvent('rsg-contraband:server:robContraband', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player then
        local AvailableContraband = {}
        Player.Functions.RemoveItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], "remove")
        for i = 1, #Config.ContrabandList, 1 do
            item = Player.Functions.GetItemByName(Config.ContrabandList[i])
            if item then
                AvailableContraband[#AvailableContraband+1] = {
                    item = item.name,
                    amount = item.amount,
                    label = RSGCore.Shared.Items[item.name]["label"]
                }
            end
        end
        TriggerClientEvent('rsg-contraband:client:refreshAvailableContraband', src, AvailableContraband)
    end
end)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()
