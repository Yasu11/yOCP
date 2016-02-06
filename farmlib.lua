--imports
c  = require("component")
s  = require("sides")
r  = require("robot")
r1 = c.proxy(c.list("robot")())
n  = require("note")
os = require("os")

function forward ()
	b = false
	while true do
		b = r.forward()
		if b then
			return
		end
			os.sleep(0.2)
	end
end

function farm ()
    r1.use(s.bottom)
end

function farmLine (length)
    if length < 1 then 
        return
    end
    for i=2, length do
        farm()
        forward()
    end
    farm()
end

function switchLeft()
    r.turnLeft()
    forward()
    r.turnLeft()
end

function switchRight()
    r.turnRight()
    forward()
    r.turnRight()
end

function farmSquare (length, width)
    if width < 1 then
        return
    end
    
    farmLine(length)
    width=width-1
    
    for i=1, width do
        if (i % 2) == 1 then
            switchRight()
        else
            switchLeft()
        end
        farmLine(length)
    end    
end

function switchField()
    r.up()
    forward()
    forward()
    forward()
    r.down()
    r.turnLeft()
    for i=1, 8 do
        forward()
    end
    r.turnRight()
end

function dumpInventory()
    r.turnLeft()
    forward()
    forward()
    forward()
    forward()
    r.turnRight()
    r.up()
    r.up()
    forward()
    forward()
    r.turnAround()
end

farmSquare(9,9)
dumpInventory()