
'Mindrealm 97a: Copyright 1997, 2021 Tim Keal

#include once "inc\fb header.bas"
#include once "inc\graphics.bas"

dim shared about_table(any) as names_type

call load_names( ".\res\about.dat", about_table() )

dim shared as string gametitle
'gametitle = "Mindrealm 97a"
gametitle = name_as_string( sync_names("gametitle", about_table() ) )

dim shared as string copyright
'copyright = "Copyright 1997, 2021 Tim Keal"
copyright = name_as_string( sync_names("copyright", about_table() ) )

DECLARE SUB StringPut (XXXX as integer = 0, YYYY as integer = 0, GGGG as string = "" )

declare sub nimgput( x0 as integer = 1, y0 as integer = 1, c0 as string = "" )

redim shared as names_type shops_table( any )
load_names "res\shops.dat", shops_table()
dim shared as integer shopi = 0

dim shared as integer ch = 0, x0 = 0, y0 = 0

declare function pickup( subject as string = "" ) as string

declare function gtext_true_len(subject as string) as integer

declare sub gtext( row as integer = 1, col as integer = 1, fg as integer = 9, bg as integer = 0, subject as string = "" )

DIM AS INTEGER ii = 0

REDIM AS INTEGER lxa(0 TO 12), lya( 0 TO 12)


DIM SHARED g01(201)
DIM SHARED goa$(32, 2)

dim as integer tempcol = 13, temprow = 11
dim as string tempstr
tempstr = "{ " + gametitle + " }"

#ifdef __old_graphics__
	DECLARE SUB GraphicPut (XXXX, YYYY, GGGG$)
#endif

ch = 7: 'number of characters (party members)
p0 = 1: 'current player in party
ic = 10: '15 ''?? item count?

dim as string sptemp = string$( 0, 0 )
DIM SHARED g(25, 40): 'realm
DIM SHARED v(25, 40): 'realm
DIM SHARED l(25, 40): 'realm
DIM SHARED ta$(3): 'terrein type list
DIM SHARED ca$(3)
DIM SHARED d(4, 2): 'filename vectors (n,e,s,w)
'DIM SHARED nas(ch): 'character names
DIM SHARED z(ch, 6): 'character status (hp,ap,dp,mp,sight,scent)
'DIM SHARED i(ch, 6): 'character
'DIM SHARED k(ch, 6): 'character spell knowledge
'DIM SHARED e(ch, 6): 'character spell experience
'DIM SHARED sas(6): 'spell names
'DIM SHARED s(6): 'spell

redim shared as string sas( any ), nas( any ), nimg( any )
redim shared as integer s( any ), i( any, any ), k( any, any ), e( any, any )

#include once "inc\names script.bas"

load_party_stats ch, party_table(), spells_table()
load_spells spells_table()

RESTORE

'[!!]'===mouse===

'KEY OFF
#ifdef __old_graphics__
SCREEN 7, 0, 0, 0
WIDTH 40
VIEW PRINT 1 TO 25
COLOR 15, 0
CLS
#else
	screenres 320,200,8,8
	screenset 0,0
#endif

'[!!]'===drivers===

LET TTTT = 1000
LET speed = .1

'[!!]'===randomizer===

#include once "inc\random.bas"

'dumpchar

dim as integer levelct = 0

0 :
'KEY OFF
#ifdef __old_graphics__
	SCREEN 7, 0, 0, 1
	WIDTH 40
	VIEW PRINT 1 TO 25
	COLOR 15, 0
	CLS
#else
	screenres 320,200,8,8
	screenset 0,1
#endif

''take out line below
''1 ch = 7: p0 = 1: ic = 10: '15

''take out line below
''2 DIM g(25, 40), v(25, 40), l(25, 40), ta$(3), ca$(3), d(4, 2), nas(ch), z(ch, 6), i(ch, 6), k(ch, 6), e(ch, 6), sas(6), s(6)

4
#ifdef __old_graphics__
	SCREEN 7, 0, 0, 1
#else
	screenres 320,200,8,8
	screenset 0,1
#endif

GOSUB 700

5 GOSUB 1400: p0 = r0: go = 0: ky = 0: bm = 0: m0i = 1
6

GOSUB 250

tempstr = "{ " + gametitle + " }"
tempcol = ( 20 - len( tempstr ) / 2 )
temprow = 25 / 2

CALL StringPut( ( tempcol - 1 ) * 8, ( temprow - 1 ) * 8, tempstr )

tempstr = copyright
tempcol = ( 20 - len( tempstr ) / 2 )
temprow = 25 / 2 + 2

CALL StringPut( ( tempcol - 1 ) * 8, ( temprow - 1 ) * 8, tempstr )

COLOR 15, 0
SCREENCOPY 0, 2

SCREENCOPY 0, 1

sleep

10 dg = 0
11 dg = dg + 1: r = INT(RND(1) * 10) + 1 + 25: rr = INT(RND(1) * r) + 1
12 mr = INT(RND(1) * 3): m0i = INT(RND(1) * 18) + 1: ic = INT(RND(1) * 8) + 8
13 GOSUB 250

35 :
levelct += 1
FOR yy = 2 TO 24
SCREENCOPY 0, 3
SCREENCOPY 2, 0

call stringput( ( 5 - 1 ) * 8, ( 18 - 1 ) * 8, "Please wait..." )
'LOCATE 18, 5: PRINT "Please wait...";

LINE ((5 - 1) * 8, (20 - 1) * 8)-((5 + 30) * 8 - 1, 20 * 8 - 1), 8, BF
LINE ((5 - 1) * 8, (20 - 1) * 8)-((5 + ((yy - 1) / 23 * 30)) * 8 - 1, 20 * 8 - 1), 10, BF
LINE ((5 - 1) * 8, (20 - 1) * 8)-((5 + 30) * 8 - 1, 20 * 8 - 1), 15, B
SCREENCOPY 0, 1
SCREENCOPY 3, 0
FOR xx = 2 TO 39
g(yy, xx) = ASC("°"): g0 = 0: g1 = 0: v(yy, xx) = 0: l(yy, xx) = 0
36 c3 = 0: x0 = xx: y0 = yy: GOSUB 200: NEXT xx: NEXT yy
37 FOR rm = 1 TO r: COLOR 15, 0

38 xs = INT(RND(1) * 6) + 2: ys = INT(RND(1) * (20 / xs)) + 2: IF ys > 7 THEN ys = 7
39 x = INT(RND(1) * (40 - xs - 3)) + 3: y = INT(RND(1) * (25 - ys - 3)) + 3
40 NP = 0: FOR xx = x TO x + xs - 1: FOR yy = y TO y + ys - 1

41 s$ = CHR$(g(yy, xx))
42 ll = 0: GOSUB 100: IF ll = 1 THEN NP = 1
43 :
NEXT yy

NEXT xx
  
   IF rm > 1000 THEN
    
     xxx1 = x - 2
     xxx2 = x + xs + 1
     IF xxx1 < 2 THEN xxx1 = 2
     IF xxx2 > 39 THEN xxx2 = 39
     yyy1 = y - 2
     yyy2 = y + ys + 1
     IF yyy1 < 2 THEN yyy1 = 2
     IF yyy2 > 24 THEN yyy2 = 24

     FOR xx = xxx1 TO xxx2
      
       FOR yy = yyy1 TO yyy2
        
         IF ((xx = x - 2) OR (xx = x + xs + 1) OR (yy = y - 2) OR (yy = y + ys + 1)) THEN
           s$ = CHR$(g(yy, xx))
          
           ll = 0
           GOSUB 100
          
           IF ll = 0 THEN
            
             NP = 1
          
           END IF
        
         END IF
      
       NEXT yy
    
     NEXT xx
  
   END IF

44 IF NP = 1 THEN 38
50 :
FOR xx = x TO x + xs - 1

FOR yy = y TO y + ys - 1
51 c3 = 1: x0 = xx: y0 = yy: GOSUB 200
52 NEXT yy: NEXT xx
53 dn = 0: de = 0: ds = 0: dw = 0: FOR xx = x TO x + xs - 1: FOR yy = y TO y + ys - 1


54 s1$ = CHR$(g(yy - 2, xx)): s2$ = CHR$(g(yy - 1, xx))
55 ll = 0: GOSUB 150: GOSUB 160: IF ll = 2 AND dn = 1 THEN dn = 0
56 ll = 0: GOSUB 110: GOSUB 160: IF ll = 2 AND dn = 0 THEN c3 = 2: y0 = yy - 1: x0 = xx: GOSUB 200: dn = 1

57 s1$ = CHR$(g(yy, xx + 2)): s2$ = CHR$(g(yy, xx + 1))
58 ll = 0: GOSUB 150: GOSUB 160: IF ll = 2 AND de = 1 THEN de = 0
59 ll = 0: GOSUB 110: GOSUB 160: IF ll = 2 AND de = 0 THEN c3 = 2: y0 = yy: x0 = xx + 1: GOSUB 200: de = 1

60 s1$ = CHR$(g(yy + 2, xx)): s2$ = CHR$(g(yy + 1, xx))
61 ll = 0: GOSUB 150: GOSUB 160: IF ll = 2 AND ds = 1 THEN ds = 0
62 ll = 0: GOSUB 110: GOSUB 160: IF ll = 2 AND ds = 0 THEN c3 = 2: y0 = yy + 1: x0 = xx: GOSUB 200: ds = 1

63 s1$ = CHR$(g(yy, xx - 2)): s2$ = CHR$(g(yy, xx - 1))
64 ll = 0: GOSUB 150: GOSUB 160: IF ll = 2 AND dw = 1 THEN dw = 0
65 ll = 0: GOSUB 110: GOSUB 160: IF ll = 2 AND dw = 0 THEN c3 = 2: y0 = yy: x0 = xx - 1: GOSUB 200: dw = 1


66 s1$ = CHR$(g(yy - 1, xx - 1)): s2$ = CHR$(g(yy - 1, xx)): s3$ = CHR$(g(yy, xx - 1))
67 ll = 0: GOSUB 110: GOSUB 160: GOSUB 170: IF ll = 3 THEN c3 = 2: y0 = yy - 1: x0 = xx: GOSUB 200

68 s1$ = CHR$(g(yy - 1, xx + 1)): s2$ = CHR$(g(yy - 1, xx)): s3$ = CHR$(g(yy, xx + 1))
69 ll = 0: GOSUB 110: GOSUB 160: GOSUB 170: IF ll = 3 THEN c3 = 2: y0 = yy: x0 = xx + 1: GOSUB 200

70 s1$ = CHR$(g(yy + 1, xx + 1)): s2$ = CHR$(g(yy + 1, xx)): s3$ = CHR$(g(yy, xx + 1))
71 ll = 0: GOSUB 110: GOSUB 160: GOSUB 170: IF ll = 3 THEN c3 = 2: y0 = yy + 1: x0 = xx: GOSUB 200

72 s1$ = CHR$(g(yy + 1, xx - 1)): s2$ = CHR$(g(yy + 1, xx)): s3$ = CHR$(g(yy, xx - 1))
73 ll = 0: GOSUB 110: GOSUB 160: GOSUB 170: IF ll = 3 THEN c3 = 2: y0 = yy: x0 = xx - 1: GOSUB 200

75 NEXT yy: NEXT xx: COLOR 15, 0

76 FOR r = 1 TO (INT(xs * ys) / (ic) + 1) - 1
77 c3 = 3: x0 = INT(RND(1) * xs) + x: y0 = INT(RND(1) * ys) + y: GOSUB 200
78 NEXT r
79 IF rm = rr THEN c0$ = "÷": c1 = 9: c2 = 1: x0 = INT(RND(1) * xs) + x: y0 = INT(RND(1) * ys) + y: g(y0, x0) = ASC(c0$)

80 IF mr = 0 THEN 82
81 IF INT(RND(1) * INT(rm / mr)) + 1 = 1 THEN c0$ = "@": c1 = 12: c2 = 7: x0 = INT(RND(1) * xs) + x: y0 = INT(RND(1) * ys) + y: IF CHR$(g(y0, x0)) = "÷" THEN 80 ELSE g(y0, x0) = ASC(c0$): mr = mr - 1: GOTO 80
82 IF dg > 256 THEN dg = 0

83 :

NEXT rm

85 lxa(1) = -5: lya(1) = -2: lxa(2) = -2: lya(2) = -5: FOR xx = 2 TO 39: FOR yy = 2 TO 24: s$ = CHR$(g(yy, xx)): IF INSTR(1, ta$(2), s$) = 0 THEN 88
86 ll = 0: lc = 0: FOR x0 = xx - 1 TO xx + 1: FOR y0 = yy - 1 TO yy + 1: s1$ = CHR$(g(y0, x0)): GOSUB 150: IF ll > lc THEN lc = ll: IF ll < 3 THEN lxa(ll) = x0: lya(ll) = y0
87 NEXT y0: NEXT x0: IF ((ll = 2) * (ABS(lxa(1) - lxa(2)) < 2) * (ABS(lya(1) - lya(2)) < 2)) + (ll < 2) THEN c3 = 1: x0 = xx: y0 = yy: GOSUB 200
88 s$ = CHR$(g(yy, xx)): g(yy, xx) = ASC(s$): c0$ = s$: x0 = xx: y0 = yy: GOSUB 211: IF c3 > 0 THEN g0 = g0 + 1
89 :
NEXT yy
SCREENCOPY 0, 3
SCREENCOPY 2, 0

call stringput( ( 5 - 1 ) * 8, ( 19 - 1 ) * 8, "Please wait..." )
'LOCATE 19, 5: PRINT "Please wait...";

LINE ((5 - 1) * 8, (21 - 1) * 8)-((5 + 30) * 8 - 1, 21 * 8 - 1), 8, BF
LINE ((5 - 1) * 8, (21 - 1) * 8)-((5 + ((xx - 1) / 38 * 30)) * 8 - 1, 21 * 8 - 1), 10, BF
LINE ((5 - 1) * 8, (21 - 1) * 8)-((5 + 30) * 8 - 1, 21 * 8 - 1), 15, B
SCREENCOPY 0, 1
SCREENCOPY 3, 0
NEXT xx

90 :
FOR yy = 2 TO 24
SCREENCOPY 0, 3
SCREENCOPY 2, 0

call stringput( ( 5 - 1 ) * 8, ( 20 - 1 ) * 8, "Please wait..." )
'LOCATE 20, 5: PRINT "Please wait...";

LINE ((5 - 1) * 8, (22 - 1) * 8)-((5 + 30) * 8 - 1, 22 * 8 - 1), 8, BF
LINE ((5 - 1) * 8, (22 - 1) * 8)-((5 + ((yy - 1) / 23 * 30)) * 8 - 1, 22 * 8 - 1), 10, BF
LINE ((5 - 1) * 8, (22 - 1) * 8)-((5 + 30) * 8 - 1, 22 * 8 - 1), 15, B
SCREENCOPY 0, 1
SCREENCOPY 3, 0
FOR xx = 2 TO 39

91 c0$ = "ù": c1 = 8: c2 = 0: x0 = xx: y0 = yy: GOSUB 215: NEXT xx: NEXT yy
92 GOSUB 250
93 px = INT(RND(1) * 38) + 2: py = INT(RND(1) * 23) + 2
94 y0 = py: x0 = px: GOSUB 410: IF c0$ <> "Û" THEN 93 ELSE 300

95 '
96 '
97 '
98 '
99 'start = TIMER: WHILE TIMER - start < 1.5 AND TIMER - start >= 0: WEND

100 IF ((INSTR(1, ta$(1), s$) > 0) + (INSTR(1, ta$(2), s$) > 0) + (INSTR(1, ta$(3), s$) > 0)) THEN ll = ll + 1
101 RETURN
110 IF ((INSTR(1, ta$(1), s1$) > 0) + (INSTR(1, ta$(2), s1$) > 0) + (INSTR(1, ta$(3), s1$) > 0)) THEN ll = ll + 1
111 RETURN
120 IF ((INSTR(1, ta$(1), s2$) > 0) + (INSTR(1, ta$(2), s2$) > 0) + (INSTR(1, ta$(3), s2$) > 0)) THEN ll = ll + 1
121 RETURN
130 IF ((INSTR(1, ta$(1), s3$) > 0) + (INSTR(1, ta$(2), s3$) > 0) + (INSTR(1, ta$(3), s3$) > 0)) THEN ll = ll + 1
131 RETURN

140 IF ((INSTR(1, ta$(1), s$) = 0) * (INSTR(1, ta$(2), s$) = 0) * (INSTR(1, ta$(3), s$) = 0)) THEN ll = ll + 1
141 RETURN
150 IF ((INSTR(1, ta$(1), s1$) = 0) * (INSTR(1, ta$(2), s1$) = 0) * (INSTR(1, ta$(3), s1$) = 0)) THEN ll = ll + 1
151 RETURN
160 IF ((INSTR(1, ta$(1), s2$) = 0) * (INSTR(1, ta$(2), s2$) = 0) * (INSTR(1, ta$(3), s2$) = 0)) THEN ll = ll + 1
161 RETURN
170 IF ((INSTR(1, ta$(1), s3$) = 0) * (INSTR(1, ta$(2), s3$) = 0) * (INSTR(1, ta$(3), s3$) = 0)) THEN ll = ll + 1
171 RETURN

200 IF c3 <> 1 THEN c0 = INT(RND(1) * LEN(ta$(c3))) + 1: c0$ = MID$(ta$(c3), c0, 1): c1 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 4, 2)): g(y0, x0) = ASC(c0$)
201 IF c3 = 1 THEN c0 = INT(RND(1) * (LEN(ta$(c3)) - 1)) + 1: c0$ = MID$(ta$(c3), c0, 1): c1 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 4, 2)): g(y0, x0) = ASC(c0$)
202 RETURN

210 c0$ = CHR$(g(y0, x0))
211 c3 = 0
212 c3 = c3 + 1: IF c3 = 4 THEN c3 = 0: c0 = 1: GOTO 214
213 c0 = INSTR(1, ta$(c3), c0$): IF c0 = 0 THEN 212
214 c0$ = MID$(ta$(c3), c0, 1): c1 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 4, 2))

215

call nimgput( x0, y0, c0$ )

'215 COLOR c1, c2: LOCATE y0, x0: PRINT c0$; : COLOR 15, 0
219 RETURN

220 FOR xx = px - 1 TO px + 1: FOR yy = py - 1 TO py + 1
221 IF (SQR((yy - py) ^ 2 + (xx - px) ^ 2)) > z(p0, 5) * .5 AND v(yy, xx) = 0 THEN 225
222 c3 = 1: c0$ = CHR$(g(yy, xx)): x0 = xx: y0 = yy: GOSUB 210
223 IF c3 > 0 AND v(yy, xx) = 0 THEN g1 = g1 + 1
224 v(yy, xx) = 1
225 NEXT yy: NEXT xx: RETURN

250 'Border

251

'FOR xx = 2 TO 39: COLOR 3: LOCATE 1, xx: PRINT "Ä"; : LOCATE 25, xx: PRINT "Ä"; : NEXT xx

'top frame
call stringput( ( 1 - 1 ) * 8, ( 1 - 1 ) * 8, "Ú" + string$( 38, "Ä") + "¿" )

'bottom frame
call stringput( ( 1 - 1 ) * 8, ( 25 - 1 ) * 8, "À" + string$(38, "Ä") + "Ù" )

253
FOR yy = 2 TO 24
'COLOR 3

'left frame
call stringput( ( 1 - 1 ) * 8, ( yy - 1 ) * 8, "³" )
'LOCATE yy, 1: PRINT "³";

'right frame
call stringput( ( 40 - 1 ) * 8, ( yy - 1 ) * 8, "³" )
'LOCATE yy, 40: PRINT "³";

NEXT yy

254

'top left frame
'LOCATE 1, 1: PRINT "Ú";

'top right frame
'LOCATE 1, 40: PRINT "¿";

'bottom left frame
'LOCATE 25, 1: PRINT "À";

'bottom right frame
'LOCATE 25, 40: PRINT "Ù";

255 'dg$ = STR$(dg): COLOR 9: LOCATE 1, 4: PRINT "Dungeon"; RIGHT$(dg$, LEN(dg$) - 1); : COLOR 15, 0
256 COLOR 15, 0: RETURN

300 :
'''start = TIMER
GOSUB 250: GOSUB 1000: GOSUB 220: y0 = py: x0 = px: GOSUB 410
301

if currentstats( p0, 1 ) = 0 then
	c0$ = "x"
else
	c0$ = nimg( p0 )
end if

'call stringput( 23, 5, c0$ )

c1 = 15
y0 = py
x0 = px
'GOSUB 215

if c0$ = "x" then
	call gtext( y0, x0, 12, 4, "x" )
else	
	call nimgput( x0, y0, c0$ )
end if

302 GOSUB 1600
SCREENCOPY 0, 1: GOSUB 220
310 :
r$ = "": c$ = "": c$ = INPUT$(1)
311 IF c$ = CHR$(27) THEN

#ifdef __old_graphics__
		SCREEN 7, 0, 0, 0
		LOCATE 24, 1
		COLOR 15, 0
#else
		screenres 320,200,8,8
		screenset 0,0
#endif
		END
	END IF

312 IF c$ = "~" THEN GOTO 0 'RUN
313 IF INSTR(1, "+-", c$) > 0 THEN GOSUB 1300
320 IF z(p0, 1) = 0 THEN 395
321 IF c$ = " " AND CHR$(g(py, px)) = "÷" THEN 11
322 IF INSTR(1, "8624", c$) > 0 THEN GOSUB 500
323 IF c$ = "w" AND k(p0, 1) > 0 AND g1 < g0 THEN r = INT(RND(1) * 3) + 6: IF z(p0, 4) >= r THEN GOSUB 400
324 IF c$ = "v" AND k(p0, 2) > 0 AND g2 < g0 THEN r = INT(RND(1) * 3) + 4: IF z(p0, 4) >= r THEN GOSUB 1200: z(p0, 4) = z(p0, 4) - r: r$ = STR$(r): r$ = "[Cast 'Vision']" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
325 IF c$ = "t" AND k(p0, 3) > 0 THEN r = INT(RND(1) * 6) + 4: IF z(p0, 4) >= r THEN GOSUB 2000: z(p0, 4) = z(p0, 4) - r: r$ = STR$(r): r$ = "[Cast 'Tinker']" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
326 IF c$ = "p" AND k(p0, 4) > 0 THEN r = INT(RND(1) * 3) + 5: IF z(p0, 4) >= r THEN GOSUB 1900: z(p0, 4) = z(p0, 4) - r: r$ = STR$(r): r$ = "[Cast 'Passage']" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
327 IF c$ = "h" AND k(p0, 5) > 0 THEN r = INT(RND(1) * 2) + 4: IF z(p0, 4) >= r THEN GOSUB 1800: z(p0, 4) = z(p0, 4) - r: r$ = STR$(r): r$ = "[Cast 'Heal']" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
328 IF c$ = "f" AND k(p0, 6) > 0 THEN r = INT(RND(1) * 5) + 4: IF z(p0, 4) >= r THEN GOSUB 1200: z(p0, 4) = z(p0, 4) - r: r$ = STR$(r): r$ = "[Cast 'Flare']" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
340 IF c$ = "b" AND bm > 0 THEN r = 1: IF bm >= r THEN GOSUB 1500: bm = bm - r: r$ = STR$(r): r$ = "[Used Bomb][Bomb -" + RIGHT$(r$, LEN(r$) - 1) + "]"
350 IF c$ = " " AND CHR$(g(py, px)) = "ô" THEN GOSUB 420
351 IF c$ = " " AND CHR$(g(py, px)) = "ø" THEN GOSUB 430
352 IF c$ = " " AND CHR$(g(py, px)) = "ì" THEN GOSUB 440
353 IF c$ = " " AND CHR$(g(py, px)) = "ç" THEN GOSUB 450
354 IF c$ = " " AND CHR$(g(py, px)) = "ñ" THEN GOSUB 460
393 GOSUB 600
394 IF CHR$(g(py, px)) = "@" THEN GOSUB 1700
395 FOR r = 1 TO 6: IF z(p0, r) > i(p0, r) THEN z(p0, r) = i(p0, r)
396 IF z(p0, r) < 0 THEN z(p0, r) = 0
397 NEXT r
398 'GOSUB 250: LOCATE 25, 3: COLOR 9, 0: PRINT r$ + STRING$(36 - LEN(r$), "Ä"); : COLOR 15, 0
'''WHILE (TIMER - start >= 0) AND (TIMER - start < speed)
'''WEND
399 GOTO 300

400 'warp
401 qx = INT(RND(1) * 38) + 2: qy = INT(RND(1) * 23) + 2
402 x0 = qx: y0 = qy: GOSUB 410
403 IF v(qy, qx) = 1 OR c3 = 0 OR c3 = 2 THEN 400 ELSE px = qx: py = qy: z(p0, 4) = z(p0, 4) - r: r$ = STR$(r): r$ = "[Cast 'Warp']" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
404 RETURN

410 c0$ = CHR$(g(y0, x0))
411 c3 = 0
412 c3 = c3 + 1: IF c3 = 4 THEN c3 = 0: c0 = 1: GOTO 414
413 c0 = INSTR(1, ta$(c3), c0$): IF c0 = 0 THEN 412
414 c0$ = MID$(ta$(c3), c0, 1): c1 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 4, 2))
419 RETURN

420 r = INT(RND(1) * 3) + 5: z(p0, 4) = z(p0, 4) + r: g(py, px) = ASC("Û"): GOSUB 220
421 r$ = STR$(r): r$ = "[Mp +" + RIGHT$(r$, LEN(r$) - 1) + "]"
429 RETURN
430 r = INT(RND(1) * 15) + 1: go = go + r: g(py, px) = ASC("Û"): GOSUB 220
431 r$ = STR$(r): r$ = "[Gold +" + RIGHT$(r$, LEN(r$) - 1) + "]"
439 RETURN
440 r = INT(RND(1) * 5) + 8: z(p0, 1) = z(p0, 1) + r: g(py, px) = ASC("Û"): GOSUB 220
441 r$ = STR$(r): r$ = "[Hp +" + RIGHT$(r$, LEN(r$) - 1) + "]"
449 RETURN

450 r = INT(RND(1) * 17) + 1
451 IF r >= 1 AND r <= 3 THEN r = INT(RND(1) * 4): z(p0, 2) = z(p0, 2) + r: z(p0, 3) = z(p0, 3) + 3 - r: i(p0, 2) = i(p0, 2) + r: i(p0, 3) = i(p0, 3) + 3 - r: r$ = STR$(r): r$ = "[Ap +" + RIGHT$(r$, LEN(r$) - 1) + "]": r1$ = STR$(3 - r): r$ = r$ + "[Dp +" + RIGHT$(r1$, LEN(r1$) - 1) + "]"
452 IF r >= 4 AND r <= 6 THEN r = INT(RND(1) * 3) + 1: z(p0, 2) = z(p0, 2) + r: i(p0, 2) = i(p0, 2) + r: r$ = STR$(r): r$ = "[Ap +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 4
453 IF r >= 7 AND r <= 9 THEN r = INT(RND(1) * 3) + 1: z(p0, 3) = z(p0, 3) + r: i(p0, 3) = i(p0, 3) + r: r$ = STR$(r): r$ = "[Dp +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 7
454 IF r >= 10 AND r <= 12 THEN r = 1: ky = ky + r: r$ = STR$(r): r$ = "[Key +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 10
455 IF r >= 13 AND r <= 15 THEN r = 1: bm = bm + r: r$ = STR$(r): r$ = "[Bomb +" + RIGHT$(r$, LEN(r$) - 1) + "]": r = 13
456 IF r >= 16 AND r <= 17 THEN GOSUB 1400: r = 16: IF rr = 0 THEN 450
458 g(py, px) = ASC("Û"): GOSUB 220
459 RETURN

460 r = INT(RND(1) * 5) + -2: z(p0, 4) = z(p0, 4) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 4) = i(p0, 4) + r:
461 r = INT(RND(1) * 5) + -2: go = go + r: g(py, px) = ASC("Û"): GOSUB 220: IF go < 0 THEN go = 0
462 r = INT(RND(1) * 5) + -2: z(p0, 1) = z(p0, 1) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 1) = i(p0, 1) + r
463 r = INT(RND(1) * 5) + -2: z(p0, 2) = z(p0, 2) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 2) = i(p0, 2) + r
464 r = INT(RND(1) * 5) + -2: z(p0, 3) = z(p0, 3) + r: g(py, px) = ASC("Û"): GOSUB 220: IF r > 0 THEN i(p0, 3) = i(p0, 3) + r
465 r$ = "[Mystic Orb]": r = INT(RND(1) * 7): IF r > 0 AND e(p0, r) = s(r) THEN 465
466 IF r > 0 AND k(p0, r) = 1 AND e(p0, r) < s(r) THEN r0 = INT(RND(1) * s(r)): r1 = INT(RND(1) * s(r)) + 1: IF r0 < e(p0, r) AND r1 > e(p0, r) THEN e(p0, r) = e(p0, r) + INT(RND(1) * 5) + 1: r$ = "[Mystic Orb: '" + sas(r) + "' Increased]"
467 IF r > 0 AND k(p0, r) = 0 THEN k(p0, r) = 1: r$ = "[Mystic Orb: Learned '" + sas(r) + "']"
468 IF e(p0, r) > s(r) THEN e(p0, r) = s(r)
469 RETURN

500 '
501 IF c$ = "8" THEN my = -1: mx = 0: ly = 2: ry = py + 1: lx = px - 1: rx = px + 1
502 IF c$ = "6" THEN my = 0: mx = 1: ly = py - 1: ry = py + 1: lx = px - 1: rx = 39
503 IF c$ = "2" THEN my = 1: mx = 0: ly = py - 1: ry = 24: lx = px - 1: rx = px + 1
504 IF c$ = "4" THEN my = 0: mx = -1: ly = py - 1: ry = py + 1: lx = 2: rx = px + 1
505 y0 = py + my: x0 = px + mx: GOSUB 410
507 IF c3 = 1 AND c0$ = "Û" AND py > ly AND py < ry AND px > lx AND px < rx THEN py = py + my: px = px + mx
508 IF c3 = 1 AND c0$ = "÷" AND py > ly AND py < ry AND px > lx AND px < rx THEN py = py + my: px = px + mx
509 IF c3 = 2 AND c0$ = "-" AND py > ly AND py < ry AND px > lx AND px < rx THEN py = py + my: px = px + mx
510 IF c3 = 2 AND c0$ = "þ" AND ky = 0 THEN r$ = "[Door is locked]"
511 IF c3 = 2 AND c0$ = "þ" AND ky > 0 AND py > ly AND py < ry AND px > lx AND px < rx THEN py = py + 0: px = px + 0: ky = ky - 1: r$ = "[Unlocked door]" + "[Used 1 Key]": g(py + my, px + mx) = ASC("-"): y0 = py + my: x0 = px + mx: GOSUB 220
512 IF c3 = 2 AND c0$ = "#" THEN r = INT(RND(1) * 4): z(p0, 1) = z(p0, 1) - r: r$ = "[Couldn't force gate]": r1$ = STR$(r): r1$ = RIGHT$(r1$, LEN(r1$) - 1): r$ = r$ + "[Hp -" + r1$ + "]"
513 IF c3 = 2 AND c0$ = "#" AND INT(RND(1) * z(p0, 2)) + 1 > INT(RND(1) * (z(p0, 2) * 2)) + INT(RND(1) * 10) + 2 AND py > ly AND py < ry AND px > lx AND px < rx THEN py = py + 0: px = px + 0: r$ = "[Forced gate]" + "[Hp -" + r1$ + "]"
514 IF c3 = 2 AND c0$ = "#" AND LEFT$(r$, 13) = "[Forced gate]" THEN g(py + my, px + mx) = ASC("Û"): y0 = py + my: x0 = px + mx: GOSUB 220
515 r = INT(RND(1) * 3) + 3: IF c3 = 2 AND c0$ = "±" AND z(p0, 4) >= r AND py > ly AND py < ry AND px > lx AND px < rx THEN py = py + my: px = px + mx: z(p0, 4) = z(p0, 4) - r: r$ = "[Passed through wall]" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
516 IF c3 = 3 AND py > ly AND py < ry AND px > lx AND px < rx THEN py = py + my: px = px + mx
517 IF CHR$(g(py, px)) = "ý" THEN r = INT(RND(1) * 10) - INT(RND(1) * z(p0, 3)): IF r < 0 THEN r = 0
518 IF CHR$(g(py, px)) = "ý" THEN r$ = STR$(r): z(p0, 1) = z(p0, 1) - r: r$ = "[Attacked by Snake]" + "[Hp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
519 IF CHR$(g(py, px)) = "ð" THEN r = INT(RND(1) * 20) - INT(RND(1) * z(p0, 3)): IF r < 0 THEN r = 0
520 IF CHR$(g(py, px)) = "ð" THEN r$ = STR$(r): z(p0, 1) = z(p0, 1) - r: r$ = "[Attacked by Orc]" + "[Hp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
521 IF CHR$(g(py, px)) = "ó" THEN r = INT(RND(1) * 15) - INT(RND(1) * z(p0, 3)): IF r < 0 THEN r = 0
522 IF CHR$(g(py, px)) = "ó" THEN r$ = STR$(r): z(p0, 1) = z(p0, 1) - r: r$ = "[Attacked by Viperess]" + "[Hp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
523 IF CHR$(g(py, px)) = "à" THEN r = INT(RND(1) * 17) - INT(RND(1) * z(p0, 3)): IF r < 0 THEN r = 0
524 IF CHR$(g(py, px)) = "à" THEN r$ = STR$(r): z(p0, 1) = z(p0, 1) - r: r$ = "[Attacked by Zombie]" + "[Hp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
525 IF CHR$(g(py, px)) = "ã" THEN r = INT(RND(1) * 22) - INT(RND(1) * z(p0, 3)): IF r < 0 THEN r = 0
526 IF CHR$(g(py, px)) = "ã" THEN r$ = STR$(r): z(p0, 1) = z(p0, 1) - r: r$ = "[Attacked by Shadow]" + "[Hp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
529 RETURN

600 '
601 ly = 2 - py: IF ly < -z(p0, 6) THEN ly = -z(p0, 6)
602 ry = 24 - py: IF ry > z(p0, 6) THEN ry = z(p0, 6)
603 lx = 2 - px: IF lx < -z(p0, 6) THEN lx = -z(p0, 6)
604 rx = 39 - px: IF rx > z(p0, 6) THEN rx = z(p0, 6)
610 FOR xx = px + lx TO px + rx: FOR yy = py + ly TO py + ry
611 x0 = xx: y0 = yy: GOSUB 640
612 IF c0$ = "ý" THEN r = INT(RND(1) * 4) + 1: r0 = INT(RND(1) * 3): GOSUB 620
613 IF c0$ = "ð" THEN r = INT(RND(1) * 5): r0 = INT(RND(1) * 3): GOSUB 620
614 IF c0$ = "ó" THEN r = INT(RND(1) * 4) + 1: r0 = INT(RND(1) * 2) + 1: GOSUB 620
615 IF c0$ = "à" THEN r = INT(RND(1) * 4) + 1: r0 = INT(RND(1) * 3) + 1: GOSUB 620
616 IF c0$ = "ã" THEN r = INT(RND(1) * 4) + 1: r0 = INT(RND(1) * 1) + 4: GOSUB 620
619 NEXT yy: NEXT xx: RETURN

620 s$ = c0$
621 'r = INT(RND(1) * 5): r0 = INT(RND(1) * 3)
622 IF r0 = 1 AND py < yy THEN r = 1 ELSE IF r0 = 1 AND py > yy THEN r = 3
623 IF r0 = 2 AND px < xx THEN r = 4 ELSE IF r0 = 2 AND px > xx THEN r = 2
624 IF r0 = 3 AND ABS(yy - py) = ABS(xx - px) THEN r0 = INT(RND(1) * 2) + 1: GOTO 622
625 IF r0 = 3 AND py < yy AND ABS(yy - py) > ABS(xx - px) THEN r = 1
626 IF r0 = 3 AND py > yy AND ABS(yy - py) > ABS(xx - px) THEN r = 3
627 IF r0 = 3 AND px < xx AND ABS(yy - py) < ABS(xx - px) THEN r = 4
628 IF r0 = 3 AND px > xx AND ABS(yy - py) < ABS(xx - px) THEN r = 2
635 y0 = yy + d(r, 1): x0 = xx + d(r, 2): GOSUB 410
636 IF c0$ = "Û" THEN SWAP s$, c0$: SWAP g(yy, xx), g(y0, x0): SWAP l(yy, xx), l(y0, x0)
637 IF v(y0, x0) > 0 THEN GOSUB 210
638 y0 = yy: x0 = xx: IF v(y0, x0) > 0 THEN GOSUB 210
639 RETURN

640 c0$ = CHR$(g(y0, x0))
641 c3 = 0
642 c3 = c3 + 1: IF c3 = 4 THEN c3 = 0: c0 = 1: GOTO 644
643 c0 = INSTR(1, ta$(c3), c0$): IF c0 = 0 THEN 642
644 c0$ = MID$(ta$(c3), c0, 1): c1 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(ca$(c3), (c0 - 1) * 6 + 4, 2))
645 'COLOR c1, c2: LOCATE y0, x0: PRINT c0$; : COLOR 15, 0
649 RETURN

700 '
701 'DIM g(25, 40), v(25, 40), l(25, 40)): 'gù[gr>value][gg>view][gs>life]

710 'DIM ta$(3), ca$(3): 'tr[0>unassigned][1>room][2>passage][3>special]
711 ta$(0) = "°": ca$(0) = "[0800]"
712 ta$(1) = "Û÷": ca$(1) = "[0707][0901]": '"÷"
713 ta$(2) = "----þþþ##²": ca$(2) = "[0806][0806][0806][0806][0806][0806][0806][0807][0807][0800]"
714 ta$(3) = "øøøøøøýýýýðððóóìììôôôççñàã": ca$(3) = "[1407][1407][1407][1407][1407][1407][0107][0107][0107][0107][1007][1007][1007][0207][0207][1007][1007][1007][0507][0507][0507][0607][0607][1107][0607][0708]"

730 'DIM d(4, 2): 'directions: North/East/South/West

#ifndef __old_members_spells_ini__

dim as integer rosecard = 0, roseaxis = 0
redim shared as names_type rose_table( any )
load_names "res\rose.dat", rose_table()

redim shared rose( 0 to 4, 1 to 2 ) as integer

for rosecard = lbound( rose, 1 ) to ubound( rose, 1 ) step 1
for roseaxis = lbound( rose, 2 ) to ubound( rose, 2 ) step 1
	
	rose( rosecard, roseaxis ) = val( sync_names( "rose(" + ltrim$( str$( rosecard ) ) + "," + ltrim$( str$( roseaxis ) ) + ")", rose_table() ) )
	d( rosecard, roseaxis ) = rose( rosecard, roseaxis )
	'print "rose(" + ltrim$( str$( rosecard ) ) + "," + ltrim$( str$( roseaxis ) ) + ")"+"="+sync_names( "rose(" + ltrim$( str$( rosecard ) ) + "," + ltrim$( str$( roseaxis ) ) + ")", rose_table() )
next roseaxis
next rosecard
'flip
'sleep

#endif

800 'DIM nas(ch), z(ch, 4), k(ch, 6), e(ch, 6)
801 'character:Name + Initial Hp & Ap & Dp & Mp + Spell Knowledge & Experience

#ifndef __old_members_spells_ini__

load_party_stats ch, party_table(), spells_table()

#endif

#ifdef __old_members_spells_ini__

810 nas(1) = "Phil": 'z(1, 1) = 60: z(1, 2) = 3: z(1, 3) = 1: z(1, 4) = 30: z(1, 5) = 2: z(1, 6) = 3
811 i(1, 1) = 60: i(1, 2) = 3: i(1, 3) = 1: i(1, 4) = 30: i(1, 5) = 2: i(1, 6) = 3
812 k(1, 1) = 0: e(1, 1) = 0: 'Warp
813 k(1, 2) = 0: e(1, 2) = 0: 'Vision
814 k(1, 3) = 0: e(1, 3) = 0: 'Tinker
815 k(1, 4) = 1: e(1, 4) = 3: 'Passage+
816 k(1, 5) = 0: e(1, 5) = 0: 'Heal
817 k(1, 6) = 0: e(1, 6) = 0: 'Flare

820 nas(2) = "Poindexter": 'z(2, 1) = 40: z(2, 2) = 2: z(2, 3) = 2: z(2, 4) = 80: z(2, 5) = 3: z(2, 6) = 3
821 i(2, 1) = 40: i(2, 2) = 2: i(2, 3) = 2: i(2, 4) = 80: i(2, 5) = 3: i(2, 6) = 3
822 k(2, 1) = 0: e(2, 1) = 0: 'Warp
823 k(2, 2) = 0: e(2, 2) = 0: 'Vision
824 k(2, 3) = 1: e(2, 3) = 5: 'Tinker+
825 k(2, 4) = 0: e(2, 4) = 0: 'Passage
826 k(2, 5) = 0: e(2, 5) = 0: 'Heal
827 k(2, 6) = 0: e(2, 6) = 0: 'Flare

830 nas(3) = "Celeste": 'z(3, 1) = 40: z(3, 2) = 2: z(3, 3) = 1: z(3, 4) = 60: z(3, 5) = 1: z(3, 6) = 2
831 i(3, 1) = 40: i(3, 2) = 2: i(3, 3) = 1: i(3, 4) = 60: i(3, 5) = 1: i(3, 6) = 2
832 k(3, 1) = 0: e(3, 1) = 0: 'Warp
833 k(3, 2) = 1: e(3, 2) = 10: 'Vision+
834 k(3, 3) = 0: e(3, 3) = 0: 'Tinker
835 k(3, 4) = 0: e(3, 4) = 0: 'Passage
836 k(3, 5) = 1: e(3, 5) = 10: 'Heal+
837 k(3, 6) = 0: e(3, 6) = 0: 'Flare

840 nas(4) = "Jacks": 'z(4, 1) = 80: z(4, 2) = 3: z(4, 3) = 2: z(4, 4) = 45: z(4, 5) = 2: z(4, 6) = 4
841 i(4, 1) = 80: i(4, 2) = 3: i(4, 3) = 2: i(4, 4) = 45: i(4, 5) = 2: i(4, 6) = 4
842 k(4, 1) = 1: e(4, 1) = 10: 'Warp+
843 k(4, 2) = 0: e(4, 2) = 0: 'Vision
844 k(4, 3) = 0: e(4, 3) = 0: 'Tinker
845 k(4, 4) = 0: e(4, 4) = 0: 'Passage
846 k(4, 5) = 0: e(4, 5) = 0: 'Heal
847 k(4, 6) = 0: e(4, 6) = 0: 'Flare

850 nas(5) = "Dereck": 'z(5, 1) = 100: z(5, 2) = 5: z(5, 3) = 5: z(5, 4) = 3: z(5, 5) = 3: z(5, 6) = 4
851 i(5, 1) = 100: i(5, 2) = 5: i(5, 3) = 5: i(5, 4) = 3: i(5, 5) = 3: i(5, 6) = 4
852 k(5, 1) = 0: e(5, 1) = 0: 'Warp
853 k(5, 2) = 0: e(5, 2) = 0: 'Vision
854 k(5, 3) = 0: e(5, 3) = 0: 'Tinker
855 k(5, 4) = 0: e(5, 4) = 0: 'Passage
856 k(5, 5) = 1: e(5, 5) = 3: 'Heal
857 k(5, 6) = 0: e(5, 6) = 0: 'Flare

860 nas(6) = "Morton": 'z(6, 1) = 70: z(6, 2) = 4: z(6, 3) = 3: z(6, 4) = 10: z(6, 5) = 4: z(6, 6) = 3
861 i(6, 1) = 70: i(6, 2) = 4: i(6, 3) = 3: i(6, 4) = 10: i(6, 5) = 4: i(6, 6) = 3
862 k(6, 1) = 0: e(6, 1) = 0: 'Warp
863 k(6, 2) = 0: e(6, 2) = 0: 'Vision
864 k(6, 3) = 1: e(6, 3) = 10: 'Tinker+
865 k(6, 4) = 1: e(6, 4) = 40: 'Passage+
866 k(6, 5) = 0: e(6, 5) = 0: 'Heal
867 k(6, 6) = 0: e(6, 6) = 0: 'Flare

870 nas(7) = "Fura": 'z(7, 1) = 80: z(7, 2) = 4: z(7, 3) = 4: z(7, 4) = 50: z(7, 5) = 4: z(7, 6) = 4
871 i(7, 1) = 80: i(7, 2) = 4: i(7, 3) = 4: i(7, 4) = 50: i(7, 5) = 4: i(7, 6) = 4
872 k(7, 1) = 0: e(7, 1) = 0: 'Warp
873 k(7, 2) = 0: e(7, 2) = 0: 'Vision
874 k(7, 3) = 0: e(7, 3) = 0: 'Tinker
875 k(7, 4) = 0: e(7, 4) = 0: 'Passage
876 k(7, 5) = 0: e(7, 5) = 0: 'Heal
877 k(7, 6) = 0: e(7, 6) = 20: 'Flare+

#endif

900 'DIM sas(6), s(6): 'magic:Name & Difficulty

#ifndef __old_spells__

load_spells spells_table()

#endif

#ifdef __old_spells__

901 sas(1) = "Warp": s(1) = 100: 'Labyrinth+Jacks
902 sas(2) = "Vision": s(2) = 100: 'Vineard Maze+Dereck
903 sas(3) = "Tinker": s(3) = 100: 'Acid Temple+Poindexter
904 sas(4) = "Passage": s(4) = 100: 'Warlock Cave+Phil
905 sas(5) = "Heal": s(5) = 100: 'Pearl Pool+Celeste
906 sas(6) = "Flare": s(6) = 100: 'Fire Lair+Fura
#endif

909 RETURN

1000 'sight
1001 ly = 2 - py: IF ly < -z(p0, 5) THEN ly = -z(p0, 5)
1002 ry = 24 - py: IF ry > z(p0, 5) THEN ry = z(p0, 5)
1003 lx = 2 - px: IF lx < -z(p0, 5) THEN lx = -z(p0, 5)
1004 rx = 39 - px: IF rx > z(p0, 5) THEN rx = z(p0, 5)
1010 FOR xx = px + lx TO px + rx: FOR yy = py + ly TO py + ry
1011 y0 = yy: x0 = xx: IF (SQR((yy - py) ^ 2 + (xx - px) ^ 2)) > z(p0, 5) * .5 THEN 1013
1012 GOSUB 210: IF v(y0, x0) = 0 THEN v(y0, x0) = 1: IF c3 >= 1 THEN g1 = g1 + 1
1013 NEXT yy: NEXT xx: RETURN

1100 'bomb
1101 ly = 2 - py: IF ly < -3 THEN ly = -z(p0, 5)
1102 ry = 24 - py: IF ry > 3 THEN ry = z(p0, 5)
1103 lx = 2 - px: IF lx < -3 THEN lx = -z(p0, 5)
1104 rx = 39 - px: IF rx > 3 THEN rx = z(p0, 5)
1110 FOR xx = px + lx TO px + rx: FOR yy = py + ly TO py + ry
1111 y0 = yy: x0 = xx: IF (SQR((yy - py) ^ 2 + (xx - px) ^ 2)) > 3 * .5 THEN 1114
1112 GOSUB 210: IF v(y0, x0) = 0 THEN v(y0, x0) = 1: IF c3 >= 1 THEN g1 = g1 + 1
1113 IF c3 = 2 OR INSTR(1, "ðýóàã@", c0$) > 0 THEN g(y0, x0) = ASC("Û"): GOSUB 210: l(y0, x0) = 0
1114 NEXT yy: NEXT xx: RETURN

1200 'vision
1201 y1 = INT(RND(1) * 23) + 2: x1 = INT(RND(1) * 38) + 2: y0 = y1: x0 = x1: GOSUB 640: IF c3 = 0 THEN 1201
1202 ly = 2 - y1: IF ly < -5 THEN ly = -5
1203 ry = 24 - y1: IF ry > 5 THEN ry = 5
1204 lx = 2 - x1: IF lx < -5 THEN lx = -5
1205 rx = 39 - x1: IF rx > 5 THEN rx = 5
1206 FOR xx = x1 + lx TO x1 + rx: FOR yy = y1 + ly TO y1 + ry
1207 y0 = yy: x0 = xx: IF (SQR((yy - y1) ^ 2 + (xx - x1) ^ 2)) > 5 * .5 THEN 1210
1208 GOSUB 210: IF v(y0, x0) = 0 AND c3 >= 1 THEN g1 = g1 + 1: v(y0, x0) = 1
1209 IF v(y0, x0) = 1 AND c3 >= 1 THEN g2 = g2 + 1: v(y0, x0) = 2
1210 NEXT yy: NEXT xx: RETURN

1300 'switch player
1301 r = p0
1302 IF c$ = "+" THEN r = (r MOD ch) + 1: IF z(r, 1) > 0 OR r = p0 THEN 1304 ELSE 1302
1303 IF c$ = "-" THEN r = ch + 1 - (((ch + 1 - r) MOD ch) + 1): IF z(r, 1) > 0 OR r = p0 THEN 1304 ELSE 1303
1304 IF r <> p0 THEN r$ = "[Switched to " + nas(r) + "]": IF z(p0, 1) = 0 THEN r$ = r$ + "[Lost " + nas(p0) + "]"
1305 p0 = r: RETURN

1400 'gain character
1401 rr = 0: FOR r = 1 TO ch: IF z(r, 1) > 0 THEN rr = rr + 1
1402 NEXT r
1403 IF rr = ch THEN RETURN
1404 r = ch - rr: IF r > 2 THEN r = 2
1405 rr = INT(RND(1) * r) + 1
1406 r$ = "[": FOR r = 1 TO rr: IF r > 1 THEN r$ = r$ + "+"
1407 r0 = INT(RND(1) * ch) + 1: IF z(r0, 1) > 0 THEN 1407
1411 FOR r1 = 1 TO 6: z(r0, r1) = i(r0, r1)
1412 IF k(r0, r1) > 0 AND e(r0, r1) > 10 THEN e(r0, r1) = 10
1413 NEXT r1: r$ = r$ + nas(r0): NEXT r: r$ = r$ + " joined!]"
1419 RETURN

1500 'flare
1501 ly = 2 - py: IF ly < -4 THEN ly = -z(p0, 5)
1502 ry = 24 - py: IF ry > 4 THEN ry = z(p0, 5)
1503 lx = 2 - px: IF lx < -4 THEN lx = -z(p0, 5)
1504 rx = 39 - px: IF rx > 4 THEN rx = z(p0, 5)
1510 FOR xx = px + lx TO px + rx: FOR yy = py + ly TO py + ry
1511 y0 = yy: x0 = xx: IF (SQR((yy - py) ^ 2 + (xx - px) ^ 2)) > 4 * .5 THEN 1517
1512 GOSUB 210: IF v(y0, x0) = 0 THEN v(y0, x0) = 1: IF c3 >= 1 THEN g1 = g1 + 1
1513 IF v(y0, x0) = 1 THEN v(y0, x0) = 2: IF c3 >= 1 THEN g2 = g2 + 1
1514 IF INSTR(1, "-ðýóàã", c0$) > 0 THEN g(y0, x0) = ASC("Û"): GOSUB 210: l(y0, x0) = 0
1515 IF INSTR(1, "þ", c0$) > 0 THEN g(y0, x0) = ASC("-"): GOSUB 210: l(y0, x0) = 0
1516 IF INSTR(1, "±", c0$) > 0 THEN g(y0, x0) = ASC("°"): GOSUB 210: l(y0, x0) = 0
1517 NEXT yy: NEXT xx: RETURN

1600 'stat display
call nimgput( 2, 1, nimg( p0 ) )
'call stringput( 3, 2, ltrim$(str$( p0 ) ) )
1601 '[!!]'==[o]==
call StringPut( ( 3 - 1 ) * 8, ( 1 - 1 ) * 8, nas(p0) )
'LOCATE 1, 5: COLOR 9, 0: PRINT nas(p0);

1602 FOR r = 1 TO 6
1603 IF z(p0, r) > i(p0, r) THEN z(p0, r) = i(p0, r)
1604 IF z(p0, r) < 0 THEN z(p0, r) = 0
1605 NEXT r

s0$ = STR$(1000 + levelct)
s0$ = RIGHT$(s0$, 3)
s0$ = "{{"+chr$(&HF7)+"}}" + s0$
1606
s1$ = STR$(1000 + z(p0, 1))
s1$ = RIGHT$(s1$, 3)
IF z(p0, 1) = i(p0, 1) THEN
	s1$ = "{{"+chr$(&HEC)+"}}" + s1$
ELSE
	s1$ = "{{"+chr$(&HEC)+"}}" + s1$
end if

1607
s2$ = RIGHT$(str$(1000+z(p0, 2)), 3)

IF z(p0, 2) = i(p0, 2) THEN
	s2$ = "{{"+chr$(&HE7)+"}}" + s2$
ELSE
	s2$ = "{{"+chr$(&HE7)+"}}" + s2$
end if

1608
s3$ = RIGHT$(str$(1000+z(p0, 3)), 3)

IF z(p0, 3) = i(p0, 3) THEN
	s3$ = "{{"+chr$(&H23)+"}}" + s3$
ELSE
	s3$ = "{{"+chr$(&H23)+"}}" + s3$
end if

1609
s4$ = RIGHT$(str$(1000+z(p0, 4)), 3)

IF z(p0, 4) = i(p0, 4) THEN
	s4$ = "{{"+chr$(&HF1)+"}}" + s4$
ELSE
	s4$ = "{{"+chr$(&HF1)+"}}" + s4$
end if

1610
s$ = "[" + s0$ + "/"  + s1$ + "/" + s2$ + "/" + s3$ + "/" + s4$ + "]"

1611

'LOCATE 1, 40 - len( s$ ) : COLOR 9, 0: PRINT s$;

gtext 1, 40 - gtext_true_len(s$), 9, 0, s$

1612 s1$ = STR$(go) 'gold
1613 s2$ = STR$(ky) 'keys
1614 s3$ = STR$(bm) 'bombs

1615 'gold hud

s$ = "[{{"+chr$(&HF8)+"}}" + RIGHT$(str$(1000+val(s1$)), 3)

1616 'keys hud

'IF ky > 0 THEN
	s$ = s$ + "/{{6B}}" + RIGHT$(str$(1000+val(s2$)), 3)
'end if

1617 'bombs hud

'IF bm > 0 THEN
	s$ = s$ + "/{{62}}" + RIGHT$(str$(1000+val(s3$)), 3)
'end if

1618

s$ = s$ + "]"

1619

''LOCATE 25, 39 - LEN(s$): COLOR 9, 0: PRINT s$;

gtext 25, 40 - gtext_true_len(s$), 9, 0, s$

1620

IF r$ <> "" THEN
	'LOCATE 25, 3
	'COLOR 9, 0
	'PRINT r$;
	'COLOR 3
	'PRINT STRING$(36 - LEN(r$), "Ä");
	'COLOR 15, 0
	
	gtext ( 25, 3, 9, 0, STRING$(36 - gtext_true_len( r$ ), "Ä") )

end if

1629

RETURN

1700

IF r$ <> "" THEN
	RETURN
	'merchant
end if

m0s$ = sync_names( "m0i/"+ltrim$(str$(1700+m0i))+"/m0s$", shops_table() )
m1s$ = sync_names( "m0i/"+ltrim$(str$(1700+m0i))+"/m1s$", shops_table() )
m1i = val( sync_names( "m0i/"+ltrim$(str$(1700+m0i))+"/m1i", shops_table() ) )
m2i = val( sync_names( "m0i/"+ltrim$(str$(1700+m0i))+"/m2i", shops_table() ) )

#ifdef __old_shops__

select case m0i

1701
case 1
	
	m0s$ = "Merchant"
	m1s$ = "Apple"
	m1i = 30
	m2i = 1
1702
case 2
	m0s$ = "Merchant"
	m1s$ = "Key"
	m1i = 100
	m2i = 1
1703
case 3
	m0s$ = "Merchant"
	m1s$ = "Bomb"
	m1i = 200
	m2i = 1
1704
case 4
	m0s$ = "Merchant"
	m1s$ = "Apple"
	m1i = 60
	m2i = 3
1705
case 5
	m0s$ = "Merchant"
	m1s$ = "Key"
	m1i = 200
	m2i = 3
1706
case 6
	m0s$ = "Merchant"
	m1s$ = "Bomb"
	m1i = 300
	m2i = 5
1707
case 7
	m0s$ = "Merchant"
	m1s$ = "Spore"
	m1i = 300
	m2i = 5
1708
case 8
	m0s$ = "Merchant"
	m1s$ = "Nectar"
	m1i = 300
	m2i = 5
1709
case 9
	m0s$ = "Blacksmith"
	m1s$ = "ApForge"
	m1i = 60
	m2i = 3
1710
case 10
	m0s$ = "Blacksmith"
	m1s$ = "DpForge"
	m1i = 200
	m2i = 3
1711
case 11
	m0s$ = "Sorceror"
	m1s$ = "'" + sas(1) + "'+"
	m1i = 100
	m2i = 3
1712
case 12
	m0s$ = "Sorceror"
	m1s$ = "'" + sas(2) + "'+"
	m1i = 100
	m2i = 3
1713
case 13
	m0s$ = "Sorceror"
	m1s$ = "'" + sas(3) + "'+"
	m1i = 100
	m2i = 3
1714
case 14
	m0s$ = "Sorceror"
	m1s$ = "'" + sas(4) + "'+"
	m1i = 100
	m2i = 3
1715
case 15
	m0s$ = "Sorceror"
	m1s$ = "'" + sas(5) + "'+"
	m1i = 100
	m2i = 3
1716
case 16
	m0s$ = "Sorceror"
	m1s$ = "'" + sas(6) + "'+"
	m1i = 100
	m2i = 3
1717
case 17
	m0s$ = "Merchant"
	m1s$ = "Spore"
	m1i = 200
	m2i = 3
1718
case 18
	m0s$ = "Sorceror"
	m1s$ = "MPmax+"
	m1i = 300
	m2i = 5

end select

#endif

1730 s1$ = STR$(m1): s1$ = RIGHT$(s1$, LEN(s1$) - 1)
1731 s2$ = STR$(m2): s2$ = RIGHT$(s2$, LEN(s2$) - 1)
1733 IF RIGHT$(m1$, 2) = "'+" THEN m3s$ = m1s$ + s2$: GOTO 1798
1734 IF RIGHT$(m1$, 1) = "+" AND m2i > 1 AND INSTR(1, "x", MID$(m1$, LEN(m1$) - 1, 1)) = 0 THEN m1s$ = LEFT$(m1$, LEN(m1$) - 1) + "s+": m3s$ = m1s$ + s2$: GOTO 1798
1735 IF RIGHT$(m1$, 1) = "+" AND m2i > 1 AND INSTR(1, "x", MID$(m1$, LEN(m1$) - 1, 1)) > 0 THEN m1s$ = LEFT$(m1$, LEN(m1$) - 1) + "es+": m3s$ = m1s$ + s2$: GOTO 1798
1736 IF RIGHT$(m1$, 1) = "+" THEN m3s$ = m1s$ + s2$: GOTO 1798
1737 IF m2i > 1 AND INSTR(1, "x", RIGHT$(m1$, 1)) = 0 THEN m1s$ = m1s$ + "s": m3s$ = s2$ + m1s$: GOTO 1798
1738 IF m2i > 1 AND INSTR(1, "x", RIGHT$(m1$, 1)) > 0 THEN m1s$ = m1s$ + "es": m3s$ = s2$ + m1s$: GOTO 1798
1739 m3s$ = s2$ + m1s$
1798 r$ = "{" + m0s$ + ": " + s1$ + "GP for " + m3s$ + "}"
1799 RETURN

1800 'Heal
1801 FOR xx = 1 TO ch
1802 IF INT(RND(1) * e(p0, 5)) + 1 >= INT(RND(1) * s(5)) + 1 AND z(xx, 1) > 0 THEN z(xx, 1) = z(xx, 1) + INT(i(xx, 1) * (e(p0, 5) / s(5)))
1803 NEXT xx
1899 RETURN

1900 'Passage
1901 ly = 2 - py: IF ly < -1 THEN ly = -1
1902 ry = 24 - py: IF ry > 1 THEN ry = 1
1903 lx = 2 - px: IF lx < -1 THEN lx = -1
1904 rx = 39 - px: IF rx > 1 THEN rx = 1
1910 FOR xx = px + lx TO px + rx: FOR yy = py + ly TO py + ry
1911 y0 = yy: x0 = xx: IF (SQR((yy - py) ^ 2 + (xx - px) ^ 2)) > 2 * .5 THEN 2014
1912 GOSUB 210: IF v(y0, x0) = 0 THEN v(y0, x0) = 1: IF c3 >= 1 THEN g1 = g1 + 1
1913 IF INSTR(1, "±", c0$) > 0 AND INT(RND(1) * e(p0, 4)) + 1 >= INT(RND(1) * s(4)) + 1 THEN g(y0, x0) = ASC("Û"): GOSUB 210: l(y0, x0) = 0
1914 NEXT yy: NEXT xx
1999 RETURN

2000 'Tinker
2001 ly = 2 - py: IF ly < -1 THEN ly = -1
2002 ry = 24 - py: IF ry > 1 THEN ry = 1
2003 lx = 2 - px: IF lx < -1 THEN lx = -1
2004 rx = 39 - px: IF rx > 1 THEN rx = 1
2010 FOR xx = px + lx TO px + rx: FOR yy = py + ly TO py + ry
2011 y0 = yy: x0 = xx: IF (SQR((yy - py) ^ 2 + (xx - px) ^ 2)) > 2 * .5 THEN 2014
2012 GOSUB 210: IF v(y0, x0) = 0 THEN v(y0, x0) = 1: IF c3 >= 1 THEN g1 = g1 + 1
2013 IF INSTR(1, "þ", c0$) > 0 AND INT(RND(1) * e(p0, 3)) + 1 >= INT(RND(1) * s(3)) + 1 THEN g(y0, x0) = ASC("-"): GOSUB 210: l(y0, x0) = 0
2014 NEXT yy: NEXT xx
2099 RETURN

function pickup( subject as string = "" ) as string

	select case lcase$(subject)
	case "m"
		pickup = "ô"
	case "g"
		pickup = "ø"
	case "h"
		pickup = "ì"
	case "k"
		pickup = "ç"
	case "b"
		pickup = "ç"
	case "gain character"
		pickup = "ç"
	case "mystic orb"
		pickup = "ñ"
	case else
		pickup = subject
	end select
	
end function

sub gtext( row as integer = 1, col as integer = 1, fg as integer = 9, bg as integer = 0, subject as string = "" )
	dim as string qopen = "{{", qclose = "}}"
	
	dim as integer offest = 0, o = 0
	dim as string c0 = string$(0,0)
	for offset = 1 to len(subject) step 1
		if mid$(subject,offset,len(qopen)) = qopen and mid$(subject,offset+len(qopen)+1,len(qclose)) = qclose then
			
			c0 = pickup( mid$(subject,offset+len(qopen),1) )
			sprite_put 0, (col + o - 1) * 8, (row - 1) * 8, "tiles\map\map_"+RIGHT$(STR$(1000 + asc(c0)), 3) + ".til", "pset"

			offset += len(qopen+qclose)
		elseif mid$(subject,offset,len(qopen)) = qopen and mid$(subject,offset+len(qopen)+2,len(qclose)) = qclose then
			
			c0 = chr$( val("&H" + mid$(subject,offset+len(qopen),2) ) )
			sprite_put 0, (col + o - 1) * 8, (row - 1) * 8, "tiles\map\map_"+RIGHT$(STR$(1000 + asc(c0)), 3) + ".til", "pset"

			offset += len(qopen+qclose)+1
		else
			c0 = mid$(subject,offset,1)
			
			call stringput( ( col + o - 1 ) * 8, ( row - 1 ) * 8, c0 )

			'locate row, col + o
			'color fg, bg
			'print c0;
		end if
		o += 1
	next offset
	''sprite_put 0, (x0 - 1) * 8, (y0 - 1) * 8, "tiles\"+RIGHT$(STR$(1000 + ASC(c0$)), 3) + "b0808.til", "pset"

end sub

#ifdef __old_true_len__
function gtext_true_len(subject as string) as integer
	dim as integer offset = 0, o = 0
	
	for offset = 1 to len(subject) step 1
		if mid$(subject,offset,5)="{{"+mid$(subject,offset+2,1)+"}}" then
			offset+=4
			o+=1
		elseif mid$(subject,offset,6)="{{"+mid$(subject,offset+2,2)+"}}" then
			offset+=5
			o+=1
		elseif mid$(subject,offset,5)="[["+mid$(subject,offset+2,1)+"]]" then
			offset+=4
			o+=1
		else
			o+=1
		end if
	next offset
	gtext_true_len = o
end function
#endif

function gtext_true_len(subject as string) as integer
	
	dim as string qopen = "{{", qclose = "}}"
	
	dim as integer offest = 0, o = 0
	dim as string c0 = string$(0,0)
	for offset = 1 to len(subject) step 1
		if mid$(subject,offset,len(qopen)) = qopen and mid$(subject,offset+len(qopen)+1,len(qclose)) = qclose then
			
			c0 = pickup( mid$(subject,offset+len(qopen),1) )
			''sprite_put 0, (col + o - 1) * 8, (row - 1) * 8, "tiles\map\map_"+RIGHT$(STR$(1000 + asc(c0)), 3) + ".til", "pset"

			offset += len(qopen+qclose)
		elseif mid$(subject,offset,len(qopen)) = qopen and mid$(subject,offset+len(qopen)+2,len(qclose)) = qclose then
			
			c0 = chr$( val("&H" + mid$(subject,offset+len(qopen),2) ) )
			''sprite_put 0, (col + o - 1) * 8, (row - 1) * 8, "tiles\map\map_"+RIGHT$(STR$(1000 + asc(c0)), 3) + ".til", "pset"

			offset += len(qopen+qclose)+1
		else
			c0 = mid$(subject,offset,1)
			
			''call stringput( ( col + o - 1 ) * 8, ( row - 1 ) * 8, c0 )

			'locate row, col + o
			'color fg, bg
			'print c0;
		end if
		o += 1
	next offset
	''sprite_put 0, (x0 - 1) * 8, (y0 - 1) * 8, "tiles\"+RIGHT$(STR$(1000 + ASC(c0$)), 3) + "b0808.til", "pset"
	gtext_true_len = o
end function


#ifdef __old_graphics__
SUB GraphicPut (XXXX, YYYY, GGGG$)
'IF GGGG = 0 THEN 10001
'IF GGGG = 3 THEN GGGG = GGGG + INT(gc)

  DEF SEG = VARSEG(g01(0)): BLOAD "tiles\map\" + "map_" + GGGG$ + ".til", VARPTR(g01(0))
  PUT (XXXX, YYYY), g01, PSET

'10001 :
END SUB
#endif

'[!!]'===mouse===
'[!!]'===sb===

DEFINT A-Z
SUB StringPut (XXXX as integer = 0, YYYY as integer = 0, GGGG as string = "" )

	'IF GGGG = 0 THEN 10001
	'IF GGGG = 3 THEN GGGG = GGGG + INT(gc)
	
 	dim as integer t = 0, tempord = 0
	dim as integer XXX = 0, YYY = 0
	dim as string GGGR = string$( 0, 0 )
	
	FOR t = 1 TO LEN( GGGG ) step 1
		
		XXX = XXXX + (t - 1) * 8
		YYY = YYYY
		
		IF XXX > 320 - 8 THEN
			XXX = XXX - 39 * 8
			YYY = YYY + 8
		END IF
		
		IF XXX > 320 - 8 THEN
			XXX = 0
		END IF
		
		tempord = ASC(MID$(GGGG, t, 1))
		
		IF tempord >= 33 AND tempord <= 255 THEN
			
			GGGR = "font_"+RIGHT$(STR$(1000 + tempord), 3) + ".til"
			
			#ifdef __old_graphics__				
				DEF SEG = VARSEG(g01(0)): BLOAD "tiles\font\" + GGGR, VARPTR(g01(0))
				PUT (XXX, YYY), g01, PSET
			#endif
			
			#ifndef __old_graphics__
				sprite_put 0, XXX, YYY, "tiles\font\" + GGGR, "pset"
			#endif
			
		END IF
		
	NEXT t

'10001 :

END SUB


sub nimgput( x0 as integer = 1, y0 as integer = 1, c0 as string = "" )
	
	dim as string sptemp = string$( 0, 0 )
	
	#ifdef __old_graphics__
		
		CALL GraphicPut( ( x0 - 1 ) * 8, ( y0 - 1 ) * 8, "tiles\map\map_" + RIGHT$( STR$( 1000 + ASC( c0 ) ), 3 ) + ".til" )
		
	#else
		
		select case len( c0 )
		case 4
			sptemp = "tiles\party\" + c0 + "_001.TIL"
						
			'locate 25, 1
			'print sptemp;
		
			'stringput( 1, 25, sptemp )
		
		case 3
			sptemp = "tiles\font\font_" + c0 + ".TIL"
						
			'locate 25, 1
			'print sptemp;
			
		case 1
			
			sptemp = "tiles\map\map_" + RIGHT$( STR$( 1000 + ASC( c0 ) ), 3 ) + ".til"			
			
		end select
		
		sprite_put 0, ( x0 - 1 ) * 8, ( y0 - 1 ) * 8, sptemp, "pset"
		
	#endif

end sub
