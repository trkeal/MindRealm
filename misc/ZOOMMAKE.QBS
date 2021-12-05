DIM SHARED gr(16000)

SCREEN 7

COLOR 15

FOR tt = 1 TO 9

LINE (0, 0)-(319, 199), 0, BF

READ in$
READ out$


OPEN in$ FOR INPUT AS 1
INPUT #1, AA
INPUT #1, DD
FOR y = 0 TO DD - 1
FOR x = 0 TO AA - 1
INPUT #1, r
PSET (x, y), r
NEXT x
NEXT y
CLOSE

GET (0, 0)-(AA - 1, DD - 1), gr
 
  DEF SEG = VARSEG(gr(0)): BSAVE out$, VARPTR(gr(0)), AA * DD + 8

GET (100, 100)-(115, 115), gr

  DEF SEG = VARSEG(gr(0)): BLOAD out$, VARPTR(gr(0))

PUT (159, 99), gr

NEXT tt

SLEEP

DATA "wall_L1.VDS","wall_L1.CBG"
DATA "wall_L2.VDS","wall_L2.CBG"
DATA "wall_L3.VDS","wall_L3.CBG"
DATA "wall_R1.VDS","wall_R1.CBG"
DATA "wall_R2.VDS","wall_R2.CBG"
DATA "wall_R3.VDS","wall_R3.CBG"
DATA "wall_F1.VDS","wall_F1.CBG"
DATA "wall_F2.VDS","wall_F2.CBG"
DATA "wall_F3.VDS","wall_F3.CBG"

