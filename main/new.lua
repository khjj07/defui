local G={}
local box_node = require "defui.module.box_node"
local text_node = require "defui.module.text_node"
function G.init(self)
	self.node={}
	self.box_node={}
	self.text_node={}
	self.node["box"]=box_node.create(gui.get_node("box"),nil)
	self.node["box1"]=box_node.create(gui.get_node("box1"),self.node["box"])
	self.node["box2"]=box_node.create(gui.get_node("box2"),self.node["box"])
	self.node["box3"]=box_node.create(gui.get_node("box3"),self.node["box"])
	self.node["box4"]=box_node.create(gui.get_node("box4"),self.node["box"])
	self.node["box5"]=box_node.create(gui.get_node("box5"),self.node["box"])
	self.node["box6"]=box_node.create(gui.get_node("box6"),self.node["box"])
	self.node["box7"]=box_node.create(gui.get_node("box7"),self.node["box"])
	self.node["box8"]=box_node.create(gui.get_node("box8"),self.node["box"])
	self.node["box9"]=box_node.create(gui.get_node("box9"),self.node["box"])
	self.node["box10"]=box_node.create(gui.get_node("box10"),self.node["box"])
	self.node["box11"]=box_node.create(gui.get_node("box11"),self.node["box"])
	self.node["box12"]=box_node.create(gui.get_node("box12"),self.node["box"])
	self.node["box13"]=box_node.create(gui.get_node("box13"),self.node["box"])
	self.node["box14"]=box_node.create(gui.get_node("box14"),self.node["box"])
	self.node["box15"]=box_node.create(gui.get_node("box15"),self.node["box"])
	self.node["box16"]=box_node.create(gui.get_node("box16"),self.node["box"])
	self.node["box17"]=box_node.create(gui.get_node("box17"),self.node["box"])
	self.node["box18"]=box_node.create(gui.get_node("box18"),self.node["box"])
	self.node["box19"]=box_node.create(gui.get_node("box19"),self.node["box"])
	self.node["box20"]=box_node.create(gui.get_node("box20"),self.node["box"])
	self.node["box21"]=box_node.create(gui.get_node("box21"),self.node["box"])
	self.node["box22"]=box_node.create(gui.get_node("box22"),self.node["box"])
	self.node["box23"]=box_node.create(gui.get_node("box23"),self.node["box"])
end
return G