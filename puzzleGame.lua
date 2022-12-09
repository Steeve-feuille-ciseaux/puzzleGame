	-- title:   Puzzle Game Children
	-- author:  Steeve-feuille-ciseaux
	-- desc:    Game for learn count from 1 to 100
	-- site:    https://steeve-feuille-ciseaux.github.io/Portfolio/
	-- license: 
	-- version: 0.1
	-- script:  lua
	-- Thanks to HaPiter and maniek207 for sharing tool!

	-- Variable
	endPuzzle = 0
	countM = 0
	pieceS = 12
	x = 100
	count = 0
	second = 0
	accSecond = 30
	boxC = 0
	numberRect = 1
	numeroRect = 1
	flash = 0
	about = false
	startCount = false
	moveRect = false
	Lock = false
	readyMessage = false
	stop = false
	placePiece = false
	goalPuzzle = false
	listRect = {}
	Cadre = {}
		Cadre.x = 60
		Cadre.y = 10
		Cadre.larg = 70
		Cadre.haut = 70

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

	-- TEST RATER
	function endgoal()
		for i,v in ipairs(listRect) do
			if listRect[x].find == true then
				endPuzzle = endPuzzle + 1
			end
		end
	end	

	-- Counter
	function counter()
		if count > 66 then
			second = second +1 
		end		
	end

	-- find piece
	function finish()
	end


	-- variable grid 
	l=12 
	a={}
	for i=0,100//l+1 do
		a[i]={}
		for j=0,100//l+1 do
			a[i][j]=0
				for p=0,100//l+1 do
					a[i][p]=0
				end
		end
	end

	-- Musique 
	
	function musique()
	end

	function TIC()

		-- Musique
		musique()
	
		musicLoop = true

		-- Extension souris
		mX,mY,lb,mb,rb,scrollX,scrollY= mouse()

		cls(0)

		if endPuzzle == x then 
			print("Finish !!!", 195,130)
		else
			print("Progress", 187,123)
			print(endPuzzle .. " / " .. tostring(x), 195,130)
		end

		local mvRect = listRect[numeroRect]
			
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
			r.color = math.random(1,15)
			r.nb = numberRect
			r.autoPut = false
			r.find = false
			r.lock = false
		
			-- ajustement taille piece / number
			if numberRect >= 100  then
				r.larg = pieceS + 6
				r.haut = pieceS
			end	
		
			-- Collision rectangle
			local ok = true
				
			-- fonction collision
			--[[
			for i,v in ipairs(listRect) do
			if CheckCollision(r.x,r.y,r.larg,r.haut,v.x,v.y,v.larg,v.haut) then
			ok = false
			boxC = boxC + 1
			end
			end	
			--]]
		
			-- ajouter les rectangle dans la liste
			if ok then   
				numberRect = numberRect + 1
				table.insert(listRect, r)
			end
			count = 0
		end 
	
		-- Show grid
		for i=0,100//l+1 do
			-- Focus grend put piece
			if Lock and mX >= 60 and mX <= 175
					and mY >= 12 and mY <= 130  then
					rectb((l*(mX//l)-2),(l*(mY//l)-2),l,l,5)
			end

			-- autofocus put on grid
			if Lock and lb == false and mvRect.autoPut == false
					and mvRect.x >= 54 and mvRect.x <= 173
					and mvRect.y >= 5 and mvRect.y <= 123  then
					mvRect.x = l*(mX//l)-2
					mvRect.y = l*(mY//l)-2
					mvRect.autoPut = true
		
				-- grid soluce
				local grid_X = 58
				local grid_Y = 10
				local adjust_mX = mX - grid_X
				local adjust_mY = mY - grid_Y
				local ligne = adjust_mX//l+1
				local colonne = (adjust_mY//l*10) 
				local resultat = ligne+colonne
					
					-- Count puzzle
					if ((mvRect.x-grid_X)//l+1)+((mvRect.y-grid_Y)//l*10) == mvRect.nb and mvRect.autoPut == true then
						mvRect.find = true
						endPuzzle = endPuzzle + 1
						mvRect.lock = true
					end
			end

			-- draw grid
			for j=0,100//l+1  do
				local nbCase = (i + 1) + (j * 10)

				if a[i][j]==0 then
					rect(58+(l*i),10+(l*j),l,l,8)
					rectb(58+(l*i),10+(l*j),l,l,13)
						for p=0,100//l+1  do
							rect(63+(l*i),15+(l*p),2,2,13)
						end
				elseif a[i][j]==1 then
					rect(58+(l*i),10+(l*j),l,l,10)
					rectb(58+(l*i),10+(l*j),l,l,9)
				end

				print(nbCase,58+(l*i),10+(l*j),12)
			end
		end
	
			--[[
			print("reste : ".. tostring(endPuzzle), 185,40)
			print("x : ".. tostring(adjust_mX//l+1), 185,50)
			print("y : ".. tostring(adjust_mY//l+1), 185,60)
			print("num : ".. tostring(resultat), 185,70)
			]]

			--[[
			if a[adjust_mX//l][adjust_mY//l]==0 then
				a[adjust_mX//l][adjust_mY//l]=1
				endPuzzle = endPuzzle + 1
			elseif	a[adjust_mX//l][adjust_mY//l]==1 then
					a[adjust_mX//l][adjust_mY//l]=0
					endPuzzle = endPuzzle - 1
			end
			--]]
		
	
		-- Afficher les rectangle
		for i,v in ipairs(listRect) do
			rect(v.x, v.y, v.larg, v.haut, v.color)
			-- gestion numero et couleur
			if v.nb < 10  then
				if v.color == 8 or v.color == 15 then
					print(v.nb,v.x+4,v.y+3,12)
				else
					print(v.nb,v.x+4,v.y+3)
				end
			end
			if v.nb >= 10 then 
				if v.color == 8 or v.color == 15 then
					print(v.nb,v.x+1,v.y+3,12)
				else
					print(v.nb,v.x+1,v.y+3)
				end
			end
		end
	
		-- Message fin de tache

		if stop == false then
			countM = countM + 1
		end
	
		if #listRect == x and flash == 0 then
				rect(80,50,76,21,12)
				print("PUZZLE READY",84,58)
				if countM > 400 then
					flash = flash + 1
					readyMessage = true
					countM = 0
				end
		end
	
		if flash >= 1 then				
			if countM < 30 and readyMessage then	
				print("DO THE PUZZLE",82,2)
			elseif countM == 40 then
				readyMessage = false				
			elseif countM == 45 then
				readyMessage = true
				countM = 0
				flash = flash + 1
			elseif flash == 4 then
				stop = true
				readyMessage = false
				print("DO THE PUZZLE",82,2)
				moveRect = true
			end
		end	
	
		-- menu deplacement Rectangle 
		if moveRect then
					

			-- how to play
			rect(180,2,60,20,12)
			if Lock == false then
				print("Select",192,4)
				print("use ",200,34,12)
				print("keyboard",186,42,12)
				print("arrow",195,50,12)
			else
				print("Move",198,4)
				print("use ",200,34,12)
				print("mouse",194,42,12)
				print("then switch",180,55,12)
				print("with",199,63,12)
				print("L or K",194,71,12)
			end

			-- Selection rectangle  
			if mvRect.nb >= 1 and mvRect.nb <= 9 then
				print("piece n' " .. listRect[numeroRect].nb
																				,186,14)
			elseif mvRect.nb >= 10 and mvRect.nb <= 99 then
				print("piece n' " .. listRect[numeroRect].nb
																				,183,14)
			elseif mvRect.nb >= 100 then
				print("piece n' " .. listRect[numeroRect].nb
																				,180,14)
			end														
				rect(mvRect.x, mvRect.y, mvRect.larg, mvRect.haut, mvRect.color)
				rectb(mvRect.x, mvRect.y, mvRect.larg, mvRect.haut,0)
		
			if mvRect.nb < 10  then
						print(mvRect.nb,mvRect.x+4,mvRect.y+3,0)
			else
					print(mvRect.nb,mvRect.x+1,mvRect.y+3,0)
			end	
	
			-- deplacement rectangle
			if mvRect.nb and Lock then
				rect(mvRect.x, mvRect.y, mvRect.larg, mvRect.haut, mvRect.color)
				rectb(mvRect.x, mvRect.y, mvRect.larg, mvRect.haut,12)
				if mvRect.nb < 10  then
						print(mvRect.nb,mvRect.x+4,mvRect.y+3,12)
				else
				print(mvRect.nb,mvRect.x+1,mvRect.y+3,12)
			end
			
			-- déplacement mouse 
			if Lock and lb and mvRect.lock == false  then
				mvRect.y = mY - 7
				mvRect.x = mX - 6
				mvRect.autoPut = false
			-- !! REPRENDRE ICI !! 
			elseif Lock and lb and mvRect.lock == true then
				mvRect.y = mvRect.y
				mvRect.x = mvRect.x
			end
		end
	
	end  
	
	-- Cadre du puzzle
	--[[
	rectb(Cadre.x,
							Cadre.y,
		Cadre.larg,
		Cadre.haut,
		12)
	--]]
		
	-- Menu Debug
	if about then
		rect(0,0,87,37,12)
		print("Frame : " .. tostring(accSecond)
																		.. " x " 
																			.. tostring(count)
																			,1,1)
		print("Time : " .. second
																		.. " sec"
																		,1,8)
		print("Rectangle : " .. #listRect,1,15)
		print("Collision : " .. boxC,1,23)
		print("limite : " .. x
																						.. " rect ",1,31)	
	end
	
	-- touche Espace
	if (keyp(48)) then
		if about == true then
			about = false
		else
			about = true
		end
	end		
	
	-- touche M
	--[[
	if (keyp(13)) then
		if moveRect == true then
			moveRect = false
		else
			moveRect = true
		end
	end
	--]]
	
	-- touche gauche/droite
	if Lock == false then
		if (keyp(60)) and numeroRect > 1
		or (key(59)) and numeroRect > 1 then
			numeroRect = numeroRect - 1
		elseif (keyp(61	)) and numeroRect < #listRect
		or (key(58)) and numeroRect < #listRect then
			numeroRect = numeroRect + 1
		end
	end
	
	-- touche L
	if (keyp(12)) or rb then
		if Lock == true then
			Lock = false
		else
			Lock = true
		end
	end
	
end 