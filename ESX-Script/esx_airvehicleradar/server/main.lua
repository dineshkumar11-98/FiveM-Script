ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('ref:reference')
AddEventHandler('ref:reference', function()
	
	local playerList = ESX.GetPlayers()
	for i=1,#playerList,1 do
		local _source = playerList[i]
		TriggerClientEvent("addblip", source, tonumber(_source))
	end
	
end)