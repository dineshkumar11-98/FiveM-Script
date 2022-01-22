local ped = GetPlayerPed(-1)

function notify(msg)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandThefeedPostTicker(true, true)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        --Lift
        for i=1, #upLiftLocation, 1 do
            DrawMarker(liftMarkerType, upLiftLocation[i].x, upLiftLocation[i].y, upLiftLocation[i].z, 0.0, 0.0, 0.0, upLiftLocation[i].rotx, upLiftLocation[i].roty, upLiftLocation[i].rotz, upLiftLocation[i].scale, upLiftLocation[i].scale, upLiftLocation[i].scale, upLiftLocation[i].r, upLiftLocation[i].g, upLiftLocation[i].b, upLiftLocation[i].a, false,true,2,false,nil,nil,false)
            if IsControlJustPressed(0,172) then
                local playerCurrentLocation = GetEntityCoords(ped)
                if Vdist(upLiftLocation[i].x, upLiftLocation[i].y, upLiftLocation[i].z,playerCurrentLocation) < 3 then
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetEntityCoords(ped, downLiftLocation[i].x, downLiftLocation[i].y, downLiftLocation[i].z,true,false,false,false)
                    SetEntityHeading(ped, downLiftLocation[i].heading)
                    if IsScreenFadedOut() then
                        Wait(1000)
                        DoScreenFadeIn(1000)
                    end
                    notify('You are in ~g~'..downLiftLocation[i].name)
                end
            end
        end
        for i=1, #downLiftLocation, 1 do
            DrawMarker(liftMarkerType, downLiftLocation[i].x, downLiftLocation[i].y, downLiftLocation[i].z-0.5, 0.0, 0.0, 0.0, downLiftLocation[i].rotx, downLiftLocation[i].roty, downLiftLocation[i].rotz, downLiftLocation[i].scale, downLiftLocation[i].scale, downLiftLocation[i].scale, downLiftLocation[i].r, downLiftLocation[i].g, downLiftLocation[i].b, downLiftLocation[i].a, false,true,2,false,nil,nil,false)
            if IsControlJustPressed(0,173) then
                local playerCurrentLocation = GetEntityCoords(ped)
                if Vdist(downLiftLocation[i].x, downLiftLocation[i].y, downLiftLocation[i].z,playerCurrentLocation) < 2 then
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    SetEntityCoords(ped, upLiftLocation[i].x, upLiftLocation[i].y, upLiftLocation[i].z,true,false,false,false)
                    SetEntityHeading(ped, upLiftLocation[i].heading)
                    if IsScreenFadedOut() then
                        Wait(1000)
                        DoScreenFadeIn(1000)
                    end
                end
                notify('You are in ~g~'..upLiftLocation[i].name)
            end
        end
        --Notification
        
        local playerCurrentLocation = GetEntityCoords(ped)
        for i=1, #upLiftLocation, 1 do
            if Vdist(upLiftLocation[i].x, upLiftLocation[i].y, upLiftLocation[i].z,playerCurrentLocation) < 2 or Vdist(downLiftLocation[i].x, downLiftLocation[i].y, downLiftLocation[i].z,playerCurrentLocation) < 2 then
                SetTextComponentFormat("STRING")
                AddTextComponentString("Press ~INPUT_CELLPHONE_UP~ to go up ~n~Press ~INPUT_CELLPHONE_DOWN~ to go down")
                DisplayHelpTextFromStringLabel(0,0,1,-1)
            end
        end
    end
end)