
local S = technic.getter

function technic.register_alloy_furnace(data)
	data.typename = "alloy"
	data.machine_name = "alloy_furnace"
	data.machine_desc = S("%s Alloy Furnace")

	data.can_insert = function(pos, node, stack, direction)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if meta:get_int("splitstacks") == 1 then
			stack = stack:peek_item(1)
		end

		-- reject second stack of item that is already present
		for _,inv_stack in pairs(inv:get_list("src")) do
			if not inv_stack:is_empty() and inv_stack:get_name() == stack:get_name() then
				return inv_stack:item_fits(stack)
			end
		end

		return technic.default_can_insert(pos, node, stack, direction)
	end

	technic.register_base_machine(data)
end

