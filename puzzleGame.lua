-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

-- Variable
countM = 0
pieceS = 12
x = 10
count = 0
second = 0
accSecond = 30
boxC = 0
numberRect = 1
numeroRect = 1
flash = 1
about = false
startCount = false
moveRect = false
Lock = false
readyMessage = true
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

-- Counter
function counter()
	if count > 66 then
		second = second +1 
	end		
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
	
	-- Afficher grid
	for i=0,100//l+1 do
		for j=0,100//l+1  do
			if a[i][j]==0 then
				rect(65+(l*i),10+(l*j),l,l,8)
				rectb(65+(l*i),10+(l*j),l,l,13)
					for p=0,100//l+1  do
						rect(70+(l*i),15+(l*p),2,2,13)
					end
			end
		end
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
  
  -- ajustement taille rect / number
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
 countM = countM + 1
 if #listRect == x then	
 print("valeur j : " .. tostring(readyMessage)
 																				.. countM
                     ,82,2)
  if flash <= 3 then
			if countM < 66 and readyMessage then	
				rect(80,50,76,21,12)
				print("PUZZLE PRET",82,58)				
			elseif countM == 66 then
				readyMessage = false				
			elseif countM == 86 then
				readyMessage = true
				countM = 0
				flash = flash + 1
			end
		end
		
 end
 
 -- menu deplacement Rectangle
 if moveRect then
 	local mvRect = listRect[numeroRect]
  
 	-- Selection rectangle  
		if mvRect.nb == 100  then
			rect(0,116,65,48,12)
		else
			rect(0,116,60,41,12)
		end
 	print("Select ",12,118)
 	print("piece n' " .. listRect[numeroRect].nb
																		,3,128)
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
   
	-- keyboard Haut
    if Lock and key((58)) then
        mvRect.y = mvRect.y - 1 
    end
    -- keyboard Bas
    if Lock and key((59)) then
        mvRect.y = mvRect.y + 1 
    end
    -- keyboard Gauche
    if Lock and key((60)) then
        mvRect.x = mvRect.x - 1 
    end
	-- keyboard Droite
    if Lock and key((61)) then
   		mvRect.x = mvRect.x + 1 
    end
 		
    -- mouse axe Y
    if Lock and lb then
    mvRect.y = mY - 7
    end
    -- mouse axe X
    if Lock and lb then
    mvRect.x = mX - 6
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
	if (keyp(13)) then
		if moveRect == true then
			moveRect = false
		else
			moveRect = true
		end
	end
	
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
	
    -- Extension souris
    mX,mY,lb,mb,rb= mouse()
end 