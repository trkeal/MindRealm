0 :
DIM SHARED v(1 TO 3, 1 TO 3)
DIM SHARED g(-5 TO 5, -5 TO 5)
CONST pi = 3.141592654#

SCREEN 7, 0, 1, 0

g1 = 0: w1 = 1
depth = .98
scale = 5

2 :

IF INKEY$ = CHR$(27) THEN END
g1 = g1 + 1 / 64: IF g1 > 1 THEN g1 = g1 - 1
t = t + 66 / 64: IF t > 1 THEN t = t - 1
'g2 = g2 + .05: IF g2 > 1 THEN g2 = g2 - 1
CLS
posx = (STICK(1) - 100) * .05
posy = (STICK(0) - 100) * .05
posz = 0

GOSUB 200

r = 10
s = 6
a = .7
h = 10
d = 2
xx = 15
yy = 2
't = .7
FOR c = 0 TO 1 STEP 1 / s

  x = COS(2 * pi * (c + t)) * r * .7 + xx
  y = SIN(2 * pi * (c + t)) * r * .7 + yy
  z = d - h
  x5 = (x * v(1, 1)) + (y * v(1, 2))
  y5 = (x * v(2, 1)) + (y * v(2, 2))
  z5 = z

  x = COS(2 * pi * (c + t + (1 / s))) * r * .7 + xx
  y = SIN(2 * pi * (c + t + (1 / s))) * r * .7 + yy
  z = d - h
  x6 = (x * v(1, 1)) + (y * v(1, 2))
  y6 = (x * v(2, 1)) + (y * v(2, 2))
  z6 = z

  x = COS(2 * pi * (c + t + (1 / s))) * r + xx
  y = SIN(2 * pi * (c + t + (1 / s))) * r + yy
  z = d
  x7 = (x * v(1, 1)) + (y * v(1, 2))
  y7 = (x * v(2, 1)) + (y * v(2, 2))
  z7 = z

  x = COS(2 * pi * (c + t)) * r + xx
  y = SIN(2 * pi * (c + t)) * r + yy
  z = d
  x8 = (x * v(1, 1)) + (y * v(1, 2))
  y8 = (x * v(2, 1)) + (y * v(2, 2))
  z8 = z

  x5 = INT(scale * x5 * depth ^ y5) + 159
  z5 = INT(scale * z5 * depth ^ y5) + 99
  x6 = INT(scale * x6 * depth ^ y6) + 159
  z6 = INT(scale * z6 * depth ^ y6) + 99
  x7 = INT(scale * x7 * depth ^ y7) + 159
  z7 = INT(scale * z7 * depth ^ y7) + 99
  x8 = INT(scale * x8 * depth ^ y8) + 159
  z8 = INT(scale * z8 * depth ^ y8) + 99

LINE (x5, z5)-(x6, z6), 2
LINE (x6, z6)-(x7, z7), 2
LINE (x7, z7)-(x8, z8), 2
LINE (x8, z8)-(x5, z5), 2

NEXT c

PCOPY 1, 0
GOTO 2


200 :

IF g1 <> w1 THEN

  C1 = COS(2 * pi * g1)
  S1 = SIN(2 * pi * g1)
 
  v(1, 1) = C1
  v(1, 2) = S1
 
  C2 = COS(2 * pi * (g1 + .75))
  S2 = SIN(2 * pi * (g1 + .75))

  v(2, 1) = C2
  v(2, 2) = S2

  w1 = g1

END IF

RETURN

