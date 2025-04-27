-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

screenW = display.contentWidth
screenH = display.contentHeight

count = 0

coucou = display.newText( {
    x = screenW / 2,
    y = screenH * 0.25,
    text="Hello World"
} )

button = display.newCircle( screenW/2, screenH/2, screenW * 0.2 )

function tap()
    count = count + 1
    coucou.text = "I was tapped "..tostring(count).." times"
end

button:addEventListener("tap", tap)