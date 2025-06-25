local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FireflyManager = require(ReplicatedStorage.Modules.FireflyManager)

local habitat = workspace:WaitForChild("Map"):WaitForChild("Grass")

local manager = FireflyManager.new()

-- spawn at a random point on the baseplate (will need to add checks so it doesn't spawn inside a tree or something and actually understands barriers etc.)
local function getRandomSpawnPosition(part)
	local half = part.Size * 0.5
	local offset = Vector3.new(
		math.random() * part.Size.X - half.X,
		part.Size.Y * 0.5 + 7.5,
		math.random() * part.Size.Z - half.Z
	)
	
	return part.Position + Vector3.new(offset.X, offset.Y, offset.Z)
end

-- spawn initial fireflies (implement parameter adjuster with gui)
for _ = 1, 75 do
	manager:spawn(getRandomSpawnPosition(habitat))
end

-- update all fireflies every frame
RunService.Heartbeat:Connect(function(dt)
	manager:updateAll(dt)
end)