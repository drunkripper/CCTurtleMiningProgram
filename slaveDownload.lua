shell.run("rm", "startup")
h = fs.open("startup", "w")
h.writeLine("shell.run(\"rm\", \"mine.lua\")")
h.writeLine("shell.run(\"wget\", \"https://raw.githubusercontent.com/drunkripper/CCTurtleMiningProgram/main/mine.lua\", \"mine.lua\")")
h.writeLine("shell.run(\"mine\")")
h.close()
os.reboot()
