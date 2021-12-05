LET Soundon = false

LET pause = false

dim shared as integer randomizer = 325

randomizer = val(sync_names( "randomizer", gamedata_table() ) )

'if randomizer = 0 then
'	randomizer = 325
'end if

LET randomizerseed = fix(randomizer * ( timer - fix( timer ) ) )
 
 locate 1, 1
 
  call gtext( csrlin, pos(), 9, 0, "Timer:" )
  locate csrlin+1, pos()
  'PRINT "Timer:"
'LET time$ = "00:00:00"
'TIMER ON

  call gtext( csrlin, pos(), 9, 0, chr$(&HFE)+" " + STR$(TIMER) )
  locate csrlin+1, pos()
  'PRINT (chr$(&HFE)+" " + STR$(TIMER))

  call gtext( csrlin, pos(), 9, 0, chr$(&HFE)+" initialized" )  
  locate csrlin+1, pos()
  'PRINT (chr$(&HFE)+" initialized")
  
  call gtext( csrlin, pos(), 9, 0, chr$(&HFE)+" activated" )
  locate csrlin+1, pos()
  'PRINT (chr$(&HFE)+" activated")

'RRRR = TIMER

RANDOMIZE randomizerseed

  call gtext( csrlin, pos(), 9, 0, chr$(&HFE)+" randomized " + STR$(randomizerseed) )
  locate csrlin+1, pos()
  'PRINT (chr$(&HFE)+" randomized " + STR$(randomizerseed))
 
  call gtext( csrlin, pos(), 9, 0, "Time:" )
  locate csrlin+1, pos()
  'PRINT "Time:"

  call gtext( csrlin, pos(), 9, 0, chr$(&HFE)+" " + TIME$ )
  locate csrlin+1, pos()
  'PRINT (chr$(&HFE)+" " + TIME$)

  call gtext( csrlin, pos(), 9, 0, "Date:" )
  locate csrlin+1, pos()
  'PRINT "Date:"

  call gtext( csrlin, pos(), 9, 0, chr$(&HFE)+" " + DATE$ )
  locate csrlin+1, pos()
  'PRINT (chr$(&HFE)+" " + DATE$)

  call gtext( csrlin, pos(), 9, 0, "Press the spacebar to start..." )
  locate csrlin+1, pos()
  'PRINT "Press the spacebar to start..."

c$ = ""
WHILE c$ <> CHR$(32)
  c$ = INKEY$
  IF c$ = CHR$(27) THEN END
  IF c$ = "@" THEN
#ifdef __old_graphics__
	SCREEN 7, 0, 0, 0
    #else
	screenres 320,200,8,8
	screenset 0,0
#endif

INPUT "seed:"; randomizerseed
    RANDOMIZE randomizerseed
    #ifdef __old_graphics__
		SCREEN 7, 0, 0, 1
    #else
		screenres 320,200,8,8
		screenset 0,1
	#endif
	c$ = " "
  END IF
WEND
