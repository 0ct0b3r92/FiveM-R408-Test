ymapPedTab = {}

entities = {
        {2384.49023, 3138.09741, 48.2076073, 169.802612, 2047212121, 'WORLD_HUMAN_CHEERING', 0, 'WEAPON_UNARMED', 'yMapPedentities0'},
        {2399.68018, 3102.21558, 48.15284, -18.5889587, 70821038, 'None', 0, 'WEAPON_UNARMED', 'yMapPedentities1'},
        {2400.1687, 3103.2627, 48.15286, 154.999664, 71501447, 'WORLD_HUMAN_AA_SMOKE', 0, 'WEAPON_UNARMED', 'yMapPedentities2'},
        {2408.362, 3110.02856, 48.15271, 81.04, 131961260, 'None', 0, 'WEAPON_UNARMED', 'yMapPedentities3'},
        {2406.22046, 3126.82, 48.19477, 64.99993, -39239064, 'WORLD_HUMAN_WELDING', 0, 'WEAPON_UNARMED', 'yMapPedentities4'},
        {2424.5105, 3130.26465, 48.20481, 84.40427, -459818001, 'None', 0, 'WEAPON_UNARMED', 'yMapPedentities5'},
        {1700.12109, 3587.74561, 40.3240356, -118.284, -1275859404, 'WORLD_HUMAN_BINOCULARS', 0, 'WEAPON_VINTAGEPISTOL', 'yMapPedentities6'},
        {1929.41125, 3732.15771, 32.8444443, -128.572861, 813893651, 'None', 0, 'WEAPON_UNARMED', 'yMapPedentities7'},
        {-1143.575, 4917.273, 220.074, -5.82359934, 1161072059, 'WORLD_HUMAN_AA_SMOKE', 0, 'WEAPON_UNARMED', 'yMapPedentities8'},
        {-1135.66663, 4946.23, 222.273621, -108.601173, -1806291497, 'WORLD_HUMAN_JANITOR', 0, 'WEAPON_UNARMED', 'yMapPedentities9'},
        {-1113.58643, 4907.46973, 218.600357, -54.2244949, -1806291497, 'WORLD_HUMAN_DRINKING', 0, 'WEAPON_UNARMED', 'yMapPedentities10'},
        {2451.088, 4939.014, 45.6466827, 84.9998245, -730659924, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedentities11'},
        {-1183.26746, 4922.457, 222.785431, 79.99984, 1490458366, 'WORLD_HUMAN_TOURIST_MAP', 0, 'WEAPON_UNARMED', 'yMapPedentities12'},
        {133.8515, -1079.3396, 29.3922234, -74.24865, -730659924, 'None', 0, 'WEAPON_UNARMED', 'yMapPedentities13'},
        {64.761116, 3680.74536, 39.835144, 155.011414, 1330042375, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedentities14'},
        {77.95682, 3705.33984, 41.0822029, 59.9999237, 1032073858, 'WORLD_HUMAN_GUARD_PATROL', 0, 'WEAPON_UNARMED', 'yMapPedentities15'},
        {17.106575, 3687.47656, 39.69105, -149.9997, 1330042375, 'WORLD_HUMAN_AA_SMOKE', 0, 'WEAPON_UNARMED', 'yMapPedentities16'},
        {154.88092, -1084.55054, 32.9272842, -84.99989, 1161072059, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedentities17'},
        {165.180542, -1076.46826, 32.36959, -90.63612, 390939205, 'None', 0, 'WEAPON_UNARMED', 'yMapPedentities18'},
        {164.084549, -1076.027, 32.2158546, 90.30013, 516505552, 'WORLD_HUMAN_PARTYING', 0, 'WEAPON_UNARMED', 'yMapPedentities19'},
        {155.030228, -1075.62, 32.2158546, -99.90429, 436345731, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedentities20'},
        {186.024734, -1076.23108, 77.54423, -149.99968, 68070371, 'WORLD_HUMAN_BINOCULARS', 0, 'WEAPON_UNARMED', 'yMapPedentities21'},
        {187.8923, -1055.73169, 71.738945, 84.99989, 71501447, 'WORLD_HUMAN_PICNIC', 0, 'WEAPON_UNARMED', 'yMapPedentities22'},
        {188.86026, -1072.94153, 68.84975, -96.29977, 131961260, 'WORLD_HUMAN_AA_SMOKE', 0, 'WEAPON_UNARMED', 'yMapPedentities23'},
        {153.539642, -1077.49756, 29.9472027, -4.923263, 193817059, 'WORLD_HUMAN_HAMMERING', 0, 'WEAPON_UNARMED', 'yMapPedentities24'},
        {133.723312, -1057.79272, 29.1923618, -115.001038, 238213328, 'WORLD_HUMAN_HAMMERING', 0, 'WEAPON_UNARMED', 'yMapPedentities25'},
        {137.535172, -1050.262, 29.1589279, 109.784775, 1142162924, 'WORLD_HUMAN_CLIPBOARD', 0, 'WEAPON_UNARMED', 'yMapPedentities26'},
		{-462.3337, 6041.17334, 31.340538, -134.255341, 1161072059, 'WORLD_HUMAN_PICNIC', 0, 'Unarmed', 'ymapped0'},
        {-759.9932, 318.967438, 171.33429, -95.85654, 60192701, 'WORLD_HUMAN_SUNBATHE_BACK', 0, 'Unarmed', 'ymapped1'},
        {-760.107849, 318.052917, 171.318817, 139.422256, 70821038, 'WORLD_HUMAN_PICNIC', 0, 'Unarmed', 'ymapped2'},
        {-769.2292, 323.858673, 170.6017, -167.892563, 569740212, 'WORLD_HUMAN_PARTYING', 0, 'Unarmed', 'ymapped3'},
        {-759.6156, 326.9753, 170.596375, 0.807714045, 602513566, 'None', 0, 'Unarmed', 'ymapped4'},
        {-761.180969, 324.303925, 170.596375, 178.010468, 605602864, 'None', 0, 'Unarmed', 'ymapped5'},
        {-777.152954, 315.9833, 173.003937, -46.9998436, 368603149, 'None', 0, 'SNSPistol', 'ymapped6'},
        {-776.632446, 315.6689, 171.876282, -39.69451, 351016938, 'None', 0, 'Unarmed', 'ymapped7'},
        {-767.4021, 328.0006, 175.401108, -108.999268, 32417469, 'WORLD_HUMAN_PARTYING', 0, 'Unarmed', 'ymapped8'},
        {-766.151245, 329.995361, 175.401108, -165.998276, 60192701, 'WORLD_HUMAN_MUSICIAN', 0, 'Unarmed', 'ymapped9'},
        {-764.601, 327.505981, 175.401108, 68.9996643, 62440720, 'WORLD_HUMAN_PARTYING', 0, 'Unarmed', 'ymapped10'},
        {-459.857971, 6028.218, 31.3295441, -139.979218, 1925237458, 'WORLD_HUMAN_AA_COFFEE', 0, 'Unarmed', 'ymapped11'},
        {-458.1733, 6029.71973, 31.340332, -80.99961, -220552467, 'WORLD_HUMAN_SUNBATHE_BACK', 0, 'Unarmed', 'ymapped12'},
        {-453.715179, 6024.903, 31.340538, 0, 60192701, 'None', 0, 'Machete', 'ymapped13'},
        {-464.770874, 6038.46143, 31.340538, 39.1550751, 1657546978, 'WORLD_HUMAN_WELDING', 0, 'Unarmed', 'ymapped14'},
        {-459.272827, 6042.655, 31.340538, -45.0128136, 68070371, 'WORLD_HUMAN_AA_COFFEE', 0, 'Unarmed', 'ymapped15'},
        {-456.749329, 6042.237, 31.340538, 78.99958, 71501447, 'WORLD_HUMAN_SMOKING', 0, 'Unarmed', 'ymapped16'},
        {-456.377136, 6040.96, 31.340538, 139.998825, 101298480, 'WORLD_HUMAN_PICNIC', 0, 'Unarmed', 'ymapped17'},
        {-456.642365, 6038.29736, 31.340538, 0, 115168927, 'WORLD_HUMAN_AA_COFFEE', 0, 'Unarmed', 'ymapped18'},
        {-459.6285, 6033.026, 31.340538, 89.00149, 188012277, 'WORLD_HUMAN_MUSICIAN', 0, 'Unarmed', 'ymapped19'},
        {-461.673157, 6031.971, 31.340538, -58.73431, 225287241, 'WORLD_HUMAN_CHEERING', 0, 'Unarmed', 'ymapped20'},
        {-461.875977, 6033.516, 31.340538, -82.99954, 228715206, 'WORLD_HUMAN_CHEERING', 0, 'Unarmed', 'ymapped21'},
        {-460.322052, 6037.1084, 31.3366547, 1.93369818, 257763003, 'WORLD_HUMAN_YOGA', 0, 'Unarmed', 'ymapped22'},
        {-476.6393, 6015.131, 31.340538, -137.998886, 62440720, 'None', 0, 'Musket', 'ymapped23'},
        {-475.764374, 6016.061, 31.340538, -136.998611, 68070371, 'None', 0, 'AdvancedRifle', 'ymapped24'},
        {-474.915344, 6016.926, 31.340538, -137.99855, 71501447, 'None', 0, 'Revolver', 'ymapped25'},
        {-474.054443, 6017.927, 31.340538, -147.998642, 115168927, 'None', 0, 'Hatchet', 'ymapped26'},
        {-473.2373, 6018.87061, 31.340538, -141.99881, 131961260, 'None', 0, 'MarksmanRifle', 'ymapped27'},
        {-472.3396, 6019.82764, 31.340538, -138.998871, 188012277, 'None', 0, 'Bat', 'ymapped28'},
        {-475.6396, 6014.02441, 31.340538, -134.998947, 193817059, 'None', 0, 'CarbineRifle', 'ymapped29'},
        {-474.708862, 6015.06641, 31.340538, -136.998489, 216536661, 'None', 0, 'SawnOffShotgun', 'ymapped30'},
        {-473.8173, 6015.93652, 31.340538, -137.998886, 228715206, 'None', 0, 'Musket', 'ymapped31'},
        {-473.02832, 6017.019, 31.340538, -143.998734, 238213328, 'None', 0, 'Machete', 'ymapped32'},
        {-472.0571, 6017.96533, 31.340538, -143.998734, 275618457, 'None', 0, 'AssaultSMG', 'ymapped33'},
        {-471.277344, 6018.97363, 31.340538, -139.998825, 327394568, 'None', 0, 'Musket', 'ymapped34'},
        {-472.8124, 6012.013, 31.340538, -3.99620271, -265970301, 'WORLD_HUMAN_CLIPBOARD', 0, 'Unarmed', 'ymapped35'},
        {-473.6799, 6011.277, 31.340538, -5.205288, 225514697, 'WORLD_HUMAN_AA_COFFEE', 0, 'Unarmed', 'ymapped36'},
        {-465.513977, 6015.19971, 31.340538, -21.9999638, 1634506681, 'WORLD_HUMAN_GUARD_PATROL', 0, 'AdvancedRifle', 'ymapped37'},
        {-465.986816, 6012.0874, 31.3295441, 73.99963, 1702441027, 'WORLD_HUMAN_PICNIC', 0, 'Unarmed', 'ymapped38'},
        {-479.0045, 6017.737, 31.340538, -127.99453, 1657546978, 'WORLD_HUMAN_VEHICLE_MECHANIC', 0, 'Unarmed', 'ymapped39'},
        {-475.085632, 6024.147, 31.340538, 125.999023, 1161072059, 'WORLD_HUMAN_WELDING', 0, 'Unarmed', 'ymapped40'},
        {-483.294861, 6022.57568, 34.84177, 75.9996, -220552467, 'WORLD_HUMAN_BINOCULARS', 0, 'Unarmed', 'ymapped41'},
        {-460.6246, 5985.35449, 38.4164047, -108.999268, 1490458366, 'WORLD_HUMAN_GUARD_PATROL', 0, 'GrenadeLauncher', 'ymapped42'},
        {-456.014771, 5990.354, 31.2594223, -91.2002945, 1490458366, 'None', 0, 'AdvancedRifle', 'ymapped43'},
        {-449.22113, 5991.89063, 31.340538, 170.998154, 228715206, 'None', 0, 'Musket', 'ymapped44'},
        {-469.718445, 5988.886, 38.4164047, -132.998947, -1422914553, 'WORLD_HUMAN_AA_COFFEE', 0, 'Unarmed', 'ymapped45'},
        {-425.4063, 5998.334, 35.3036461, -97.98399, 62440720, 'None', 0, 'MarksmanRifle', 'ymapped46'},
        {-447.497559, 6022.722, 36.61715, -30.9999313, 68070371, 'None', 0, 'GrenadeLauncher', 'ymapped47'},
        {-432.21048, 6007.854, 36.634716, 0, 71501447, 'None', 0, 'AssaultRifle', 'ymapped48'},
        {-440.347778, 6015.62451, 36.61909, -41.9998741, 131961260, 'None', 0, 'GrenadeLauncher', 'ymapped49'},
        {-466.865784, 5997.46631, 31.24104, 0.03426042, 666086773, 'WORLD_HUMAN_GUARD_PATROL', 0, 'Revolver', 'ymapped50'},
        {-471.309845, 6001.34229, 31.3024635, -69.9990158, 788443093, 'WORLD_HUMAN_SMOKING', 0, 'Unarmed', 'ymapped51'},
        {-455.143768, 6009.679, 36.96357, 113.944962, 2141384740, 'WORLD_HUMAN_AA_COFFEE', 0, 'Unarmed', 'ymapped52'},
        {-440.2584, 5986.255, 35.3146439, -139.001328, -9308122, 'None', 0, 'AdvancedRifle', 'ymapped53'},
        {-443.222046, 5999.99365, 36.6547, 162.998337, 60192701, 'WORLD_HUMAN_SMOKING', 0, 'Unarmed', 'ymapped54'},
        {-457.1369, 6017.29639, 31.4901237, -130.999, 233415434, 'WORLD_HUMAN_HAMMERING', 0, 'Unarmed', 'ymapped55'},
}


local firstSpawn = false

    Citizen.CreateThread(function()
		while true do
			Citizen.Wait(100)
				if firstSpawn == false then
					for k,v in pairs(entities) do
									
						local x, y, z, h, hash, action, relationship, weapon, pedname = table.unpack(v)
						RequestModel(hash)
						while not HasModelLoaded(hash) do
							Citizen.Wait(100)
						end
							

						pedname = CreatePed(-1, hash, x, y, z - 1, h, false, false)
						relationship = tonumber(relationship)
						AddRelationshipGroup("scenepeds")
						SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("PLAYER")) -- guards love players
						SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("scenepeds")) -- Player Loves guards
						SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("zombeez")) -- merryweather hate Zombies
						SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("guards")) -- merryweather hate Zombies
						SetPedRelationshipGroupHash(pedname, GetHashKey("scenepeds"))
						TaskStartScenarioInPlace(pedname, action, 0, true)
						SetPedFleeAttributes(pedname, 0, 0)
						SetPedKeepTask(pedname, true)
						SetEntityInvincible(pedname, true)
						SetEntityMaxSpeed(pedname, 0.00)
						FreezeEntityPosition(pedname, true)
						if weapon == 'WEAPON_UNARMED' then
						else
							GiveWeaponToPed(pedname, GetHashKey(weapon), 9999, true, true)
						end
						table.insert(ymapPedTab, pedname)
						
						firstSpawn = true
					end
				end
		end
	end)
	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for i, pedname in pairs(ymapPedTab) do
			SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("PLAYER")) -- guards love players
			SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), GetHashKey("scenepeds")) -- Player Loves guards
			SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("zombeez")) -- merryweather hate Zombies
			SetRelationshipBetweenGroups(0, GetHashKey("scenepeds"), GetHashKey("guards")) -- merryweather hate Zombies
			SetPedRelationshipGroupHash(pedname, GetHashKey("scenepeds"))
			TaskStartScenarioInPlace(pedname, action, 0, true)
			SetPedFleeAttributes(pedname, 0, 0)
			SetPedKeepTask(pedname, true)
			SetEntityInvincible(pedname, true)
			SetEntityMaxSpeed(pedname, 0.00)
			FreezeEntityPosition(pedname, true)
			
			playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(pedname, true))
			if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 25.0) then
				DrawText3d(pedX, pedY, pedZ + 1, 0.5, 0, "a safezone survivor", 255, 255, 255, false)
			end
		end
	end
end)

-- Handles 3D Text above AI
function DrawText3d(x,y,z, size, font, text, r, g, b, outline)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
	
	if onScreen then
		SetTextScale(size*scale, size*scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		if not outline then
			SetTextDropshadow(0, 0, 0, 0, 55)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
		end
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
end