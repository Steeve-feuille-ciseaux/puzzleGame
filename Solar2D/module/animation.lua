-- module/animation.lua

local M = {}

-- 🎆 Explosion feu d'artifice (animation)
function M.fireWork(x, y, color, parentGroup)
    local particleCount = 12  -- Nombre de particules
    for i = 1, particleCount do
        local particle = display.newCircle(x, y, 10)
        particle:setFillColor(unpack(color))
        
        if parentGroup and parentGroup.insert then
            parentGroup:insert(particle)
        end

        local angle = math.random() * 2 * math.pi
        local distance = math.random(40, 80)
        local dx = math.cos(angle) * distance
        local dy = math.sin(angle) * distance

        transition.to(particle, {
            time = 400,
            x = x + dx,
            y = y + dy,
            alpha = 0,
            xScale = 0.2,
            yScale = 0.2,
            onComplete = function()
                particle:removeSelf()
            end
        })
    end
end

return M
