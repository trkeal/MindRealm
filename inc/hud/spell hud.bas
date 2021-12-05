
declare sub spell_hud()

sub spell_hud()
''16XX 'spell display
	
	call border(41,1,60,25,-1)

	dim as integer xo=0, yo=0, is0 = 0, ip0 = 0
	dim as string co = ""
	
	dim as integer spellct = val( sync_names( "spell/count", gamedata_table() ) )

	if currentstats( p0, 1 ) = 0 then
		exit sub
	end if

	'render party member header
		
		xo = 42
		yo = 2
		co = memberimage(p0)
		call nimgput( xo, yo, co )

		xo = 44
		yo = 2
		co = membername(p0)
		call gtext( yo, xo, 15, 0, co )
	
	'render spells headers
	
		xo = 42
		yo = 4
		co = ucword( sync_names( "hud/spell", gamedata_table() ) )
		call gtext( yo, xo, 15, 0, co )

		xo = 50
		yo = 4
		co = ucase$( sync_names( "hud/knowledge", gamedata_table() ) )

		call gtext( yo, xo, 15, 0, co )

		xo = 57
		yo = 4
		co = ucase$( sync_names( "hud/experience", gamedata_table() ) )
		call gtext( yo, xo, 15, 0, co )


	'render spell stats
	
	for is0 = 1 to spellct step 1

		xo = 42
		yo = 6 + ( is0 - 1 ) * 2
		co = truncate( left$( str$( spellname( is0 ) ), 7 ), 3 )
		call gtext( yo, xo, 15, 0, co )

		xo = 50
		yo = 6 + ( is0 - 1 ) * 2
		co = truncate( left$( str$( knowledge( p0, is0 ) ), 2 ), 3 )
		call gtext( yo, xo, 15, 0, co )

		xo = 57
		yo = 6 + ( is0 - 1 ) * 2
		co = truncate( left$( str$( experience( p0, is0 ) ), 2 ), 3 )		
		call gtext( yo, xo, 15, 0, co )
					
	next is0
	
end sub
