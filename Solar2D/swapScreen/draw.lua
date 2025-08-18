-----------------------------------------------------------------------------------------
--
-- draw.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

composer.removeScene("selectDraw", true)
function scene:create(event)
    local sceneGroup = self.view

    -- Références globales dans la scène
    self.puzzleText = nil
    self.titleText = nil
    self.difficultyText = nil

    self.gridRects = {}    -- tableau pour stocker les rectangles de la grille vierge
    self.carreList = {}    -- tableau pour stocker les carrés de couleur

    -- Puzzle Play
    local letPuzzle = composer.getVariable("selectedPuzzle")
    local drawPixel = nil

    local selectedPage = composer.getVariable("selectedPage") or 1
    local selectMAP = require("data.drawMap" .. selectedPage)
    local colorMap = require("data.colorMap")
    local compass = require("module.compass")

    -- Variable Map et Data
    local map = selectMAP[letPuzzle]
    local grid = map.grid

    -- Taille des cellules miniatures
    local cellMiniSize = map.data.miniSize  
    local cellLargeur = map.data.Largeur
    local cellHauteur = map.data.Hauteur

    -- Initialisation des variables
    scene.miniRects = {}

    -- Affichage puzzle à reproduire
    local offsetX = 15
    local offsetY = 20

    -- Grille vierge
    local gridBlank = {}

    -- Cellule de la grille vierge
    local indexCell = nil

    -- Affiche la quantité de couleur disponible
    local textColorNb = {}

    -- Message de victoire
    local function showFinitoMessage()
        local finitoText = display.newText({
            text = "FINITO",
            x = display.contentCenterX,
            y = display.contentHeight - 30, -- 30 pixels depuis le bas
            font = native.systemFontBold,
            fontSize = 28
        })
        finitoText:setFillColor(0, 1, 0)  -- Vert
    end

    local function countGridDifferences(grid1, grid2)
        local value = 0

        for y = 1, #grid1 do
            for x = 1, #grid1[y] do
                if grid1[y][x] ~= grid2[y][x] then
                    value = value + 1
                end
            end
        end

        return value
    end

    -- Initialisation des variables
    scene.miniRects = {}

    -- Affichage puzzle à reprodruire
    for y = 1, #grid do
        for x = 1, #grid[y] do
            local value = grid[y][x]
            local valueC = value
            local color = colorMap[valueC] or {1, 1, 1}

            -- Case principale
            local rect = display.newRect(offsetX + (x - 1) * cellMiniSize, offsetY + (y - 1) * cellMiniSize, cellMiniSize, cellMiniSize)
            rect:setFillColor(unpack(color))
            rect.anchorX = 0
            rect.anchorY = 0
            sceneGroup:insert(rect)
            table.insert(scene.miniRects, rect) -- ✅ Stocke pour suppression

            -- Si c’est 99 (gris), ajouter un petit carré blanc au centre
            if valueC == 99 then
                local whiteSize = cellMiniSize * 0.3  -- Taille du petit carré blanc
                local centerX = offsetX + (x - 1) * cellMiniSize + cellMiniSize / 2
                local centerY = offsetY + (y - 1) * cellMiniSize + cellMiniSize / 2
                local whiteSquare = display.newRect(centerX, centerY, whiteSize, whiteSize)
                whiteSquare:setFillColor(1, 1, 1)
                sceneGroup:insert(whiteSquare)
                table.insert(scene.miniRects, whiteSquare) -- ✅ Aussi stocké
            end
        end
    end

    -- Infos puzzle
    local infoY = offsetY + (#grid * cellMiniSize) + 20

    local puzzleText = display.newText({
        text = "Puzzle #" .. map.num,
        x = offsetX + 5, y = infoY,
        font = native.systemFontBold, fontSize = 18
    })
    puzzleText.anchorX = 0

    local titleText = display.newText({
        text = "Name: " .. map.data.name,
        x = offsetX + 5, y = infoY + 25,
        font = native.systemFont, fontSize = 16
    })
    titleText.anchorX = 0

    local difficultyText = display.newText({
        text = "Difficulty: " .. map.data.difficulty,
        x = offsetX + 5, y = infoY + 45,
        font = native.systemFont, fontSize = 16
    })
    difficultyText.anchorX = 0

    -- Créer une grille vierge mini-grille modèle à réproduire
    local cellSize = map.data.cellSize  -- Taille de chaque case
    local gridOffsetX = map.data.posX   -- Décalage à gauche
    local gridOffsetY = map.data.posY   -- Décalage en haut

    local rows = map.data.Hauteur
    local cols = map.data.Largeur

    local function printGrid()
        -- print("Contenu de gridBlank :")
        for i = 1, #gridBlank do
            local row = {}
            for j = 1, #gridBlank[i] do
                table.insert(row, gridBlank[i][j])
            end
            -- print(table.concat(row, "\t"))
        end
    end

    -- Position de départ des carré 
    local startX = 930
    local startY = 30
    local spacing = 10

    local arrowList = {}
    local carreList = {} -- 📌 Liste des carrés
    local firstArrow
    currentIndex = 1 -- ✅ Bien initialisé

    -- ## Nombre de pixel contenu par le puzzle ##
    local pixCountTotal = 0

    for y = 1, #grid do
        for x = 1, #grid[y] do
            if grid[y][x] ~= 99 then
                pixCountTotal = pixCountTotal + 1
            end
        end
    end

    -- Ligne Rambow X (lignes verticales)
    for i = 1, cellHauteur do
        compass.randowX(5, cellMiniSize - 2, cellMiniSize)
    end

    -- Ligne Rambow Y (lignes horizontales)
    for i = 1, cellLargeur do
        compass.randowY(10, cellMiniSize - 2, cellMiniSize)
    end

    local pixCountText = display.newText({
        text = pixCountTotal,
        x = display.contentWidth - 30,
        y = map.data.totalY, -- Ajustement en dessous du derniers carré de couleur
        font = native.systemFont,
        fontSize = 30,
        align = "right"
    })
    pixCountText.anchorX = 1  -- Alignement à droite
    pixCountText:setFillColor(1, 1, 1)  -- Couleur blanche

    -- ## Compteur de pixel a poser ##

    local diffCount2 = pixCountTotal

    local diffCountText = display.newText({
        text = tostring(diffCount2),  -- Conversion explicite en texte
        x = display.contentWidth - 80,
        y = map.data.countY,  -- Ajustement en dessous du dernier carré de couleur
        font = native.systemFont,
        fontSize = 30,
        align = "right"
    })
    diffCountText.anchorX = 1  -- Alignement à droite
    diffCountText:setFillColor(1, 1, 1)  -- Couleur blanche

    -- ## Fonction pour ajouter les couleurs ##
    local function onCellTouch(event)
    local rect = event.target
    local phase = event.phase

    if phase == "began" then
        -- Mémoriser le temps de début
        rect.touchStartTime = system.getTimer()

        -- On capture le focus pour bien suivre le touch jusqu’au bout
        display.getCurrentStage():setFocus(rect)
        rect.isFocus = true

    elseif rect.isFocus then
        if phase == "ended" or phase == "cancelled" then
            display.getCurrentStage():setFocus(nil)
            rect.isFocus = false

            local elapsed = system.getTimer() - rect.touchStartTime

            local i, j = rect.i, rect.j

    -- CLIC LONG : Efface toujours
    if elapsed > 300 then
        indexCell = gridBlank[i][j]

        if indexCell ~= 99 then
            for k = 1, #map.data.colors do
                if map.data.colors[k] == indexCell then
                    map.data.colorsNb[k] = map.data.colorsNb[k] + 1
                    if textColorNb[k] then
                        textColorNb[k].text = "x " .. map.data.colorsNb[k]
                    end
                    break
                end
            end

            gridBlank[i][j] = 99
            rect:setFillColor(unpack(colorMap[99]))

            if not rect.marker then
                local x, y = rect.x, rect.y
                local marker = display.newRect(x, y, 3, 3)
                marker:setFillColor(1, 1, 1)
                rect.marker = marker
            end
        else
            print("⏩ Cellule déjà vide (99), aucune action")
        end

    else
        -- CLIC COURT
        if deletePix then
            -- Mode suppression par clic court
            indexCell = gridBlank[i][j]

            if indexCell ~= 99 then
                for k = 1, #map.data.colors do
                    if map.data.colors[k] == indexCell then
                        map.data.colorsNb[k] = map.data.colorsNb[k] + 1
                        if textColorNb[k] then
                            textColorNb[k].text = "x " .. map.data.colorsNb[k]
                        end
                        break
                    end
                end

                gridBlank[i][j] = 99
                rect:setFillColor(unpack(colorMap[99]))

                if not rect.marker then
                    local x, y = rect.x, rect.y
                    local marker = display.newRect(x, y, 3, 3)
                    marker:setFillColor(1, 1, 1)
                    rect.marker = marker
                end
            else
                print("⏩ Cellule déjà vide.")
            end
        else
            -- Mode peinture normal
            local newColor = drawPixel
            indexCell = gridBlank[i][j]

            -- Si on essaie de poser la même couleur, ne rien faire
            if gridBlank[i][j] == newColor then
                print("⏩ Cellule [" .. i .. "," .. j .. "] déjà colorée avec " .. tostring(newColor) .. ", aucune action")
                return true
            end

            -- Vérifier si on peut placer la couleur (stock > 0)
            local canPlace = false
            local colorIndex = nil

            for k = 1, #map.data.colors do
                if map.data.colors[k] == newColor then
                    colorIndex = k
                    if map.data.colorsNb[k] > 0 then
                        canPlace = true
                    end
                    break
                end
            end

            if not canPlace then
                print("⛔ Impossible de placer la couleur " .. tostring(newColor) .. " : stock vide.")
                return true
            end

            -- Ici on est sûr de pouvoir placer la couleur, donc on remet en stock la couleur précédente si ce n'est pas 99
            if indexCell ~= 99 then
                for k = 1, #map.data.colors do
                    if map.data.colors[k] == indexCell then
                        map.data.colorsNb[k] = map.data.colorsNb[k] + 1
                        if textColorNb[k] then
                            textColorNb[k].text = "x " .. map.data.colorsNb[k]
                        end
                        break
                    end
                end
            end

            -- Poser la nouvelle couleur
            gridBlank[i][j] = newColor
            rect:setFillColor(unpack(colorMap[newColor]))

            -- Retirer le marqueur si existant
            if rect.marker then
                rect.marker:removeSelf()
                rect.marker = nil
            end

            -- Décrémenter le stock de la couleur posée
            map.data.colorsNb[colorIndex] = map.data.colorsNb[colorIndex] - 1
            if textColorNb[colorIndex] then
                textColorNb[colorIndex].text = "x " .. map.data.colorsNb[colorIndex]
            end
        end
    end

    -- Recalculer diffCount après modification (dans tous les cas)
    diffCount2 = countGridDifferences(grid, gridBlank)
    diffCountText.text = tostring(diffCount2)

    if diffCount2 == 0 then
        showFinitoMessage()
    end

            end
        end

        return true
    end

    -- Créer une grille vierge interactive 
    for i = 1, rows do
        self.gridRects[i] = {}
        gridBlank[i] = {}  -- Important pour initialiser gridBlank aussi !
        for j = 1, cols do
            local x = gridOffsetX + (j - 1) * cellSize
            local y = gridOffsetY + (i - 1) * cellSize
            local color = colorMap[99]  -- initialisation vide

            local rect = display.newRect(x, y, cellSize, cellSize)
            rect:setFillColor(unpack(color))
            rect.i = i
            rect.j = j
            sceneGroup:insert(rect)
            table.insert(self.gridRects[i], rect)

            gridBlank[i][j] = 99  -- Initialiser avec gris (valeur vide)

            -- marker
            local marker = display.newRect(x, y, 3, 3)
            marker:setFillColor(1, 1, 1)
            rect.marker = marker
            sceneGroup:insert(marker)

            rect:addEventListener("touch", onCellTouch)
        end
    end    

    -- Ligne Rambow X (lignes verticales)
    for i = 1, cellHauteur do
        compass.randowX(gridOffsetX, cellSize - 2, cellSize)
    end

    -- Ligne Rambow Y (lignes horizontales)
    for i = 1, cellLargeur do
        compass.randowY(gridOffsetY, cellSize - 2, cellSize)
    end

    -- Sélectionner une couleur 
    for i = 1, #map.data.colors do
        local colorName = map.data.colors[i]
        local colorNb = map.data.colorsNb[i]

        local carre = display.newRect(startX, startY, cellSize, cellSize)
        carre:setFillColor(unpack(colorMap[colorName]))
        carre.colorValue = colorName
        carre.index = i
        sceneGroup:insert(carre)
        table.insert(self.carreList, carre)

        local arrow = display.newPolygon(startX - 30, startY, { 0, -10, 0, 10, 15, 0})
        arrow:setFillColor(1, 1, 1)
        arrow.isVisible = false
        sceneGroup:insert(arrow)
        table.insert(arrowList, arrow)

        if i == 1 then
            firstArrow = arrow
            drawPixel = colorName
        end

        carre:addEventListener("tap", function(event)
            drawPixel = event.target.colorValue
            currentIndex = event.target.index -- ✅ Met à jour currentIndex correctement
            -- deleteButton.updateDeleteMode(false)  -- ✅ Désactive le mode suppression

            -- Masquer toutes les flèches
            for _, a in ipairs(arrowList) do
                a.isVisible = false
            end

            -- Afficher la flèche sur le bon carré
            arrowList[currentIndex].isVisible = true

            return true
        end)

        textColorNb[i] = display.newText({
            text = "x " .. colorNb,
            x = startX + cellSize + 15,
            y = startY - 8,
            font = native.systemFont,
            fontSize = 18
        })
        textColorNb[i].anchorY = 0
        textColorNb[i]:setFillColor(1, 1, 1)


        startY = startY + cellSize + spacing
    end

    -- Afficher la première flèche
    if firstArrow then
        firstArrow.isVisible = true
    end

    native.setProperty("mouseCursorVisible", true)

    -- ## 🖱️ Molette souris : changer currentIndex et mettre à jour flèche + drawPixel ##
    local function onMouseEvent(event)
        if event.scrollY and event.scrollY ~= 0 then
            if event.scrollY >= 0 then
                currentIndex = currentIndex + 1
            elseif event.scrollY <= 0 then
                currentIndex = currentIndex - 1
            end

            -- Clamping pour rester dans les bornes valides
            if currentIndex < 1 then 
                currentIndex = #map.data.colors  
            end
            if currentIndex > #map.data.colors then 
                currentIndex = 1
            end

            drawPixel = map.data.colors[currentIndex]
            deleteButton.updateDeleteMode(false)

            -- Cacher toutes les flèches
            for _, a in ipairs(arrowList) do
                a.isVisible = false
            end

            -- Afficher la flèche sur le bon élément
            arrowList[currentIndex].isVisible = true
        end
        return false
    end

    -- Activer l’écouteur molette
    Runtime:addEventListener("mouse", onMouseEvent)

    -- DevMod Fin de puzzle
    local finishUp = require("module.finishBouton")
    local finishButton = finishUp(function()
        diffCount2 = 0
        diffCountText.text = tostring(diffCount2)
        showFinitoMessage()
        compass.resetCounters()
    end)
    scene.finishButton = finishButton
    sceneGroup:insert(finishButton)

    local finishButtonText = display.newText({
        text = "Fin",  -- Conversion explicite en texte
        x = 80,
        y = display.contentHeight - 70,  -- Ajustement en dessous du dernier carré de couleur
        font = native.systemFont,
        fontSize = 30,
        align = "right"
    })

    -- DevMod Soluce
    local soluceUp = require("module.soluceBouton")
    local soluceButton = soluceUp(grid, gridBlank, gridOffsetX, gridOffsetY, cellSize, 5)
    scene.soluceButton = soluceButton

    local soluceButtonText = display.newText({
        text = "Soluce",  -- Conversion explicite en texte
        x = 100,
        y = display.contentHeight - 110,  -- Ajustement en dessous du dernier carré de couleur
        font = native.systemFont,
        fontSize = 30,
        align = "right"
    })

    -- Revenir au sélection de dessin
    local function onAbortDraw()
        -- Supprimer les infos du puzzle (texte à gauche)
        local textElements = {
            scene.puzzleText,
            scene.titleText,
            scene.difficultyText,
            scene.finishButtonText,
            scene.soluceButtonText,
            scene.retourButtonText
        }

        for _, txt in ipairs(textElements) do
            if txt then
                txt:removeSelf()
            end
        end

        -- Supprimer la mini carte (en haut à gauche)
        if scene.miniRects then
            for _, rect in ipairs(scene.miniRects) do
                rect:removeSelf()
            end
            scene.miniRects = nil
        end

        -- Supprimer la grille vierge
        if scene.gridRects then
            for i, row in ipairs(scene.gridRects) do
                for _, rect in ipairs(row) do
                    if rect.marker then
                        rect.marker:removeSelf()
                        rect.marker = nil
                    end
                    rect:removeSelf()
                end
            end
            scene.gridRects = nil
        end

        -- Supprimer les carrés de couleur (à droite)
        if scene.carreList then
            for _, carre in ipairs(scene.carreList) do
                carre:removeSelf()
            end
            scene.carreList = nil
        end

        -- Supprimer les flèches blanches de sélection
        if scene.arrowList then
            for _, arrow in ipairs(scene.arrowList) do
                arrow:removeSelf()
            end
            scene.arrowList = nil
        end

        -- Supprimer les textes de quantité de couleurs
        if scene.textColorNb then
            for _, txt in ipairs(scene.textColorNb) do
                txt:removeSelf()
            end
            scene.textColorNb = nil
        end

        -- Supprimer les boutons ronds
        if scene.retourButton then
            scene.retourButton:removeSelf()
            scene.retourButton = nil
        end
        if scene.finishButton then
            scene.finishButton:removeSelf()
            scene.finishButton = nil
        end
        if scene.soluceButton then
            scene.soluceButton:removeSelf()
            scene.soluceButton = nil
        end
        if scene.deleteButton then
            local deleteButton = require("module.deleteButton")
            deleteButton.cancelBlinkTimer() -- ✅ Ajout important ici
            scene.deleteButton:removeSelf()
            scene.deleteButton = nil
        end
        if scene.deleteButtonText then
            scene.deleteButtonText:removeSelf()
            scene.deleteButtonText = nil
        end

        -- Supprimer les compteurs
        if scene.diffCountText then
            scene.diffCountText:removeSelf()
            scene.diffCountText = nil
        end

        if scene.pixCountText then
            scene.pixCountText:removeSelf()
            scene.pixCountText = nil
        end

        compass.resetCounters()

        -- Navigation retour vers l'écran de sélection
        composer.gotoScene("swapScreen.selectDraw", {time = 500, effect = "fade"})

        -- Nettoyer la scène actuelle
        composer.removeScene("swapScreen.draw")
    end    

    -- Importation du module deleteButton.lua    
    package.loaded["module.deleteButton"] = nil
    local deleteButton = require("module.deleteButton")
    deleteButton.init({
        map = map,
        arrowList = arrowList,
        currentIndex = currentIndex
    })
    sceneGroup:insert(deleteButton.yellowButton)
    sceneGroup:insert(deleteButton.yellowButtonText)
    scene.deleteButton = deleteButton.yellowButton
    scene.deleteButtonText = deleteButton.yellowButtonText

    -- Importation du module backBoutton.lua
    local createBackButton = require("module.backBoutton")
    local retourButton, retourButtonText = createBackButton(onAbortDraw)
    sceneGroup:insert(retourButton)
    sceneGroup:insert(retourButtonText)
    scene.retourButton = retourButton
    scene.retourButtonText = retourButtonText

    scene.puzzleText = puzzleText
    scene.titleText = titleText
    scene.difficultyText = difficultyText
    scene.miniRects = {}  -- lors de la création de la miniMap
    scene.arrowList = arrowList
    scene.carreList = self.carreList
    scene.textColorNb = textColorNb
    scene.diffCountText = diffCountText
    scene.pixCountText = pixCountText
    scene.finishButtonText = finishButtonText
    scene.soluceButtonText = soluceButtonText
    scene.retourButtonText = buttonText  -- bouton "Retour"

    end

    scene:addEventListener("create", scene)

    function scene:destroy(event)
        local sceneGroup = self.view

        -- Nettoyage : retirer les écouteurs Runtime ou objets créés manuellement
        Runtime:removeEventListener("mouse", onMouseEvent)

        print("✅ Scène draw.lua détruite proprement.")
    end

    scene:addEventListener("destroy", scene)
return scene