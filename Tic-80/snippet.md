-- SNIPPET : Appliquer ce code dans un compilateur LUA


# obtenir MAP.COLOR, MAP.COLOR.NB, MAP.LARGEUR, MAP.HAUTEUR #

-- Remplacer l'exemple par votre dessin
local map =    {
					{99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,99,99,99,00,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,99,99,00,00,00,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,99,00,00,12,00,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,00,12,12,00,00,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,00,00,12,12,12,12,12,00,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,00,00,12,12,12,12,12,12,00,00,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,00,00,12,12,12,12,12,12,12,12,00,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,00,12,12,12,12,00,00,12,12,12,00,00,99,99,99,99,99,99,99,99,99,99},
					{99,00,00,12,12,12,00,04,00,12,12,12,12,00,99,99,99,99,99,99,99,99,99,99},
					{99,00,12,12,12,16,00,04,00,16,12,12,12,00,99,99,99,99,99,99,99,99,99,99},
					{99,00,12,00,12,16,00,03,00,16,16,00,12,00,99,99,99,99,99,99,99,99,99,99},
					{99,00,12,00,16,16,00,03,00,16,00,12,12,00,99,99,99,99,99,99,99,99,99,99},
					{99,00,12,12,00,00,00,03,00,00,12,12,00,00,99,99,99,99,99,99,99,99,99,99},
					{99,00,00,12,12,12,12,00,00,16,12,00,00,99,99,00,00,00,00,99,99,99,99,99},
					{99,99,00,00,00,00,12,12,00,16,12,00,99,99,00,00,07,07,06,00,00,99,99,99},
					{99,99,99,99,00,16,12,00,16,12,12,00,99,00,00,07,07,06,07,06,06,00,99,99},
					{99,99,99,99,00,16,12,00,16,12,12,00,00,00,07,07,06,07,07,06,00,06,00,99},
					{99,99,99,99,00,00,12,00,16,12,12,00,07,07,07,06,06,07,06,06,00,06,00,99},
					{99,99,99,99,99,00,12,00,16,12,00,07,07,07,06,06,07,07,06,00,06,06,00,99},
					{99,99,99,99,99,00,00,00,00,00,06,07,07,06,06,07,07,06,00,00,00,06,00,99},
					{99,99,99,99,99,00,06,06,06,00,06,07,06,06,07,07,07,06,00,99,99,00,00,99},
					{99,99,99,99,99,99,00,07,06,00,06,06,06,07,07,07,06,00,00,99,99,99,00,99},
					{99,99,99,99,99,99,00,07,00,06,06,07,07,07,07,06,00,00,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,06,07,07,07,07,06,00,00,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,06,07,07,07,06,00,00,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,06,07,06,06,00,00,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,06,06,00,00,00,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,06,00,00,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,00,00,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,07,00,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,00,00,00,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
					{99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99,99},
				}

local color = {}
local count_i = 0
local count_j = 0

-- Compter le nombre d'éléments sur la première ligne
for i = 1, #map[1] do
    count_i = count_i + 1
end

-- Compter le nombre d'éléments sur la première colonne
for j = 1, #map do
    count_j = count_j + 1
end

for i = 1, #map do
    for j = 1, #map[i] do
        local value = map[i][j]
        if value ~= 99 then
            local found = false
            for k = 1, #color do
                if color[k][1] == value then
                    color[k][2] = color[k][2] + 1
                    found = true
                    break
                end
            end
            if not found then
                table.insert(color, {value, 1})
            end
        end
    end
end

-- Construire les chaînes de caractères pour l'affichage
local numbers = "{"
local quantities = "{"

for i, pair in ipairs(color) do
    numbers = numbers .. string.format("%02d", pair[1])
    quantities = quantities .. pair[2]
    if i < #color then
        numbers = numbers .. ","
        quantities = quantities .. ","
    end
end

numbers = numbers .. "}"
quantities = quantities .. "}"

-- Afficher les résultats
print(numbers .. ", " .. quantities)
print("Nombre d'éléments sur la première ligne (i):", count_i)
print("Nombre d'éléments sur la première colonne (j):", count_j)

# Créer un tableau vierge selon la hauteur et la largeur #

local X = 24  -- Indiquer la largeur 
local Y = 34  -- Indiquer la hauteur 

local tableau = {}

for i = 1, Y do
    tableau[i] = {}
    for j = 1, X do
        tableau[i][j] = 99
    end
end

-- Affichage du tableau sans espaces inutiles
print("Largeur : "..X )
print("Hauteur : "..Y )
print("{")
for i = 1, Y do
    print("    {" .. table.concat(tableau[i], ",") .. "},")
end
print("}")

# Dev Mode #

----------------------------- devMode ------------------------
-- MODE SOLUCE touche Q
if key(17) then
    solucePuzzle = true
end

-- FIN DE PUZZLE touche E
if key(5) then
    GRID = MAP
end
----------------------------- CHEAT KEY ------------------------

## Explosion de pixel ##
ps = {}

function TIC()
 cls()
 local x, y, l = mouse()
 if l then
  for i=1,10 do
   local a = math.random()*6.28
   local s = math.random()*1 -- vitesses réduites
   ps[#ps+1] = {x=x, y=y, dx=math.cos(a)*s, dy=math.sin(a)*s, life=30}
  end
 end

 for i=#ps,1,-1 do
  local p = ps[i]
  p.x = p.x + p.dx
  p.y = p.y + p.dy
  p.life = p.life - 1
  pix(p.x, p.y, 15)
  if p.life <= 0 then table.remove(ps, i) end
 end
end