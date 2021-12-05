DIM SHARED g01(201)

SCREEN 7

COLOR 15

FOR tt = 1 TO 12

LINE (0, 0)-(319, 199), 0, BF

READ in$
READ out$


OPEN in$ FOR INPUT AS 1
FOR y = 0 TO 15
FOR x = 0 TO 15
INPUT #1, r
IF r <> 0 THEN PSET (x, y), 15
NEXT x
NEXT y
CLOSE

GET (0, 0)-(15, 15), g01
 
  DEF SEG = VARSEG(g01(0)): BSAVE out$, VARPTR(g01(0)), 16 * 16 + 8

GET (100, 100)-(115, 115), g01

  DEF SEG = VARSEG(g01(0)): BLOAD out$, VARPTR(g01(0))

PUT (130, 70), g01

NEXT tt

SLEEP

DATA "ds1i1616.vis","ds1_1616.msk"
DATA "ds2i1616.vis","ds2_1616.msk"
DATA "ds3i1616.vis","ds3_1616.msk"
DATA "dn1i1616.vis","dn1_1616.msk"
DATA "dn2i1616.vis","dn2_1616.msk"
DATA "dn3i1616.vis","dn3_1616.msk"
DATA "dw1i1616.vis","dw1_1616.msk"
DATA "dw2i1616.vis","dw2_1616.msk"
DATA "dw3i1616.vis","dw3_1616.msk"
DATA "de1i1616.vis","de1_1616.msk"
DATA "de2i1616.vis","de2_1616.msk"
DATA "de3i1616.vis","de3_1616.msk"

SUB LoadCells

  DEF SEG = VARSEG(g01(0)): BLOAD "01.TIL", VARPTR(g01(0))

END SUB

