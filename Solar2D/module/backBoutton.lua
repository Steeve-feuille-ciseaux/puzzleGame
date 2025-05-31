-- backBoutton.lua

local function createBackButton(onBack)
    -- Création du bouton rond bleu, en bas à droite
    local button = display.newCircle(30, display.contentHeight - 30, 12.5)
    button:setFillColor(0, 0, 1)  -- Bleu

    -- Création du texte "Retour" à droite du bouton
    local buttonText = display.newText({
        text = "Retour",
        x = 100,
        y = display.contentHeight - 30,
        font = native.systemFont,
        fontSize = 30,
    })
    buttonText:setFillColor(1, 1, 1)  -- Texte en blanc

    -- Fonction de gestion du clic
    local function onTap()
        if onBack then
            onBack()
        end
    end

    -- Ajouter un listener pour le clic sur le bouton
    button:addEventListener("tap", onTap)
end

return createBackButton