SCREEN 9, 0, 1, 0: WIDTH 80: VIEW PRINT 1 TO 25: COLOR 15, 0: CLS
RANDOMIZE TIMER: RESTORE: CLOSE
CONST PI = 3.141592654#
start = TIMER
k = 1: kk = 1

pp = 25: ss = 7
DIM x(pp), y(pp), z(pp), v(3, 3)

xp = 0: yp = 0: zp = 0: vl = 25: sz = .35
xx = 639 * .5: yy = 639 * .5: zz = 349 * .5
xm = xx / sz: ym = yy / sz: zm = zz / sz
g1 = .21: 'tilt dirrection
g2 = .46: 'tilt

w1 = -1: w2 = -1

0 '

LINE (0, 0)-(639, 349), 0, BF
RESTORE

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
10 '

FOR p = 1 TO pp
READ xq, yq, zq
x(p) = xx + (xp + (xq * v(1, 1)) + (yq * v(2, 1)) + (zq * v(3, 1))) * sz
z(p) = zz + (zp + (xq * v(1, 3)) + (yq * v(2, 3)) + (zq * v(3, 3))) * sz
NEXT p

FOR s = 1 TO ss
READ sa, sb, sc, sd, se
LINE (x(sa), z(sa))-(x(sb), z(sb)), kk
LINE -(x(sc), z(sc)), kk
LINE -(x(sd), z(sd)), kk
LINE -(x(se), z(se)), kk
NEXT s

PCOPY 1, 0

c$ = INKEY$
sx = STICK(0)
sy = STICK(1)
IF sx > 110 THEN g1 = g1 + ((sx - 110) / 90) * (10 / 360): IF g1 > 1 THEN g1 = g1 - 1
IF sx < 90 THEN g1 = g1 - ((90 - sx) / 90) * (10 / 360): IF g1 < 0 THEN g1 = g1 + 1
IF sy > 110 THEN g2 = g2 + ((sy - 110) / 90) * (10 / 360): IF g2 > 1 THEN g2 = g2 - 1
IF sy < 90 THEN g2 = g2 - ((90 - sy) / 90) * (10 / 360): IF g2 < 0 THEN g2 = g2 + 1
xp = xp + v(1, 1) * vl: zp = zp + v(1, 3) * vl
IF c$ = CHR$(27) THEN SYSTEM
IF ABS(xp) > xm THEN xp = -xp
IF ABS(zp) > zm THEN zp = -zp

GOTO 0

'points

1001 DATA - 20,- 60,-  5
1002 DATA - 20,  60,-  5
1003 DATA   10,  60,-  5
1004 DATA   10,- 60,-  5

1005 DATA - 20,- 60,  10
1006 DATA - 20,  60,  10
1007 DATA   10,  60,  10
1008 DATA   10,- 60,  10

1009 DATA -100,-  6,   3
1010 DATA -100,   6,   3
1011 DATA   20,  10,   3
1012 DATA   20,- 10,   3

1013 DATA -100,-  6,   0
1014 DATA -100,   6,   0
1015 DATA - 10,  10,-  5
1016 DATA - 10,- 10,-  5

1017 DATA - 80,   0,   3
1018 DATA - 90,   0,  15
1019 DATA -110,   0,  18
1020 DATA -105,   0,   3

1021 DATA    0,   0,  10

1022 DATA - 90,- 19,   2
1023 DATA - 90,  19,   2
1024 DATA -110,  20,   2
1025 DATA -110,- 20,   2

'polygons

DATA   5,  6,  7,  8,  5

DATA   9, 10, 11, 12,  9

DATA   1,  2,  3,  4,  1

DATA  17, 18, 19, 20, 17

DATA  22, 23, 24, 25, 22

DATA  15, 11, 21, 12, 16

DATA  13, 14, 15, 16, 13

