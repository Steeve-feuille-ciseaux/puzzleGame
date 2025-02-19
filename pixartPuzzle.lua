-- title:   pixArt Puzzle
-- author:  Steeve-feuille-ciseaux
-- desc:    Puzzle in Pixel
-- site:    https://steeve-feuille-ciseaux.github.io/Portfolio/
-- license: MIT License (change this to your license of choice)
-- version: 1.00.0
-- script:  lua

-- Script: Affichage de la grille uniquement
endPuzzle = false
titlePage = false
thxPage = false
GameplayZone = 1

-- bouton droit relaché
prev_rb = false

-- Delete variable
cellDelete = false

-- ICONE DELETE 
-- Position du carré icone en bas à droite
squarePosX = 222
squarePosY = 120
-- Taille du carré 
squareSize = 7  
-- Position de la croix en bas à gauche
crossPosX = 222
crossPosY = 120
crossSize = 3  -- Taille de la croix
crossLarg = 0.5 -- Largeur des lignes

-- Animation Mode Soluce
rainbowColors = {2, 3, 4, 5, 6, 9, 10, 11} -- Couleurs pour l'animation
rainbowIndex = 1 -- Index actuel dans le tableau de couleurs
rainbowTimer = 0 -- Timer pour l'animation

indexMap = 2
selectMAP = {
	{
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
	},
	{
		{99,99,99,99,99,99,99,99,99,99,99,00,00,00,00,99,99,99,99},
		{99,99,99,99,99,99,99,99,00,00,00,13,13,13,13,00,99,99,99},
		{99,99,99,99,99,99,00,00,13,13,13,13,13,13,00,00,99,99,99},
		{99,99,99,99,99,00,13,13,13,13,13,13,13,13,13,00,99,99,99},
		{99,99,99,00,00,13,13,13,13,13,13,13,13,13,13,13,00,99,99},
		{99,99,00,13,13,13,13,13,13,13,13,13,13,13,13,13,00,99,99},
		{99,00,13,13,13,13,13,13,13,13,13,13,00,00,13,13,13,00,00},
		{99,00,13,13,00,13,13,13,13,13,13,13,00,00,04,04,13,00,99},
		{99,99,00,00,13,13,00,00,13,13,13,13,13,13,04,04,00,00,00},
		{99,99,00,13,13,13,00,00,13,13,00,13,13,13,13,13,13,00,99},
		{99,00,00,00,13,04,04,13,13,13,13,13,13,13,13,13,00,99,99},
		{99,99,00,13,13,04,04,13,13,13,13,13,13,13,00,00,99,99,99},
		{99,99,99,00,13,13,13,13,13,13,13,02,02,02,02,02,00,99,99},
		{99,00,99,99,00,00,00,02,02,02,02,02,02,02,02,13,00,99,99},
		{00,13,00,99,99,00,02,02,02,02,02,13,02,13,13,13,13,00,99},
		{00,13,13,00,99,00,13,13,13,13,02,13,02,13,13,13,13,00,99},
		{99,00,13,13,00,13,13,13,13,13,13,13,13,13,13,13,13,00,99},
		{99,99,00,13,00,13,13,13,13,13,13,13,13,13,13,13,00,99,99}, -- limite pour le puzzle 1
		{99,99,99,00,00,13,13,13,13,13,13,13,13,13,13,13,00,99,99},
		{99,99,99,99,00,00,13,13,13,00,13,13,00,13,13,00,99,99,99},
		{99,99,99,99,99,99,00,00,00,00,00,00,99,00,00,99,99,99,99}, -- limite pour le puzzle 2
	}
}

infoMAP = {
	{ 7, 70, 5, {00,02,03,04,05,06,09,10,11}, {64,11,21,20,27,22,12,5,3}, "STAR"}, -- ETOILE | SIZE | POS_X | POS_Y | {COLOR} | {COLOR.NB}
	{ 7, 70, 5, {99,00,13,04,2}, {64,11,21,20,27,22,12,5,3}, "CAT1"}, -- CAT1 | SIZE | POS_X | POS_Y | {COLOR} | {COLOR.NB}
}

-- Dessin à réaliser 
MAP = selectMAP[indexMap]

-- Info sur MAP
MAP.CELL_SIZE = infoMAP[indexMap][1]
MAP.POS_X = infoMAP[indexMap][2]
MAP.POS_Y = infoMAP[indexMap][3]
MAP.COLOR = infoMAP[indexMap][4]
MAP.COLOR.NB = infoMAP[indexMap][5]
MAP.NAME = infoMAP[indexMap][6]

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
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
    {99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
}

-- Info sur la grille
GRID.CELL_SIZE = MAP.CELL_SIZE
GRID.POS_X = MAP.POS_X
GRID.POS_Y = MAP.POS_Y
GRID.COLOR = MAP.COLOR
GRID.COLOR.Q = {14,11,21,20,27,22,12,5,3}

-- Fonction pour compter les occurrences des valeurs dans MAP.COLOR.NB
local function count_values_in_grid(grid, values)
    local count = 0
    for i = 1, #grid do
        for j = 1, #grid[i] do
            for _, value in ipairs(values) do
                if grid[i][j] == value then
                    count = count + 1
                end
            end
        end
    end
    return count
end

function resetGrid(g1)    
    endPuzzle = false
    for i = 1, #g1 do
        for j = 1, #g1[i] do
            g1[i][j] = 99
        end
    end
end

-- Vérifier si les dimensions sont les mêmes
function watchEqual(t1, t2)
    if #t1 ~= #t2 then return false end  

    for i = 1, #t1 do
        if #t1[i] ~= #t2[i] then return false end  -- Vérifier la largeur de chaque ligne

        for j = 1, #t1[i] do
            if t1[i][j] ~= t2[i][j] then
                return false  -- Dès qu'une cellule est différente, renvoyer false
            end
        end
    end

    return true  -- Si toutes les cases sont identiques, renvoyer true
end

-- Nombre de pixel à placer
function countDifferences(t1, t2)
    local count = 0

    -- Vérifier si les dimensions sont les mêmes
    if #t1 ~= #t2 then return -1 end  

    for i = 1, #t1 do
        if #t1[i] ~= #t2[i] then return -1 end  -- Vérifier la largeur de chaque ligne

        for j = 1, #t1[i] do
            if t1[i][j] ~= t2[i][j] then
                count = count + 1  -- Incrémenter le compteur si la valeur est différente
            end
        end
    end

    return count
end

-- Nombre maximum de piece
pixTotal = countDifferences(GRID, MAP)


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

-- Identifie la couleur
indexColor = 1
selectedColor = MAP.COLOR[indexColor];  -- Stocke la couleur actuellement sélectionnée

function TIC()
    cls(0) -- Efface l'écran
	print("#".. infoMAP[1][6], 10, 20, 12)
    -- Récupère la position et état du clic
	mX, mY, lb, _, rb, scrollX, scrollY= mouse()
    -- Affiche les coordonné X et Y de la souris
	-- print(mX, 10,100,12)
	-- print(mY, 10,110,12)    

    -- Changer de carte avec les touches fléchées
    if btnp(2) then  -- Flèche gauche
        indexMap = indexMap - 1
        if indexMap < 1 then indexMap = #selectMAP end
    end
    if btnp(3) then  -- Flèche droite
        indexMap = indexMap + 1
        if indexMap > #selectMAP then indexMap = 1 end
    end
    
    -- Gestion de l'animation arc-en-ciel
    rainbowTimer = rainbowTimer + 1
    if rainbowTimer > 10 then -- Changer de couleur toutes les 10 frames
        rainbowTimer = 0
        rainbowIndex = rainbowIndex + 1
        if rainbowIndex > #rainbowColors then
            rainbowIndex = 1
        end
    end

    -- ## BUILDING PUZZLE
    if endPuzzle == false then

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
    
                -- Mode Soluce
                -- S'applique avec la touche Q 
                if key(17) and GRID[y][x] ~= MAP[y][x] then
                        rectb(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, rainbowColors[rainbowIndex])
                        --rectb(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, 13)
                end

                -- Ajouter un point gris au centre de chaque cellule
                -- pix(posX + GRID.CELL_SIZE // 2, posY + GRID.CELL_SIZE // 2, 13)
            end
        end
        
        -- Affiche la mini-grille
        drawMiniGrid()

        -- Affiche les pixels à placer
        for i, color in ipairs(MAP.COLOR) do
            local yPos = MAP.POS_Y + (MAP.CELL_SIZE + 2) * (i - 1)  
            rect(215, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, color)
            rectb(215, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
            --print("x".. MAP.COLOR.NB[i], 224, yPos + 1, 12)
            --print("x".. GRID.COLOR.NB[i], 224, yPos + 1, 12)
            --print("x".. (MAP.COLOR.NB[i] - GRID.COLOR.Q[i]), 224, yPos + 1, 12)
            
            print("x".. "?", 224, yPos + 1, 12)
        end

        -- Dessine le carré qui sera l'icone delete pixel de la grille
        rect(squarePosX - squareSize, squarePosY - squareSize, squareSize * 2, squareSize * 2, 8)
        rectb(squarePosX - squareSize, squarePosY - squareSize, squareSize * 2, squareSize * 2, 13)

        -- Dessine la croix rouge dans l'icone delete
        for i = -crossLarg, crossLarg do
            line(crossPosX - crossSize + i, crossPosY - crossSize, crossPosX + crossSize + i, crossPosY + crossSize, 2)
            line(crossPosX - crossSize + i, crossPosY + crossSize, crossPosX + crossSize + i, crossPosY - crossSize, 2)
        end
        
        -- Positionne la flèche pour indiquer la couleur sélectionnée
        arrowPosY = (MAP.POS_Y + 3) + (MAP.CELL_SIZE + 2) * (indexColor - 1)  -- Position Y de la flèche
        arrowPosX = 212  -- Position X de la flèche (fixe, juste à gauche des carrés de couleur)

        -- Dessiner une flèche pointant vers le carré de couleur sélectionné
        tri(arrowPosX, arrowPosY, arrowPosX - 4, arrowPosY - 4, arrowPosX - 4, arrowPosY + 4, 12)

        -- Calculer le nombre de différences
        pixCount = countDifferences(GRID, MAP)

        -- Affiche les pixel restant
        print(pixCount, 210, 93, 12)
        -- Place le Slash entre le restant sur le total
        line(210, 108, 235, 94, 12)
        -- Affiche le total de pixel
        print(pixTotal, 220, 105, 12)

		-- Affiche le numéro et nom du puzzle
        print("#".. indexMap, 10, 10, 12)

        -- Affiche les limites de l'écran 
        -- rectb(1,1,239,135,13)

        -- Carre cursor
        -- Afficher un carré de la couleur sélectionnée qui suit la souris
        if cellDelete then
            for i = -crossLarg, crossLarg do
                line(mX - crossSize + i, mY - crossSize, mX + crossSize + i, mY + crossSize, 2)
                line(mX - crossSize + i, mY + crossSize, mX + crossSize + i, mY - crossSize, 2)
            end
        else
            rect(mX - (GRID.CELL_SIZE // 2), mY - (GRID.CELL_SIZE // 2), GRID.CELL_SIZE, GRID.CELL_SIZE, selectedColor)
            rectb(mX - (GRID.CELL_SIZE // 2), mY - (GRID.CELL_SIZE // 2), GRID.CELL_SIZE, GRID.CELL_SIZE, 13) -- Bordure
        end

        -- Si le bouton droite est pressé
        if prev_rb and not rb and cellDelete == false then
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
                if cellDelete == false then
                    GRID[gridY][gridX] = selectedColor -- Changer la valeur de la cellule pour dessiner dans la grille
                else
                    GRID[gridY][gridX] = 99 -- Changer la valeur de la cellule pour dessiner dans la grille
                end
            end
    
            -- Vérifier si le bouton gauche est pressé sur l'icône de suppression
            if mX >= (squarePosX - squareSize) and mX <= (squarePosX + squareSize) and 
                mY >= (squarePosY - squareSize) and mY <= (squarePosY + squareSize) then
                cellDelete = true -- Basculer entre true et false
            end
            -- Vérifier si un carré de couleur est cliqué
            if mX >= 215 and mX <= 215 + GRID.CELL_SIZE then
                for i, color in ipairs(MAP.COLOR) do
                    local yPos = MAP.POS_Y + (GRID.CELL_SIZE + 2) * (i - 1)  
                    if mY >= yPos and mY <= yPos + GRID.CELL_SIZE then
                        indexColor = i  -- Met à jour l'index de couleur
                        selectedColor = MAP.COLOR[indexColor]  
                        cellDelete = false -- Désactiver le mode suppression
                    end
                end
            end
        end

    end

    -- Condition de FIN    
    -- Vérifier si MAP et GRID sont identiques avant d'appeler completePuzzle
    
    if watchEqual(MAP, GRID) then
        endPuzzle = true
        --cls(0)    -- Dessiner la grille
        for y = 1, #GRID do
            for x = 1, #GRID[y] do
                local color = GRID[y][x]
                local posX = GRID.POS_X + (x - 1) * GRID.CELL_SIZE
                local posY = GRID.POS_Y + (y - 1) * GRID.CELL_SIZE
    
                if color == 99 then
                    rect(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, 0) 
                else
                    rect(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, color)
                end
    
                -- Ajouter un point gris au centre de chaque cellule
                -- pix(posX + GRID.CELL_SIZE // 2, posY + GRID.CELL_SIZE // 2, 13)
            end
        end

        if endPuzzle then

            -- Positions des textes "Yes" et "No"
            local yesX, yesY, colorY = 15, 76, 12
            local noX, noY, colorN = 40, 76, 12

            -- Dimensions des boutons "Yes" et "No"
            local yesWidth, yesHeight = 21, 10
            local noWidth, noHeight = 15, 10

            -- page de remerciement 
            if thxPage then
                print("Thanks", 10, 58, 12)
                print("for", 18, 67, 12)
                print("playing", 10, 76, colorN)
            else            
                -- Afficher les messages
                print("BRAVO !!!", 10, 58, 12)
                print("One More", 10, 67, 12)
    
                -- Afficher les textes "Yes" et "No" avec les couleurs mises à jour
                print("Yes", yesX, yesY, colorY)
                print("No", noX, noY, colorN)
            end

            -- Récupérer la position de la souris et l'état des clics
            --mX, mY, lb, _, rb, _, _ = mouse()

            -- Si la souris survole "Yes"
            if mX >= yesX and mX <= yesX + yesWidth and mY >= yesY and mY <= yesY + yesHeight then
                colorY = 4  -- Changer la couleur de "Yes"
                if lb then 
                    resetGrid(GRID)
                end
            end

            -- Si la souris survole "No"
            if mX >= noX and mX <= noX + noWidth and mY >= noY and mY <= noY + noHeight then
                colorN = 4  -- Changer la couleur de "No"
                if lb then 
                    thxPage = true
                end
            end
        end
    end

end
