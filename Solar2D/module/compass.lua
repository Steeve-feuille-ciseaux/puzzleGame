-- module compass.lua

local compass = {}

local compteurNumber = 0
local compteurLetter = 0

local numberGroup = display.newGroup()
local letterGroup = display.newGroup()

-- Permet de reset les compteurs et de nettoyer les affichages
function compass.resetCounters()
    compteurNumber = 0
    compteurLetter = 0

    -- Supprimer les textes affichés
    for i = numberGroup.numChildren, 1, -1 do
        local child = numberGroup[i]
        if child and child.removeSelf then
            child:removeSelf()
        end
    end

    for i = letterGroup.numChildren, 1, -1 do
        local child = letterGroup[i]
        if child and child.removeSelf then
            child:removeSelf()
        end
    end
end

-- Affiche un nombre à l'écran de haut en bas
function compass.number(x, size, space)
    compteurNumber = compteurNumber + 1

    local y = 20 + (compteurNumber - 1) * space

    local txt = display.newText({
        text = tostring(compteurNumber),
        x = x,
        y = y,
        font = native.systemFontBold,
        fontSize = size
    })
    txt:setFillColor(1, 1, 1)
    numberGroup:insert(txt)
end

-- Convertit un index en lettre style Excel (A, B, ..., Z, AA, AB...)
local function toLetters(n)
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local result = ""
    while n > 0 do
        local remainder = (n - 1) % 26
        result = alphabet:sub(remainder + 1, remainder + 1) .. result
        n = math.floor((n - 1) / 26)
    end
    return result
end

-- Affiche les lettres à l'écran de haut en bas
function compass.letter(x, size, space)
    compteurLetter = compteurLetter + 1
    local letter = toLetters(compteurLetter)

    local x = 20 + (compteurLetter - 1) * space

    local txt = display.newText({
        text = letter,
        x = x,
        y = y,
        font = native.systemFontBold,
        fontSize = size
    })
    txt:setFillColor(1, 1, 1)
    letterGroup:insert(txt)
end

return compass
