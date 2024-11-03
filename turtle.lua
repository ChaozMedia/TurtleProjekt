local modemSide = "left"  
rednet.open(modemSide)
 
print("Super Krasses Turtle Skript")
print("Computer ID: " .. os.getComputerID())
print("--------------------------")
 
-- Function to listen for network messages
local function listenForMessages()
    while true do
        local senderId, message, protocol = rednet.receive()  -- Waits for a message on any channel
        print("Nachricht von " .. senderId .. ": " .. tostring(message))  -- React to the network message here
        if message == "ping" then
            rednet.send(senderId, os.getComputerID())
        end
    end
end
 
-- Function to handle user input
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
        else
            term.setTextColor(colors.red)
            print("Kein solcher Befehl gefunden")
            term.setTextColor(colors.white)
        end
 
 
    end
end
 
-- Run both functions in parallel
parallel.waitForAny(listenForMessages, handleUserInput)
