Config = {}

-- Inventory settings
Config.MaxWeight = 50000 -- Max weight for inventory in grams
Config.DefaultItems = {
    {name = 'bread', count = 5},
    {name = 'water', count = 5}
}

-- Database settings
Config.Database = {
    TableName = 'inventory_items'
}