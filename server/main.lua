-- Function for spawning in the vehicle
local function spawnVehicle(src, modelName)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)

    -- Create a temporary vehicle to get the vehicle type
    local tVehicle = CreateVehicle(modelName, 0, 0, 0, 0, true, true)
    while not DoesEntityExist(tVehicle) do
        Wait(0)
    end

    local vehicleType = GetVehicleType(tVehicle)
    DeleteEntity(tVehicle)
    local vehicle = CreateVehicleServerSetter(modelName, vehicleType, playerCoords.x, playerCoords.y, playerCoords.z, playerHeading)

    while not DoesEntityExist(vehicle) do
        Wait(10)
    end

    local vehicleProperties = {
        plate = 'ABC1234',
        color1 = 53,
        color2 = 103,
        body = 1000,
        engine = 1000,
    }

    Entity(vehicle).state:set('setVehicleProperties', vehicleProperties, true)
end

-- Registering the command
RegisterCommand('spawnvehicle', function(src, args)
    if src == 0 then return end
    local model = args[1]
    if type(model) ~= "string" then return end

    spawnVehicle(src, model)
end, false)

