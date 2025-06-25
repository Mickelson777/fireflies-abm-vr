local Lighting = game:GetService("Lighting")

Lighting.ClockTime = 7
Lighting.Brightness = 2.7
Lighting.GlobalShadows = true
Lighting.EnvironmentDiffuseScale = 0.4
Lighting.EnvironmentSpecularScale = 0.3

Lighting.Ambient = Color3.fromRGB(30, 35, 30)
Lighting.OutdoorAmbient = Color3.fromRGB(25, 30, 25)

Lighting.FogColor = Color3.fromRGB(30, 35, 30)
Lighting.FogStart = 80
Lighting.FogEnd = 400

local bloom = Instance.new("BloomEffect")
bloom.Name = "EnchantedBloom"
bloom.Intensity = 1.8
bloom.Threshold = 1.0
bloom.Size = 42
bloom.Parent = Lighting

local cc = Instance.new("ColorCorrectionEffect")
cc.Name = "SwampTone"
cc.Brightness = 0.05
cc.Contrast = 0.1
cc.Saturation = 0.05
cc.TintColor = Color3.fromRGB(180, 220, 180)
cc.Parent = Lighting