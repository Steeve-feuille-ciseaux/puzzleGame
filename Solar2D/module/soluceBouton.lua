-----------------------------------------------------------------------------------------
--
-- soluceBouton.lua
--
-----------------------------------------------------------------------------------------

local M = {}

-- HSV → RGB conversion
local function hsvToRgb(h, s, v)
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r, g, b
end

function M(grid, gridBlank, gridOffsetX, gridOffsetY, cellSize, duration)
    local button = display.newCircle(30, display.contentHeight - 110, 12.5)
    button:setFillColor(1, 0, 0)

    local isActive = true
    local outlines = {}
    local hue = 0
    local rainbowTimer = nil

    button:addEventListener("tap", function()
        -- Nettoyer avant de redémarrer
        if rainbowTimer then
            timer.cancel(rainbowTimer)
        end

        isActive = true
        hue = 0
        outlines = {}

        -- Créer les cadres autour des erreurs
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
                end
            end
        end

        -- Démarre l’effet arc-en-ciel fluide
        rainbowTimer = timer.performWithDelay(100, function()
            if not isActive then return end

            hue = (hue + 0.05) % 1
            local r, g, b = hsvToRgb(hue, 1, 1)

            for _, outline in ipairs(outlines) do
                if outline and outline.setStrokeColor then
                    outline:setStrokeColor(r, g, b)
                end
            end

            if button and button.setFillColor then
                button:setFillColor(r, g, b)
            end
        end, 0)

        -- Arrêter et nettoyer après `duration` secondes
        timer.performWithDelay(duration * 1000, function()
            isActive = false

            if rainbowTimer then
                timer.cancel(rainbowTimer)
            end

            for _, outline in ipairs(outlines) do
                if outline and outline.removeSelf then
                    outline:removeSelf()
                end
            end
            outlines = {}

            -- -- Supprimer le bouton (si tu veux le conserver, laisse ce bloc commenté)
            -- if button and button.removeSelf then
            --     button:removeSelf()
            -- end
        end)
    end)
    return button
end

return M
