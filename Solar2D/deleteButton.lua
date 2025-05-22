local N = {}

local group = display.newGroup()
local customCursorImage

local function onMouseMove(event)
    local x, y = event.x, event.y
    group.x, group.y = x, y
end

-- Désactive le curseur natif en le cachant
function N.setCustomCursor(imagePath, width, height)
    -- Nettoyer le curseur précédent si déjà existant
    if customCursorImage then
        customCursorImage:removeSelf()
        customCursorImage = nil
    end

    -- Ajouter l’image personnalisée comme curseur
    customCursorImage = display.newImageRect(group, imagePath, width or 32, height or 32)
    
    -- 🔽 Ancrage en bas à gauche
    customCursorImage.anchorX = 0
    customCursorImage.anchorY = 1
    
    -- Position de départ
    customCursorImage.x, customCursorImage.y = 0, 0

    -- Masquer le curseur natif
    native.setProperty("mouseCursorVisible", false)

    -- Ajouter l'écouteur pour déplacer le curseur personnalisé avec la souris
    Runtime:addEventListener("mouse", onMouseMove)
end

-- Pour supprimer le curseur personnalisé
function N.removeCustomCursor()
    if customCursorImage then
        customCursorImage:removeSelf()
        customCursorImage = nil
    end
    -- Rendre visible le curseur natif
    native.setProperty("mouseCursorVisible", true)
    -- Enlever l'écouteur de mouvement
    Runtime:removeEventListener("mouse", onMouseMove)
end

return N
