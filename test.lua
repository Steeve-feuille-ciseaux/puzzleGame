-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

-- Variable
x = 100
count = 0
second = 0
accSecond = 30
boxC = 0
numberRect = 1
numeroRect = 1
about = false
startCount = false
moveRect = false
Lock = false
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


-- variable grille
l=12 
a={}
for i=0,100//l+1 do
	a[i]={}
	for j=0,100//l+1 do
		a[i][j]=0
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
	
	-- Afficher grille
	for i=0,100//l+1 do
		for j=0,100//l+1  do
			if a[i][j]==0 then
				rect(65+(l*i),10+(l*j),l,l,8)
				rectb(65+(l*i),10+(l*j),l,l,13)
			end
		end
	end

 if count > 66 and #listRect < x then
  -- config des rectangle en dynamique
  local r = {}
  
  r.larg = 10
  r.haut = 10
  r.x = math.random(0,55 - r.larg)
  r.y = math.random(0,135 - r.haut)
  r.color = math.random(1,15)
  r.nb = numberRect
  
  -- ajustement taille rect / number
  if numberRect >= 10  then
	  r.larg = 13
	  r.haut = 7
		end	
				
		if numberRect >= 100 then 
	  r.larg = 18
	  r.haut = 7 	
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
		if v.color == 8 or v.color == 15 then
			print(v.nb,v.x+1,v.y+1,12)
		else
			print(v.nb,v.x+1,v.y+1)
		end
	end
 
 -- Message fin de tache
 if #listRect == x and moveRect == false then
		rect(80,50,76,21,12)
 	print("TACHE TERMINE",82,58)
 end
 
 -- menu deplacement Rectangle
 if moveRect then
 	local mvRect = listRect[numeroRect]
  
 	-- Selection rectangle  
		rect(0,116,76,41,12)
 	print("Deplace Rect ",4,118)
 	print("Numero " .. listRect[numeroRect].nb
																		,10,128)
 	rect(mvRect.x, mvRect.y, mvRect.larg, mvRect.haut, mvRect.color)
 	rectb(mvRect.x-1, mvRect.y-1, mvRect.larg+1, mvRect.haut+1,12)
		print(mvRect.nb,mvRect.x+1,mvRect.y+1,12)
  	
  -- deplacement rectangle
  if mvRect.nb and Lock then
 		rect(mvRect.x, mvRect.y, mvRect.larg, mvRect.haut, mvRect.color)
 		rectb(mvRect.x-1, mvRect.y-1, mvRect.larg+1, mvRect.haut+1,0)
			print(mvRect.nb,mvRect.x+1,mvRect.y+1,0)
 		
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
		if (keyp(60)) and numeroRect > 1 then
			numeroRect = numeroRect - 1
		elseif (keyp(61	)) and numeroRect < #listRect then
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