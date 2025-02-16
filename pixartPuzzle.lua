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

indexColor = 1
selectedColor = MAP.COLOR[indexColor];  -- Stocke la couleur actuellement sélectionnée

-- bouton droit relaché
local prev_rb = false

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

    -- Récupère la position et état du clic
    mX, mY, lb, _, rb, _, _ = mouse()

    -- Affiche les pixels à placer
    for i, color in ipairs(MAP.COLOR) do
        local yPos = MAP.POS_Y + (MAP.CELL_SIZE + 2) * (i - 1)  
        rect(215, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, color)
        rectb(215, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
        print("x".. 5, 224, yPos + 1, 12)

        -- Vérification du clic gauche sur les carrés de couleurs
        if lb then
            if mX >= 215 and mX <= 215 + MAP.CELL_SIZE and mY >= yPos and mY <= yPos + MAP.CELL_SIZE then
                indexColor = i  -- Met à jour l'index de couleur en fonction du carré cliqué
                selectedColor = MAP.COLOR[indexColor]  -- Change la couleur sélectionnée
            end
        end
    end

    -- Position de la croix en bas à droite
    local crossPosX = 220
    local crossPosY = 120
    local crossSize = 3  -- Taille de la croix (longueur des lignes)
    local crossLarg = 2  -- Largeur de la croix (épaisseur des lignes)
    -- Dessiner la croix (deux lignes croisées) avec une épaisseur simulée
    local lineThickness = 1  -- Épaisseur de la ligne (en nombre de pixels)
    -- Diagonale 1 (haut-gauche à bas-droit)
    for i = -lineThickness, lineThickness do
        line(crossPosX - crossSize - crossLarg + i, crossPosY - crossSize, crossPosX + crossSize + crossLarg + i, crossPosY + crossSize, 2)  -- Couleur rouge (2)
    end
    -- Diagonale 2 (haut-droit à bas-gauche)
    for i = -lineThickness, lineThickness do
        line(crossPosX - crossSize - crossLarg + i, crossPosY + crossSize, crossPosX + crossSize + crossLarg + i, crossPosY - crossSize, 2)  -- Couleur rouge (2)
    end

    -- Dessiner la flèche pour indiquer la couleur sélectionnée
    local arrowPosY = (MAP.POS_Y + 3) + (MAP.CELL_SIZE + 2) * (indexColor - 1)  -- Position Y de la flèche
    local arrowPosX = 212  -- Position X de la flèche (fixe, juste à gauche des carrés de couleur)

    -- Dessiner une flèche pointant vers le carré de couleur sélectionné
    tri(arrowPosX, arrowPosY, arrowPosX - 4, arrowPosY - 4, arrowPosX - 4, arrowPosY + 4, 12)

    -- Affiche les limites de l'écran 
    -- rectb(1,1,239,135,13)

    -- Carre cursor
    -- Afficher un carré de la couleur sélectionnée qui suit la souris
    rect(mX - (GRID.CELL_SIZE // 2), mY - (GRID.CELL_SIZE // 2), GRID.CELL_SIZE, GRID.CELL_SIZE, selectedColor)
    rectb(mX - (GRID.CELL_SIZE // 2), mY - (GRID.CELL_SIZE // 2), GRID.CELL_SIZE, GRID.CELL_SIZE, 13) -- Bordure


    -- Si le bouton droite est pressé
    if prev_rb and not rb then
        indexColor = indexColor + 1
        if indexColor > #MAP.COLOR then
            indexColor = 1 -- Revenir au début si on dépasse la liste
        end
        selectedColor = MAP.COLOR[indexColor]
    end

    -- Mettre à jour l'état précédent du bouton droit
    prev_rb = rb

    -- Si le bouton gauche est pressé
    if lb then 
        -- Convertir les coordonnées de la souris en indices de la grille
        local gridX = math.floor((mX - GRID.POS_X) / GRID.CELL_SIZE) + 1
        local gridY = math.floor((mY - GRID.POS_Y) / GRID.CELL_SIZE) + 1

        -- Vérifier si les indices sont dans les limites de la grille
        if gridX >= 1 and gridX <= #GRID[1] and gridY >= 1 and gridY <= #GRID then
            GRID[gridY][gridX] = selectedColor -- Changer la valeur de la cellule en 5
        end
    end

end
