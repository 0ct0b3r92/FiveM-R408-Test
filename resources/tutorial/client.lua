RegisterNetEvent("tutorial:spawn")
AddEventHandler("tutorial:spawn", function()
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)   
end)





