local M={}

function M.create(box,mark)
	local new_node=box
	new_node.check=false
	new_node.press=false
	new_node.mark=mark
	new_node.mark:hide()
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
	
	function new_node:pressed(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.pressed  then
			new_node.press=true
			local event = new_node.event_list.pressed
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
		
		end
	end
	
	function new_node:pressing(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and new_node.press then
			local event = new_node.event_list.pressing
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
		end
	end
	
	function new_node:released(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.released and new_node.press then
			local event = new_node.event_list.released
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
			new_node.press=false
			new_node.check = not new_node.check
			if new_node.check then
				new_node.mark:show()
			else
				new_node.mark:hide()
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
	end
	
	return new_node
end

return M