local M = {}

function M(grid, gridBlank, gridOffsetX, gridOffsetY, cellSize)
    -- Créer le bouton rond arc-en-ciel
    local button = display.newCircle(30, display.contentHeight - 110, 12.5)

    -- Animation de couleurs changeantes sur le bouton
    local function rainbowEffect()
        local r = math.random()
        local g = math.random()
        local b = math.random()
        button:setFillColor(r, g, b)
    end
    timer.performWithDelay(100, rainbowEffect, 0)

    -- Quand on clique sur le bouton
    button:addEventListener("tap", function()
        for i = 1, #grid do
            for j = 1, #grid[i] do
                local correctVal = grid[i][j]
                local userVal = gridBlank[i][j]

                if correctVal ~= 99 and correctVal ~= userVal then
                    -- Corriger la position pour aligner en haut à gauche
                    local x = gridOffsetX + (j - 1) * cellSize - (cellSize / 2)
                    local y = gridOffsetY + (i - 1) * cellSize - (cellSize / 2)

                    local outline = display.newRect(x, y, cellSize, cellSize)
                    outline.anchorX = 0
                    outline.anchorY = 0
                    outline:setFillColor(0, 0, 0, 0)
                    outline.strokeWidth = 3
                    outline:setStrokeColor(1, 0, 1)

                    -- Animation arc-en-ciel
                    transition.to(outline, {
                        time = 1500,
                        iterations = 0,
                        onRepeat = function()
                            outline:setStrokeColor(math.random(), math.random(), math.random())
                        end
                    })
                end

            end
        end
    end)
end

return M
