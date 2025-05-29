-- finishBouton.lua

local function createFinishButton(onFinish)
    -- Création du bouton rond vert, en bas à gauche
    local button = display.newCircle(30, display.contentHeight - 70, 12.5)
    button:setFillColor(0, 1, 0)

    local function onTap()
        if onFinish then
            onFinish()
        end
    end

    button:addEventListener("tap", onTap)
end

return createFinishButton
