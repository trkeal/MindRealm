
DECLARE SUB bsvszfix (filenamelist AS STRING)
DECLARE SUB vis2bsv (filename AS STRING, filenameout AS STRING)

SCREEN 7, 0, 0, 0
COLOR 15, 0
CLS

'
DIM names(1 TO 1) AS STRING
names(1) = "BOMB"

'
'names(1) = "CLST"
'names(2) = "DREK"
'names(3) = "JAKS"
'names(4) = "PHIL"
'names(5) = "PNDX"
'names(6) = "FURA"
'names(7) = "MORT"
'
DIM index AS INTEGER
FOR index = LBOUND(names, 1) TO UBOUND(names, 1) STEP 1
	LINE (0, 0)-(319, 199), 0, BF
	LOCATE 1, 3: PRINT LEFT$(names(index), 4);
	CALL vis2bsv(names(index) + "_001.08x", names(index) + "_001.TIL")
	SLEEP
NEXT index

SUB bsvszfix (filenamelist AS STRING)

'DIM filenamelist AS STRING
DIM filenamein AS STRING
DIM filenameout AS STRING
DIM filemode AS INTEGER
DIM r AS STRING

DIM tile(0 TO 8 * 8 / 2 + 5)  AS INTEGER
DIM w AS INTEGER, h AS INTEGER, x AS INTEGER, y  AS INTEGER

filemode = FREEFILE
OPEN filenamelist FOR INPUT AS #filemode
	DO
		 IF EOF(filemode) THEN
			EXIT DO
		END IF
		INPUT #filemode, filenamein
	
		x = 0
		y = 0
		w = 8
		h = 8
		
		LOCATE 3, 1
		PRINT VARSEG(tile(0))
		LOCATE 4, 1
		PRINT VARPTR(tile(0))
		LOCATE 5, 1
		PRINT 8 * 8 / 2 + 11
       
	DEF SEG = VARSEG(tile(0))
	BLOAD filenamein, VARPTR(tile(0))

	PUT (0, 0), tile(0), PSET

	GET (0, 0)-(7, 7), tile(0)

	LOCATE 3, 20
	PRINT VARSEG(tile(0))
	LOCATE 4, 20
	PRINT VARPTR(tile(0))
	LOCATE 5, 20
	PRINT 8 * 8 / 2 + 11
      
	filenameout = "bsvout\" + filenamein

	DEF SEG = VARSEG(tile(0))
	BSAVE filenameout, VARPTR(tile(0)), 8 * 8 / 2 + 11

	PUT ((2 - 1) * 8, (1 - 1) * 8), tile(0), PSET

	LOOP
CLOSE #filemode

END SUB

SUB vis2bsv (filename AS STRING, filenameout AS STRING)
	DIM tile(0 TO 8 * 8 / 2 + 5)  AS INTEGER
	DIM filemode AS INTEGER, w AS INTEGER, h AS INTEGER, x AS INTEGER, y  AS INTEGER
	x = 0
	y = 0
	w = 8
	h = 8
	DIM r  AS STRING
	r = STRING$(0, 0)
	
	filemode = FREEFILE
	OPEN filename FOR INPUT AS #filemode
		FOR y = 0 TO h - 1 STEP 1
		FOR x = 0 TO w - 1 STEP 1
			INPUT #filemode, r$
			PSET (x, y), VAL(r$)
		NEXT x
		NEXT y
	CLOSE #filemode
	GET (0, 0)-(w - 1, h - 1), tile(0)
	
	LOCATE 3, 1
	PRINT VARSEG(tile(0))
	LOCATE 4, 1
	PRINT VARPTR(tile(0))
	LOCATE 5, 1
	PRINT 8 * 8 / 2 + 11
       
	DEF SEG = VARSEG(tile(0))
	BSAVE filenameout, VARPTR(tile(0)), 8 * 8 / 2 + 11

	PUT ((2 - 1) * 8, (1 - 1) * 8), tile(0), PSET

END SUB

