0 :
DIM SHARED v(1 TO 3, 1 TO 3)
CONST PI = 3.141592654#

SCREEN 7, 0, 1, 0

g1 = 0: w1 = 1
g2 = 0: w2 = 1

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

FOR ty = -5 TO 5
FOR tx = -5 TO 5

