# TurtleProjekt

## Turtle API

### Über Network messages

**ping** - sendet die Computer-ID von der Turtle zurück

### Über lokales Terminal

**help** - Aufzählung der Befehle

**id** - gibt die Computer-ID von der Turtle aus

**send <ID> <message>** - sendet manuell eine Nachricht an die angegebene ID
```lua
rednet.send(tonumber(arguments[1]),arguments[2])
print('"' ..arguments[2].. '" an ID '..arguments[1].." gesendet")  
```
**f <Blöcke>** - Fährt die Turtle die angegebene Anzahl and Blöcken (oder 1) nach vorne

**l** - Dreht die turtle nach links

**r** Dreht die turtle nach rechts

