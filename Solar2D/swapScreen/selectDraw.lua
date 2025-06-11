local composer = require("composer")
local scene = composer.newScene()

-- 📦 Importation des couleurs
local ColorMiniDraw = require("data.colorMap")

-- 📦 Fonction de chargement dynamique des puzzles
local function loadDataMap(page)
    local moduleName = "data.drawMap" .. page
    package.loaded[moduleName] = nil -- Force le rechargement
    return require(moduleName)
end

-- 📄 Variables globales à la scène
local pageCurrent = 1
local pageMax = 2
local dataMap = loadDataMap(pageCurrent)
local sceneGroup
local pageIndicator
local leftArrow
local rightArrow

-- 📐 Grille
local squareSize = 230
local spacing = 20
local numRows = 2
local numCols = 3
local ajustY = 50

local gridWidth = numCols * squareSize + (numCols - 1) * spacing
local gridHeight = numRows * squareSize + (numRows - 1) * spacing
local startX = (display.contentCenterX - gridWidth / 2)
local startY = (display.contentCenterY - gridHeight / 2) + ajustY - 30

-- 🧱 Dessin de la grille
local function drawGrid()
    local idCounter = 1
    for row = 0, numRows - 1 do
        for col = 0, numCols - 1 do
            local x = startX + col * (squareSize + spacing) + squareSize / 2
            local y = startY + row * (squareSize + spacing) + squareSize / 2

            local mapData = dataMap[idCounter]

            if mapData then
                local square = display.newRect(sceneGroup, x, y, squareSize, squareSize)
                square:setFillColor(0.3, 0.3, 0.3)
                square:setStrokeColor(1)
                square.isPuzzleElement = true

                square.idNom = mapData.num
                square.grid = mapData.grid
                square.difficulty = mapData.data.difficulty
                square.clear = mapData.data.Clear
                square.unlock = mapData.data.Unlock
                square.name = mapData.data.name

                local grid = mapData.grid
                local cellSize = (squareSize * 0.8) / math.max(mapData.data.Hauteur, mapData.data.Largeur)
                local offsetX = x - (cellSize * mapData.data.Largeur) / 2
                local offsetY = y - (cellSize * mapData.data.Hauteur) / 2

                for row = 1, #grid do
                    for col = 1, #grid[row] do
                        local value = grid[row][col]
                        if value ~= 99 then
                            local color = ColorMiniDraw[value] or {1, 1, 1}
                            local px = offsetX + (col - 1) * cellSize
                            local py = offsetY + (row - 1) * cellSize

                            local pixel = display.newRect(sceneGroup, px, py, cellSize, cellSize)
                            pixel:setFillColor(unpack(color))
                            pixel.anchorX = 0
                            pixel.anchorY = 0
                            pixel.isPuzzleElement = true
                        end
                    end
                end

                square:addEventListener("tap", function()
                    composer.removeScene("swapScreen.selectDraw")
                    composer.setVariable("selectedPuzzle", square.idNom)
                    composer.gotoScene("swapScreen.draw", { effect = "crossFade", time = 500 })
                end)
            else
                -- 🞬 Case vide avec croix
                local square = display.newRect(sceneGroup, x, y, squareSize, squareSize)
                square:setFillColor(0.3, 0.3, 0.3)
                square:setStrokeColor(0.3)
                square.strokeWidth = 2
                square.isPuzzleElement = true

                local offset = squareSize * 0.4
                local line1 = display.newLine(sceneGroup, x - offset, y - offset, x + offset, y + offset)
                local line2 = display.newLine(sceneGroup, x - offset, y + offset, x + offset, y - offset)

                for _, line in ipairs({line1, line2}) do
                    line:setStrokeColor(0, 0, 0)
                    line.strokeWidth = 4
                    line.isPuzzleElement = true
                end
            end

            idCounter = idCounter + 1
        end
    end
end

-- 🔁 Nettoyage de la grille précédente
local function clearGrid()
    for i = sceneGroup.numChildren, 1, -1 do
        local child = sceneGroup[i]
        if child.isPuzzleElement then
            display.remove(child)
        end
    end
end

-- 🔺 Mise à jour des flèches et page
local function updatePageDisplay()
    pageIndicator.text = pageCurrent .. " / " .. pageMax
    leftArrow.isVisible, leftArrow.isHitTestable = pageCurrent > 1, pageCurrent > 1
    rightArrow.isVisible, rightArrow.isHitTestable = pageCurrent < pageMax, pageCurrent < pageMax
end

-- 🔺 Flèches
local function createArrow(points, x, y, fill, stroke, onTap)
    local arrow = display.newPolygon(sceneGroup, x, y + 20, points)
    arrow:setFillColor(unpack(fill))
    arrow.strokeWidth = 2
    arrow:setStrokeColor(unpack(stroke))

    arrow:addEventListener("tap", function()
        arrow:setFillColor(1, 0.5, 0)
        timer.performWithDelay(150, function()
            arrow:setFillColor(unpack(fill))
        end)
        onTap()
    end)

    return arrow
end

-- 🔨 Création de la scène
function scene:create(event)
    sceneGroup = self.view

    local title = display.newText({
        parent = sceneGroup,
        text = "Sélectionnez un dessin",
        x = display.contentCenterX,
        y = 80,
        font = native.systemFontBold,
        fontSize = 36
    })
    title:setFillColor(0.5, 0.5, 0.5)

    pageIndicator = display.newText({
        parent = sceneGroup,
        text = pageCurrent .. " / " .. pageMax,
        x = display.contentCenterX,
        y = display.contentHeight * 0.92,
        font = native.systemFontBold,
        fontSize = 36
    })
    pageIndicator:setFillColor(0.5, 0.5, 0.5)

    -- ➡️ Flèche droite
    local size = 40
    rightArrow = createArrow(
        {0, -size, 0, size, size, 0},
        display.contentWidth - 60, display.contentCenterY,
        {0.6, 0.6, 1}, {0.3, 0.3, 0.6},
        function()
            if pageCurrent < pageMax then
                pageCurrent = pageCurrent + 1
                clearGrid()
                dataMap = loadDataMap(pageCurrent)
                drawGrid()
                updatePageDisplay()
            end
        end
    )

    -- ⬅️ Flèche gauche
    leftArrow = createArrow(
        {0, -size, 0, size, -size, 0},
        60, display.contentCenterY,
        {0.6, 0.6, 1}, {0.3, 0.3, 0.6},
        function()
            if pageCurrent > 1 then
                pageCurrent = pageCurrent - 1
                clearGrid()
                dataMap = loadDataMap(pageCurrent)
                drawGrid()
                updatePageDisplay()
            end
        end
    )

    drawGrid()
    updatePageDisplay()
end

scene:addEventListener("create", scene)
return scene
