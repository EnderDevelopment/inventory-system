local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.TriggerServerCallback('inventory:getItems', function(items)
        for _, item in ipairs(items) do
            print('Item: ' .. item.item .. ', Count: ' .. item.count)
        end
    end)
end)

function OpenInventory()
    ESX.UI.Menu.CloseAll()
    ESX.TriggerServerCallback('inventory:getItems', function(items)
        local elements = {}
        for _, item in ipairs(items) do
            table.insert(elements, {label = item.item .. ' x' .. item.count, value = item.item})
        end
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory', {
            title = 'Inventory',
            align = 'top-left',
            elements = elements
        }, function(data, menu)
            -- Handle item selection
        end, function(data, menu)
            menu.close()
        end)
    end)
end

RegisterCommand('inventory', function()
    OpenInventory()
end, false)