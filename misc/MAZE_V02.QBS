DIM SHARED g(16000)
DIM SHARED gr(1600)

AA = 5
DD = 17

x = 3
y = 16


FOR ty = 1 TO DD
FOR tx = 1 TO AA
READ gr(tx + (ty - 1) * AA)
NEXT tx
NEXT ty

DATA 01,01,01,01,01
DATA 01,00,00,01,01
DATA 01,01,00,00,01
DATA 01,00,00,01,01
DATA 01,00,00,01,01
DATA 01,01,00,00,01
DATA 01,01,00,01,01
DATA 01,01,00,00,01
DATA 01,00,00,00,01
DATA 01,00,00,00,01
DATA 01,00,00,01,01
DATA 01,01,00,01,01
DATA 01,01,00,01,01
DATA 01,01,00,01,01
DATA 01,01,00,00,01
DATA 01,00,00,01,01
DATA 01,01,01,01,01


SCREEN 7, 0, 1, 0

COLOR 15

FOR y = 16 TO 4 STEP -1

LINE (0, 0)-(319, 199), 0, BF

GET (100, 100)-(115, 115), g

LINE (159 - 20, 99 + 7)-(159 + 21, 99 + 21), 6, BF

IF gr(x - 1 + (y - 2 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_L3.CBG", VARPTR(g(0)): PUT (159 - 8, 99 - 8), g, OR
IF gr(x + 1 + (y - 2 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_R3.CBG", VARPTR(g(0)): PUT (159 + 6, 99 - 8), g, OR
IF gr(x + 0 + (y - 3 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F3.CBG", VARPTR(g(0)): PUT (159 - 5, 99 - 5), g, OR
IF gr(x - 1 + (y - 3 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F3.CBG", VARPTR(g(0)): PUT (159 - 16, 99 - 5), g, OR
IF gr(x + 1 + (y - 3 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F3.CBG", VARPTR(g(0)): PUT (159 + 6, 99 - 5), g, OR

IF gr(x - 1 + (y - 1 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_L2.CBG", VARPTR(g(0)): PUT (159 - 12, 99 - 12), g, OR
IF gr(x + 1 + (y - 1 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_R2.CBG", VARPTR(g(0)): PUT (159 + 9, 99 - 12), g, OR
IF gr(x + 0 + (y - 2 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F2.CBG", VARPTR(g(0)): PUT (159 - 8, 99 - 8), g, OR
IF gr(x - 1 + (y - 2 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F2.CBG", VARPTR(g(0)): PUT (159 - 25, 99 - 8), g, OR
IF gr(x + 1 + (y - 2 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F2.CBG", VARPTR(g(0)): PUT (159 + 9, 99 - 8), g, OR

IF gr(x - 1 + (y + 0 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_L1.CBG", VARPTR(g(0)): PUT (159 - 19, 99 - 19), g, OR
IF gr(x + 1 + (y + 0 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_R1.CBG", VARPTR(g(0)): PUT (159 + 13, 99 - 19), g, OR
IF gr(x + 0 + (y - 1 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F1.CBG", VARPTR(g(0)): PUT (159 - 12, 99 - 12), g, OR
IF gr(x - 1 + (y - 1 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F1.CBG", VARPTR(g(0)): PUT (159 - 37, 99 - 12), g, OR
IF gr(x + 1 + (y - 1 - 1) * AA) = 1 THEN DEF SEG = VARSEG(g(0)): BLOAD "wall_F1.CBG", VARPTR(g(0)): PUT (159 + 13, 99 - 12), g, OR

'PSET (159, 99), 10

LINE (159 - 20, 99 - 20)-(159 + 21, 99 + 21), 11, B

PCOPY 1, 0

c$ = INPUT$(1)

NEXT y

SLEEP

