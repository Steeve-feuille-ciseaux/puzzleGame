-- finishBouton.lua

local function createFinishButton(onFinish)
    -- Création du bouton rond vert, en bas à gauche
    local radius = 20
    local margin = 20
    local x = margin + radius
    local y = display.contentHeight - margin - radius

    local button = display.newCircle(x, y, radius)
    button:setFillColor(0, 1, 0)

    local function onTap()
        if onFinish then
            onFinish()
        end
    end

    button:addEventListener("tap", onTap)
end

return createFinishButton
