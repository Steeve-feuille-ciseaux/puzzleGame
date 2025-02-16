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

-- Définition de la carte MAP
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

-- Info sur la grille
MAP.CELL_SIZE = 7
MAP.POS_X = 50
MAP.POS_Y = 5
MAP.COLOR = {00,02,03,04,05,06,09,10,11}
MAP.COLOR.NB = {}

PIXEL = {}
PIXEL.COLOR = {}

-- Met à jour la carte lorsque le puzzle est fini
function completePuzzle()
    cls(0) -- Efface l'écran    -- Dessiner la carte
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

-- Définition de la carte MAP
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

-- Info sur la grille
MAP.CELL_SIZE = 7
MAP.POS_X = 50
MAP.POS_Y = 5
MAP.COLOR = {00,02,03,04,05,06,09,10,11}
MAP.COLOR.NB = {}

PIXEL = {}
PIXEL.COLOR = {}

-- Met à jour la carte lorsque le puzzle est fini
function completePuzzle()
    cls(0) -- Efface l'écran    -- Dessiner la carte
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

-- Ajout des variables
selectedColor = nil
holding = false

function TIC()
    cls(0) -- Efface l'écran

    -- Dessiner la carte vierge
    for y = 1, #MAP do
        for x = 1, #MAP[y] do
            local color = MAP[y][x]
            local posX = MAP.POS_X + (x - 1) * MAP.CELL_SIZE
            local posY = MAP.POS_Y + (y - 1) * MAP.CELL_SIZE

            rect(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, 8) 
            rectb(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
        end
    end

    -- Affiche les couleurs disponibles à droite
    for i, color in ipairs(MAP.COLOR) do
        local yPos = MAP.POS_Y + (MAP.CELL_SIZE + 2) * (i - 1)  
        rect(200, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, color)
        rectb(200, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
        print("x".. 5, 209, yPos + 1,12)
    end

    -- Récupération des coordonnées de la souris
    mX, mY, lb, _, _ = mouse()

    -- Sélectionner une couleur lorsqu'on clique sur la palette
    for i, color in ipairs(MAP.COLOR) do
        local yPos = MAP.POS_Y + (MAP.CELL_SIZE + 2) * (i - 1)
        if lb and mX >= 200 and mX <= 200 + MAP.CELL_SIZE and mY >= yPos and mY <= yPos + MAP.CELL_SIZE then
            selectedColor = color
            holding = true
        end
    end

    -- Si on maintient le bouton de la souris, afficher le carré en déplacement
    if holding and selectedColor then
        rect(mX - MAP.CELL_SIZE // 2, mY - MAP.CELL_SIZE // 2, MAP.CELL_SIZE, MAP.CELL_SIZE, selectedColor)
        rectb(mX - MAP.CELL_SIZE // 2, mY - MAP.CELL_SIZE // 2, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
    end

    -- Relâchement du bouton de la souris
    if not lb and holding then
        -- Vérifie si la souris est sur la carte
        local gridX = (mX - MAP.POS_X) // MAP.CELL_SIZE + 1
        local gridY = (mY - MAP.POS_Y) // MAP.CELL_SIZE + 1

        if gridX > 0 and gridX <= #MAP[1] and gridY > 0 and gridY <= #MAP then
            -- Placer le carré dans la carte
            MAP[gridY][gridX] = selectedColor
        end

        -- Réinitialiser la sélection
        selectedColor = nil
        holding = false
    end

    -- Affichage des coordonnées de la souris
    print(mX, 20,100,12)
    print(mY, 20,110,12)

    -- Affichage de la progression
    if endPuzzle == x then 
        print("Finish !!!", 195,130 - 5,12)
        completePuzzle()
    else
        print("Complete", 187,123 - 5,12)
        print(endPuzzle .. " / " .. tostring(x), 195,130 - 5,12)
    end
end
