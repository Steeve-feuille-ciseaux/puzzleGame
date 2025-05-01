-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Puzzle Play
local letPuzzle = 1

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
		local valueStr = string.format("%02d", value)
		local color = colorMap[valueStr] or {1, 1, 1}

		-- Case principale
		local rect = display.newRect(offsetX + (x - 1) * cellMiniSize, offsetY + (y - 1) * cellMiniSize, cellMiniSize, cellMiniSize)
		rect:setFillColor(unpack(color))
		rect.anchorX = 0
		rect.anchorY = 0

		-- Si c’est 99 (gris), ajouter un petit carré blanc au centre
		if valueStr == "99" then
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

--- Reprise du code créer une grille vierge 

-- Création grille vierge
local gridBlank = map.grid

-- Affichage puzzle à reproduire
local cellSize = map.data.cellSize  -- Taille de chaque case
local gridOffsetX = map.data.posX   -- Décalage à gauche
local gridOffsetY = map.data.posY   -- Décalage en haut

for y = 1, #gridBlank do
	for x = 1, #gridBlank[y] do
		local value = gridBlank[y][x]
		local valueStr = string.format("%02d", value)
		if not colorMap[valueStr] then valueStr = "99" end
		local color = colorMap[valueStr]

		local rect = display.newRect(gridOffsetX + (x - 1) * cellSize, gridOffsetY + (y - 1) * cellSize, cellSize, cellSize)
		rect:setFillColor(unpack(color))
		rect.anchorX = 0
		rect.anchorY = 0

		-- Ajout coordonnées pour usage dans l'événement
		rect.gridX, rect.gridY = x, y

		-- Ajout du carré blanc si "99"
		if valueStr == "99" then
			local whiteSize = cellSize * 0.2
			local centerX = rect.x + cellSize / 2
			local centerY = rect.y + cellSize / 2
			local whiteSquare = display.newRect(centerX, centerY, whiteSize, whiteSize)
			whiteSquare:setFillColor(1, 1, 1)
			rect.whiteSquare = whiteSquare
		end

		-- Fonction de clic pour changer 99 -> 05
		local function onTap()
			local newValueStr = "05"
			local newColor = colorMap[newValueStr]
			rect:setFillColor(unpack(newColor))
			if rect.whiteSquare then rect.whiteSquare:removeSelf() end
			gridBlank[rect.gridY][rect.gridX] = 5  -- Mettre à jour la grille
		end

		rect:addEventListener("tap", onTap)
	end
end

