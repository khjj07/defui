local M={}

local function delete_child(node)
	gui.set_parent(node.id, nil)
	if node.parent then
		for _, c in pairs(node.parent.child) do
			if c==node then
				table.remove(node.parent.child,_)
				break
			end
		end
	end
	node.parent=nil
end

function M.create(id,parent)
	local new_node={id=id,parent=parent}
	
	if parent then
		table.insert(parent.child, new_node)
	end
	
	new_node.enabled=true
	new_node.child={}
	new_node.event_list={}
	new_node.event_list.show={}
	new_node.event_list.hide={}
	new_node.event_list.delete={}
	for _, event in pairs(new_node.event_list) do
		setmetatable(event, event_meta)
	end

	function new_node:on_show(func)
		local temp={coroutine.create(func(self,action_id,action))}
		setmetatable(temp, event_meta)
		new_node.event_list.show=new_node.event_list.show+temp
		return new_node
	end
	function new_node:on_hide(func)
		local temp={coroutine.create(func(self,action_id,action))}
		setmetatable(temp, event_meta)
		new_node.event_list.hide=new_node.event_list.hide+temp
		return new_node
	end
	function new_node:on_delete(func)
		local temp={coroutine.create(func(self,action_id,action))}
		setmetatable(temp, event_meta)
		new_node.event_list.delete=new_node.event_list.delete+temp
		return new_node
	end
	
	function new_node:hide(flag)
		if not flag then
			gui.set_enabled(new_node.id,false)
			new_node.enabled=false
			for _, c in pairs(new_node.child) do
				c:hide(true)
			end
			local event = new_node.event_list.hide
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action,new_node)
			end
		else
			new_node.enabled=false
			for _, c in pairs(new_node.child) do
				c:hide(true)
			end
		end
		return new_node
	end
	
	function new_node:show(flag)
		if not flag then
			gui.set_enabled(new_node.id,true)
			new_node.enabled=true
			for _, c in pairs(new_node.child) do
				c:show(true)
			end
			local event = new_node.event_list.show
			for _, v in pairs(event) do
				local t = coroutine.create(v)
				coroutine.resume(t,self,action_id,action,new_node)
			end
		elseif gui.is_enabled(new_node.id) then
			new_node.enabled=true
			for _, c in pairs(new_node.child) do
				c:show(true)
			end
		end
		return new_node
	end
	
	function new_node:set_parent(parent,transform)
		if parent then
			delete_child(new_node)
			gui.set_parent(new_node.id, parent.id, transform)
			new_node.parent=parent
			if parent then
				table.insert(new_node.parent.child, new_node)
			end
		else
			delete_child(new_node)
		end
		new_node.parent=parent
		return new_node
	end
	
	function new_node:delete()
		delete_child(new_node)
		gui.delete_node(new_node.id)
		local event = new_node.event_list.delete
		for _, v in pairs(event) do
			local t = coroutine.create(v)
			coroutine.resume(t,self,action_id,action,new_node)
		end
	end
	
	function new_node:animate(property, to, easing, duration,delay,complete_function,playback)
		delay=delay or 0
		complete_function=complete_function or nil
		playback=playback or gui.PLAYBACK_ONCE_FORWARD
		gui.animate(new_node.id, property, to, easing, duration,delay,complete_function,playback)
		return new_node
	end


	function new_node:animate_relatively(property, to, easing, duration,delay,complete_function,playback)
		delay=delay or 0
		complete_function=complete_function or nil
		playback=playback or gui.PLAYBACK_ONCE_FORWARD
		if property == "position" then
			to=new_node:get_position()+to
		elseif property == "position.x" then
			to=new_node:get_position().x+to
		elseif property == "position.y" then
			to=new_node:get_position().y+to
		elseif property == "position.z" then
			to=new_node:get_position().z+to
		elseif property == "rotation" then
			to=new_node:get_rotation()+to
		elseif property == "rotation.x" then
			to=new_node:get_rotation().x+to
		elseif property == "rotation.y" then
			to=new_node:get_rotation().y+to
		elseif property == "rotation.z" then
			to=new_node:get_rotation().z+to
		elseif property == "scale" then
			to=new_node:get_scale()+to
		elseif property == "scale.x" then
			to=new_node:get_scale().x+to
		elseif property == "scale.y" then
			to=new_node:get_scale().y+to
		elseif property == "scale.z" then
			to=new_node:get_scale().z+to
		elseif property == "size" then
			to=new_node:get_size()+to
		elseif property == "size.x" then
			to=new_node:get_size().x+to
		elseif property == "size.y" then
			to=new_node:get_size().y+to
		elseif property == "size.z" then
			to=new_node:get_size().z+to
		elseif property == "slice_9" then
			to=new_node:get_slice9()+to
		elseif property == "slice_9.x" then
			to=new_node:get_slice9().x+to
		elseif property == "slice_9.y" then
			to=new_node:get_slice9().y+to
		elseif property == "slice_9.z" then
			to=new_node:get_slice9().z+to
		end
		gui.animate(new_node.id, property, to, easing, duration,delay,complete_function,playback)
		return new_node
	end
	
	
	function new_node:cancel_animation(property)
		gui.cancel_animation(new_node.id, property)
	end
	

	function new_node:set_blend_mode(blend_mode)
		gui.set_blend_mode(new_node.id,blend_mode)
		return new_node
	end

	function new_node:set_id(id)
		gui.set_id(new_node.id, id)
		new_node.id=gui.get_node(id)
		return new_node
	end

	function new_node:set_position(pos)
		gui.set_position(new_node.id,pos)
		new_node.position = pos
		return new_node
	end

	function new_node:set_layer(layer)
		gui.set_layer(new_node.id,layer)
		return new_node
	end

	function new_node:set_rotation(rot)
		gui.set_rotation(new_node.id,rot)
		new_node.rotation = rot
		return new_node
	end
	
	function new_node:set_scale(scale)
		gui.set_scale(new_node.id,scale)
		new_node.scale = scale
		return new_node
	end

	function new_node:set_size(size)
		gui.set_size(new_node.id,size)
		new_node.size = size
		return new_node
	end

	function new_node:set_slice9(slice_9)
		gui.set_slice9(new_node.id,slice_9)
		new_node.slice9 = slice_9
		return new_node
	end

	function new_node:set_color(color)
		gui.set_color(new_node.id,color)
		new_node.color = color
		return new_node
	end
	
	function new_node:set_clipping_mode(clipping_mode)
		gui.set_clipping_mode(new_node.id,clipping_mode)
		return new_node
	end
	
	function new_node:set_clipping_visible(bool)
		gui.set_clipping_visible(new_node.id,bool)
		return new_node
	end
	
	function new_node:set_clipping_inverted(bool)
		gui.set_clipping_inverted(new_node.id,bool)
		return new_node
	end
	
	function new_node:set_xanchor(anchor)
		gui.set_xanchor(new_node.id,anchor)
		return new_node
	end
	
	function new_node:set_yanchor(anchor)
		gui.set_yanchor(new_node,anchor)
		return new_node
	end	
	
	function new_node:set_pivot(pivot)
		gui.set_pivot(new_node.id,pivot)
		return new_node
	end
	

	function new_node:get_position()
		return gui.get_position(new_node.id)
	end
	function new_node:get_rotation()
		return gui.get_rotation(new_node.id)
	end

	function new_node:get_scale()
		return gui.get_scale(new_node.id)
	end
	
	function new_node:get_size()
		return gui.get_size(new_node.id)
	end
	
	function new_node:get_slice9()
		return gui.get_slice9(new_node.id)
	end

	function new_node:get_color()
		return gui.get_color(new_node.id)
	end
	
	function new_node:get_layer()
		return gui.get_layer(new_node.id)
	end
	
	function new_node:get_screen_position()
		return gui.get_screen_position(new_node.id)
	end
	
	function new_node:change_texture(animation,texture)
		texture=texture or nil
		if texture then
			gui.set_texture(new_node.id,texture)
			gui.play_flipbook(new_node.id,animation)
		else
			gui.play_flipbook(new_node.id,animation)
		end
		return new_node
	end
	
	function new_node:pick_node(x,y)
		return gui.pick_node(new_node.id, x, y)
	end
	
	function new_node:set_text(text)
		gui.set_text(new_node.id,text)
		return new_node
	end

	function new_node:get_text()
		return gui.get_text(new_node.id)
	end
	
	function new_node:set_outline(outline)
		gui.set_outline(new_node.id,outline)
		return new_node
	end
	
	function new_node:get_outline()
		return gui.get_outline(new_node.id)
	end

	function new_node:set_font(font)
		gui.set_font(new_node.id,font)
		return new_node
	end

	function new_node:get_font()
		return gui.get_font(new_node.id)
	end
	
	new_node.initial_position=new_node:get_position()
	new_node.initial_rotation=new_node:get_rotation()
	new_node.initial_scale=new_node:get_scale()
	new_node.initial_size=new_node:get_size()
	new_node.initial_slice_9=new_node:get_slice9()
	new_node.initial_color=new_node:get_color()
	new_node.initial_layer=new_node:get_layer()
	new_node.initial_screen_position=new_node:get_screen_position()
	return new_node
end

return M