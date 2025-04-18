-- main.lua

local cellSize = 20
local cols, rows = 16, 16
local grid = {}
local animations = {}

local palette = {
    [0] = {1, 1, 1},       -- Blanc
    [1] = {0, 0, 0},       -- Noir
    [2] = {1, 0, 0},       -- Rouge
    [3] = {0, 1, 0},       -- Vert
    [4] = {0, 0, 1},       -- Bleu
    [5] = {1, 1, 0},       -- Jaune
    [6] = {1, 0, 1},       -- Magenta
    [7] = {0, 1, 1},       -- Cyan
    [8] = {0.5, 0.5, 0.5}, -- Gris
}

local currentColor = 1

function love.load()
    for y = 1, rows do
        grid[y] = {}
        animations[y] = {}
        for x = 1, cols do
            grid[y][x] = 0
            animations[y][x] = 0 -- pas d’animation initialement
        end
    end
end

function love.update(dt)
    -- Met à jour les animations
    for y = 1, rows do
        for x = 1, cols do
            if animations[y][x] > 0 then
                animations[y][x] = animations[y][x] - dt
                if animations[y][x] < 0 then
                    animations[y][x] = 0
                end
            end
        end
    end
end

function love.draw()
    for y = 1, rows do
        for x = 1, cols do
            local colorIndex = grid[y][x]
            local color = palette[colorIndex] or {1, 1, 1}
            local anim = animations[y][x]
            local scale = 1 + anim * 1.5 -- effet "pop"

            local px = (x - 1) * cellSize + cellSize / 2
            local py = (y - 1) * cellSize + cellSize / 2
            local size = cellSize * scale

            love.graphics.setColor(color)
            love.graphics.rectangle("fill", px - size / 2, py - size / 2, size, size)

            love.graphics.setColor(0.2, 0.2, 0.2)
            love.graphics.rectangle("line", (x - 1) * cellSize, (y - 1) * cellSize, cellSize, cellSize)
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Couleur actuelle : " .. currentColor, 10, rows * cellSize + 10)
end

function love.mousepressed(x, y, button)
    local gridX = math.floor(x / cellSize) + 1
    local gridY = math.floor(y / cellSize) + 1

    if gridX >= 1 and gridX <= cols and gridY >= 1 and gridY <= rows then
        if button == 1 then
            grid[gridY][gridX] = currentColor
            animations[gridY][gridX] = 0.2
        elseif button == 2 then
            grid[gridY][gridX] = 0
            animations[gridY][gridX] = 0.2
        end
    end
end

function love.wheelmoved(x, y)
    local maxColor = #palette
    if y > 0 then
        currentColor = (currentColor + 1) % (maxColor + 1)
    elseif y < 0 then
        currentColor = (currentColor - 1)
        if currentColor < 0 then
            currentColor = maxColor
        end
    end
end

function love.keypressed(key)
    local num = tonumber(key)
    if num and palette[num] then
        currentColor = num
    end
end
