
declare sub screen_scaler( sourcepage as integer = 0, destpage as integer = 1 )

sub screen_scaler( sourcepage as integer = 0, destpage as integer = 1 )
	
	dim as integer sourcew = 320, sourceh = 200
	dim as integer destw = 640, desth = 480
	
	dim as integer sourcex = 0, sourcey = 0
	dim as integer destx = 0, desty = 0
	
	dim as any ptr sourceimage = imagecreate( sourcew, sourceh, 0, 8 )

	get ( 0, 0 )-( sourcew - 1, sourceh - 1 ), sourceimage
	
	for desty = 0 to desth - 1 step 1
	for destx = 0 to destw - 1 step 1
		
		sourcex = ( destx * (sourcew - 1 ) ) / ( destw - 1 )
		sourcey = ( desty * (sourceh - 1 ) ) / ( desth - 1 )
		
		pset ( destx , desty ), point ( sourcex, sourcey, sourceimage )
		
	next destx
	next desty
	
	imagedestroy sourceimage
	
end sub
