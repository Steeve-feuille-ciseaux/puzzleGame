-- title:   pixArt Puzzle
-- author:  Steeve-feuille-ciseaux
-- desc:    Puzzle in Pixel
-- site:    https://steeve-feuille-ciseaux.github.io/Portfolio/
-- license: MIT License (change this to your license of choice)
-- version: 1.00.0
-- script:  lua

-- Script: Affichage de la grille uniquement
titlePage = false
selectPuzzle = false
buildingPuzzle = true
endPuzzle = false
thxPage = false
GameplayPhase = 0
pagePuzzle = 1
pageMax = 2
indexMap = 0

-- DECOUPAGE DU JEU
function updatePhase(GameplayPhase)
    -- Réinitialiser toutes les variables
    selectPuzzle = false
    buildingPuzzle = false
    endPuzzle = false
    thxPage = false

    -- Activer la bonne variable en fonction de GameplayPhase
    if GameplayPhase == 1 then
        cls(0)
        initPuzzle()
        buildingPuzzle = true       -- building Puzzle
    elseif GameplayPhase == 2 then
        GRID = MAP
        endPuzzle = true            -- end Puzzle
    elseif GameplayPhase == 3 then   
        selectPuzzle = true         -- select Puzzle
    elseif GameplayPhase == 4 then
        thxPage = true
    end
end

-- bouton droit relaché
prev_rb = false

-- bouton droit relaché
prev_lb = false

-- Delete variable
cellDelete = false

-- soluce Puzzle
solucePuzzle = false
ajuste2 = 20

-- ICONE DELETE 
-- Position du carré icone en bas à droite
squarePosX = 222 
squarePosY = 120 - ajuste2
-- Taille du carré 
squareSize = 7  
-- Position de la croix en bas à gauche
crossPosX = 222
crossPosY = 120 - ajuste2
crossSize = 3  -- Taille de la croix
crossLarg = 0.5 -- Largeur des lignes

-- Animation Mode Soluce
rainbowColors = {2, 3, 4, 5, 6, 9, 10, 11} -- Couleurs pour l'animation
rainbowIndex = 1 -- Index actuel dans le tableau de couleurs
rainbowTimer = 0 -- Timer pour l'animation

-- Collection de puzzle
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
		{99,99,00,13,00,13,13,13,13,13,13,13,13,13,13,13,00,99,99},
		{99,99,99,00,00,13,13,13,13,13,13,13,13,13,13,13,00,99,99},
		{99,99,99,99,00,00,13,13,13,00,13,13,00,13,13,00,99,99,99},
		{99,99,99,99,99,99,00,00,00,00,00,00,99,00,00,99,99,99,99}, 
	},
    {
        {99,99,99,99,00,00,00,99,99,99,99,99,99,99,99,99,99,99,99,99,00,00,00,99},
        {99,99,99,00,02,02,02,00,00,99,99,99,99,99,99,99,99,99,00,00,02,02,02,00},
        {99,99,99,00,02,03,03,02,02,00,00,00,00,00,00,00,00,00,02,02,03,03,02,00},
        {99,99,99,00,02,03,03,00,00,02,03,02,03,02,03,02,03,02,00,00,03,03,02,00},
        {99,99,99,00,02,03,00,03,03,02,03,02,03,02,03,02,03,02,03,03,00,03,02,00},
        {99,99,99,00,02,00,03,03,03,03,03,02,03,02,03,02,03,03,03,03,03,00,02,00},
        {99,99,99,99,00,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,00,99},
        {99,99,99,99,00,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,00,99},
        {99,99,99,99,00,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,00,99},
        {99,99,99,00,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,03,00},
        {99,99,99,00,02,02,03,00,00,00,03,03,03,03,03,03,03,00,00,00,03,02,02,00},
        {99,99,99,00,03,03,03,03,03,03,03,00,03,00,03,00,03,03,03,03,03,03,03,00},
        {99,99,99,00,02,02,03,03,04,04,04,04,00,04,00,04,04,04,04,03,03,02,02,00},
        {99,99,99,00,03,03,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,03,03,00},
        {99,99,99,99,00,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,00,99},
        {99,99,99,99,00,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,04,00,99},
        {99,99,99,99,99,00,00,04,04,04,04,04,04,04,04,04,04,04,04,04,00,00,99,99},
        {99,99,99,99,00,03,03,00,00,04,04,04,04,04,04,04,04,04,00,00,03,03,00,99},
        {99,00,00,99,00,02,03,03,03,04,04,04,00,00,00,04,04,04,03,03,03,02,00,99},
        {00,02,02,00,03,03,03,03,03,04,04,04,04,04,04,04,04,04,03,03,03,03,03,00},
        {00,02,03,00,02,02,02,03,03,04,04,04,04,04,04,04,04,04,03,03,02,02,02,00},
        {99,00,03,00,03,03,03,03,03,03,04,04,04,04,04,04,04,03,03,03,03,03,03,00},
        {99,99,00,00,02,02,02,03,03,03,04,04,04,04,04,04,04,03,03,03,02,02,02,00},
        {99,99,99,00,00,03,03,03,03,03,04,04,04,04,04,04,04,03,03,03,03,03,00,99},
        {99,99,99,99,99,00,00,02,03,03,00,04,00,04,00,04,00,03,03,02,00,00,99,99},
        {99,99,99,99,99,99,99,00,00,00,00,00,00,00,00,00,00,00,00,00,99,99,99,99},
    },
    {
        {99,99,99,99,99,99,00,00,00,00,00,00,99,99,99,99,99,00,00,00,00,00,00,99,99,99,99,99,99},
        {99,99,99,99,99,00,00,10,06,04,03,00,00,99,99,99,00,00,03,04,06,10,00,00,99,99,99,99,99},
        {99,99,99,99,99,00,10,06,04,03,02,01,00,00,99,00,00,01,02,03,04,06,10,00,99,99,99,99,99},
        {99,99,99,99,99,00,06,04,00,00,00,09,10,00,99,00,10,09,00,00,00,04,06,00,99,99,99,99,99},
        {99,99,99,99,99,00,04,03,00,99,00,10,06,00,99,00,06,10,00,99,00,03,04,00,99,99,99,99,99},
        {99,00,00,00,00,00,00,00,00,00,00,06,04,00,00,00,00,00,00,00,00,02,03,00,00,00,00,00,99},
        {00,00,10,06,04,03,02,01,09,10,00,04,03,00,09,02,03,04,06,10,00,01,02,00,04,06,10,00,00},
        {00,10,06,04,03,02,01,09,10,06,00,03,02,00,10,01,02,03,04,06,00,09,01,00,03,04,06,10,00},
        {00,06,04,00,00,00,00,00,00,00,00,02,01,00,00,00,00,00,00,00,00,10,09,00,00,00,04,06,00},
        {00,04,03,00,99,00,10,06,00,99,00,01,09,00,99,00,09,01,00,99,00,06,10,00,99,00,03,04,00},
        {00,03,02,00,00,00,06,04,00,00,00,09,10,00,99,00,10,09,00,00,00,00,00,00,00,00,02,03,00},
        {00,00,01,09,10,00,04,03,00,01,09,10,06,00,99,00,06,10,09,01,02,03,04,06,10,09,01,00,00},
        {99,00,00,10,06,00,03,02,00,09,10,06,04,00,99,00,04,06,10,09,01,02,03,04,06,10,00,00,99},
        {99,99,00,00,00,00,02,01,00,00,00,00,00,00,99,00,00,00,00,00,00,00,00,00,00,00,00,99,99},
        {99,99,99,99,99,00,01,09,00,99,99,99,99,99,99,99,99,99,99,99,00,09,01,00,99,99,99,99,99},
        {99,99,00,00,00,00,00,00,00,00,00,00,00,00,99,00,00,00,00,00,00,01,02,00,00,00,00,99,99},
        {99,00,00,10,06,04,03,02,01,09,10,06,04,00,99,00,04,06,10,09,00,02,03,00,06,10,00,00,99},
        {00,00,01,09,10,06,04,03,02,01,09,10,06,00,99,00,06,10,09,01,00,03,04,00,10,09,01,00,00},
        {00,03,02,00,00,00,00,00,00,00,00,09,10,00,99,00,10,09,00,00,00,04,06,00,00,00,02,03,00},
        {00,04,03,00,99,00,10,06,00,99,00,01,09,00,99,00,09,01,00,99,00,06,10,00,99,00,03,04,00},
        {00,06,04,00,00,00,09,10,00,00,00,00,00,00,00,00,01,02,00,00,00,00,00,00,00,00,04,06,00},
        {00,10,06,04,03,00,01,09,00,06,04,03,02,01,09,00,02,03,00,06,10,09,01,02,03,04,06,10,00},
        {00,00,10,06,04,00,02,01,00,10,06,04,03,02,01,00,03,04,00,10,09,01,02,03,04,06,10,00,00},
        {99,00,00,00,00,00,03,02,00,00,00,00,00,00,00,00,04,06,00,00,00,00,00,00,00,00,00,00,99},
        {99,99,99,99,99,00,04,03,00,99,00,10,06,00,99,00,06,10,00,99,00,03,04,00,99,99,99,99,99},
        {99,99,99,99,99,00,06,04,00,00,00,09,10,00,99,00,10,09,00,00,00,04,06,00,99,99,99,99,99},
        {99,99,99,99,99,00,10,06,04,03,02,01,00,00,99,00,00,01,02,03,04,06,10,00,99,99,99,99,99},
        {99,99,99,99,99,00,00,10,06,04,03,00,00,99,99,99,00,00,03,04,06,10,00,00,99,99,99,99,99},
        {99,99,99,99,99,99,00,00,00,00,00,00,99,99,99,99,99,00,00,00,00,00,00,99,99,99,99,99,99},
    },
}

-- Variable très important pour choisir un puzzle parmi la collection 
indexMap = 4

-- Définis aléatoirement un puzzle
function rdmSelectPuzzle(minR, maxR)
    indexMap = math.random(minR, maxR)
end
-- Execution aléatoire d'un puzzle
--rdmSelectPuzzle(1, 4)

-- Paramètre de l'ensemble des puzzles
infoMAP = {
    -- CELL_SIZE ,POS_X ,POS_Y ,{COLOR} ,{COLOR.NB} ,NAME ,LARGEUR ,HAUTEUR ,MINI.CELL_SIZE, MINI.PIXEL_MODE
	{ 7, 70, 5, {00,02,03,04,05,06,09,10,11}, {64,11,21,20,27,22,12,5,3}, "STAR", 19, 18, 3, false},
	{ 6, 75, 3, {00,13,04,02}, {64,11,21,20,27,22,12,5,3}, "CAT1", 19, 21, 3, false},
	{ 5, 80, 3, {00,02,03,04}, {64,11,21,20,27,22,12,5,3}, "CAT2", 24, 26, 3, false},
	{ 4, 80, 8, {00,06,10,04,03,02,09,01}, {64,11,21,20,27,22,12,5,3}, "PUZZLE1", 29, 29, 2, false}
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
MAP.LARG = infoMAP[indexMap][7]
MAP.HAUT = infoMAP[indexMap][8]
MAP.MINI = infoMAP[indexMap][9]
MAP.PIXEL_MODE = infoMAP[indexMap][10]
--MAP.PIXEL_MODE = true

-- Initialiser la puzzle 
function initPuzzle()
    MAP = selectMAP[indexMap]

    -- Info sur MAP !! A AMELIORER !!
    MAP.CELL_SIZE = infoMAP[indexMap][1]
    MAP.POS_X = infoMAP[indexMap][2]
    MAP.POS_Y = infoMAP[indexMap][3]
    MAP.COLOR = infoMAP[indexMap][4]
    MAP.COLOR.NB = infoMAP[indexMap][5]
    MAP.NAME = infoMAP[indexMap][6]
    MAP.LARG = infoMAP[indexMap][7]
    MAP.HAUT = infoMAP[indexMap][8]
    MAP.MINI = infoMAP[indexMap][9]
    MAP.PIXEL_MODE = infoMAP[indexMap][10]
    --MAP.PIXEL_MODE = true

    -- Définition de la grille avec 21 lignes et 19 colonnes remplie de 99
    GRID = create_grid(MAP.HAUT, MAP.LARG, 99)
    
    -- Info sur la grille !! A AMELIORER !!
    GRID.CELL_SIZE = MAP.CELL_SIZE
    GRID.POS_X = MAP.POS_X
    GRID.POS_Y = MAP.POS_Y
    GRID.COLOR = MAP.COLOR
    GRID.COLOR.Q = {14,11,21,20,27,22,12,5,3}

    
    pixTotal = countDifferences(GRID, MAP)
end


-- Création de la grille en Lua pour TIC-80
function create_grid(rows, cols, value)
    local grid = {}
    for i = 1, rows do
        grid[i] = {}
        for j = 1, cols do
            grid[i][j] = value
        end
    end
    return grid
end

-- Définition de la grille avec 21 lignes et 19 colonnes remplie de 99
GRID = create_grid(MAP.HAUT, MAP.LARG, 99)

-- Info sur la grille
GRID.CELL_SIZE = MAP.CELL_SIZE
GRID.POS_X = MAP.POS_X
GRID.POS_Y = MAP.POS_Y
GRID.COLOR = MAP.COLOR
GRID.COLOR.Q = {14,11,21,20,27,22,12,5,3}

-- Dessiner la grille
function drawGrid()
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
            if solucePuzzle and GRID[y][x] ~= MAP[y][x] then
                    rectb(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, rainbowColors[rainbowIndex])
                    --rectb(posX, posY, GRID.CELL_SIZE, GRID.CELL_SIZE, 13)
            end

            -- Ajouter un point gris au centre de chaque cellule
            -- pix(posX + GRID.CELL_SIZE // 2, posY + GRID.CELL_SIZE // 2, 13)
        end
    end
end

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
    local total = 0

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
MINI.CELL_SIZE = MAP.MINI
MINI.POS_X = 2  -- Position à gauche
MINI.POS_Y = 13  -- Position en bas
MINI.PIXEL = MAP.PIXEL_MODE  -- Mode pixel ou case

function drawMiniGrid()
    for y = 1, #MAP do
        for x = 1, #MAP[y] do
            local color = MAP[y][x]
            local posX = MINI.POS_X + (x - 1) * MINI.CELL_SIZE
            local posY = MINI.POS_Y + (y - 1) * MINI.CELL_SIZE

            -- Pisition du pixel non centré
            local pixX = MINI.POS_X + (x - 1)
            local pixY = MINI.POS_Y + (y - 1)
                
            -- Position du pixel au centre 
            local centerX = posX + math.floor(MINI.CELL_SIZE / 2)
            local centerY = posY + math.floor(MINI.CELL_SIZE / 2)

            if MINI.PIXEL then
                -- Mode Pixel : Affichage d'un seul pixel par cellule
                if color ~= 99 then
                    pix(pixX, pixY, color)  -- Pixel au centre
                else
                    pix(pixX, pixY, 8)  -- Pixel gris pour cases vides
                end
            else
                -- Mode Carré : Affichage de cases colorées avec bordure
                if color ~= 99 then
                    rect(posX, posY, MINI.CELL_SIZE, MINI.CELL_SIZE, color)  -- Remplissage
                else
                    rect(posX, posY, MINI.CELL_SIZE, MINI.CELL_SIZE, 8) 
                    pix(centerX, centerY, 13)
                end
            end
        end
    end
end


-- Identifie la couleur
indexColor = 1
selectedColor = MAP.COLOR[indexColor];  -- Stocke la couleur actuellement sélectionnée

-- Sélection puzzle / niveau
function nextPuzzle()        
    local ajustText = 20
    local iconSize = 60
    local ajustIcon = 15

    -- Récupère la position et état du clic
    local mX, mY, lb = mouse()

    -- Initialiser prev_lb au début pour qu'il garde son état entre les cadres
    if prev_lb == nil then prev_lb = false end  

    -- Position et contenu des puzzles
    local tablePuzzle = {
        {
            {10, 10, selectMAP[1],1}, {75, 10, selectMAP[2],2}, {140, 10, selectMAP[3],3},
            {10, 75, selectMAP[4],4}, {75, 75, selectMAP[5],5}, {140, 75, selectMAP[6],6}  
        },
        {
            {10, 10, selectMAP[3],3}, {75, 10, selectMAP[8]}, {140, 10, selectMAP[2],2},
            {10, 75, selectMAP[10]}, {75, 75, selectMAP[1],1}, {140, 75, selectMAP[12]}  
        },
    }

    -- Vérifie que pagePuzzle est valide
    if pagePuzzle < 1 or pagePuzzle > #tablePuzzle then
        print("Erreur: pagePuzzle hors limites!" .. pagePuzzle, 30, 10, 12)
        return
    end

    -- Dessine les cadres des puzzles
    for i, pos in ipairs(tablePuzzle[pagePuzzle]) do
        local x, y = pos[1] + ajustIcon, pos[2]

        -- Vérifie si la souris est sur le cadre
        local hover = mX >= x and mX <= x + iconSize and mY >= y and mY <= y + iconSize
        local fillColor = hover and 3 or 13  

        rect(x, y, iconSize, iconSize, 8)  
        rectb(x, y, iconSize, iconSize, fillColor)

        -- Choisir le puzzle
        if prev_lb and not lb and hover then
           -- print(pos[4], 1, 1, 12)  -- Affiche le nom du cadre cliqué
           indexMap = pos[4]
            updatePhase(1)
        end

        -- Récupère la MAP du puzzle actuel
        local puzzleMAP = pos[3]

        -- Vérifie que la MAP du puzzle existe
        if puzzleMAP then
            local rows = #puzzleMAP
            local cols = #puzzleMAP[1]

            -- Calcul de la taille des cellules
            local maxPuzzleSize = math.max(rows, cols)
            local cellSize = math.floor((iconSize - 8) / maxPuzzleSize)

            -- Calcul du point de départ pour centrer
            local startX = x + (iconSize - (cols * cellSize)) / 2
            local startY = y + (iconSize - (rows * cellSize)) / 2

            -- Dessine la miniature du puzzle
            for py = 1, rows do
                for px = 1, cols do
                    local color = puzzleMAP[py][px]
                    local posX = startX + (px - 1) * cellSize
                    local posY = startY + (py - 1) * cellSize

                    if color ~= 99 then
                        rect(posX, posY, cellSize, cellSize, color)
                    else
                        rect(posX, posY, cellSize, cellSize, 8) 
                    end
                end
            end
        end
    end

    -- Affichage des infos
    print("SELECT NEXT PUZZLE", 30 + ajustText, 1, 12)
    print(pagePuzzle, 140 + ajustText, 1, 12)
    print(" / " .. #tablePuzzle, 145 + ajustText, 1, 12)
end

function TIC()
    cls(0) -- Efface l'écran
    -- Récupère la position et état du clic
	mX, mY, lb, _, rb, scrollX, scrollY= mouse()

    -- Affiche les coordonné X et Y de la souris
	-- print(mX, 1,5,12)
	-- print(mY, 1,15,12)       

    -- Affiche les limites de l'écran 
    -- rectb(1,1,239,135,13) 

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
    ----------------------------- CHEAT KEY ------------------------
    -- RESET GRID touche T
    if key(20) then
        updatePhase(1)
    end

    -- SWAP PUZZLE touche U
    if key(21) then
        updatePhase(3)
    end

    -- MODE SOLUCE touche Q
    if key(17) then
        solucePuzzle = true
    end

    -- FIN DE PUZZLE touche E
    if key(5) then
        updatePhase(2)
    end
    ----------------------------- CHEAT KEY ------------------------

    -- ## SELECTION PUZZLE        
    if selectPuzzle then
        cls(0)

        -- Affiche la collection de puzzle débloqué
        nextPuzzle()

        -- Taille de la flèche pour changer de page
        local size = 7  

        -- next Page
        local rightX, rightY = 225, 72

        -- Vérifie si la souris est sur le triangle droit
        local hoverRight = mX >= rightX and mX <= rightX + size and mY >= rightY - size and mY <= rightY + size
        local rightColor = hoverRight and 3 or 12  -- Rouge si survolé, sinon couleur normale
        local rightBorderColor = 14  -- Rouge foncé pour la bordure

        -- Corps de la flèche (rectangle fait de deux triangles)
        if pagePuzzle <= pageMax - 1 then
            tri(rightX, rightY - size, rightX, rightY + size, rightX + size, rightY, rightColor) -- Triangle arrière
            trib(rightX, rightY - size, rightX, rightY + size, rightX + size, rightY, rightBorderColor) -- Bordure
        end

        -- Aller à la page suivante 
        if prev_lb and not lb and hoverRight then
            pagePuzzle = pagePuzzle + 1
            if pagePuzzle == pageMax + 1 then
                pagePuzzle = pageMax 
            end 
        end

        -- before Page
        local leftX, leftY = 15, 72

        -- Vérifie si la souris est sur le triangle gauche
        local hoverLeft = mX >= leftX - size and mX <= leftX and mY >= leftY - size and mY <= leftY + size
        local leftColor = hoverLeft and 3 or 12  -- Rouge si survolé, sinon couleur normale
        local leftBorderColor = 14  -- Rouge foncé pour la bordure

        -- Corps de la flèche (rectangle fait de deux triangles)
        if pagePuzzle >= 2 then
            tri(leftX, leftY - size, leftX, leftY + size, leftX - size, leftY, leftColor)  
            trib(leftX, leftY - size, leftX, leftY + size, leftX - size, leftY, leftBorderColor) 
        end

        -- Aller à la page précedente 
        if prev_lb and not lb and hoverLeft and pagePuzzle >= 0 then
            pagePuzzle = pagePuzzle - 1
            if pagePuzzle == 0 then
                pagePuzzle = 1
            end 
        end        

        -- Mettre à jour l'état précédent du bouton droit
        prev_lb = lb

    end


    -- ## BUILDING PUZZLE
    if buildingPuzzle then
        -- Affiche la grille
        drawGrid()
        
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
        print(pixCount, 210, 113, 12)
        -- Place le Slash entre le restant sur le total
        line(210, 128, 235, 115, 12)
        -- Affiche le total de pixel
        print(pixTotal, 220, 125, 12)

		-- Affiche le numéro et nom du puzzle
        print("#".. indexMap, 2, 3, 12)
        print(infoMAP[indexMap][6], 20, 3, 12)

        -- Icone Mode Soluce
        rect(16, 105, 25, 25, 8)
        rectb(16, 105, 25, 25, 13)

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

    -- ## Condition de VICTOIRE    
    -- Vérifier si MAP et GRID sont identiques avant d'appeler completePuzzle    
    if watchEqual(MAP, GRID) and endPuzzle then
        cls(0)

        -- Dessiner la grille
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
            colorY = 5  -- Changer la couleur de "Yes"
            print("Yes", yesX, yesY, colorY)
            if lb then 
                endPuzzle = false -- !! INDISPENSABLE POUR QUITTER LA BOUCLE ET CHANGER DE PHASE !!
                updatePhase(3)
            end
        end

        -- Si la souris survole "No"
        if mX >= noX and mX <= noX + noWidth and mY >= noY and mY <= noY + noHeight then
            colorN = 4  -- Changer la couleur de "No"
            print("No", noX, noY, colorN)
            if lb then 
                updatePhase(4)
            end
        end
    end

end