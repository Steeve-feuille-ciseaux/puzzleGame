-- title:  TIC-Sweeper (OST Oscilloscope View)
-- author: Bentic, visual by StinkerB06
-- script: lua

track=0
music(track)

scale=8

function TIC()
	cls()

	if btnp(2,30,5) then
		if(scale>1) then
			scale = scale - 1
		end
	elseif btnp(3,30,5) then
		scale = scale + 1
	elseif btnp()~=0 then
		track = track + 1
		music(track%5)
	end

end