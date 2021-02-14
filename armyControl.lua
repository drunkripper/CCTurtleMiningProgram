local slotFuelChest = 16
local FuelThreshold = 100
local slotChunkloaders = 13

modem = peripheral.wrap("left")
modem.open(2)

function refuel()
  if turtle.getFuelLevel() < FuelThreshold then
    turtle.select(slotFuelChest)
	turtle.digDown()
	turtle.placeDown()
	turtle.suckDown()
	turtle.refuel(64)
	turtle.digDown()
  end
end

function advanceArmy()
  modem.transmit(2, 2, "advance")  
end

function chunkLoadLeapFrog()
  turtle.select(slotChunkloaders)
  turtle.forward() 
  turtle.placeUp()
  turtle.back()
  turtle.digUp()
  turtle.forward()  
end

turtle.select(slotChunkloaders)
turtle.placeUp()
  
while true do
  refuel()
  advanceArmy()
  chunkLoadLeapFrog()
  sleep(17)
end
