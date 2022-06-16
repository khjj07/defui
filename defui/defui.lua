local D={}
local box_node = require "defui.module.box_node"
local text_node = require "defui.module.text_node"
local button_node = require "defui.module.button_node"
local slider_node = require "defui.module.slider_node"
local scroll_view_node = require "defui.module.scroll_view_node"
local drag_box_node = require "defui.module.drag_box_node"
local toggle_node = require "defui.module.toggle_node"
local input_field_node = require "defui.module.input_field_node"
local dropdown_node = require "defui.module.dropdown_node"
local vertical_layout = require "defui.layout.vertical_layout"
local horizontal_layout = require "defui.layout.horizontal_layout"
local grid_layout = require "defui.layout.grid_layout"
local flow = require "defui.module.gui_flow"

function D.create_button(self,name,box)
	box=box or self.node[name]
	self.button[name]=button_node.create(box)
	return self.button[name]
end

function D.delete_button(self,name)
	self.button[name] = nil
	self.node[name] = nil
end


function D.create_slider(self,name,box)
	box=box or self.node[name]
	self.slider[name]=slider_node.create(box)
	return self.slider[name]
end

function D.delete_slider(self,name)
	self.slider[name] = nil
	self.node[name] = nil
end

function D.create_scroll_view(self,name1,name2,box,content)
	box=box or self.node[name1]
	content=content or self.node[name2]
	self.scroll_view[name1]=scroll_view_node.create(box,content)
	return self.scroll_view[name1]
end

function D.delete_scroll_view(self,name)
	self.scroll_view[name] = nil
	self.node[name] = nil
end

function D.create_drag_box(self,name,box)
	box=box or self.node[name]
	self.drag_box[name]=drag_box_node.create(box)
	return self.drag_box[name]
end

function D.delete_drag_box(self,name)
	self.drag_box[name] = nil
	self.node[name] = nil
end


function D.create_toggle(self,name1,name2,box,mark)
	box=box or self.node[name1]
	mark=mark or self.node[name2]
	self.toggle[name1]=toggle_node.create(box,mark)
	return self.toggle[name1]
end

function D.delete_toggle(self,name)
	self.toggle[name] = nil
	self.node[name] = nil
end

function D.create_input_field(self,name1,name2,box,text)
	box=box or self.node[name1]
	text=text or self.node[name2]
	self.input_field[name1]=input_field_node.create(box,text)
	return self.input_field[name1]
end

function D.delete_input_field(self,name)
	self.input_field[name] = nil
	self.node[name] = nil
end

function D.create_dropdown(self,name1,name2,box,drop_box)
	box=box or self.node[name1]
	drop_box=drop_box or self.node[name2]
	self.dropdown[name1]=dropdown_node.create(box,drop_box)
	return self.dropdown[name1]
end

function D.delete_dropdown(self,name)
	self.dropdown[name] = nil
	self.node[name] = nil
end

function D.create_flow(self,name)
	self.flow[name]=flow.create(name)
	return self.flow[name]
end

function D.delete_flow(self,name)
	self.flow[name] = nil
	self.node[name] = nil
end

function D.set_vertical_layout(self,name,box)
	box=box or self.node[name]
	return vertical_layout.create(box)
end

function D.set_horizontal_layout(self,name,box)
	box=box or self.node[name]
	return horizontal_layout.create(box)
end

function D.set_grid_layout(self,name,box)
	box=box or self.node[name]
	return grid_layout.create(box)
end

function D.init(self)
	self.button={}
	self.slider={}
	self.scroll_view={}
	self.drag_box={}
	self.toggle={}
	self.input_field={}
	self.dropdown={}
	self.flow={}
end

function D.on_input(self, action_id, action)
	for _, button in pairs(self.button) do
		button:pressed(self,action_id,action)
		button:pressing(self,action_id,action)
		button:released(self,action_id,action)
		button:hover(self,action_id,action)
	end

	for _, slider in pairs(self.slider) do
		slider:pressed(self,action_id,action)
		slider:pressing(self,action_id,action)
		slider:released(self,action_id,action)
		slider:hover(self,action_id,action)
	end
	
	for _, scroll_view in pairs(self.scroll_view) do
		scroll_view:pressed(self,action_id,action)
		scroll_view:pressing(self,action_id,action)
		scroll_view:released(self,action_id,action)
		scroll_view:hover(self,action_id,action)
	end

	for _, drag_box in pairs(self.drag_box) do
		drag_box:pressed(self,action_id,action)
		drag_box:pressing(self,action_id,action)
		drag_box:released(self,action_id,action)
		drag_box:hover(self,action_id,action)
	end

	for _, toggle in pairs(self.toggle) do
		toggle:pressed(self,action_id,action)
		toggle:pressing(self,action_id,action)
		toggle:released(self,action_id,action)
		toggle:hover(self,action_id,action)
	end

	for _, input_field in pairs(self.input_field) do
		input_field:pressed(self,action_id,action)
		input_field:pressing(self,action_id,action)
		input_field:released(self,action_id,action)
		input_field:hover(self,action_id,action)
		input_field:text_input(self,action_id,action)
	end

	for _, dropdown in pairs(self.dropdown) do
		dropdown:pressed(self,action_id,action)
		dropdown:pressing(self,action_id,action)
		dropdown:released(self,action_id,action)
		dropdown:hover(self,action_id,action)
	end
end



return D