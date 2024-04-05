

-- Add a state bag change handler for the setVehicleProperties state that sets the vehicle properties
AddStateBagChangeHandler('setVehicleProperties', nil, function(bagName, _, properties)
    if not properties then return end

	local vehicle = GetEntityFromStateBagName(bagName)
    if vehicle == 0 then return end

    -- Wait for the vehicle to be owned by the player
	local timer = GetGameTimer()
	while NetworkGetEntityOwner(vehicle) ~= PlayerId() do
		Wait(0)
		if GetGameTimer() - timer > 10000 then
            -- If the vehicle isn't owned by the player, return
			return
		end
	end

    -- Set the vehicle properties
    SetVehicleNumberPlateText(vehicle, properties.plate)
    SetVehicleOnGroundProperly(vehicle)
    SetVehicleEngineHealth(vehicle, properties.engine + 0.0)
    SetVehicleBodyHealth(vehicle, properties.body + 0.0)
    SetVehicleColours(vehicle, properties.color1, properties.color2)

    -- Remove the vehicle properties from the state since they've been set
    Entity(vehicle).state:set('setVehicleProperties', nil, true)
end)