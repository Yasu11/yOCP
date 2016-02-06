--imports
c=require("component")
s=require("sides")
r=c.proxy(c.list("robot")())

-- move into position
r.move(s.front)
r.move(s.down)
r.move(s.down)
r.turn(false)
r.move(s.front)
r.move(s.front)
r.turn(true)

--first row
for i=1, 8 do
 r.use(s.bottom)
 r.move(s.front)
end
r.use(s.bottom)

r.turn(true)
r.move(s.front)
r.turn(true)

--second row
for i=1, 8 do
 r.use(s.bottom)
 r.move(s.front)
end
r.use(s.bottom)

r.turn(false)
r.move(s.front)
r.turn(false)

--third row
for i=1, 8 do
 r.use(s.bottom)
 r.move(s.front)
end
r.use(s.bottom)

--move to diamond & redstone field
r.turn(true)
r.move(s.front)
r.turn(true)
for i=1, 7 do
 r.move(s.front)
end

--farm diamonds and redstone
r.turn(false)

for i=1, 5 do
 r.use(s.bottom)
 r.move(s.front)
end
r.use(s.bottom)

r.turn(true)
r.move(s.front)
r.turn(true)

for i=1, 5 do
 r.use(s.bottom)
 r.move(s.front)
end
r.use(s.bottom)

-- return to home
r.move(s.front)
r.turn(false)
r.move(s.up)
r.move(s.up)
r.move(s.front)
r.turn(true)
r.turn(true)