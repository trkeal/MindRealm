0 :
DIM SHARED v(1 TO 3, 1 TO 3)
DIM SHARED g(-5 TO 5, -5 TO 5)
CONST PI = 3.141592654#

SCREEN 7, 0, 1, 0

g1 = 0: w1 = 1
g2 = .4: w2 = 1

FOR ty = -5 TO 5
FOR tx = -5 TO 5
READ g(tx, ty)
NEXT tx
NEXT ty

DATA 11,11,11,11,11,11,11,11,11,11,11
DATA 11,03,03,03,03,03,03,03,03,03,11
DATA 11,03,03,03,03,03,03,00,00,03,11
DATA 11,03,03,03,00,00,00,00,00,03,11
DATA 11,03,03,00,00,00,00,00,00,03,11
DATA 11,03,03,00,00,05,00,00,00,00,11
DATA 11,03,00,00,05,15,05,00,00,00,11
DATA 11,03,00,00,00,05,00,00,00,03,11
DATA 11,03,00,00,00,00,00,00,00,03,11
DATA 11,03,03,00,00,00,00,00,03,03,11
DATA 11,03,03,03,00,03,03,03,03,03,11
DATA 11,11,11,11,11,11,11,11,11,11,11

2 :

IF INKEY$ = CHR$(27) THEN END
g1 = g1 + .05: IF g1 > 1 THEN g1 = g1 - 1
'g2 = g2 + .05: IF g2 > 1 THEN g2 = g2 - 1
CLS
posx = (STICK(1) - 100) * .05
posy = (STICK(0) - 100) * .05
posz = 0

GOSUB 200

FOR ty = -5 TO 5
FOR tx = -5 TO 5

IF g(tx, ty) <> 0 THEN
 
  x = 10 * (ty - .4)
  y = 10 * (tx - .4)
  z = 10 * (-.4)
  
  x1 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y1 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x = 10 * (ty + .4)
  y = 10 * (tx - .4)
  z = 10 * (-.4)
  GOSUB 200
  x2 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y2 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x = 10 * (ty + .4)
  y = 10 * (tx + .4)
  z = 10 * (-.4)
  GOSUB 200
  x3 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y3 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x = 10 * (ty - .4)
  y = 10 * (tx + .4)
  z = 10 * (-.4)
  GOSUB 200
  x4 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y4 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x = 10 * (ty - .4)
  y = 10 * (tx - .4)
  z = 10 * (.4)
  GOSUB 200
  x5 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y5 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x = 10 * (ty + .4)
  y = 10 * (tx - .4)
  z = 10 * (.4)
  GOSUB 200
  x6 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y6 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x = 10 * (ty + .4)
  y = 10 * (tx + .4)
  z = 10 * (.4)
  GOSUB 200
  x7 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y7 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x = 10 * (ty - .4)
  y = 10 * (tx + .4)
  z = 10 * (.4)
  GOSUB 200
  x8 = (x * v(2, 1)) + (y * v(2, 2)) + (z * v(2, 3))
  y8 = (x * v(3, 1)) + (y * v(3, 2)) + (z * v(3, 3))

  x1 = 2 * x1 + 159
  y1 = 2 * y1 + 99
  x2 = 2 * x2 + 159
  y2 = 2 * y2 + 99
  x3 = 2 * x3 + 159
  y3 = 2 * y3 + 99
  x4 = 2 * x4 + 159
  y4 = 2 * y4 + 99
  x5 = 2 * x5 + 159
  y5 = 2 * y5 + 99
  x6 = 2 * x6 + 159
  y6 = 2 * y6 + 99
  x7 = 2 * x7 + 159
  y7 = 2 * y7 + 99
  x8 = 2 * x8 + 159
  y8 = 2 * y8 + 99

LINE (x1, y1)-(x2, y2), g(tx, ty)
LINE (x2, y2)-(x3, y3), g(tx, ty)
LINE (x3, y3)-(x4, y4), g(tx, ty)
LINE (x4, y4)-(x1, y1), g(tx, ty)

LINE (x5, y5)-(x6, y6), g(tx, ty)
LINE (x6, y6)-(x7, y7), g(tx, ty)
LINE (x7, y7)-(x8, y8), g(tx, ty)
LINE (x8, y8)-(x5, y5), g(tx, ty)

LINE (x1, y1)-(x5, y5), g(tx, ty)
LINE (x2, y2)-(x6, y6), g(tx, ty)
LINE (x3, y3)-(x7, y7), g(tx, ty)
LINE (x4, y4)-(x8, y8), g(tx, ty)

END IF

NEXT tx
NEXT ty

PCOPY 1, 0
GOTO 2


200 :

IF g1 = w1 AND g2 = w2 THEN 10

C1 = COS(2 * PI * (-g1))
S1 = SIN(2 * PI * (-g1))
C2 = COS(2 * PI * g2)
S2 = SIN(2 * PI * g2)

FOR p = 1 TO 3
IF p = 1 THEN x = 1: y = 0: z = 0
IF p = 2 THEN x = 0: y = 1: z = 0
IF p = 3 THEN x = 0: y = 0: z = 1
v(p, 1) = y * S1 + (z * S2 - x * C2) * C1
v(p, 2) = x * S1 - y * C1
v(p, 3) = x * S2 + z * C2
NEXT p

w1 = g1: w2 = g2
10 :

RETURN

