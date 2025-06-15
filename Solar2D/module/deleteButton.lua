-----------------------------------------------------------------------------------------
--
-- deleteButton.lua
--
-----------------------------------------------------------------------------------------

local N = {}

local group = display.newGroup()
local customCursorImage

local drawPixel = nil
local arrowList = nil
local map = nil
local cellSize = nil

-- Curseur personnalisé comme avant
local function onMouseMove(event)
    local x, y = event.x, event.y
    group.x, group.y = x, y
    group:toFront() -- 🔁 le curseur passe AU-DESSUS de tout
end

function N.setCustomCursor(imagePath, width, height, ancrageX, ancrageY)
    if customCursorImage then
        customCursorImage:removeSelf()
        customCursorImage = nil
    end

    customCursorImage = display.newImageRect(group, imagePath, width or 32, height or 32)
    customCursorImage.anchorX = ancrageX
    customCursorImage.anchorY = ancrageY
    customCursorImage.x, customCursorImage.y = 0, 0

    native.setProperty("mouseCursorVisible", false)

    -- ✅ Évite d'ajouter plusieurs listeners
    Runtime:removeEventListener("mouse", onMouseMove)
    Runtime:addEventListener("mouse", onMouseMove)
end


function N.removeCustomCursor()
    if customCursorImage then
        customCursorImage:removeSelf()
        customCursorImage = nil
    end
    native.setProperty("mouseCursorVisible", true)
    Runtime:removeEventListener("mouse", onMouseMove)
end

-- HSV → RGB conversion (copié tel quel)
local function hsvToRgb(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return r, g, b
end

-- Bouton jaune + animation
local yellowButton = display.newCircle(30, display.contentHeight - 150, 12.5)
yellowButton:setFillColor(1, 1, 0)

local yellowButtonText = display.newText({
    text = "Effacer",
    x = 100,
    y = display.contentHeight - 150,
    font = native.systemFont,
    fontSize = 30,
    align = "right"
})

local hue = 0
local blinkTimerId = timer.performWithDelay(100, function()
    if deletePix then
        hue = (hue + 0.08) % 1
        local r, g, b = hsvToRgb(hue, 1, 1)
        yellowButton:setFillColor(r, g, b)
    else
        yellowButton:setFillColor(1, 1, 0)
    end
end, 0)

function N.cancelBlinkTimer()
    if blinkTimerId then
        timer.cancel(blinkTimerId)
        blinkTimerId = nil
    end
end

-- Met à jour le mode suppression et le curseur personnalisé
local function updateDeleteMode(isDelete)
    deletePix = isDelete
    if deletePix then
        drawPixel = nil
        N.setCustomCursor("img/crossRed.png", 32, 32, 0.5, 0.5)
        -- Cacher les flèches si arrowList défini
        if arrowList then
            for _, a in ipairs(arrowList) do
                a.isVisible = false
            end
        end
    else
        if map and currentIndex and map.data and map.data.colors then
            drawPixel = map.data.colors[currentIndex]
        end
        N.setCustomCursor("img/penIcon.png", 32, 32, 0, 1)
        -- Afficher flèche active
        if arrowList and currentIndex and arrowList[currentIndex] then
            arrowList[currentIndex].isVisible = true
        end
    end
end

local function onYellowButtonClick(event)
    if event.phase == "ended" then
        updateDeleteMode(not deletePix)
    end
    return true
end

yellowButton:addEventListener("touch", onYellowButtonClick)

-- Fonction d'initialisation pour passer les variables depuis main.lua
function N.init(params)
    map = params.map
    arrowList = params.arrowList
    currentIndex = params.currentIndex
    -- Met à jour le curseur initial
    updateDeleteMode(false)
end

function N.updateDeleteMode(isDelete)
    updateDeleteMode(isDelete)
end

N.yellowButton = yellowButton
N.yellowButtonText = yellowButtonText

return N