local M={}

function M.create(box)
	local new_node=box
	new_node.press=false
	new_node.parent_pos=vmath.vector3()
	new_node.max= 100
	new_node.min= 0
	new_node.offset= 1
	new_node.value= 50
	new_node.direction="horizontal"
	local pos = gui.get_position(new_node.id)
	if new_node.direction=="horizontal" then
		pos.x = new_node.offset*new_node.value
	else
		pos.y = new_node.offset*new_node.value
	end
	gui.set_position(new_node.id,pos)
	new_node.event_list = {}
	new_node.event_list.pressed={}
	new_node.event_list.pressing={}
	new_node.event_list.released={}
	new_node.event_list.hover={}
	new_node.event_list.not_hover={}

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

	function new_node:set_max(var)
		new_node.max=var
		return new_node
	end
	
	function new_node:set_min(var)
		new_node.min=var
		return new_node
	end
	
	function new_node:set_offset(var)
		new_node.offset=var
		return new_node
	end

	function new_node:set_default_value(var)
		new_node.value=var
		return new_node
	end
	
	function new_node:set_direction(var)
		new_node.direction=var
		return new_node
	end
	function new_node:pressed(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.pressed  then
			local event = new_node.event_list.pressed
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action,new_node)
			end
			new_node.parent_pos=new_node:get_screen_position()-new_node.get_position()
			new_node.press=true
		end
	end
	function new_node:pressing(self,action_id,action)
		if new_node.enabled and action_id==hash("touch") and new_node.press then
			local mouse_pos=vmath.vector3(action.screen_x,action.screen_y,0)
			
			mouse_pos = mouse_pos-new_node.parent_pos
		
			local pos = new_node:get_position()
			local event = new_node.event_list.pressing
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action,new_node)
			end
			if new_node.direction == "horizontal" then
				if pos.x<=new_node.offset*new_node.max and pos.x>=new_node.offset*new_node.min then
					if mouse_pos.x > new_node.max then
						pos.x=new_node.max
					elseif mouse_pos.x < new_node.min then 
						pos.x=new_node.min
					else
						pos.x=mouse_pos.x
					end
					new_node.value = pos.x/new_node.offset
				end
			else
				if pos.y<=new_node.offset*new_node.max and pos.y>=new_node.offset*new_node.min then
					if mouse_pos.y > new_node.max then
						pos.y=new_node.max
					elseif mouse_pos.y < new_node.min then 
						pos.y=new_node.min
					else
						pos.y=mouse_pos.y
					end
					new_node.value = pos.y/new_node.offset
				end
			end
			new_node:set_position(pos)
		end
	end
	
	function new_node:released(self,action_id,action)
		if new_node.enabled and action_id==hash("touch") and action.released then
			local event = new_node.event_list.released
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action,new_node)
			end
			new_node.press=false
		end
	end
	
	function new_node:hover(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) then 
			local event = new_node.event_list.hover
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action,new_node)
			end
		elseif new_node.enabled and not new_node:pick_node(action.x,action.y) then 
			local event = new_node.event_list.not_hover
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action,new_node)
			end
		end
	end
	return new_node
end

return M