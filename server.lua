local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('inventory:getItems', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchAll('SELECT item, count FROM inventory_items WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            local items = {}
            for _, row in ipairs(result) do
                table.insert(items, {item = row.item, count = row.count})
            end
            cb(items)
        end)
    else
        cb({})
    end
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    MySQL.Async.fetchAll('SELECT item, count FROM inventory_items WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if #result == 0 then
            for _, item in ipairs(Config.DefaultItems) do
                MySQL.Async.execute('INSERT INTO inventory_items (identifier, item, count) VALUES (@identifier, @item, @count)', {
                    ['@identifier'] = xPlayer.identifier,
                    ['@item'] = item.name,
                    ['@count'] = item.count
                })
            end
        end
    end)
end)