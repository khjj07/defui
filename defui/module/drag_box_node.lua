local M={}

function M.create(box)
	local new_node=box
	new_node.event_list = {}
	new_node.event_list.pressed={}
	new_node.event_list.pressing={}
	new_node.event_list.released={}
	new_node.event_list.hover={}
	new_node.event_list.not_hover={}
	
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
		table.insert(new_node.event_list.pressed, func)
		return new_node
	end

	function new_node:on_pressing(func)
		local thread = coroutine.create(func)
		table.insert(new_node.event_list.pressing, func)
		return new_node
	end

	function new_node:on_released(func)
		table.insert(new_node.event_list.released, func)
		return new_node
	end

	function new_node:on_hover(func)
		table.insert(new_node.event_list.hover, func)
		return new_node
	end

	function new_node:on_not_hover(func)
		table.insert(new_node.event_list.not_hover, func)
		return new_node
	end
	
	function new_node:pressed(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.pressed  then
			local event = new_node.event_list.pressed
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
			new_node.pressed_box_position=new_node:get_position()
			new_node.pressed_mouse_position=vmath.vector3(action.x,action.y,0)
		end
	end

	function new_node:pressing(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") then
			local event = new_node.event_list.pressing
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
		end
	end

	function new_node:released(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.released then
			local event = new_node.event_list.released
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
		end
	end

	function new_node:hover(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) then 
			local event = new_node.event_list.hover
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
		elseif new_node.enabled and not new_node:pick_node(action.x,action.y) then 
			local event = new_node.event_list.not_hover
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
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

return M