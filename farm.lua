require("farmlib")
local k= require("keyboard")

local l=9
local w=9

local stop = false

m.broadcast(fport, "Autofarming started")

while true do
    goToStart()
    farmRect(l,w)
    switchField(w)
    farmRect(l,w)
    returnToHome(l)
    for i = 1, 30 do
        os.sleep(1)
        if k.isKeyDown(0x2E) and k.isControlDown() then
            stop = true
        end
        if stop then break end
    end
    if stop then break end
end

m.broadcast(fport, "Autofarming stoped")