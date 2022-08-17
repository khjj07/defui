local G={}
local node = require "defui.module.node"
function G.init(self)
	self.node={}
	self.node["box"]=node.create(gui.get_node("box"),nil)
end
return G