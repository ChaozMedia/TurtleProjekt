local function initialize()
    local modemSide = "left"  
    rednet.open(modemSide)

    blacklist = loadBlacklist()
    
    print("Super Krasses Turtle Skript")
    print("Computer ID: " .. os.getComputerID())
    print("--------------------------")
end

local function listenForMessages()
    while true do
        local senderId, message, protocol = rednet.receive()  -- Waits for a message on any channel
        print("Nachricht von " .. senderId .. ": " .. tostring(message))  -- React to the network message here
        if message == "ping" then
            rednet.send(senderId, os.getComputerID())
        end
    end
end
 
local function handleUserInput()
    while true do
        local input = read()  -- Reads from the console
        
        -- Add more command processing here if needed
        local command, args = input:match("^(%S+)%s*(.*)$")  -- Extract command and remaining arguments
        local arguments = {}
 
        for arg in args:gmatch("%S+") do
            table.insert(arguments, arg)
        end
        if command == "help" then
            print("id")
            print("send <ID> <Message>")
        elseif command == "id" then
            print(os.computerID())
        elseif command == "send" then
            rednet.send(tonumber(arguments[1]),arguments[2])
            print('"' ..arguments[2].. '" an ID '..arguments[1].." gesendet")  
        elseif command == "f" then
            if arguments[1]==nil then
                turtle.forward()
            else
                for i=1,tonumber(arguments[1]) do
                    turtle.forward()
                end
            end
        elseif command == "l" then
            turtle.turnLeft()
        elseif command == "r" then
            turtle.turnRight()
        elseif command == "mine" then
            mine()
        else
            term.setTextColor(colors.red)
            print("Kein solcher Befehl gefunden")
            term.setTextColor(colors.white)
        end
 
 
    end
end

local function loadBlacklist()
    local blacklist = {}
    local file = fs.open("blacklist.txt", "r")
    if file then
        local line = file.readLine()
        while line do
            blacklist[line] = true
            line = file.readLine()
        end
        file.close()
    end
    return blacklist
end
 
local function isBlacklisted(blockName)
    return (blacklist[blockName] == true)
end
 
 local function mine()
    turtle.digDown()
    depth = 0
    while turtle.down() do
        depth = depth + 1
        turtle.digDown()
        for i=1,4 do
            _,a = turtle.inspect()
            if not isBlacklisted(a["name"]) then
                turtle.dig()
            end
            turtle.turnRight()
        end
    end
    for i=1,depth do
        while not turtle.up() do
            sleep(1)
        end
    end

 end
 

 initialize()

 
-- Run both functions in parallel
parallel.waitForAny(listenForMessages, handleUserInput)
