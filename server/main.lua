-- Function for spawning in the vehicle

local function spawnVehicle(src, modelName)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    -- Creates the vehicles with the native
    local car = CreateVehicle(joaat(modelName), playerCoords.x, playerCoords.y, playerCoords.z, playerHeading, true, false)

    while not DoesEntityExist(car) do
        Wait(100)
    end

    -- Setting the vehicle properties and saving them to the entity state
    SetVehicleColours(car, 53, 103)
    SetVehicleNumberPlateText(car, 'ABC1234')

    local vehicleProperties = {
        plate = 'ABC1234',
        color1 = 53,
        color2 = 103,
        body = 1000,
        engine = 1000,
    }
    Entity(car).state:set('vehicleProperties', vehicleProperties)
end

-- Registering the command

RegisterCommand('sspawnvehicle', function(src, args)
    if source ~= 0 then return end
    local model = args[1]
    if type(model) ~= "string" then return end

    spawnVehicle(src, model)
end, false)