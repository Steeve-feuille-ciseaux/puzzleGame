-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

x = 100
listRect = {}

while (#listRect < x) do
	local r = {}
	r.larg = math.random(1,25)
	r.haut = math.random(1,25)
	r.x = math.random(0,239 - r.larg)
	r.y = math.random(0,135 - r.haut)
	r.color = math.random(1,15) 
	
	table.insert(listRect, r)
end

function TIC()

	cls(0)
	
	for i,v in ipairs(listRect) do
		rect(v.x, v.y, v.larg, v.haut, v.color)
	end
	
end
