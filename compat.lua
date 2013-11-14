-- this bit of code modifies the default chests and furnaces to be compatible
-- with pipeworks.

function pipeworks:clone_node(name)
	node2={}
	node=minetest.registered_nodes[name]
	for k,v in pairs(node) do
		node2[k]=v
	end
	return node2
end

furnace=pipeworks:clone_node("default:furnace")
	furnace.tiles[1] = "pipeworks_furnace_top.png"
	furnace.tiles[2] = "pipeworks_furnace_bottom.png"
	furnace.tiles[3] = "pipeworks_furnace_side.png"
	furnace.tiles[4] = "pipeworks_furnace_side.png"
	furnace.tiles[5] = "pipeworks_furnace_side.png"
		-- note we don't redefine entry #6 - the front.
	furnace.groups.tubedevice=1
	furnace.groups.tubedevice_receiver=1
	furnace.tube={insert_object = function(pos,node,stack,direction)
			local meta=minetest.get_meta(pos)
			local inv=meta:get_inventory()
			if direction.y==1 then
				return inv:add_item("fuel",stack)
			else
				return inv:add_item("src",stack)
			end
		end,
	can_insert=function(pos,node,stack,direction)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		if direction.y==1 then
			return inv:room_for_item("fuel",stack)
		elseif direction.y==-1 then
			return inv:room_for_item("src",stack)
		else
			return 0
	end
	end,
	input_inventory="dst",
	connect_sides={left=1, right=1, back=1, bottom=1}}
	furnace.after_place_node= function(pos)
		tube_scanforobjects(pos)
	end
	furnace.after_dig_node = function(pos)
		tube_scanforobjects(pos)
	end

minetest.register_node(":default:furnace",furnace)

furnace=pipeworks:clone_node("default:furnace_active")
	furnace.tiles[1] = "pipeworks_furnace_top.png"
	furnace.tiles[2] = "pipeworks_furnace_bottom.png"
	furnace.tiles[3] = "pipeworks_furnace_side.png"
	furnace.tiles[4] = "pipeworks_furnace_side.png"
	furnace.tiles[5] = "pipeworks_furnace_side.png"
		-- note we don't redefine entry #6 - the front.
	furnace.groups.tubedevice=1
	furnace.groups.tubedevice_receiver=1
	furnace.tube={insert_object=function(pos,node,stack,direction)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		if direction.y==1 then
			return inv:add_item("fuel",stack)
		else
			return inv:add_item("src",stack)
		end
	end,
	can_insert=function(pos,node,stack,direction)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		if direction.y==1 then
			return inv:room_for_item("fuel",stack)
		elseif direction.y==-1 then
			return inv:room_for_item("src",stack)
		else
			return 0
		end
	end,
	input_inventory="dst",
	connect_sides={left=1, right=1, back=1, bottom=1}}
	furnace.after_place_node= function(pos)
		tube_scanforobjects(pos)
	end
	furnace.after_dig_node = function(pos)
		tube_scanforobjects(pos)
	end
	minetest.register_node(":default:furnace_active",furnace)


chest=pipeworks:clone_node("default:chest")
	chest.tiles[1] = "pipeworks_chest_tb.png"
	chest.tiles[2] = "pipeworks_chest_tb.png"
	chest.tiles[3] = "pipeworks_chest_side.png"
	chest.tiles[4] = "pipeworks_chest_side.png"
	chest.tiles[5] = "pipeworks_chest_side.png"
		-- note we don't redefine entry #6 - the front.
	chest.groups.tubedevice=1
	chest.groups.tubedevice_receiver=1
	chest.tube={insert_object = function(pos,node,stack,direction)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		return inv:add_item("main",stack)
	end,
	can_insert=function(pos,node,stack,direction)
		local meta=minetest.get_meta(pos)
		local inv=meta:get_inventory()
		return inv:room_for_item("main",stack)
	end,
	input_inventory="main",
	connect_sides={left=1, right=1, back=1, bottom=1, top=1}}
	chest.after_place_node = function(pos)
		tube_scanforobjects(pos)
	end
	chest.after_dig_node = function(pos)
		tube_scanforobjects(pos)
	end

minetest.register_node(":default:chest",chest)


chest_locked=pipeworks:clone_node("default:chest_locked")
	chest_locked.tiles[1] = "pipeworks_chest_tb.png"
	chest_locked.tiles[2] = "pipeworks_chest_tb.png"
	chest_locked.tiles[3] = "pipeworks_chest_side.png"
	chest_locked.tiles[4] = "pipeworks_chest_side.png"
	chest_locked.tiles[5] = "pipeworks_chest_side.png"
		-- note we don't redefine entry #6 - the front.
	chest_locked.groups.tubedevice=1
	chest_locked.groups.tubedevice_receiver=1
	chest_locked.tube={insert_object = function(pos,node,stack,direction)
		local meta=minetest.env:get_meta(pos)
		local inv=meta:get_inventory()
		return inv:add_item("main",stack)
	end,
	can_insert=function(pos,node,stack,direction)
		local meta=minetest.env:get_meta(pos)
		local inv=meta:get_inventory()
		return inv:room_for_item("main",stack)
	end,
	connect_sides={left=1, right=1, back=1, bottom=1, top=1}}
  local old_after_place = minetest.registered_nodes["default:chest_locked"].after_place_node;
	chest_locked.after_place_node = function(pos, placer)
		tube_scanforobjects(pos)
    old_after_place(pos, placer)
	end
	chest_locked.after_dig_node = function(pos)
		tube_scanforobjects(pos)
	end

minetest.register_node(":default:chest_locked",chest_locked)
