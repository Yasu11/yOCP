--imports
c  = require("component")
s  = require("sides")
r  = require("robot")
local r1 = c.robot
n  = require("note")
os = require("os")
t  = require("term")
m  = c.modem

local fport = 235

function getInvRat()
	iS = r.inventorySize()
	iL = 0
	for i = 1, iS do
		if r.count(i) > 0 then
			iL = iL +1
		end
	end
	return tostring(iL/iS)
end

function sound(a)
	if a=="error" then
		n.play("A4",0.2)
		os.sleep(0.1)
		n.play("A4",0.2)
		os.sleep(0.1)
		n.play("A4",0.2)
	elseif a == "attention" then
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

local function throwError()
	sound("error")
    m.broadcast(fport,"ERROR")
end

local function forward ()
	b = false
	i = 0
	while true do
		b = r.forward()
		if b then
			return
		end
		sound("beep")
		os.sleep(0.25)
		i = i + 1
		if i > 20 then
			throwError()
			i = 0
		end
	end
end

local function farm ()
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
    m.broadcast(fport,"IR:" .. getInvRat())
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

	if width % 2 == 1 then
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

-- goes to the lower left
-- of the first field
function goToStart()
	sound("start")
    m.broadcast(fport,"start")
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
    m.broadcast(fport,"end")
end

-- EOF