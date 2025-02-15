-- title:   pixArt Puzzle
-- author:  Steeve-feuille-ciseaux
-- desc:    Puzzle in Pixel
-- site:    https://steeve-feuille-ciseaux.github.io/Portfolio/
-- license: 
-- version: 0.1
-- script:  lua
-- Thanks to HaPiter and maniek207 for sharing tool!

-- Variable
accSecond = 30
count = 00
listRect = {}
numberRect = 1
pieceS = 12
second = 0
sizeGrid = 0
startCount = false
x = 100

-- Stock le nombre de couleur differente
drawGrid = {}
drawGrid.up = false
drawGrid.color = 0

-- Nombre de rectangles par couleurs 
blackCount = 0
purleCount = 0
redCount = 0
orangeCount = 0
yellowCount = 0
green1Count = 0
green2Count = 0
green3Count = 0
blue1Count = 0
blue2Count = 0
blue3Count = 0
blue4Count = 0
whiteCount = 0
grey1Count = 0
grey2Count = 0
grey3Count = 0

-- Nombre maximum de rectangles par couleur
maxBlack = 0 
maxPurple = 0
maxRed = 10
maxOrange = 0
maxYellow = 0
maxGreen1 = 10
maxGreen2 = 0
maxGreen3 = 0
maxBlue1 = 0
maxBlue2 = 10
maxBlue3 = 0
maxBlue4 = 0
maxWhite = 10
maxGrey1 = 10
maxGrey2 = 0
maxGrey3 = 10

-- Ajouter les variables avec des valeurs > 0 dans le tableau
if maxBlack > 0 then
	drawGrid.up = true
	drawGrid.color = 0
	table.insert(drawGrid, maxBlack)
end
if maxPurple > 0 then
	drawGrid.up = true
	drawGrid.color = 1
	table.insert(drawGrid, maxPurple)
end
if maxRed > 0 then
	drawGrid.up = true
	drawGrid.color = 2
	table.insert(drawGrid, maxRed)
end
if maxOrange > 0 then
	drawGrid.up = true
	drawGrid.color = 3
	table.insert(drawGrid, maxOrange)
end
if maxYellow > 0 then
	drawGrid.up = true
	drawGrid.color = 4
	table.insert(drawGrid, maxYellow)
end
if maxGreen1 > 0 then
	drawGrid.up = true
	drawGrid.color = 5
	table.insert(drawGrid, maxGreen1)
end
if maxGreen2 > 0 then
	drawGrid.up = true
	drawGrid.color = 6
	table.insert(drawGrid, maxGreen2)
end
if maxGreen3 > 0 then
	drawGrid.up = true
	drawGrid.color = 7
	table.insert(drawGrid, maxGreen3)
end
if maxBlue1 > 0 then
	drawGrid.up = true
	drawGrid.color = 8
	table.insert(drawGrid, maxBlue1)
end
if maxBlue2 > 0 then
	drawGrid.up = true
	drawGrid.color = 9
	table.insert(drawGrid, maxBlue2)
end
if maxBlue3 > 0 then
	drawGrid.up = true
	drawGrid.color = 10
	table.insert(drawGrid, maxBlue3)
end
if maxBlue4 > 0 then
	drawGrid.up = true
	drawGrid.color = 11
	table.insert(drawGrid, maxBlue4)
end
if maxWhite > 0 then
	drawGrid.up = true
	drawGrid.color = 12
	table.insert(drawGrid, maxWhite)
end
if maxGrey1 > 0 then
	drawGrid.up = true
	drawGrid.color = 13
	table.insert(drawGrid, maxGrey1)
end
if maxGrey2 > 0 then
	drawGrid.up = true
	drawGrid.color = 14
	table.insert(drawGrid, maxGrey2)
end
if maxGrey3 > 0 then
	drawGrid.up = true
	drawGrid.color = 15
	table.insert(drawGrid, maxGrey3)
end

-- Affichage compteur rectangle par couleur et le nombre
for i, v in ipairs(drawGrid) do
	print("Valid max value: " .. #drawGrid)
end

-- formule collision
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
return x1 < x2+w2 and
		x2 < x1+w1 and
		y1 < y2+h2 and
		y2 < y1+h1
end

-- Remise a zero
function init()
	listRect = {}	
end

-- Counter
function counter()
	if count > 66 then
		second = second +1 
	end		
end

function TIC()

	cls(0)

	-- Counter
	if #listRect < x  then  
		if accSecond == 0 then
			count = count + 1 
			counter()
		elseif accSecond ~= 0 then
			count = count + 1 * accSecond
			counter()
		end	
	elseif #listRect == x then
		startCount = false
	end
	
	if count > 66 and #listRect < x then
		-- config des rectangle en dynamique
		local r = {}
		
		r.larg = pieceS
		r.haut = pieceS
		r.x = math.random(0,55 - r.larg)
		r.y = math.random(0,135 - r.haut)
		-- r.color = math.random(1,15)
		r.nb = numberRect
		r.autoPut = false
		r.find = false
		r.lock = false
		r.answerX = 58
		r.answerY = 10
	
		-- ajustement taille piece en corélation de la grille
		if sizeGrid == 100  then
			r.larg = pieceS + 6
			r.haut = pieceS
		end	

		-- Attribuer la couleur en fonction des compteurs
		if blackCount < maxBlack then
			r.color = 0 -- Noir
			blackCount = blackCount + 1
		elseif purleCount < maxPurple then
			r.color = 1 -- Violet
			purleCount = purleCount + 1
		elseif redCount < maxRed then
			r.color = 2 -- Rouge
			redCount = redCount + 1
		elseif orangeCount < maxOrange then
			r.color = 3 -- Orange
			orangeCount = orangeCount + 1
		elseif yellowCount < maxYellow then
			r.color = 4 -- Rouge
			yellowCount = yellowCount + 1
		elseif green1Count < maxGreen1 then
			r.color = 5 -- Vert claire
			green1Count = green1Count + 1
		elseif green2Count < maxGreen1 then
			r.color = 6 -- Vert normal
			green2Count = green2Count + 1
		elseif green3Count < maxGreen3 then
			r.color = 7 -- Vert foncé
			green3Count = green3Count + 1
		elseif blue1Count < maxBlue1 then
			r.color = 8 -- Bleu foncé
			blue1Count = blue1Count + 1
		elseif blue2Count < maxBlue2 then
			r.color = 9 -- Bleu marine
			blue2Count = blue2Count + 1
		elseif blue3Count < maxBlue3 then
			r.color = 10 -- Bleu foncé
			blue3Count = blue3Count + 1
		elseif blue4Count < maxBlue4 then
			r.color = 11 -- Bleu clair
			blue4Count = blue4Count + 1
		elseif whiteCount < maxWhite then
			r.color = 12 -- Blanc
			whiteCount = whiteCount + 1
		elseif grey1Count < maxGrey1 then
			r.color = 13 -- Gris clair
			grey1Count = grey1Count + 1
		elseif grey2Count < maxGrey2 then
			r.color = 14 -- Gris normal
			grey2Count = grey2Count + 1
		elseif grey3Count < maxGrey3 then
			r.color = 15 -- Gris foncé
			grey3Count = grey3Count + 1
		else
			r.color = 12
		end
	
        -- Ajouter le rectangle à la liste
        numberRect = numberRect + 1
        table.insert(listRect, r)

        -- Réinitialiser le compteur
        count = 0
	end 
	

	-- Afficher les rectangle
	for i,v in ipairs(listRect) do
		rect(v.x, v.y, v.larg, v.haut, v.color)
	end	

	-- Ajuster la position du chiffre selon le nombre restant
	if redCount >= 1 then
		rect(57, 5, 12, 12, 2)
		print("x"..redCount, 57, 5, 12)
	end

	for i,v in ipairs(drawGrid) do
		if drawGrid.up then
			rect(57, 15 * i, 12, 12, drawGrid.color)
		end
		print(#drawGrid, 57, 25, 12)
	end
	
	-- Affiche les coordonné X et Y de la souris
	mX,mY,lb,mb,rb,scrollX,scrollY= mouse()
	print(mX, 215,100,12)
	print(mY, 215,110,12)

end