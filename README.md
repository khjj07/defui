# DefUI


DefUI is a UI tool created to solve the hassle of UI work.



##Installation

Install DefUI in your project by adding it as a [library dependency](https://www.defold.com/manuals/libraries/). Open your game.project file and in the "Dependencies" field under "Project", add:

```
https://github.com/khjj07/defui/archive/refs/tags/1.1.0.zip
```

Then open the "Project" menu of the editor and click "Fetch Libraries". You should see the "defui" folder appear in your assets panel after a few moments.

##How to use

1. Press the Update gui module
![20220818_053934](https://user-images.githubusercontent.com/57747205/185238722-dd1522b0-9d11-43d1-886b-eb5b5d5e9038.png)

2. Then, you can see that the module is created with the gui node information you configured in the same folder.
![20220818_054322](https://user-images.githubusercontent.com/57747205/185239392-706fd03b-4dcc-40af-9421-40dc24bb4e0b.png)

3. Import created ui module and defui module. defui module allow you to create and use some widget

```lua
local ui = require "main.new"
local defui = require "defui.defui"

function init(self)
    ui.init(self)
    defui.init(self)
end

function on_input(self,action_id,action)
    defui.on_input(self,action_id,action)
end
```

##Example
new.module
```lua
local G={}
local node = require "defui.module.node"
function G.init(self)
	self.node={}
	self.node["box"]=node.create(gui.get_node("box"),nil)
end
return G
```

new.gui_script
```lua
local ui = require "main.new"
local defui = require "defui.defui"

function init(self)
    ui.init(self)
    defui.init(self)
    defui.create_button(self, "box")
	:on_pressed(function(self,action_id,action)
		print("button_pressed")
	end)
        :on_released(function(self,action_id,action)
		print("button_released")
	end)
        :on_pressing(function(self,action_id,action)
		print("button_pressing")
	end)
        :on_hover(function(self,action_id,action)
		print("button_hover")
	end)
end

function on_input(self,action_id,action)
    defui.on_input(self,action_id,action)
end
```


##Document
