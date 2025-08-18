local compass = {}

-- Fonction pour afficher un nombre
local compteurNumber = 0
function compass.number(_)
    compteurNumber = compteurNumber + 1
    print("Compass Number: " .. compteurNumber)
end

-- Fonction pour afficher une lettre
local compteurLetter = 0
local alphabet = {}
for c = 65, 90 do -- ASCII codes de 'A' à 'Z'
    table.insert(alphabet, string.char(c))
end

function compass.letter()
    compteurLetter = compteurLetter + 1
    if compteurLetter > #alphabet then
        compteurLetter = 1 -- revient à 'a' après 'z'
    end
    print("Compass Letter: " .. alphabet[compteurLetter])
end

return compass