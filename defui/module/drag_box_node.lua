local D={}

function D.create(box)
	local new_node=box
	new_node.func_list = {}
	new_node.content=content
	new_node.pressed_position=nil

	function new_node:set_vertical(var)
		new_node.vertical=var
		return new_node
	end

	function new_node:set_horizontal(var)
		new_node.horizontal=var
		return new_node
	end


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
			new_node.pressed_box_position=new_node:get_position()
			new_node.pressed_mouse_position=vmath.vector3(action.x,action.y,0)
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
		if action.released then
			new_node.pressed_box_position=nil
			new_node.pressed_mouse_position=nil
		end
		if new_node.pressed_box_position then
			local difference = vmath.vector3(action.x,action.y,0)-new_node.pressed_mouse_position
			new_node:set_position(new_node.pressed_box_position+difference)
		end
	end

	return new_node
end

return D