local FireflyAgent = {}
FireflyAgent.__index = FireflyAgent

-- emit all particle emitters under an object
local function emitParticles(container)
	for _, obj in ipairs(container:GetDescendants()) do
		if obj:IsA("ParticleEmitter") then
			obj:Emit(obj:GetAttribute("EmitCount") or 1)
		end
	end
end

function FireflyAgent.new(model)
	local self = setmetatable({}, FireflyAgent)

	self.model = model
	self.position = model.PrimaryPart.Position

	-- initial random direction
	self.direction = Vector3.new(math.random() - 0.5, (math.random() - 0.5) * 0.2, math.random() - 0.5).Unit

	self.speed = math.random(25, 35)
	self.blinkCooldown = 0

	-- controls how often direction changes
	self.directionChangeCooldown = math.random(3, 5)

	return self
end

function FireflyAgent:Glow(emit)	
	if emit then
		emitParticles(self.model.PrimaryPart)
	end
end

function FireflyAgent:update(dt)	
	-- blink/glow mechanic
	self.blinkCooldown -= dt
	if self.blinkCooldown <= 0 then
		self:Glow(true)
		self.blinkCooldown = math.random(3, 7)
	end
	
	-- direction change mechanic
	self.directionChangeCooldown -= dt
	if self.directionChangeCooldown <= 0 then
		self.direction = Vector3.new(math.random() - 0.5, (math.random() - 0.5) * 0.2, math.random() - 0.5).Unit
		self.directionChangeCooldown = math.random(3, 5)
	end

	-- smooth movement and rotation
	local currentPos = self.model.PrimaryPart.Position
	local moveVec = self.direction * self.speed * dt
	local newPos = currentPos + moveVec

	-- compute smooth cframe to face direction
	if moveVec.Magnitude > 0.001 then
		local targetCFrame = CFrame.lookAt(currentPos, newPos)
		local currentCFrame = self.model:GetPivot()
		local lerpedCFrame = currentCFrame:Lerp(targetCFrame + moveVec, 0.1)
		
		self.model:PivotTo(lerpedCFrame)
	end

	self.position = newPos
end

return FireflyAgent