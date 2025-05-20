local M = {}

function M(grid, gridBlank, gridOffsetX, gridOffsetY, cellSize, duration)
    local button = display.newCircle(30, display.contentHeight - 110, 12.5)

    local isActive = true
    local rainbowTimer
    local outlines = {}  -- stocke les cadres à supprimer

    -- Animation de couleurs du bouton
    local function rainbowEffect()
        if isActive then
            button:setFillColor(math.random(), math.random(), math.random())
        end
    end

    rainbowTimer = timer.performWithDelay(100, rainbowEffect, 0)

    button:addEventListener("tap", function()
        -- Affiche les cadres autour des erreurs
        for i = 1, #grid do
            for j = 1, #grid[i] do
                local correctVal = grid[i][j]
                local userVal = gridBlank[i][j]

                if correctVal ~= 99 and correctVal ~= userVal then
                    local x = gridOffsetX + (j - 1) * cellSize - (cellSize / 2)
                    local y = gridOffsetY + (i - 1) * cellSize - (cellSize / 2)

                    local outline = display.newRect(x, y, cellSize, cellSize)
                    outline.anchorX = 0
                    outline.anchorY = 0
                    outline:setFillColor(0, 0, 0, 0)
                    outline.strokeWidth = 3
                    outline:setStrokeColor(1, 0, 1)

                    table.insert(outlines, outline)

                    transition.to(outline, {
                        time = 1500,
                        iterations = 0,
                        onRepeat = function()
                            if isActive then
                                outline:setStrokeColor(math.random(), math.random(), math.random())
                            end
                        end
                    })
                end
            end
        end

        -- Après `duration` secondes, arrêter les effets
        timer.performWithDelay(duration * 1000, function()
            isActive = false

            -- Stopper l’animation du bouton
            if rainbowTimer then
                timer.cancel(rainbowTimer)
            end

            -- Supprimer les cadres
            for _, outline in ipairs(outlines) do
                if outline and outline.removeSelf then
                    outline:removeSelf()
                end
            end
            outlines = {}

            --[[ Supprimer le bouton
            if button and button.removeSelf then
                button:removeSelf()
            end
            ]]
        end)
    end)
end

return M