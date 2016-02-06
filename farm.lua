f = require("farmlib")

l=9
w=9

f.goToStart()
f.farmRect(l,w)
f.switchField(w)
f.farmRect(l,w)
f.returnToHome(l)
f.dumpInventory()