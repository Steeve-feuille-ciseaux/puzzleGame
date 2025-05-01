-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Puzzle Play
local letPuzzle = 1
local drawPixel = nil

-- Tableau des Puzzle
local selectMAP = require("selectMAP") -- selectMAP.lua

-- Tableau des couleurs (valeur -> couleur)
local colorMap = require("colorMap") -- colorMap.lua

-- Variable Map et Data
local map = selectMAP[letPuzzle]
local grid = map.grid

-- Affichage puzzle à reprodruire
local cellMiniSize = map.data.miniSize  -- Taille de chaque case
local offsetX = 10    -- Décalage à gauche
local offsetY = 20    -- Décalage en haut

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

		-- Si c’est 99 (gris), ajouter un petit carré blanc au centre
		if valueC == 99 then
			local whiteSize = cellMiniSize * 0.3  -- Taille du petit carré blanc
			local centerX = offsetX + (x - 1) * cellMiniSize + cellMiniSize / 2
			local centerY = offsetY + (y - 1) * cellMiniSize + cellMiniSize / 2
			local whiteSquare = display.newRect(centerX, centerY, whiteSize, whiteSize)
			whiteSquare:setFillColor(1, 1, 1)
		end
	end
end

-- Affichage des infos du puzzle actuel
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

-- Créer une grille vierge
local cellSize = map.data.cellSize  -- Taille de chaque case
local gridOffsetX = map.data.posX   -- Décalage à gauche
local gridOffsetY = map.data.posY   -- Décalage en haut

local rows = map.data.Hauteur
local cols = map.data.Largeur

local gridBlank = {}

-- Fonction pour ajouter les couleurs
local function onCellTap(event)
    local rect = event.target
    local i, j = rect.i, rect.j

    -- Modifier la valeur de la 
	newColor = drawPixel
    gridBlank[i][j] = newColor

    -- Mettre à jour la couleur
    rect:setFillColor(unpack(colorMap[newColor]))

    -- Supprimer le petit carré blanc si présent
    if rect.marker then
        rect.marker:removeSelf()
        rect.marker = nil
    end

    return true
end

-- Créer une grille vierge
for i = 1, rows do
    gridBlank[i] = {}
    for j = 1, cols do
        gridBlank[i][j] = 99
        local x = gridOffsetX + (j - 1) * cellSize
        local y = gridOffsetY + (i - 1) * cellSize
        local color = colorMap[99]

        local rect = display.newRect(x, y, cellSize, cellSize)
        rect:setFillColor(unpack(color))
        rect.i = i
        rect.j = j

        -- Ajouter le listener global
        rect:addEventListener("tap", onCellTap)

        -- Ajouter un petit carré blanc si valeur est 99
		local marker = display.newRect(x, y, 3, 3)
		marker:setFillColor(1, 1, 1)
		rect.marker = marker -- Attacher à la cellule pour suppression future
    end
end

-- Position de départ
local startX = 930
local startY = 30
local spacing = 10

local arrowList = {}
local carreList = {} -- 📌 Liste des carrés
local firstArrow
local currentIndex = 1 -- ✅ Bien initialisé

-- Créer les carrés
for i = 1, #map.data.colors do
    local colorName = map.data.colors[i]

    local carre = display.newRect(startX, startY, cellSize, cellSize)
    carre:setFillColor(unpack(colorMap[colorName]))
    carre.colorValue = colorName
    carre.index = i -- 📌 Stocker l'index

    table.insert(carreList, carre)

    local arrow = display.newPolygon(startX - 30, startY, { 
        0, -10,
        0, 10,
        15, 0
    })
    arrow:setFillColor(1, 1, 1)
    arrow.isVisible = false
    table.insert(arrowList, arrow)

    if i == 1 then
        firstArrow = arrow
        drawPixel = colorName
    end

    carre:addEventListener("tap", function(event)
        drawPixel = event.target.colorValue
        currentIndex = event.target.index -- ✅ Met à jour currentIndex correctement

        -- Masquer toutes les flèches
        for _, a in ipairs(arrowList) do
            a.isVisible = false
        end

        -- Afficher la flèche sur le bon carré
        arrowList[currentIndex].isVisible = true

        return true
    end)

    local text = display.newText({
        text = "x ???",
        x = startX + cellSize + 15,
        y = startY - 10,
        font = native.systemFont,
        fontSize = 16
    })
    text.anchorY = 0
    text:setFillColor(1, 1, 1)

    startY = startY + cellSize + spacing
end

-- Afficher la première flèche
if firstArrow then
    firstArrow.isVisible = true
end

native.setProperty("mouseCursorVisible", true)

-- 🖱️ Molette souris : changer currentIndex et mettre à jour flèche + drawPixel
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
