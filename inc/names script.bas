
declare sub load_party_stats( ch as integer = 7, party_table( any ) as names_type, spells_table( any ) as names_type )

declare sub load_spells( spells_table( any ) as names_type )

redim shared party_table( any ) as names_type
redim shared spells_table( any ) as names_type

redim shared shops( any ) as names_type

sub load_party_stats( ch as integer = 7, party_table( any ) as names_type, spells_table( any ) as names_type )
	
	dim as string spellname = string$( 0, 0 )
	dim as string spelltemp = string$( 0, 0 )	

	dim as integer spell = 0, member = 0, stat = 0
	
	'spell knowledge
	dim as string spell_k = string$( 0, 0 ), spell_k_sync = string$( 0, 0 ), spellplus_k = string$( 0, 0 ), spellplus_k_sync = string$( 0, 0 )
	
	'spell experience
	dim as string spell_e = string$( 0, 0 ), spell_e_sync = string$( 0, 0 ), spellplus_e = string$( 0, 0 ), spellplus_e_sync = string$( 0, 0 )
	
	load_names "res\party.dat", party_table()
	load_names "res\spells.dat", spells_table()

	dim as integer spellcount = val( sync_names( "spell/count", spells_table() ) )
	
	redim preserve sas( 1 to spellcount ), nas( 1 to ch ), nimg( 1 to ch )
	redim preserve s( 1 to ch ), i( 1 to ch, 1 to spellcount ), k( 1 to ch, 1 to spellcount ), e( 1 to ch, 1 to spellcount )

	for spell = lbound( sas, 1 ) to ubound( sas, 1 ) step 1
		
		sas( spell ) = sync_names( "spell/906/" + ltrim$( str$( spell ) ) + "/sas", spells_table() )
			
		s(spell) = val( sync_names( "spell/906/" + ltrim$( str$( spell ) ) + "/s", spells_table() ) )
			
	next spell

	for member = lbound( i, 1 ) to ubound( i, 1 ) step 1
		
		nas( member ) = name_as_string( sync_names( "party/8" + ltrim$( str$( member ) ) + "0/nas", party_table() ) )

		nimg( member ) = ucase$( name_as_string( sync_names( "party/8" + ltrim$( str$( member ) ) + "0/nimg", party_table() ) ) )
		
		for stat = lbound( i, 2 ) to ubound( i, 2 ) step 1

			i( member, stat ) = val( sync_names( "party/8" + ltrim$( str$( member ) ) + "1" + "/Stat/" + ltrim$( str$( stat ) ), party_table() ) )
		
		next stat
		
		for spell = lbound( sas, 1 ) to ubound( sas, 1 ) step 1
			
			spellname = name_as_string( sas( spell ) )
			
			spelltemp = "party/8" + ltrim$( str$( member ) ) + ltrim$( str$( spell + 1 ) ) + "/" + spellname
			
			spell_k = spelltemp + "/k"
			spell_k_sync = sync_names( spell_k, party_table() )
						
			spellplus_k = spelltemp + "+/k"
			spellplus_k_sync = sync_names( spellplus_k, party_table() )
			
			if spellplus_k_sync <> "%%" then
				k( member, spell )= val( spellplus_k_sync )
			else
				k( member, spell )= val( spell_k_sync )
			end if

			spell_e = spelltemp + "/e"			
			spell_e_sync = sync_names( spell_e, party_table() )

			spellplus_e = spelltemp + "+/e"
			spellplus_e_sync = sync_names( spellplus_e, party_table() )
						
			if spellplus_e_sync <> "%%" then
				e( member, spell )= val( spellplus_e_sync )
			else
				e( member, spell )= val( spell_e_sync )
			end if

		next spell
	next member

end sub

sub load_spells( spells_table( any ) as names_type )

	load_names("res\spells.dat", spells_table() )
	
	dim as integer spellcount = val( sync_names( "spell/count", spells_table() ) )
	
	redim preserve sas( 1 to spellcount )
	redim preserve s( 1 to spellcount )
	
	dim as integer spell = 0

	for spell = lbound( sas, 1 ) to ubound( sas, 1 ) step 1

		sas( spell ) = name_as_string( sync_names( "spell/" + ltrim$( str$( 906 ) ) + "/" + ltrim$( str$( spell ) ) + "/sas", spells_table() ) )
		
		s( spell ) = val( sync_names( "spell/" + ltrim$( str$( 906 ) ) + "/" + ltrim$( str$( spell ) ) + "/s", spells_table() ) )

	next spell

end sub
