local L={}
local function realign_content(new_node)
	if new_node.direction == hash("vertical") then
		for index, content in pairs(new_node.child) do
			local pos = vmath.vector3(new_node.standard.x+new_node.offset*((index-1)%new_node.line_num),new_node.standard.y-new_node.offset*math.floor((index-1)/new_node.line_num),0)
			content:set_position(pos)
		end
	elseif new_node.direction == hash("horizontal") then
		for index, content in pairs(new_node.child) do
			local pos = vmath.vector3(new_node.standard.x+new_node.offset*(index%new_node.line_num-1),new_node.standard.y-new_node.offset*(new_node.line_num-1),0)
			content:set_position(pos)
		end
	end
	
end


function L.create(box)
	local new_node=box
	new_node.standard=vmath.vector3()
	new_node.offset=100
	new_node.direction=hash("vertical")
	new_node.line_num=4
	new_node.child_mt = {
		__index = function(table, key) 
			realign_content(new_node)
		end,
		__newindex = function(table, key, value)
			realign_content(new_node)
		end
	}
	setmetatable(new_node.child, new_node.child_mt)
	realign_content(new_node)
	function new_node:set_standard(standard)
		new_node.standard=standard
		realign_content(new_node)
		return new_node
	end
	
	function new_node:set_offset(offset)
		new_node.offset=offset
		realign_content(new_node)
		return new_node
	end
	
	return new_node
end

return L