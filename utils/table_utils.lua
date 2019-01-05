-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
local table_utils = {}

function table_utils:table_append(table_a, table_b)
	for i=1, #table_b, 1 do
		table_a[#table_a + 1] = table_b[i]
	end
end

function table_utils:table_contains(table, check_for)
	for index, value in pairs(table) do 
		if value == check_for then
			return true;
		end
	end
	return false
end

return table_utils