local D={}

function D.create(box,drop_box)
	local new_node=box
	new_node.func_list = {}
	new_node.drop=false
	new_node.drop_box=drop_box
	new_node.drop_box:hide()
	function new_node:on_pressed(func)
		new_node.func_list.pressed=func
		return new_node
	end

	function new_node:on_released(func)
		new_node.func_list.released=func
		return new_node
	end

	function new_node:on_hover(func)
		new_node.func_list.hover=func
		return new_node
	end

	function new_node:on_not_hover(func)
		new_node.func_list.not_hover=func
		return new_node
	end

	function new_node:pressed(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.pressed  then
			local func = new_node.func_list.pressed
			if func then
				func(self,action_id,action,new_node)
			end
		end
	end

	function new_node:pressing(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") then
			local func = new_node.func_list.pressing
			if func then
				func(self,action_id,action,new_node)
			end
		end
	end

	function new_node:released(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.released then
			local func = new_node.func_list.released 
			if func then
				func(self,action_id,action,new_node)
			end
			new_node.drop = not new_node.drop
			if new_node.drop then
				new_node.drop_box:show()
				:set_scale(vmath.vector3(1,0.01,1))
				:animate("scale.y", 1,gui.EASING_LINEAR,0.1)
			else
				new_node.drop_box:animate("scale.y", 0.01,gui.EASING_LINEAR,0.1,0,function()
					new_node.drop_box:hide()
				end)
				
			end
		end
	end

	function new_node:hover(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) then 
			local func = new_node.func_list.hover 
			if func then
				func(self,action_id,action,new_node)
			end
		elseif new_node.enabled and not new_node:pick_node(action.x,action.y) then 
			local func = new_node.func_list.not_hover 
			if func then
				func(self,action_id,action,new_node)
			end
		end
	end

	return new_node
end

return D