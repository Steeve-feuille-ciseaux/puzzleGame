local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    local pageCurrent = 1
    local pageMax = 5 -- 🟢 Modifie selon le nombre réel de pages

    local squareSize = 230
    local spacing = 20
    local numRows = 2
    local numCols = 3
    local ajustY = 50

    -- 📝 Titre principal
    local title = display.newText({
        parent = sceneGroup,
        text = "Sélectionnez un dessin",
        x = display.contentCenterX,
        y = 80,
        font = native.systemFontBold,
        fontSize = 36
    })
    title:setFillColor(0.5, 0.5, 0.5)

    -- 📝 Affichage dynamique de la page
    local pageIndicator = display.newText({
        parent = sceneGroup,
        text = pageCurrent .. " / " .. pageMax,
        x = display.contentCenterX,
        y = display.contentHeight * 0.92,
        font = native.systemFontBold,
        fontSize = 36
    })
    pageIndicator:setFillColor(0.5, 0.5, 0.5)

    -- 🔄 Calcul pour centrer la grille
    local gridWidth = numCols * squareSize + (numCols - 1) * spacing
    local gridHeight = numRows * squareSize + (numRows - 1) * spacing
    local startX = (display.actualContentWidth - gridWidth) / 2
    local startY = (display.actualContentHeight - gridHeight + ajustY) / 2

    -- 🧱 Création de la grille
    local function drawGrid()
        for row = 0, numRows - 1 do
            for col = 0, numCols - 1 do
                local x = startX + col * (squareSize + spacing) + squareSize / 2
                local y = startY + row * (squareSize + spacing) + squareSize / 2

                local square = display.newRect(sceneGroup, x, y, squareSize, squareSize)
                square:setFillColor(0.2, 0.6, 1)
                square:setStrokeColor(1)

                square:addEventListener("tap", function()
                    composer.gotoScene("swapScreen.Title", { effect = "crossFade", time = 500 })
                end)
            end
        end
    end

    drawGrid()

    -- 🔺 Création des flèches (triangles)
    local size = 40
    local ajustArrowY = 20 
    local ajustArrowX = 60 

    local function createArrow(points, x, y, fill, stroke, onTap)
        local arrow = display.newPolygon(sceneGroup, x, y + ajustArrowY, points)
        arrow:setFillColor(unpack(fill))
        arrow.strokeWidth = 2
        arrow:setStrokeColor(unpack(stroke))

        -- Animation + appel de la logique
        local function tapped()
            -- Sauvegarde de la couleur actuelle
            local originalFill = { unpack(fill) }

            -- Flash orange
            arrow:setFillColor(1, 0.5, 0)

            timer.performWithDelay(150, function()
                arrow:setFillColor(unpack(originalFill))
            end)

            onTap()
        end

        arrow:addEventListener("tap", tapped)
        return arrow
    end

    local leftArrow, rightArrow -- rendre visibles globalement pour pouvoir les modifier

    local function updatePageDisplay()
        pageIndicator.text = pageCurrent .. " / " .. pageMax

        -- Gère la visibilité des flèches
        if pageCurrent <= 1 then
            leftArrow.isVisible = false
            leftArrow.isHitTestable = false
        else
            leftArrow.isVisible = true
            leftArrow.isHitTestable = true
        end

        if pageCurrent >= pageMax then
            rightArrow.isVisible = false
            rightArrow.isHitTestable = false
        else
            rightArrow.isVisible = true
            rightArrow.isHitTestable = true
        end
    end

    -- ➡️ Flèche droite (page suivante)
    local rightArrowPoints = {
        0, -size,
        0, size,
        size, 0
    }

    rightArrow = createArrow(rightArrowPoints,
        display.contentWidth - ajustArrowX, display.contentCenterY,
        {0.6, 0.6, 1}, {0.3, 0.3, 0.6},
        function()
            if pageCurrent < pageMax then
                pageCurrent = pageCurrent + 1
                updatePageDisplay()
                -- 🔁 Redessiner ou changer de page ici si besoin
            end
        end
    )

    -- ⬅️ Flèche gauche (page précédente)
    local leftArrowPoints = {
        0, -size,
        0, size,
        -size, 0
    }

    leftArrow = createArrow(leftArrowPoints,
        ajustArrowX, display.contentCenterY,
        {0.6, 0.6, 1}, {0.3, 0.3, 0.6},
        function()
            if pageCurrent > 1 then
                pageCurrent = pageCurrent - 1
                updatePageDisplay()
                -- 🔁 Redessiner ou changer de page ici si besoin
            end
        end
    )

    -- 🔁 Mise à jour initiale
    updatePageDisplay()

end

scene:addEventListener("create", scene)
return scene
