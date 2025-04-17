-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

x = 100
listRect = {}

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

while (#listRect < x) do
	local r = {}
	r.larg = math.random(1,25)
	r.haut = math.random(1,25)
	r.x = math.random(0,239 - r.larg)
	r.y = math.random(0,135 - r.haut)
	r.color = math.random(1,15) 
	
	local ok = true
	
	for i,v in ipairs(listRect) do
		if CheckCollision(r.x,r.y,r.larg,r.haut,v.x,v.y,v.larg,v.haut) then
			ok = false
		end
	end	
	
	
	if ok then
		table.insert(listRect, r)
	end
end

function TIC()

	cls(0)
	
	for i,v in ipairs(listRect) do
		rect(v.x, v.y, v.larg, v.haut, v.color)
	end
	
end
