require("farmlib")
k= require("keyboard")

l=9
w=9

stop = false

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