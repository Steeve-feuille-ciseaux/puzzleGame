-- title:   pixArt Puzzle
-- author:  Steeve-feuille-ciseaux
-- desc:    Puzzle in Pixel
-- site:    https://steeve-feuille-ciseaux.github.io/Portfolio/
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

-- Script: Affichage de la grille uniquement
x = 100
endPuzzle = 0

-- Dessin sur la carte 
MAP = {
    {99,99,99,99,99,99,99,99,99,00,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,00,02,00,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,00,02,02,03,00,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,00,02,03,03,00,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,00,02,03,03,03,04,00,99,99,99,99,99,99},
    {99,99,99,99,99,99,00,03,03,03,04,04,00,99,99,99,99,99,99},
    {00,00,00,00,00,00,03,03,03,04,04,04,05,00,00,00,00,00,00},
    {00,02,02,02,02,03,03,00,04,04,04,00,05,05,06,06,06,09,00},
    {99,00,02,02,03,03,03,00,04,04,05,00,05,06,06,06,09,00,99},
    {99,99,00,03,03,03,04,00,04,05,05,00,06,06,06,09,00,99,99},
    {99,99,99,00,03,04,04,04,05,05,05,06,06,06,09,00,99,99,99},
    {99,99,99,99,00,04,04,05,05,05,06,06,06,09,00,99,99,99,99},
    {99,99,99,99,00,04,05,05,05,06,06,06,09,09,00,99,99,99,99},
    {99,99,99,00,04,05,05,05,06,06,06,09,09,09,10,00,99,99,99},
    {99,99,99,00,05,05,05,06,00,00,00,09,09,10,10,00,99,99,99},
    {99,99,00,05,05,05,00,00,99,99,99,00,00,10,10,11,00,99,99},
    {99,99,00,05,05,00,99,99,99,99,99,99,99,00,11,11,00,99,99},
    {99,99,00,00,00,99,99,99,99,99,99,99,99,99,00,00,00,99,99},
}

-- Info sur MAP
MAP.CELL_SIZE = 7
MAP.POS_X = 70
MAP.POS_Y = 5
MAP.COLOR = {00,02,03,04,05,06,09,10,11}


-- Grille vierge
GRID = {
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
}

-- Info sur la grille
GRID.CELL_SIZE = MAP.CELL_SIZE
GRID.POS_X = MAP.POS_X
GRID.POS_Y = MAP.POS_Y
GRID.COLOR = MAP.COLOR
GRID.COLOR.NB = {}
GRID.TYPE = 0

-- Info sur la mini grille
MINI = {}
MINI.CELL_SIZE = 3
MINI.POS_X = 2  -- Position à gauche
MINI.POS_Y = 35  -- Position en bas

function drawMiniGrid()
    for y = 1, #MAP do
        for x = 1, #MAP[y] do
            local color = MAP[y][x]
            local posX = MINI.POS_X + (x - 1) * MINI.CELL_SIZE
            local posY = MINI.POS_Y + (y - 1) * MINI.CELL_SIZE

            if color ~= 99 then
                rect(posX, posY, MINI.CELL_SIZE, MINI.CELL_SIZE, color)
            else
                rect(posX, posY, MINI.CELL_SIZE, MINI.CELL_SIZE, 13) 
                rectb(posX, posY, MINI.CELL_SIZE, MINI.CELL_SIZE, 8)
            end
        end
    end
end

PIXEL = {}
PIXEL.COLOR = {}

-- Met à jour la carte lorsque le puzzle est fini
function completePuzzle()
    -- Efface l'écran  
    cls(0) 

    -- Affiche le dessin sans grille
    for y = 1, #MAP do
        for x = 1, #MAP[y] do
            local color = MAP[y][x]
            local posX = MAP.POS_X + (x - 1) * MAP.CELL_SIZE
            local posY = MAP.POS_Y + (y - 1) * MAP.CELL_SIZE

            if color == 99 then
                MAP[y][x] = 0 -- Remplace 99 par 0
            else
                -- Sinon, dessiner normalement
                rect(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, color)
            end
        end
    end
    print("Finish !!!", 187,123 - 5,12)
    print(endPuzzle .. " / " .. tostring(x), 190,130 - 5,12)
end

selectedColor = nil  -- Stocke la couleur actuellement sélectionnée

function TIC()
    cls(0) -- Efface l'écran

    -- Affiche la mini-grille
    drawMiniGrid()

    -- Dessiner la grille
    for y = 1, #GRID do
        for x = 1, #GRID[y] do
            local color = GRID[y][x]
            local posX = GRID.POS_X + (x - 1) * GRID.CELL_SIZE
            local posY = GRID.POS_Y + (y - 1) * GRID.CELL_SIZE

            if color == 99 then
                rect(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, 8) 
                rectb(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, 13)
            else
                rect(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, color)
            end

            -- Ajouter un point gris au centre de chaque cellule
            -- pix(posX + GRID.CELL_SIZE // 2, posY + GRID.CELL_SIZE // 2, 13)
        end
    end

    -- Affiche les pixels à placer
    for i, color in ipairs(MAP.COLOR) do
        local yPos = MAP.POS_Y + (MAP.CELL_SIZE + 2) * (i - 1)  
        rect(215, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, color)
        rectb(215, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
        print("x".. 5, 224, yPos + 1, 12)

        -- Vérifier si la souris clique sur une couleur
        if mousePressed and mX >= 200 and mX <= 200 + MAP.CELL_SIZE and mY >= yPos and mY <= yPos + MAP.CELL_SIZE then
            selectedColor = color  -- Stocke la couleur sélectionnée
        end
    end

    -- Récupère la position et état du clic
    mX, mY, lb, _, _, _, _ = mouse()
    mousePressed = lb  -- Stocke l'état du bouton gauche

    -- Affiche la couleur sous la souris si un bouton est maintenu
    if selectedColor and mousePressed then
        rect(mX - MAP.CELL_SIZE // 2, mY - MAP.CELL_SIZE // 2, MAP.CELL_SIZE, MAP.CELL_SIZE, selectedColor)
    end

    -- Affiche les limites de l'écran 
    -- rectb(1,1,239,135,13)

    -- Quand on relâche, applique la couleur si dans la grille
    if selectedColor and not mousePressed then
        local gridX = math.floor((mX - GRID.POS_X) / GRID.CELL_SIZE) + 1
        local gridY = math.floor((mY - GRID.POS_Y) / GRID.CELL_SIZE) + 1

        if gridX > 0 and gridX <= #GRID[1] and gridY > 0 and gridY <= #GRID then
            GRID[gridY][gridX] = selectedColor
        end

        selectedColor = nil  -- Réinitialise après le relâchement
    end
end
