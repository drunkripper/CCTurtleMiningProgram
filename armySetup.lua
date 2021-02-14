term.clear()
term.setCursorPos(1, 1)
print("Hello, Welcome to CCMiningProgram setup. Created by TheFakeJaneDoe. Please put the enderchest you wish to use for setup below")
print("Press of the following keys:")
print("f" .. ":for the Fuel Chest")
print("c" .. ": For the Empty Chest")
print("f" .. ": For the Fuel Chest")
print("p" .. ": For the Flux Point")
print("m" .. ": For the Mining Well")
print("u" .. ": To Update All The Miners And This Machine")
print("r" .. ": To Run Army Control")
print("e" .. ": To Quit This Program")
print("t" .. ": Test one Advance")

modem = peripheral.wrap("left")
modem.open(2)

while true do
  local _ , key, isHeld = os.pullEvent("key")
  if isHeld ~= true then
    if key == keys.u then
	  modem.transmit(2, 2, "update")
	  os.reboot()
	end
	if key == keys.m then
	  modem.transmit(2, 2, "setupMiningWell") 
	end
	if key == keys.p then
	  modem.transmit(2, 2, "setupFluxPoint")
	end
    if key == keys.f then
	  modem.transmit(2, 2, "setupFuelChest")
	end
    if key == keys.c then
	  modem.transmit(2, 2, "setupEmptyChest")
	end
    if key == keys.r then
	  term.clear()
	  term.setCursorPos(1, 1)
	  print("Running Army Control")
	  shell.run("armyControl")
	end
    if key == keys.t then
	  modem.transmit(2, 2, "advance")
	end
    if key == keys.e then
	  break
	end
  end
end
