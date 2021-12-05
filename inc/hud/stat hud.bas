
declare sub stat_hud()

sub stat_hud()
''1600 'stat display
	
	call border(1,26,40,45,-1)
	
	redim as string statname( any )
	
	redim as names_type stats_table(any)
		
	load_names("res\stats.dat", stats_table())
	
	'load statistics count from file
	
	dim as integer xo=0, yo=0, is0 = 0, ip0 = 0, statct = val(sync_names("stat/count", stats_table())), chrow = 0
	
	dim as string co = ""
	
	redim statname( 1 to statct )

	'load statistics names from file
	for is0 = 1 to statct step 1
		statname( is0 ) = name_as_string( sync_names( "stat/" + right$( str$( is0 ), 1 )+"/name", stats_table() ) )
	next is0
	
	'render statistics headers
	for is0 = 1 to statct step 1
		
		xo = 2 + ( is0 - 1 ) * 7
		yo = 27
		co = truncate( left$( statname( is0 ), 5 ), 5 )		
		call gtext( yo, xo-2, 15, 0, co )
		
	next is0
	
	ip0 = 1
	chrow = 0
	for ip0 = 1 to ch step 1
		if currentstats( ip0, 1 ) > 0 then
			
			chrow += 1
			
			xo = 4
			yo = 26 + chrow * 2
			co = memberimage( ip0 )				
			call nimgput xo,yo,co
			
			xo = 6
			yo = 26 + chrow * 2
			co = membername( ip0 )		
			call gtext( yo, xo, 15, 0, co )
			
			for is0 = 1 to statct step 1
				
				xo = 2 + ( is0 - 1 ) * 7
				yo = 27 + chrow * 2
				co = truncate( str$( currentstats( ip0, is0 ) ), 3 )			
				call gtext( yo, xo, 15, 0, co )
				
			next is0
			
		end if
		
	next ip0
	
end sub
