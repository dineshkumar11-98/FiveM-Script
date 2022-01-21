ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)
----deafult end
local helicopter = nil
local plane = nil
local helicopterblip = nil
local aeroblip = nil

RegisterNetEvent('addblip')
AddEventHandler('addblip', function(id)
	
	local id = GetPlayerFromServerId(id)
	local ped = GetPlayerPed(id)
	
	if IsPedInAnyHeli(ped) then
		helicopter = GetVehiclePedIsIn(ped, false)
	end
	if IsPedInAnyPlane(ped) then
		plane = GetVehiclePedIsIn(ped, false)
	end
	
	helicopterblip = GetBlipFromEntity(helicopter)
	aeroblip = GetBlipFromEntity(plane)

	if not DoesBlipExist(helicopterblip) then
		helicopterblip = AddBlipForEntity(helicopter)
		SetBlipSprite(helicopterblip,heli.blipSprite)
        SetBlipColour(helicopterblip,heli.blipColor)
	end
	if not DoesBlipExist(aeroblip	) then
		aeroblip = AddBlipForEntity(plane)
		SetBlipSprite(aeroblip,aeroplane.blipSprite)
        SetBlipColour(aeroblip,aeroplane.blipColor)
	end
end)

RegisterNetEvent('removeblip')
AddEventHandler('removeblip', function()
	if DoesBlipExist(helicopterblip) then
		RemoveBlip(helicopterblip)
	end
	if DoesBlipExist(aeroblip) then
		RemoveBlip(aeroblip)
	end
end)


Citizen.CreateThread(function()
	local radarlocation = vector3(marker.markerPos.x, marker.markerPos.y, marker.markerPos.z)
	local blipseted = false
	while true do
		Citizen.Wait(0)
		DrawMarker(marker.markerType, marker.markerPos.x, marker.markerPos.y, marker.markerPos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, marker.markerScale, marker.markerScale, marker.markerScale, marker.markerColor.r, marker.markerColor.g, marker.markerColor.b, marker.markerColor.a, false, false, 2, nil, nil, false)
		local pedlocation = GetEntityCoords(GetPlayerPed(-1))
		if Vdist(radarlocation,pedlocation) < 2 then
			TriggerServerEvent("ref:reference",src)
			blipseted = true
		end
		if Vdist(radarlocation,pedlocation) > 3 then
			if blipseted then
				blipseted = false
				TriggerEvent('removeblip')
			end
		end
	end
end)