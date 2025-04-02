ESX = exports["es_extended"]:getSharedObject()

local keys = {} -- Uložené klíče podle SPZ

RegisterServerEvent("illegal_tuning:craftKey")
AddEventHandler("illegal_tuning:craftKey", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(Config.RequiredItem).count >= Config.RequiredAmount then
        xPlayer.removeInventoryItem(Config.RequiredItem, Config.RequiredAmount)
        local keyId = "key_" .. math.random(100000, 999999)
        xPlayer.addInventoryItem(keyId, 1)
        TriggerClientEvent("esx:showNotification", source, "Vyrobil jsi speciální klíč!")
    else
        TriggerClientEvent("esx:showNotification", source, "Nemáš dostatek materiálu!")
    end
end)

RegisterServerEvent("illegal_tuning:registerKey")
AddEventHandler("illegal_tuning:registerKey", function(plate, keyId)
    keys[plate] = keyId
end)

RegisterServerEvent("illegal_tuning:replaceKey")
AddEventHandler("illegal_tuning:replaceKey", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == Config.MechanicJob then
        if keys[plate] then
            local newKeyId = "key_" .. math.random(100000, 999999)
            keys[plate] = newKeyId
            xPlayer.addInventoryItem(newKeyId, 1)
            TriggerClientEvent("esx:showNotification", source, "Vytvořil jsi nový klíč pro SPZ: " .. plate)
        else
            TriggerClientEvent("esx:showNotification", source, "Pro toto vozidlo neexistuje žádný klíč!")
        end
    else
        TriggerClientEvent("esx:showNotification", source, "Nejsi mechanik!")
    end
end)

ESX.RegisterServerCallback("illegal_tuning:hasKey", function(source, cb, plate, keyId)
    cb(keys[plate] and keys[plate] == keyId)
end)
