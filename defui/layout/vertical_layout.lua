local L={}
local function realign_content(new_node)
	for index, content in pairs(new_node.child) do
		local pos = vmath.vector3(new_node.standard.x,new_node.standard.y-new_node.offset*(index-1),0)
		content:set_position(pos)
	end
end


function L.create(box)
	local new_node=box
	new_node.standard=vmath.vector3()
	new_node.offset=100
	new_node.child_mt = {
		__index = function(table, key) 
			for index, content in pairs(table) do
				local pos = vmath.vector3(new_node.standard.x,new_node.standard.y-new_node.offset*(index-1),0)
				content:set_position(pos)
			end
		end,
		__newindex = function(table, key, value)
			for index, content in pairs(table) do
				local pos = vmath.vector3(new_node.standard.x,new_node.standard.y-new_node.offset*(index-1),0)
				content:set_position(pos)
			end
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