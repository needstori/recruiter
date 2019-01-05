-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.


local combat_entity = {}

local new = function(health, attack, defence, speed, name)
	local ce = {
		health = health or 0,
		attack = attack or 0,
		defence = defence or 0,
		speed = speed or 0,
		name = name or "Default"
	}
	return setmetatable(ce, combat_entity)
end

local calculate_damage = function(self, damage)
	if damage < self.defence then
		return math.ceil(damage * 0.5 / (self.defence / damage))
	else
		return math.ceil(damage * (1 - (self.defence / damage / 2)))
	end
end

local is_alive = function(self)
	return self.health > 0
end

local do_attack = function(self, target_combat_entity)
	if self:is_alive() then
		damage = target_combat_entity:calculate_damage(self.attack)
		target_combat_entity.health = target_combat_entity.health - damage 
		print(string.format("%s attacks %s, dealing %d. %s has %d health remaining.", self.name,
		target_combat_entity.name, damage, target_combat_entity.name, target_combat_entity.health))
	end
end

local compare_speed = function(first_combat_entity, second_combat_entity)
	return first_combat_entity.speed > second_combat_entity.speed
end

local to_string = function(self)
	return self.name
end

combat_entity.__tostring = to_string
combat_entity.calculate_damage = calculate_damage
combat_entity.is_alive = is_alive
combat_entity.do_attack = do_attack
combat_entity.compare_speed = compare_speed

combat_entity.__index = combat_entity
combat_entity.__metatable = {}

local constructor = function (cls, health, attack, defence, speed, name)
	return new(health, attack, defence, speed, name)
end


return setmetatable({}, {__call = constructor})