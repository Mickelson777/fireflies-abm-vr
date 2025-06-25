local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Firefly = require(script.Parent.FireflyAgent)

local FireflyManager = {}
FireflyManager.__index = FireflyManager

function FireflyManager.new()
	local self = setmetatable({}, FireflyManager)
	self.fireflies = {}
	
	return self
end

function FireflyManager:spawn(position)
	local template = ReplicatedStorage:WaitForChild("FireflyTemplate")
	local clone = template:Clone()
	clone.Parent = workspace.FireflyAgents
	clone:PivotTo(CFrame.new(position))

	local firefly = Firefly.new(clone)
	table.insert(self.fireflies, firefly)
end

function FireflyManager:updateAll(dt)
	for _, firefly in ipairs(self.fireflies) do
		firefly:update(dt)
	end
end

return FireflyManager