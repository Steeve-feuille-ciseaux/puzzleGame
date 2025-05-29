-- scene2.lua
local composer = require("composer")
local scene = composer.newScene()

-- Fonction d'événement pour la scène
function scene:create(event)
    local sceneGroup = self.view

    -- Création d'un bouton pour revenir à la scène 1
    local button = display.newText(sceneGroup, "Back to Scene 1", display.contentCenterX, display.contentCenterY, native.systemFont, 32)
    
    -- Fonction qui change de scène lorsqu'on clique sur le bouton
    button:addEventListener("tap", function()
        composer.gotoScene("swapScreen.Title", { effect = "crossFade", time = 500 })  -- Change vers la scène 1
    end)
end

-- Ajout des fonctions à la scène
scene:addEventListener("create", scene)

return scene
