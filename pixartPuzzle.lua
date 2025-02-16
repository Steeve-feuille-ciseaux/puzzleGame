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

function TIC()
    cls(0) -- Efface l'écran

    -- Dessiner la carte
    for y = 1, #MAP do
        for x = 1, #MAP[y] do
            local color = MAP[y][x]
            local posX = MAP.POS_X + (x - 1) * MAP.CELL_SIZE
            local posY = MAP.POS_Y + (y - 1) * MAP.CELL_SIZE

            if color == 99 then
                -- Si la valeur est 99, dessiner avec une bordure
                rect(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, 8) 
                rectb(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
            elseif color == 99 and endPuzzle == x then
                -- Si le puzzle est fini, la pixel inutile s'efface
                rect(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, 0) 
                rectb(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, 0)
            else
                -- Sinon, dessiner normalement
                rect(posX, posY, MAP.CELL_SIZE, MAP.CELL_SIZE, color)
            end
        end
    end

    -- Affiche les pixels à placer sur le puzzle
    for i, color in ipairs(MAP.COLOR) do
        local yPos = MAP.POS_Y + (MAP.CELL_SIZE + 2) * (i - 1)  -- Aligné avec MAP.POS_Y
        rect(200, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, color)
        rectb(200, yPos, MAP.CELL_SIZE, MAP.CELL_SIZE, 13)
        print("x".. 5, 209, yPos + 1,12)
    end

    -- Affiche les coordonné X et Y de la souris
	mX,mY,lb,mb,rb,scrollX,scrollY= mouse()
	print(mX, 20,100,12)
	print(mY, 20,110,12)

    -- Affiche la progression
    if endPuzzle == x then 
        print("Finish !!!", 195,130 - 5,12)
        completePuzzle()
    else
        print("Complete", 187,123 - 5,12)
        print(endPuzzle .. " / " .. tostring(x), 195,130 - 5,12)
    end

end