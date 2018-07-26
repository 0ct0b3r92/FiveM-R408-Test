RegisterServerEvent("SaveDrinkCoords")
AddEventHandler("SaveDrinkCoords", function( PlayerName , x , y , z )
 file = io.open( "DrinkCoords.txt", "a")
    if file then
        file:write("	{x=" .. x .. ", y=" .. y .. ", z=" .. z .. "}, \n")
    end
    file:close()
end)

RegisterServerEvent("SaveFoodCoords")
AddEventHandler("SaveFoodCoords", function( PlayerName , x , y , z )
 file = io.open( "FoodCoords.txt", "a")
    if file then
        file:write("	{x=" .. x .. ", y=" .. y .. ", z=" .. z .. "}, \n")
    end
    file:close()
end)

RegisterServerEvent("SaveLootCoords")
AddEventHandler("SaveLootCoords", function( PlayerName , x , y , z )
 file = io.open( "LootCoords.txt", "a")
    if file then
        file:write("	{x=" .. x .. ", y=" .. y .. ", z=" .. z .. "}, \n")
    end
    file:close()
end)

RegisterServerEvent("SavePillCoords")
AddEventHandler("SavePillCoords", function( PlayerName , x , y , z )
 file = io.open( "PillCoords.txt", "a")
    if file then
        file:write("	{x=" .. x .. ", y=" .. y .. ", z=" .. z .. "}, \n")
    end
    file:close()
end)


RegisterServerEvent("SaveMiscCoords")
AddEventHandler("SaveMiscCoords", function( PlayerName , x , y , z )
 file = io.open( "MiscCoords.txt", "a")
    if file then
        file:write("	{" .. x .. ", " .. y .. ", " .. z .. "}, \n")
    end
    file:close()
end)