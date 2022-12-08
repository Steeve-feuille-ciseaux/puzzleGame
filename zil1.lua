// title:  TIC-Sweeper (OST Oscilloscope View)
// author: Bentic, visual by StinkerB06
// script: js

var track=0
music(track)

var flr=Math.floor
var rnd=Math.round
// noise phase
var phase=1

var scale=8

const ADDR=0xFF9C
const CH=flr(128/4)

function isnoise(c)
{
	var sum=0
	for(var i=0;i<16;i++)
		sum+=peek(ADDR+18*c+2+i)

	return sum==0
}

function drawReg(x,y,c)
{
	var val=peek(ADDR+18*c+1)<<8|peek(ADDR+18*c)
	var pitch=(val&0x0fff)
	var vol=(val&0xf000)>>12

	if(pitch==0)return;


	var h=flr(CH/16)
	var prev=0
	var color=8+c
	var p={x:x,y:y}
	var f=flr(pitch/4)
	var noise=isnoise(c)
	var subd=0
	p.x = 120
	var first=true
	var prevx=-161615


	while(p.x<240) // from center of screen to right
	{
		var w=55/pitch*scale
		if(w==0)w=1
		for(var i=0;i<32;i++)
		{
			if(p.x+w>prevx || d!=prev){
				var amp=flr((peek4((ADDR+18*c+2)*2+i)-8)*(vol/15)) //amp=volume

				if(noise)
				{
					// noise is LFSR
					phase=phase||1
					phase=((phase&1)*(3<<13))^(phase>>1)
					amp=phase&1?-(vol/2):(vol/2)
				}

				var d=(flr(amp*31/15))

				if (first)
				{
					subd=d
					first=false
				}
				p.y=y-d

				if(!noise){

					//draw period

						rect(p.x,p.y,w+1,1,color) //x, y, width, height, color

					if(d!=prev && p.x!=120)
						line(p.x,p.y,p.x,p.y+(d-prev),color)
					}
					if(noise && p.x+w>prevx){
						if(d!=prev && p.x!=120){
							line(p.x,p.y,p.x,p.y+(d-prev),color)
						}
						line(p.x,p.y,p.x+w,p.y,color) //x, y, width, height, color
					}
				}
				prevx=Math.ceil(p.x)
				p.x=p.x+w
				prev=d
		}


	}
	prev=subd
	p.x=120
	while(p.x>0) // from middle to left
	{
		var w=55/pitch*scale
		if(w==0)w=1
		for(var i=31;i>=0;i--)
		{
			if(p.x-w<prevx || d!=prev){
				var amp=flr((peek4((ADDR+18*c+2)*2+i)-8)*(vol/15)) //amp=volume

				if(noise)
				{
					// noise is LFSR
					phase=phase||1
					phase=((phase&1)*(3<<13))^(phase>>1)
					amp=phase&1?-(vol/2):(vol/2)
				}

				var d=flr(amp*31/15)


				// draw pitch
				//rect(x+i*f,y-CH,1,CH,1)

				p.y=y-d


				if(!noise){
					//draw period
						rect(p.x-w,p.y,w+1,1,color) //x, y, width, height, color
					if(d!=prev && p.x!=0)
						line(p.x,p.y,p.x,p.y+(d-prev),color)
				}
				if(noise && p.x-w<prevx){
					if(d!=prev && p.x!=0){
						line(p.x,p.y,p.x,p.y+(d-prev),color)
					}
					line(p.x,p.y,p.x-w,p.y,color) //x, y, width, height, color
				}
			}
			prevx=flr(p.x)
			p.x=p.x-w
			prev=d

		}
	}



}

function TIC()
{
	cls()

	if(btnp(2,30,5))
	{
		if(scale>1)scale--
	}
	else if(btnp(3,30,5))
	{
		scale++
	}
	else if(btnp()!=0)
	{
		track++
		music(track%5)
	}
	rect(0,102,240,34,4)
	rect(0,0,240,34,3)
	rect(0,34,240,34,4)
	rect(0,68,240,34,3)


	for(var c=0;c<4;c++){

		drawReg(0,(c+1)*(34)-19,c)
	}
}
