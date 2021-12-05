
declare sub dumpchar()

declare function imagescale( source as any ptr, destw as integer = 640, desth as integer = 480) as any ptr

sub dumpchar()

	dim as any ptr image = imagecreate(128,128,0,8)
	dim as any ptr zoom
	
	dim as integer o=0,col=0,row=0
	dim as string filename = string$(0,0)
	for o = 0 to 255
		row = fix(o/16)
		col = o mod 16
		filename = "tiles\"+RIGHT$(STR$(1000 + o), 3) + "b0808.til"
		sprite_put image, col*8, row*8, filename, "pset"	
	next o
	
	bsave ("tiles.bmp",image)
	
	zoom = imagescale( image, 320, 320 )

	put (0,0),zoom,pset

	bsave ("tilezoom.bmp",zoom)
	
	imagedestroy image
	imagedestroy zoom
	
	flip
	sleep
	
end sub

function imagescale( source as any ptr, destw as integer = 640, desth as integer = 480) as any ptr
		
	dim as integer sourcew = 320, sourceh = 200
	imageinfo source, sourcew, sourceh

	dim as any ptr dest = imagecreate ( destw, desth, 0, 8 )
	
	dim as integer sourcex = 0, sourcey = 0
	dim as integer destx = 0, desty = 0
			
	for desty = 0 to desth - 1 step 1
	for destx = 0 to destw - 1 step 1
		
		sourcex = ( destx * (sourcew - 1 ) ) / ( destw - 1 )
		sourcey = ( desty * (sourceh - 1 ) ) / ( desth - 1 )
		
		pset dest, ( destx , desty ), point ( sourcex, sourcey, source )
		
	next destx
	next desty
	
	imagescale = dest
	
end function
