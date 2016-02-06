--imports
c  = require("component")
s  = require("sides")
r  = require("robot")
r1 = c.proxy(c.list("robot")())
n  = require("note")
os = require("os")

function sound(a)
    if a=="error" then
        n.play("A4",0.2)
        os.sleep(0.1)
        n.play("A4",0.2)
        os.sleep(0.1)
        n.play("A4",0.2)
    elseif a == "attention" then
        n.play("C3",0.3)
        os.sleep(0.1)
        n.play("C3",0.3)
    elseif a == "beep" then
        n.play("C3",0.1)
        os.sleep(0.05)
        n.play("C3",0.1)
    elseif a == "start" then
        n.play("C3",0.2)
        os.sleep(0.05)
        n.play("E3",0.2)
        os.sleep(0.05)
        n.play("G3",0.2)
        os.sleep(0.05)
        n.play("C4",0.15)
    elseif a == "end" then
        n.play("C4",0.2)
        os.sleep(0.05)
        n.play("G3",0.2)
        os.sleep(0.05)
        n.play("E3",0.2)
        os.sleep(0.05)
        n.play("C3",0.15)
    end
end

function forward ()
	b = false
	while true do
		b = r.forward()
		if b then
			return
		end
        sound("beep")
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
    sound("attention")
    r.turnLeft()
    forward()
    r.turnLeft()
end

function switchRight()
    sound("attention")
    r.turnRight()
    forward()
    r.turnRight()
end

-- farms a field from the lower left
-- ends on upper right
function farmRect(length, width)
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
    
    if width % 2 == 0 then
    r.turnAround()        
        for i=1, length do
            forward()
        end
    end
end

function switchField(width)
    sound("attention")
    r.up()
    forward()
    forward()
    forward()
    r.down()
    r.turnLeft()
    for i=1, width-1 do
        forward()
    end
    r.turnRight()
end

function dumpInventory()
    os.sleep(20)
end

-- goes to the lower left 
-- of the first field
function goToStart()
    sound("start")
    forward()
    forward()
    r.down()
    r.down()
    r.down()
    r.turnLeft()
    forward()
    forward()
    forward()
    forward()
    r.turnRight()
end

function returnToHome(length)
    r.turnAround()
    for i=1, length-1 do
        forward()
    end
    
    sound("attention")
    r.up()
    forward()
    forward()
    forward()
    r.down()
    
    for i=1, length-1 do
        forward()
    end
    r.turnRight()
    for i=1, length/2 do
        forward()
    end
    r.turnLeft()
    r.up()
    forward()
    r.up()
    r.up()
    forward()
    r.turnAround()
    sound("end")
end

-- EOF