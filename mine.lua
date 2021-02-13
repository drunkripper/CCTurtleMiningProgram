local slotMiningWell = 13
local slotFluxPoint = 14
local slotFuelChest = 15
local slotEmptyChest = 16

local modem = peripheral.wrap("left")

local FuelThreshold = 100

function refuel()
  if turtle.getFuelLevel() < FuelThreshold then
    turtle.select(slotFuelChest)
	turtle.placeUp()
	turtle.suckUp()
	turtle.refuel(64)
	turtle.digUp()
  end
end

function mine()
  turtle.select(slotMiningWell)
  turtle.dig()
  turtle.place()
  turtle.digUp()
  turtle.up()
  turtle.select(slotEmptyChest)
  turtle.dig()
  turtle.place()
  turtle.select(slotFluxPoint)
  turtle.placeDown()
  sleep(10)
  turtle.digDown()
  turtle.select(slotEmptyChest)
  turtle.dig()
  turtle.down()
  turtle.select(slotMiningWell)
  turtle.dig()
end

function sendError(error)
  print(error)
end

function checkInventoryCorrect()
  local slotMiningWell = 13
  local slotFluxPoint = 14
  local slotFuelChest = 15
  local slotEmptyChest = 16
  
  
  local _, slotMiningWellName = turtle.getItemDetail(slotMiningWell)
  if slotMiningWellName ~= "quarryplus:miningwellplus" then
    print("Mining Well not in place. Sending Alert to master Error Server")
	sendError("Mining Well")
  end
  local _, slotFluxPointName = turtle.getItemDetail(slotFluxPoint)
  if slotFluxPointName ~= "fluxnetworks:flux_point" then
    print("Flux Point not in place. Sending Alert to master Error Server")
	sendError("Flux Point")
  end
  local _, slotFuelChestName = turtle.getItemDetail(slotFuelChest)
  if slotFuelChestName ~= "enderstorage:ender_chest" then
    print("Fuel Chest not in place. Sending Alert to master Error Server")
	sendError("Fuel Chest")
  end
  local _, slotEmptyChestName = turtle.getItemDetail(slotEmptyChest)
  if slotEmptyChestName ~= "quarryplus:miningwellplus" then
    print("Empty Chest not in place. Sending Alert to master Error Server")
	sendError("Empty Chest")
  end
  
  
end

modem.open(2)
while true do
  refuel()
  local event_type, side, recievedChannel, replyChannel, message, distance = os.pullEvent("modem_message")
  if message == "advance" then
    turtle.forward()  
    mine()
  end
end
