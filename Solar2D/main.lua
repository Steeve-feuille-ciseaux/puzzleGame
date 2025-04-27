-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Tableau des Puzzle
local selectMAP = require("selectMAP") -- selectMAP.lua

-- Tableau des couleurs (valeur -> couleur)
local colorMap = require("colorMap") -- colorMap.lua

-- Affichage puzzle à reprodruire
local cellSize = 15  -- Taille de chaque case
local offsetX = 10    -- Décalage à gauche
local offsetY = 20    -- Décalage en haut

for y = 1, #selectMAP[1] do
	for x = 1, #selectMAP[1][y] do
		local value = selectMAP[1][y][x]
		local valueStr = string.format("%02d", value)
		local color = colorMap[valueStr] or {1, 1, 1}

		-- Case principale
		local rect = display.newRect(offsetX + (x - 1) * cellSize, offsetY + (y - 1) * cellSize, cellSize, cellSize)
		rect:setFillColor(unpack(color))
		rect.anchorX = 0
		rect.anchorY = 0

		-- Si c’est 99 (gris), ajouter un petit carré blanc au centre
		if valueStr == "99" then
			local whiteSize = cellSize * 0.3  -- Taille du petit carré blanc
			local centerX = offsetX + (x - 1) * cellSize + cellSize / 2
			local centerY = offsetY + (y - 1) * cellSize + cellSize / 2
			local whiteSquare = display.newRect(centerX, centerY, whiteSize, whiteSize)
			whiteSquare:setFillColor(1, 1, 1)
		end
	end
end