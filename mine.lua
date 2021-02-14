local slotMiningWell = 13
local slotFluxPoint = 14
local slotFuelChest = 15
local slotEmptyChest = 16
local waitTime = 12

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
  sleep(waitTime)
  turtle.digDown()
  turtle.select(slotEmptyChest)
  turtle.dig()
  turtle.down()
  turtle.select(slotMiningWell)
  turtle.dig()
end

function sendError(errorMessage)
  print(errorMessage)
  modem.open(4)
  modem.transmit(4, 4, "Miner: " .. os.getComputerID() .. " is missing a " .. errorMessage)
end

function checkInventoryCorrect()
  local result = true

  print("Checking Inventory Setup")
  local _, slotMiningWellName = turtle.getItemDetail(slotMiningWell)
  if slotMiningWellName ~= "quarryplus:miningwellplus" then
	sendError("Mining Well")
    result = false
  end
  local _, slotFluxPointName = turtle.getItemDetail(slotFluxPoint)
  if slotFluxPointName ~= "fluxnetworks:flux_point" then
	sendError("Flux Point")
    result = false
  end
  local _, slotFuelChestName = turtle.getItemDetail(slotFuelChest)
  if slotFuelChestName ~= "enderstorage:ender_chest" then
	sendError("Fuel Chest")
    result = false
  end
  local _, slotEmptyChestName = turtle.getItemDetail(slotEmptyChest)
  if slotEmptyChestName ~= "quarryplus:miningwellplus" then
	sendError("Empty Chest")
	result = false
  end
  
  return result
  
end

modem.open(2)
--checkInventoryCorrect()
while true do
  refuel()
  local event_type, side, recievedChannel, replyChannel, message, distance = os.pullEvent("modem_message")
  if message == "advance" then
    turtle.forward()  
    mine()
  end
  if message == "update" then
    os.reboot()
  end
  if message == "setupMiningWell" then
    if turtle.getItemCount(slotMiningWell) == 0 then
	  turtle.select(slotMiningWell)
	  turtle.suckDown(1)
	end
  end
  if message == "setupFluxPoint" then
    if turtle.getItemCount(slotFluxPoint) == 0 then
	  turtle.select(slotFluxPoint)
	  turtle.suckDown(1)
	end
  end
  if message == "setupFuelChest" then
    if turtle.getItemCount(slotFuelChest) == 0 then
	  turtle.select(slotFuelChest)
	  turtle.suckDown(1)
	end
  end
  if message == "setupEmptyChest" then
    if turtle.getItemCount(slotEmptyChest) == 0 then
	  turtle.select(slotEmptyChest)
	  turtle.suckDown(1)
	end
  end
end
