-- Title.lua
local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Image de fond responsive
    local background = display.newImageRect(sceneGroup, "img/background.png", display.actualContentWidth, display.actualContentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Texte clignotant
    local button = display.newText(sceneGroup, "Push Here for start", display.contentCenterX, display.contentHeight * 0.75, native.systemFont, 32)
    button.isHitTestable = true

    -- Fonction pour faire clignoter le texte
    local function blink()
        transition.to(button, {
            time = 700,
            alpha = 0,
            onComplete = function()
                transition.to(button, {
                    time = 1400,
                    alpha = 1,
                    onComplete = blink
                })
            end
        })
    end

    blink()

    button:addEventListener("tap", function()
        composer.gotoScene("swapScreen.selectDraw", {effect="fade", time=500})
    end)
end

scene:addEventListener("create", scene)

return scene
