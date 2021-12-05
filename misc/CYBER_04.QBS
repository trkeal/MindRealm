0 :
DIM SHARED v(1 TO 3, 1 TO 3)
DIM SHARED g(-5 TO 5, -5 TO 5)
CONST PI = 3.141592654#

SCREEN 7, 0, 1, 0

g1 = 0: w1 = 1
depth = .98
scale = 5

FOR ty = -5 TO 5 STEP 1
FOR tx = -5 TO 5 STEP 1
READ g(tx, ty)
NEXT tx
NEXT ty

DATA 11,11,11,11,11,11,11,11,11,11,11
DATA 11,03,03,03,03,03,03,03,03,03,11
DATA 11,03,03,03,03,03,03,00,00,03,11
DATA 11,03,03,03,00,00,00,00,00,03,11
DATA 11,03,03,00,00,05,00,00,00,03,11
DATA 11,03,03,00,05,15,05,00,00,00,11
DATA 11,03,00,00,00,05,00,00,00,00,11
DATA 11,03,00,00,00,00,00,00,00,03,11
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

FOR ty = -2 TO 2 STEP 1
FOR tx = -2 TO 2 STEP 1

IF g(tx, ty) <> 0 THEN

  GOSUB 200

  x = 10 * (ty - .4)
  y = 10 * (tx - .4)
  z = 10 * (-.4)
  x1 = (x * v(1, 1)) + (y * v(1, 2))
  y1 = (x * v(2, 1)) + (y * v(2, 2))
  z1 = z

  x = 10 * (ty + .4)
  y = 10 * (tx - .4)
  z = 10 * (-.4)
  x2 = (x * v(1, 1)) + (y * v(1, 2))
  y2 = (x * v(2, 1)) + (y * v(2, 2))
  z2 = z

  x = 10 * (ty + .4)
  y = 10 * (tx + .4)
  z = 10 * (-.4)
  GOSUB 200
  x3 = (x * v(1, 1)) + (y * v(1, 2))
  y3 = (x * v(2, 1)) + (y * v(2, 2))
  z3 = z

  x = 10 * (ty - .4)
  y = 10 * (tx + .4)
  z = 10 * (-.4)
  x4 = (x * v(1, 1)) + (y * v(1, 2))
  y4 = (x * v(2, 1)) + (y * v(2, 2))
  z4 = z

  x = 10 * (ty - .4)
  y = 10 * (tx - .4)
  z = 10 * (.4)
  x5 = (x * v(1, 1)) + (y * v(1, 2))
  y5 = (x * v(2, 1)) + (y * v(2, 2))
  z5 = z

  x = 10 * (ty + .4)
  y = 10 * (tx - .4)
  z = 10 * (.4)
  x6 = (x * v(1, 1)) + (y * v(1, 2))
  y6 = (x * v(2, 1)) + (y * v(2, 2))
  z6 = z

  x = 10 * (ty + .4)
  y = 10 * (tx + .4)
  z = 10 * (.4)
  x7 = (x * v(1, 1)) + (y * v(1, 2))
  y7 = (x * v(2, 1)) + (y * v(2, 2))
  z7 = z

  x = 10 * (ty - .4)
  y = 10 * (tx + .4)
  z = 10 * (.4)
  x8 = (x * v(1, 1)) + (y * v(1, 2))
  y8 = (x * v(2, 1)) + (y * v(2, 2))
  z8 = z

  x1 = INT(scale * x1 * depth ^ y1) + 159
  z1 = INT(scale * z1 * depth ^ y1) + 99
  x2 = INT(scale * x2 * depth ^ y2) + 159
  z2 = INT(scale * z2 * depth ^ y2) + 99
  x3 = INT(scale * x3 * depth ^ y3) + 159
  z3 = INT(scale * z3 * depth ^ y3) + 99
  x4 = INT(scale * x4 * depth ^ y4) + 159
  z4 = INT(scale * z4 * depth ^ y4) + 99
  x5 = INT(scale * x5 * depth ^ y5) + 159
  z5 = INT(scale * z5 * depth ^ y5) + 99
  x6 = INT(scale * x6 * depth ^ y6) + 159
  z6 = INT(scale * z6 * depth ^ y6) + 99
  x7 = INT(scale * x7 * depth ^ y7) + 159
  z7 = INT(scale * z7 * depth ^ y7) + 99
  x8 = INT(scale * x8 * depth ^ y8) + 159
  z8 = INT(scale * z8 * depth ^ y8) + 99

LINE (x1, z1)-(x2, z2), g(tx, ty)
LINE (x2, z2)-(x3, z3), g(tx, ty)
LINE (x3, z3)-(x4, z4), g(tx, ty)
LINE (x4, z4)-(x1, z1), g(tx, ty)

LINE (x5, z5)-(x6, z6), g(tx, ty)
LINE (x6, z6)-(x7, z7), g(tx, ty)
LINE (x7, z7)-(x8, z8), g(tx, ty)
LINE (x8, z8)-(x5, z5), g(tx, ty)

LINE (x1, z1)-(x5, z5), g(tx, ty)
LINE (x2, z2)-(x6, z6), g(tx, ty)
LINE (x3, z3)-(x7, z7), g(tx, ty)
LINE (x4, z4)-(x8, z8), g(tx, ty)

END IF

NEXT tx
NEXT ty

PCOPY 1, 0
GOTO 2


200 :

IF g1 <> w1 THEN

  C1 = COS(2 * PI * g1)
  S1 = SIN(2 * PI * g1)
 
  v(1, 1) = C1
  v(1, 2) = S1
 
  C2 = COS(2 * PI * (g1 + .75))
  S2 = SIN(2 * PI * (g1 + .75))

  v(2, 1) = C2
  v(2, 2) = S2

  w1 = g1

END IF

RETURN

