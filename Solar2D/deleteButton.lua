local N = {}

local group = display.newGroup()
local customCursorImage

local function onMouseMove(event)
    local x, y = event.x, event.y
    group.x, group.y = x, y
end

-- Désactive le curseur natif en le cachant
function N.setCursorToCross()
    -- Cacher le curseur natif (enlever les deux méthodes)
    native.setProperty("mouseCursor", "none")
    native.setProperty("mouseCursorVisible", false)
    
    -- Assurer que le curseur personnalisé est bien actif
    if not customCursorImage then
        -- Optionnel : Ajouter le curseur personnalisé ici si ce n'est pas déjà fait
        N.setCustomCursor("images/crossRed.png", 32, 32)
    end
end

function N.setCustomCursor(imagePath, width, height)
    -- Nettoyer le curseur précédent si déjà existant
    if customCursorImage then
        customCursorImage:removeSelf()
        customCursorImage = nil
    end

    -- Ajouter l'image personnalisée comme curseur
    customCursorImage = display.newImageRect(group, imagePath, width or 32, height or 32)
    customCursorImage.x, customCursorImage.y = 0, 0

    -- Masquer le curseur natif (on cache le curseur natif ici)
    native.setProperty("mouseCursorVisible", false)

    -- Assurer que l'événement de mouvement de la souris est bien géré
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
