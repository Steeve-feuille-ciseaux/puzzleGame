-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

-- Variable
x = 1000
listRect = {}
count = 0
second = 0
accSecond = 0
boxC = 0

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
	
	startCount = true
	
 -- Counter
 if accSecond == 0 then
		count = count + 1 
		counter()
	elseif accSecond ~= 0 then
		count = count + 1 * accSecond
		counter()
	end

 if count > 66 and #listRect < x then
  -- config des rectangle en dynamique
  local r = {}
  r.larg = math.random(2,4)
  r.haut = math.random(2,4)
  r.x = math.random(0,239 - r.larg)
  r.y = math.random(0,135 - r.haut)
  r.color = math.random(1,15) 
  
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
   table.insert(listRect, r)
  end
  count = 0
 end 
 
 if #listRect > x then
 	startCount = false
		rect(100,50,76,21,12)
 	print("TACHE TERMINE",100,50)
 end
 
	-- Afficher les rectangle
	for i,v in ipairs(listRect) do
		rect(v.x, v.y, v.larg, v.haut, v.color)
	end
	
	rect(0,0,84,29,12)
	print("Frame : " .. tostring(count)
																	 .. " x " .. tostring(accSecond)
																		,1,1)
	print("Second : " .. second,1,8)
	print("Rectangle : " .. #listRect,1,15)
	print("Collision : " .. boxC,1,23)
	
end 