-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

-- Variable
x = 100
listRect = {}
count = 0
second = 0
accSecond = 30
boxC = 0
numberRect = 0
about = false
startCount = false

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
		if v.color == 8 or v.color == 15 then
			print(v.nb,v.x+1,v.y+1,12)
		else
			print(v.nb,v.x+1,v.y+1)
		end
	end
 
 if #listRect == x then
		rect(80,50,76,21,12)
 	print("TACHE TERMINE",82,58)
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
	if (key(48)) then
		if about == true then
			about = false
		else
			about = true
		end
	end
		
end 