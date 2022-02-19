local G={}

function G.create(name)
	local new_flow={name=name,list={},index_flag=1}
	function new_flow:add(box)
		box:set_position(vmath.vector3(10000,0,0))
		box:hide()
		table.insert(new_flow.list, box)
		return new_flow
	end
	
	function new_flow:enable()
		for i = 1, #new_flow.list do
			if i==new_flow.index_flag then
				new_flow.list[i]:set_position(vmath.vector3(0,0,0))
			end
			new_flow.list[i]:show()
		end
		return new_flow
	end
	function new_flow:disable()
		for i = 1, #new_flow.list do
			new_flow.list[i]:set_position(10000,0,0)
			new_flow.list[i]:hide()
		end
		return new_flow
	end
	function new_flow:next(property,to,easing,duration,delay)
		property = property or "position"
		to = to or gui.get_position(new_flow.id)
		easing = easing or gui.EASING_LINEAR
		duration = duration or 0
		delay = delay or 0
		if new_flow.index_flag<#new_flow.list then
			new_flow:animate(property, to, easing, duration,delay,function()
				new_flow.list[new_flow.index_flag]:set_position(vmath.vector3(10000,0,0))
				new_flow.index_flag=new_flow.index_flag+1
				new_flow.list[new_flow.index_flag]:set_position(vmath.vector3(0,0,0))
			end)
		end
		return new_flow
	end
	function new_flow:previous(property,to,easing,duration,delay)
		property = property or "position"
		to = to or gui.get_position(new_flow.id)
		easing = easing or gui.EASING_LINEAR
		duration = duration or 0
		delay = delay or 0
		if new_flow.index_flag>1 then
			new_flow:animate(property, to, easing, duration,delay,function()
				new_flow.list[new_flow.index_flag]:set_position(vmath.vector3(10000,0,0))
				new_flow.index_flag=new_flow.index_flag-1
				new_flow.list[new_flow.index_flag]:set_position(vmath.vector3(0,0,0))
			end)
		end
		return new_flow
	end
	function new_flow:change(index,property,to,easing,duration,delay)
		property = property or "position"
		to = to or gui.get_position(new_flow.id)
		easing = easing or gui.EASING_LINEAR
		duration = duration or 0
		delay = delay or 0
		new_flow:animate(property, to, easing, duration,delay,function()
			new_flow.list[new_flow.index_flag]:set_position(vmath.vector3(10000,0,0))
			new_flow.index_flag=index
			new_flow.list[new_flow.index_flag]:set_position(vmath.vector3(0,0,0))
		end)
		return new_flow
	end
	return new_flow
end

return G