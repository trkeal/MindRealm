
declare sub encounter_hud( subject as string = "" )

'#ifdef __encounter_script__
declare sub encounter_sync( subject as string = "" )

declare sub encounter_text( subject as string = "" )

sub encounter_sync( subject as string = "" )
	redim text_table( 0 )

	dim as string buffer = string$( 0, 0 ), sep = string$( 1 , 32 ), dump = string$( 0, 0 )
	dim as integer counter = 0
	buffer = subject
	
	do while instr( 1, buffer, sep ) > 0
		
		counter += 1
		
		dump += "text/" + ltrim$( str$( counter ) ) + "=" + left$( buffer, instr( 1, buffer, sep ) - 1 ) + crlf
		
		buffer = mid$( buffer, instr( 1, buffer, sep ) + 1 )
	loop
				
	if len( buffer ) > 0 then
		counter += 1
		dump += "text/" + ltrim$( str$( counter ) ) + "=" + buffer + crlf
	end if
	
	dump = "text/count=" + ltrim$( str$( counter ) ) + crlf + dump
	
	call load_names_from_buffer( dump, text_table() )

#ifdef __encounter_debug__
	kill "res\encounter.txt"
	call save_names( "res\encounter.txt", text_table() )
#endif

end sub

sub encounter_text( subject as string = "" )
	
	call encounter_sync( subject )
	
	dim as integer x1 = 41, y1 = 26, x2 = 60, y2 = 45, w = 0, h = 0, textcount = 0, counter = 0, x = 1, y = 1

	dim as string chunk = string$( 0, 0 ), word = string$( 0, 0 ), buffer = string$( 0, 0 ), sep = string$( 1, 32 )

	buffer = subject
	
	w = x2 - x1 - 1
	h = y2 - y1 - 1
	
	call border( x1, y1, x2, y2, -1 )
	
	gtext y1+1, x1+1, 12, 4, "Encounter"
	
	y+=2
	
	textcount = val( sync_names( "text/count", text_table() ) )
		
	for counter = 1 to textcount step 1
		
		word = sync_names( "text/"+ltrim$(str$(counter)), text_table() )
		
		while len( chunk ) > w
			gtext y1+y, x1+x, 12, 4, left$(chunk,w)
			y+=1
			chunk = mid$(chunk,w+1)
		wend

		if len(chunk) > 0 then
			if len( chunk + sep + word ) > w then
				gtext y1+y, x1+x, 12, 4, chunk
				y+=1
				chunk = word
			else
				chunk += sep + word		
			end if
		else
			chunk = word		
		end if
	next counter
	
	if len(chunk) > 0 then
		gtext y1+y, x1+x, 12, 4, chunk
	end if
	
end sub
'#endif

sub encounter_hud( subject as string = "" )

	dim as integer x1 = 41, y1 = 26, x2 = 60, y2 = 45
	
	w = x2 - x1 + 1
	h = y2 - y1 + 1
	
	call border( x1, y1, x2, y2, -1 )
	
	call encounter_text( subject )
	'gtext y1, x1, 12, 4, subject

end sub
