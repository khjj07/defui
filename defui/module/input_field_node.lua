local M={}

function M.create(box,text)
	local new_node=box
	new_node.text=text
	new_node.input=false
	new_node.event_list = {}
	new_node.event_list.pressed={}
	new_node.event_list.pressing={}
	new_node.event_list.released={}
	new_node.event_list.hover={}
	new_node.event_list.not_hover={}
	new_node.event_list.text={}
	new_node.event_list.delete={}



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
	
	function new_node:on_text(func)
		table.insert(new_node.event_list.text, func)
		return new_node
	end

	function new_node:on_delete(func)
		table.insert(new_node.event_list.delete, func)
		return new_node
	end
	
	function new_node:pressed(self,action_id,action)
		if new_node.enabled and new_node:pick_node(action.x,action.y) and action_id==hash("touch") and action.pressed  then
			local event = new_node.event_list.pressed
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
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
			new_node.input=true
		elseif action_id==hash("touch") and action.released then
			new_node.input=false
		end
	end
	function new_node:text_input(self,action_id,action)
		local text = new_node.text:get_text()
		if new_node.enabled and new_node.input and action_id==hash("text") then
			text = text .. action.text
			local event = new_node.event_list.text
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
		elseif new_node.enabled and new_node.input and action_id==hash("backspace") and (action.pressed or action.repeated)  then
			text=string.sub(text, 1,string.len(text)-1)
			local event = new_node.event_list.delete
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action)
			end
		end
		new_node.text:set_text(text)
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