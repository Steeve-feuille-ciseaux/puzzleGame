-- scene1.lua
local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local button = display.newText(sceneGroup, "Push Here for start", display.contentCenterX, display.contentHeight * 0.75, native.systemFont, 32)
    
    -- Permet d’interagir même quand alpha = 0
    button.isHitTestable = true

    -- Fonction pour faire clignoter le texte en boucle
    local function blink()
        transition.to(button, {
            time = 700,
            alpha = 0,
            onComplete = function()
                transition.to(button, {
                    time = 1400,
                    alpha = 1,
                    onComplete = blink  -- Relancer la boucle
                })
            end
        })
    end

    blink()  -- Lancer le clignotement

    button:addEventListener("tap", function()
        composer.gotoScene("swapScreen.scene2", {effect="fade", time=500})
    end)
end

scene:addEventListener("create", scene)

return scene
