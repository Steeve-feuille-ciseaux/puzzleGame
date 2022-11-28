-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

-- Variable
x = 10
listRect = {}
count = 0
second = 0
accSecond = 30
boxC = 0
numberRect = 0
numeroRect = 1
about = false
startCount = false
moveRect = false
Lock = false

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
  
  r.larg = 7
  r.haut = 7
  r.x = math.random(0,239 - r.larg)
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
  
  -- Trier les rectangle en collision dans la liste
  local ok = true	
  for i,v in ipairs(listRect) do
   if CheckCollision(r.x,r.y,r.larg,r.haut,v.x,v.y,v.larg,v.haut) then
    ok = false
    boxC = boxC + 1
   end
  end	
  
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
 	rect(mvRect.x-2, mvRect.y-2, mvRect.larg+4, mvRect.haut+4,12)
 	rect(mvRect.x-1, mvRect.y-1, mvRect.larg+2, mvRect.haut+2,0)
		print(mvRect.nb,mvRect.x+1,mvRect.y+1,12)
  	
  -- deplacement rectangle
  if mvRect.nb and Lock then
 		rect(mvRect.x, mvRect.y, mvRect.larg, mvRect.haut, mvRect.color)
 		rect(mvRect.x-2, mvRect.y-2, mvRect.larg+4, mvRect.haut+4,0)
 		rect(mvRect.x-1, mvRect.y-1, mvRect.larg+2, mvRect.haut+2,12)
			print(mvRect.nb,mvRect.x+1,mvRect.y+1,0)
 		
   if Lock and key((58)) then
   		mvRect.y = mvRect.y - 1 
   elseif Lock and key((59)) then
   		mvRect.y = mvRect.y + 1 
   elseif Lock and key((60)) then
   		mvRect.x = mvRect.x - 1 
   elseif Lock and key((61)) then
   		mvRect.x = mvRect.x + 1 
			end
   
  end
  
 end  
	
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
	
	-- Input keyboard
	if (keyp(48)) then
		if about == true then
			about = false
		else
			about = true
		end
	end		
		
	if (keyp(13)) then
		if moveRect == true then
			moveRect = false
		else
			moveRect = true
		end
	end
	
	if Lock == false then
		if (keyp(60)) and numeroRect > 1 then
			numeroRect = numeroRect - 1
		elseif (keyp(61	)) and numeroRect < #listRect then
			numeroRect = numeroRect + 1
		end
	end
	
	if (keyp(12)) then
		if Lock == true then
			Lock = false
		else
			Lock = true
		end
	end
	
end 