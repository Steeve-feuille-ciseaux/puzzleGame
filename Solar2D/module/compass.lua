local compass = {}

-- Compteurs internes au module
local compteurNumber = 0
local compteurLetter = 0

-- Fonction pour incrémenter et afficher un nombre
function compass.number(x)
    compteurNumber = compteurNumber + 1
    print("Compass Number: " .. compteurNumber)
end

-- Fonction pour incrémenter et afficher une lettre majuscule
function compass.letter()
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    compteurLetter = compteurLetter + 1

    local function toLetters(n)
        local result = ""
        while n > 0 do
            local remainder = (n - 1) % 26
            result = alphabet:sub(remainder + 1, remainder + 1) .. result
            n = math.floor((n - 1) / 26)
        end
        return result
    end

    local letter = toLetters(compteurLetter)
    print("Compass Letter: " .. letter)
end

-- Fonction pour réinitialiser les compteurs
function compass.resetCounters()
    compteurNumber = 0
    compteurLetter = 0
end

return compass
