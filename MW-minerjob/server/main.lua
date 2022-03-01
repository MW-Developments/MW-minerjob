-- ESX = nil
local QBCore = exports['qb-core']:GetCoreObject()

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


QBCore.Functions.CreateCallback('MW-minerjob:server:GetItem', function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        local pickaxe = Player.Functions.GetItemByName(item)
        if pickaxe ~= nil and not Player.PlayerData.metadata["isdead"] and
            not Player.PlayerData.metadata["inlaststand"] then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent("refreshItems:minerJob") 
AddEventHandler("refreshItems:minerJob", function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
		
	local goldCount = xPlayer.Functions.GetItemByName('gold')
	local ironCount = xPlayer.Functions.GetItemByName('iron')
	local pickaxeCount = xPlayer.Functions.GetItemByName('pickaxe')
    

    TriggerClientEvent("refreshGold:minerJob", source, goldCount)
    TriggerClientEvent("refreshIron:minerJob", source, ironCount)
    TriggerClientEvent("refreshPickaxe:minerJob", source, pickaxeCount)
end)


RegisterNetEvent("sellResource:minerJob")
AddEventHandler("sellResource:minerJob", function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    
    local goldCount = xPlayer.getInventoryItem('gold').count
    local ironCount = xPlayer.getInventoryItem('iron').count

    local randomGoldCash = math.random(1500, 3500)
    local randomIronCash = math.random(100, 1000)


    local goldReward = goldCount * randomGoldCash
    local ironReward = ironCount * randomIronCash
    local completReward = goldReward + ironReward

    if goldCount > 0 then
        xPlayer.removeInventoryItem("gold", goldCount)
        xPlayer.addMoney(goldReward)

    end
    if ironCount > 0 then
        xPlayer.removeInventoryItem("iron", ironCount)
        xPlayer.addMoney(ironReward)
    end

    if completReward == 0 then

    else
        TriggerClientEvent("showReward:minerJob", source, completReward)
    end
    

end)


RegisterNetEvent("addItems:minerJob")
AddEventHandler("addItems:minerJob", function()

    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)

    local randomItem = math.random(1,100)

    local randomeIronCounter = math.random(1,3)

    if randomItem < 65 then
            xPlayer.Functions.AddItem('iron', randomeIronCounter)
    
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['iron'], "add", randomeIronCounter)
    else
        xPlayer.Functions.AddItem('gold', 1)
    
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['gold'], "add", 1)
    end

end)


RegisterNetEvent("removePickaxe:minerJob")
AddEventHandler("removePickaxe:minerJob", function()

    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
    local randomDestroy = math.random(1,100)
   
    print(randomDestroy)
    if randomDestroy < 80 then
        
    else
        TriggerClientEvent("pickaxeBroken:minerJob", source)
        xPlayer.removeInventoryItem("pickaxe", 1)
    end

end)