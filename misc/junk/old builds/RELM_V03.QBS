DEFINT A-Z
DECLARE FUNCTION DetectCard% ()
DECLARE SUB SBInit ()
DECLARE SUB WriteReg (Reg%, Value%)
DECLARE SUB SBPlay (note%)
CONST false = 0, true = NOT false
DECLARE SUB MouseDriver (AX%, bx%, CX%, DX%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB mouseshow ()
DECLARE SUB mousestatus (lb%, RB%, Xmouse%, Ymouse%)
DECLARE SUB STICKS (Joyx%, JOYY%, BUT1%, BUt2%, BUT3%)
DIM SHARED mouse$
DIM SHARED g01(201)
DIM SHARED go$(32, 2)
DECLARE SUB GraphicPut (XXXX, YYYY, GGGG$)
RESTORE

mouse$ = SPACE$(57)
FOR i% = 1 TO 57
  READ a$
  H$ = CHR$(VAL("&H" + a$))
  MID$(mouse$, i%, 1) = H$
NEXT i%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00

MS% = MouseInit%
IF NOT MS% THEN
  PRINT "Mouse not found"
  LET Amouse$ = "NO"
ELSE
  'mouseshow
  PRINT "Mouse found and initialized"
  LET Amouse$ = "YES"
END IF

IF DetectCard = false THEN
  PRINT "Sound card not found"
  LET Asbcard$ = "NO"
ELSE
  SBInit
  PRINT "Sound card found and initialized"
  LET Asbcard$ = "YES"
END IF
LET TTTT = 1000
LET speed = .1
LET Soundon = false

LET pause = false

TIMER ON
  PRINT "Timer activated at "; TIME$

PRINT "Press the spacebar to start..."

WHILE INKEY$ = "": WEND

0 KEY OFF: SCREEN 7, 0, 0, 1: WIDTH 40: VIEW PRINT 1 TO 25: COLOR 15, 0: CLS : RANDOMIZE TIMER
1 ch = 7: p0 = 1: ic = 10: '15
2 DIM g(25, 40), v(25, 40), l(25, 40), T$(3), c$(3), d(4, 2), n$(ch), z(ch, 6), i(ch, 6), k(ch, 6), e(ch, 6), s$(6), s(6)
4 SCREEN 7, 0, 0, 1: GOSUB 700
5 GOSUB 1400: p0 = r0: go = 0: ky = 0: bm = 0: m0 = 1
6 GOSUB 250: LOCATE 11, 13: COLOR 10: PRINT " - Mind Realm -"; : COLOR 15: PCOPY 0, 1

10 dg = 0
11 dg = dg + 1: r = INT(RND(1) * 10) + 1 + 25: rr = INT(RND(1) * r) + 1
12 mr = INT(RND(1) * 3): m0 = INT(RND(1) * 18) + 1: ic = INT(RND(1) * 8) + 8
13 GOSUB 250

35 FOR yy = 2 TO 24: FOR xx = 2 TO 39: g(yy, xx) = ASC("°"): g0 = 0: g1 = 0: v(yy, xx) = 0: l(yy, xx) = 0
36 c3 = 0: x0 = xx: y0 = yy: GOSUB 200: NEXT xx: NEXT yy
37 FOR rm = 1 TO r: COLOR 15, 0
38 xs = INT(RND(1) * 6) + 2: ys = INT(RND(1) * (20 / xs)) + 2: IF ys > 7 THEN ys = 7
39 x = INT(RND(1) * (40 - xs - 3)) + 3: y = INT(RND(1) * (25 - ys - 3)) + 3
40 NP = 0: FOR xx = x TO x + xs - 1: FOR yy = y TO y + ys - 1
41 s$ = CHR$(g(yy, xx))
42 ll = 0: GOSUB 100: IF ll = 1 THEN NP = 1
43 NEXT yy: NEXT xx
44 IF NP = 1 THEN 38
50 FOR xx = x TO x + xs - 1: FOR yy = y TO y + ys - 1
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
83 NEXT rm

85 lx(1) = -5: ly(1) = -2: lx(2) = -2: ly(2) = -5: FOR xx = 2 TO 39: FOR yy = 2 TO 24: s$ = CHR$(g(yy, xx)): IF INSTR(1, T$(2), s$) = 0 THEN 88
86 ll = 0: lc = 0: FOR x0 = xx - 1 TO xx + 1: FOR y0 = yy - 1 TO yy + 1: s1$ = CHR$(g(y0, x0)): GOSUB 150: IF ll > lc THEN lc = ll: IF ll < 3 THEN lx(ll) = x0: ly(ll) = y0
87 NEXT y0: NEXT x0: IF ((ll = 2) * (ABS(lx(1) - lx(2)) < 2) * (ABS(ly(1) - ly(2)) < 2)) + (ll < 2) THEN c3 = 1: x0 = xx: y0 = yy: GOSUB 200
88 s$ = CHR$(g(yy, xx)): g(yy, xx) = ASC(s$): c0$ = s$: x0 = xx: y0 = yy: GOSUB 211: IF c3 > 0 THEN g0 = g0 + 1
89 NEXT yy: NEXT xx

90 FOR yy = 2 TO 24: FOR xx = 2 TO 39
91 c0$ = "ù": c1 = 8: c2 = 0: x0 = xx: y0 = yy: GOSUB 215: NEXT xx: NEXT yy
92 GOSUB 250
93 px = INT(RND(1) * 38) + 2: py = INT(RND(1) * 23) + 2
94 y0 = py: x0 = px: GOSUB 410: IF c0$ <> "Û" THEN 93 ELSE 300

95 '
96 '
97 '
98 '
99 'start = TIMER: WHILE TIMER - start < 1.5 AND TIMER - start >= 0: WEND

100 IF ((INSTR(1, T$(1), s$) > 0) + (INSTR(1, T$(2), s$) > 0) + (INSTR(1, T$(3), s$) > 0)) THEN ll = ll + 1
101 RETURN
110 IF ((INSTR(1, T$(1), s1$) > 0) + (INSTR(1, T$(2), s1$) > 0) + (INSTR(1, T$(3), s1$) > 0)) THEN ll = ll + 1
111 RETURN
120 IF ((INSTR(1, T$(1), s2$) > 0) + (INSTR(1, T$(2), s2$) > 0) + (INSTR(1, T$(3), s2$) > 0)) THEN ll = ll + 1
121 RETURN
130 IF ((INSTR(1, T$(1), s3$) > 0) + (INSTR(1, T$(2), s3$) > 0) + (INSTR(1, T$(3), s3$) > 0)) THEN ll = ll + 1
131 RETURN

140 IF ((INSTR(1, T$(1), s$) = 0) * (INSTR(1, T$(2), s$) = 0) * (INSTR(1, T$(3), s$) = 0)) THEN ll = ll + 1
141 RETURN
150 IF ((INSTR(1, T$(1), s1$) = 0) * (INSTR(1, T$(2), s1$) = 0) * (INSTR(1, T$(3), s1$) = 0)) THEN ll = ll + 1
151 RETURN
160 IF ((INSTR(1, T$(1), s2$) = 0) * (INSTR(1, T$(2), s2$) = 0) * (INSTR(1, T$(3), s2$) = 0)) THEN ll = ll + 1
161 RETURN
170 IF ((INSTR(1, T$(1), s3$) = 0) * (INSTR(1, T$(2), s3$) = 0) * (INSTR(1, T$(3), s3$) = 0)) THEN ll = ll + 1
171 RETURN

200 IF c3 <> 1 THEN c0 = INT(RND(1) * LEN(T$(c3))) + 1: c0$ = MID$(T$(c3), c0, 1): c1 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 4, 2)): g(y0, x0) = ASC(c0$)
201 IF c3 = 1 THEN c0 = INT(RND(1) * (LEN(T$(c3)) - 1)) + 1: c0$ = MID$(T$(c3), c0, 1): c1 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 4, 2)): g(y0, x0) = ASC(c0$)
202 RETURN

210 c0$ = CHR$(g(y0, x0))
211 c3 = 0
212 c3 = c3 + 1: IF c3 = 4 THEN c3 = 0: c0 = 1: GOTO 214
213 c0 = INSTR(1, T$(c3), c0$): IF c0 = 0 THEN 212
214 c0$ = MID$(T$(c3), c0, 1): c1 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 4, 2))
215 :
CALL GraphicPut((x0 - 1) * 8, (y0 - 1) * 8, RIGHT$(STR$(1000 + ASC(c0$)), 3) + "b0808.til")
'215 COLOR c1, c2: LOCATE y0, x0: PRINT c0$; : COLOR 15, 0
219 RETURN

220 FOR xx = px - 1 TO px + 1: FOR yy = py - 1 TO py + 1
221 IF (SQR((yy - py) ^ 2 + (xx - px) ^ 2)) > z(p0, 5) * .5 AND v(yy, xx) = 0 THEN 225
222 c3 = 1: c0$ = CHR$(g(yy, xx)): x0 = xx: y0 = yy: GOSUB 210
223 IF c3 > 0 AND v(yy, xx) = 0 THEN g1 = g1 + 1
224 v(yy, xx) = 1
225 NEXT yy: NEXT xx: RETURN

250 'Border
251 FOR xx = 2 TO 39: COLOR 3: LOCATE 1, xx: PRINT "Ä"; : LOCATE 25, xx: PRINT "Ä"; : NEXT xx
253 FOR yy = 2 TO 24: COLOR 3: LOCATE yy, 1: PRINT "³"; : LOCATE yy, 40: PRINT "³"; : NEXT yy
254 LOCATE 1, 1: PRINT "Ú"; : LOCATE 1, 40: PRINT "¿"; : LOCATE 25, 1: PRINT "À"; : LOCATE 25, 40: PRINT "Ù";
255 'dg$ = STR$(dg): COLOR 9: LOCATE 1, 4: PRINT "Dungeon"; RIGHT$(dg$, LEN(dg$) - 1); : COLOR 15, 0
256 COLOR 15, 0: RETURN

300 GOSUB 250: GOSUB 1000: GOSUB 220: y0 = py: x0 = px: GOSUB 410
301 c0$ = "x": c1 = 15: y0 = py: x0 = px: GOSUB 215
302 GOSUB 1600: PCOPY 0, 1: GOSUB 220
310 r$ = "": c$ = "": c$ = INKEY$
311 IF c$ = CHR$(27) THEN SCREEN 7, 0, 0, 0: LOCATE 24, 1: COLOR 15, 0: END
312 IF c$ = "~" THEN RUN
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
399 GOTO 300

400 'warp
401 qx = INT(RND(1) * 38) + 2: qy = INT(RND(1) * 23) + 2
402 x0 = qx: y0 = qy: GOSUB 410
403 IF v(qy, qx) = 1 OR c3 = 0 OR c3 = 2 THEN 400 ELSE px = qx: py = qy: z(p0, 4) = z(p0, 4) - r: r$ = STR$(r): r$ = "[Cast 'Warp']" + "[Mp -" + RIGHT$(r$, LEN(r$) - 1) + "]"
404 RETURN

410 c0$ = CHR$(g(y0, x0))
411 c3 = 0
412 c3 = c3 + 1: IF c3 = 4 THEN c3 = 0: c0 = 1: GOTO 414
413 c0 = INSTR(1, T$(c3), c0$): IF c0 = 0 THEN 412
414 c0$ = MID$(T$(c3), c0, 1): c1 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 4, 2))
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
466 IF r > 0 AND k(p0, r) = 1 AND e(p0, r) < s(r) THEN r0 = INT(RND(1) * s(r)): r1 = INT(RND(1) * s(r)) + 1: IF r0 < e(p0, r) AND r1 > e(p0, r) THEN e(p0, r) = e(p0, r) + INT(RND(1) * 5) + 1: r$ = "[Mystic Orb: '" + s$(r) + "' Increased]"
467 IF r > 0 AND k(p0, r) = 0 THEN k(p0, r) = 1: r$ = "[Mystic Orb: Learned '" + s$(r) + "']"
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
643 c0 = INSTR(1, T$(c3), c0$): IF c0 = 0 THEN 642
644 c0$ = MID$(T$(c3), c0, 1): c1 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 2, 2)): c2 = VAL(MID$(c$(c3), (c0 - 1) * 6 + 4, 2))
645 'COLOR c1, c2: LOCATE y0, x0: PRINT c0$; : COLOR 15, 0
649 RETURN

700 '
701 'DIM g(25, 40), v(25, 40), l(25, 40)): 'gù[gr>value][gg>view][gs>life]

710 'DIM t$(3), c$(3): 'tr[0>unassigned][1>room][2>passage][3>special]
711 T$(0) = "°": c$(0) = "[0800]"
712 T$(1) = "Û÷": c$(1) = "[0707][0901]": '"÷"
713 T$(2) = "----þþþ##²": c$(2) = "[0806][0806][0806][0806][0806][0806][0806][0807][0807][0800]"
714 T$(3) = "øøøøøøýýýýðððóóìììôôôççñàã": c$(3) = "[1407][1407][1407][1407][1407][1407][0107][0107][0107][0107][1007][1007][1007][0207][0207][1007][1007][1007][0507][0507][0507][0607][0607][1107][0607][0708]"

730 'DIM d(4, 2): 'dirrections: North/East/South/West
731 d(0, 1) = 0: d(0, 2) = 0
732 d(1, 1) = -1: d(0, 2) = 0: d(2, 1) = 0: d(0, 2) = 1
733 d(3, 1) = 1: d(0, 2) = 0: d(4, 1) = 0: d(0, 2) = -1

800 'DIM n$(ch), z(ch, 4), k(ch, 6), e(ch, 6)
801 'character:Name + Initial Hp & Ap & Dp & Mp + Spell Knowledge & Experience

810 n$(1) = "Phil": 'z(1, 1) = 60: z(1, 2) = 3: z(1, 3) = 1: z(1, 4) = 30: z(1, 5) = 2: z(1, 6) = 3
811 i(1, 1) = 60: i(1, 2) = 3: i(1, 3) = 1: i(1, 4) = 30: i(1, 5) = 2: i(1, 6) = 3
812 k(1, 1) = 0: e(1, 1) = 0: 'Warp
813 k(1, 2) = 0: e(1, 2) = 0: 'Vision
814 k(1, 3) = 0: e(1, 3) = 0: 'Tinker
815 k(1, 4) = 1: e(1, 4) = 3: 'Passage+
816 k(1, 5) = 0: e(1, 5) = 0: 'Heal
817 k(1, 6) = 0: e(1, 6) = 0: 'Flare

820 n$(2) = "Poindexter": 'z(2, 1) = 40: z(2, 2) = 2: z(2, 3) = 2: z(2, 4) = 80: z(2, 5) = 3: z(2, 6) = 3
821 i(2, 1) = 40: i(2, 2) = 2: i(2, 3) = 2: i(2, 4) = 80: i(2, 5) = 3: i(2, 6) = 3
822 k(2, 1) = 0: e(2, 1) = 0: 'Warp
823 k(2, 2) = 0: e(2, 2) = 0: 'Vision
824 k(2, 3) = 1: e(2, 3) = 5: 'Tinker+
825 k(2, 4) = 0: e(2, 4) = 0: 'Passage
826 k(2, 5) = 0: e(2, 5) = 0: 'Heal
827 k(2, 6) = 0: e(2, 6) = 0: 'Flare

830 n$(3) = "Celeste": 'z(3, 1) = 40: z(3, 2) = 2: z(3, 3) = 1: z(3, 4) = 60: z(3, 5) = 1: z(3, 6) = 2
831 i(3, 1) = 40: i(3, 2) = 2: i(3, 3) = 1: i(3, 4) = 60: i(3, 5) = 1: i(3, 6) = 2
832 k(3, 1) = 0: e(3, 1) = 0: 'Warp
833 k(3, 2) = 1: e(3, 2) = 10: 'Vision+
834 k(3, 3) = 0: e(3, 3) = 0: 'Tinker
835 k(3, 4) = 0: e(3, 4) = 0: 'Passage
836 k(3, 5) = 1: e(3, 5) = 10: 'Heal+
837 k(3, 6) = 0: e(3, 6) = 0: 'Flare

840 n$(4) = "Jacks": 'z(4, 1) = 80: z(4, 2) = 3: z(4, 3) = 2: z(4, 4) = 45: z(4, 5) = 2: z(4, 6) = 4
841 i(4, 1) = 80: i(4, 2) = 3: i(4, 3) = 2: i(4, 4) = 45: i(4, 5) = 2: i(4, 6) = 4
842 k(4, 1) = 1: e(4, 1) = 10: 'Warp+
843 k(4, 2) = 0: e(4, 2) = 0: 'Vision
844 k(4, 3) = 0: e(4, 3) = 0: 'Tinker
845 k(4, 4) = 0: e(4, 4) = 0: 'Passage
846 k(4, 5) = 0: e(4, 5) = 0: 'Heal
847 k(4, 6) = 0: e(4, 6) = 0: 'Flare

850 n$(5) = "Dereck": 'z(5, 1) = 100: z(5, 2) = 5: z(5, 3) = 5: z(5, 4) = 3: z(5, 5) = 3: z(5, 6) = 4
851 i(5, 1) = 100: i(5, 2) = 5: i(5, 3) = 5: i(5, 4) = 3: i(5, 5) = 3: i(5, 6) = 4
852 k(5, 1) = 0: e(5, 1) = 0: 'Warp
853 k(5, 2) = 0: e(5, 2) = 0: 'Vision
854 k(5, 3) = 0: e(5, 3) = 0: 'Tinker
855 k(5, 4) = 0: e(5, 4) = 0: 'Passage
856 k(5, 5) = 1: e(5, 5) = 3: 'Heal
857 k(5, 6) = 0: e(5, 6) = 0: 'Flare

860 n$(6) = "Morton": 'z(6, 1) = 70: z(6, 2) = 4: z(6, 3) = 3: z(6, 4) = 10: z(6, 5) = 4: z(6, 6) = 3
861 i(6, 1) = 70: i(6, 2) = 4: i(6, 3) = 3: i(6, 4) = 10: i(6, 5) = 4: i(6, 6) = 3
862 k(6, 1) = 0: e(6, 1) = 0: 'Warp
863 k(6, 2) = 0: e(6, 2) = 0: 'Vision
864 k(6, 3) = 1: e(6, 3) = 10: 'Tinker+
865 k(6, 4) = 1: e(6, 4) = 40: 'Passage+
866 k(6, 5) = 0: e(6, 5) = 0: 'Heal
867 k(6, 6) = 0: e(6, 6) = 0: 'Flare

870 n$(7) = "Fura": 'z(7, 1) = 80: z(7, 2) = 4: z(7, 3) = 4: z(7, 4) = 50: z(7, 5) = 4: z(7, 6) = 4
871 i(7, 1) = 80: i(7, 2) = 4: i(7, 3) = 4: i(7, 4) = 50: i(7, 5) = 4: i(7, 6) = 4
872 k(7, 1) = 0: e(7, 1) = 0: 'Warp
873 k(7, 2) = 0: e(7, 2) = 0: 'Vision
874 k(7, 3) = 0: e(7, 3) = 0: 'Tinker
875 k(7, 4) = 0: e(7, 4) = 0: 'Passage
876 k(7, 5) = 0: e(7, 5) = 0: 'Heal
877 k(7, 6) = 0: e(7, 6) = 20: 'Flare+

900 'DIM s$(6), s(6): 'magic:Name & Difficulty
901 s$(1) = "Warp": s(1) = 100: 'Labyrinth+Jacks
902 s$(2) = "Vision": s(2) = 100: 'Vineard Maze+Dereck
903 s$(3) = "Tinker": s(3) = 100: 'Acid Temple+Poindexter
904 s$(4) = "Passage": s(4) = 100: 'Warlock Cave+Phil
905 s$(5) = "Heal": s(5) = 100: 'Pearl Pool+Celeste
906 s$(6) = "Flare": s(6) = 100: 'Fire Lair+Fura

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
1304 IF r <> p0 THEN r$ = "[Switched to " + n$(r) + "]": IF z(p0, 1) = 0 THEN r$ = r$ + "[Lost " + n$(p0) + "]"
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
1413 NEXT r1: r$ = r$ + n$(r0): NEXT r: r$ = r$ + " joined!]"
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
1601 LOCATE 1, 3: COLOR 9, 0: PRINT n$(p0);
1602 FOR r = 1 TO 6
1603 IF z(p0, r) > i(p0, r) THEN z(p0, r) = i(p0, r)
1604 IF z(p0, r) < 0 THEN z(p0, r) = 0
1605 NEXT r
1606 s1$ = STR$(1000 + z(p0, 1)): s1$ = RIGHT$(s1$, 3): IF z(p0, 1) = i(p0, 1) THEN s1$ = "H" + s1$ ELSE s1$ = "h" + s1$
1607 s2$ = STR$(1000 + z(p0, 2)): s2$ = RIGHT$(s2$, 2): IF z(p0, 2) = i(p0, 2) THEN s2$ = "A" + s2$ ELSE s2$ = "a" + s2$
1608 s3$ = STR$(1000 + z(p0, 3)): s3$ = RIGHT$(s3$, 2): IF z(p0, 3) = i(p0, 3) THEN s3$ = "D" + s3$ ELSE s3$ = "d" + s3$
1609 s4$ = STR$(1000 + z(p0, 4)): s4$ = RIGHT$(s4$, 3): IF z(p0, 4) = i(p0, 4) THEN s4$ = "M" + s4$ ELSE s4$ = "m" + s4$
1610 s$ = "[" + s1$ + "/" + s2$ + "/" + s3$ + "/" + s4$ + "]"
1611 LOCATE 1, 21: COLOR 9, 0: PRINT s$;
1612 s1$ = STR$(go)
1613 s2$ = STR$(ky)
1614 s3$ = STR$(bm)
1615 s$ = "[G" + RIGHT$(s1$, LEN(s1$) - 1)
1616 IF ky > 0 THEN s$ = s$ + "/K" + RIGHT$(s2$, LEN(s2$) - 1)
1617 IF bm > 0 THEN s$ = s$ + "/B" + RIGHT$(s3$, LEN(s3$) - 1)
1618 s$ = s$ + "]"
1619 LOCATE 25, 39 - LEN(s$): COLOR 9, 0: PRINT s$;
1620 IF r$ <> "" THEN LOCATE 25, 3: COLOR 9, 0: PRINT r$; : COLOR 3: PRINT STRING$(36 - LEN(r$), "Ä"); : COLOR 15, 0
1629 RETURN

1700 IF r$ <> "" THEN RETURN: 'merchant
1701 IF m0 = 1 THEN m0$ = "Merchant": m1$ = "Apple": m1 = 30: m2 = 1
1702 IF m0 = 2 THEN m0$ = "Merchant": m1$ = "Key": m1 = 100: m2 = 1
1703 IF m0 = 3 THEN m0$ = "Merchant": m1$ = "Bomb": m1 = 200: m2 = 1
1704 IF m0 = 4 THEN m0$ = "Merchant": m1$ = "Apple": m1 = 60: m2 = 3
1705 IF m0 = 5 THEN m0$ = "Merchant": m1$ = "Key": m1 = 200: m2 = 3
1706 IF m0 = 6 THEN m0$ = "Merchant": m1$ = "Bomb": m1 = 300: m2 = 5
1707 IF m0 = 7 THEN m0$ = "Merchant": m1$ = "Spore": m1 = 300: m2 = 5
1708 IF m0 = 8 THEN m0$ = "Merchant": m1$ = "Nectar": m1 = 300: m2 = 5
1709 IF m0 = 9 THEN m0$ = "Blacksmith": m1$ = "ApForge": m1 = 60: m2 = 3
1710 IF m0 = 10 THEN m0$ = "Blacksmith": m1$ = "DpForge": m1 = 200: m2 = 3
1711 IF m0 = 11 THEN m0$ = "Sorceror": m1$ = "'" + s$(1) + "'+": m1 = 100: m2 = 3
1712 IF m0 = 12 THEN m0$ = "Sorceror": m1$ = "'" + s$(2) + "'+": m1 = 100: m2 = 3
1713 IF m0 = 13 THEN m0$ = "Sorceror": m1$ = "'" + s$(3) + "'+": m1 = 100: m2 = 3
1714 IF m0 = 14 THEN m0$ = "Sorceror": m1$ = "'" + s$(4) + "'+": m1 = 100: m2 = 3
1715 IF m0 = 15 THEN m0$ = "Sorceror": m1$ = "'" + s$(5) + "'+": m1 = 100: m2 = 3
1716 IF m0 = 16 THEN m0$ = "Sorceror": m1$ = "'" + s$(6) + "'+": m1 = 100: m2 = 3
1717 IF m0 = 17 THEN m0$ = "Merchant": m1$ = "Spore": m1 = 200: m2 = 3
1718 IF m0 = 18 THEN m0$ = "Sorceror": m1$ = "MPmax+": m1 = 300: m2 = 5
1730 s1$ = STR$(m1): s1$ = RIGHT$(s1$, LEN(s1$) - 1)
1731 s2$ = STR$(m2): s2$ = RIGHT$(s2$, LEN(s2$) - 1)
1733 IF RIGHT$(m1$, 2) = "'+" THEN m3$ = m1$ + s2$: GOTO 1798
1734 IF RIGHT$(m1$, 1) = "+" AND m2 > 1 AND INSTR(1, "x", MID$(m1$, LEN(m1$) - 1, 1)) = 0 THEN m1$ = LEFT$(m1$, LEN(m1$) - 1) + "s+": m3$ = m1$ + s2$: GOTO 1798
1735 IF RIGHT$(m1$, 1) = "+" AND m2 > 1 AND INSTR(1, "x", MID$(m1$, LEN(m1$) - 1, 1)) > 0 THEN m1$ = LEFT$(m1$, LEN(m1$) - 1) + "es+": m3$ = m1$ + s2$: GOTO 1798
1736 IF RIGHT$(m1$, 1) = "+" THEN m3$ = m1$ + s2$: GOTO 1798
1737 IF m2 > 1 AND INSTR(1, "x", RIGHT$(m1$, 1)) = 0 THEN m1$ = m1$ + "s": m3$ = s2$ + m1$: GOTO 1798
1738 IF m2 > 1 AND INSTR(1, "x", RIGHT$(m1$, 1)) > 0 THEN m1$ = m1$ + "es": m3$ = s2$ + m1$: GOTO 1798
1739 m3$ = s2$ + m1$
1798 r$ = "{" + m0$ + ": " + s1$ + "GP for " + m3$ + "}"
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

FUNCTION DetectCard%
                                                        
'  Purpose:   Detects an AdLib-compatible card.
'             Returns -1 (true) if detected and 0 (false) if not.
'  Variables: Nope                         
                                                        
CALL WriteReg(&H4, &H60)
CALL WriteReg(&H4, &H80)
B = INP(&H388)
CALL WriteReg(&H2, &HFF)
CALL WriteReg(&H4, &H21)
  FOR x = 0 TO 130
    a = INP(&H388)
  NEXT x
c = INP(&H388)
CALL WriteReg(&H4, &H60)
CALL WriteReg(&H4, &H80)
Success = 0
IF (B AND &HE0) = &H0 THEN
  IF (c AND &HE0) = &HC0 THEN
    Success = -1
  END IF
END IF
DetectCard% = Success
END FUNCTION

SUB GraphicPut (XXXX, YYYY, GGGG$)
'IF GGGG = 0 THEN 10001
'IF GGGG = 3 THEN GGGG = GGGG + INT(gc)

  DEF SEG = VARSEG(g01(0)): BLOAD GGGG$, VARPTR(g01(0))
  PUT (XXXX, YYYY), g01, PSET

'10001 :
END SUB

DEFSNG A-Z
SUB MouseDriver (AX%, bx%, CX%, DX%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL Absolute(AX%, bx%, CX%, DX%, mouse%)
END SUB

SUB MouseHide
 AX% = 2
 MouseDriver AX%, 0, 0, 0
END SUB

FUNCTION MouseInit%
  AX% = 0
  MouseDriver AX%, 0, 0, 0
  MouseInit% = AX%

END FUNCTION

SUB MousePut
  AX% = 4
  CX% = x%
  DX% = y%
  MouseDriver AX%, 0, CX%, DX%
END SUB

SUB mouseshow
  AX% = 1
  MouseDriver AX%, 0, 0, 0
END SUB

SUB mousestatus (lb%, RB%, Xmouse%, Ymouse%)
  AX% = 3
  MouseDriver AX%, bx%, CX%, DX%
  lb% = ((bx% AND 1) <> 0)
  RB% = ((bx% AND 2) <> 0)
  Xmouse% = CX%
  Ymouse% = DX%
END SUB

DEFINT A-Z
SUB SBInit
'  Initialize the sound card               
                                                        
'(This is the "quick-and-dirty" method; what it's doing is zeroing out

'  all of the card's registers.  I haven't had any problems with this.)


                                                        
FOR q = 1 TO &HF5
  CALL WriteReg(q, 0)
NEXT q
                                                        
END SUB

SUB SBPlay (freq%)
'  Purpose:      Plays a note              
'  Variables:    freq% - Frequency (00-FF hex)
'                duration% - Duration (n seconds) (not used)
'  I'm still working on this part, it may be ugly, but it works <g>.

'  The first group of WriteRegs is the modulator, the second is the

'  carrier.                                
'  If you just want to know how to create your own instrument, play around

'  with the second values in the first four calls to WriteReg in each group.

'  :-)  Have fun!  - Brett                 
                                                        
CALL WriteReg(&H20, &HFB)     ' Set modulator's multiple to F
CALL WriteReg(&H40, &H3)    ' Set modulator's level to 40 dB
CALL WriteReg(&H60, &H0)   ' Modulator attack: quick, decay: long

CALL WriteReg(&H87, &HF)   ' Modulator sustain: medium, release: medium
CALL WriteReg(&HA0, freq%)
                                                        
                                                        
CALL WriteReg(&H23, &HF)   ' Set carrier's multiple to 0
CALL WriteReg(&H43, &H0)   ' Set carrier's level to 0 dB
CALL WriteReg(&H63, &HF0)  ' Carrier attack: quick, decay: long

CALL WriteReg(&H83, &HFF)  ' Carrier sustain: quick, release: quick
CALL WriteReg(&HB0, &H20)  ' Octave        
                                                        
CALL WriteReg(&HE0, &H0)   ' Waveform argument for Tom..
                           ' &H00 is the default, but I felt like
                           ' dropping it in for you.. :)
                                                        
' I originally had an extra argument, duration!, but for some reason
' I wanted to do the timing outside of this sub..  You can change it back

' if needs require..                       
                                                        
'TimeUp! = TIMER + duation!                
'WHILE TimeUp! > TIMER: WEND  ' Worst you can be off is .182 of a second

END SUB

DEFSNG A-Z
SUB STICKS (Joyx%, JOYY%, BUT1%, BUt2%, BUT3%)
Joyx% = STICK(0)
JOYY% = STICK(1)

BUT1% = STRIG(1)
BUt2% = STRIG(5)
BUT3% = STRIG(7)
END SUB

DEFINT A-Z
SUB WriteReg (Reg%, Value%)
'  Purpose:   Writes to any of the SB/AdLib's registers
'  Variables: Reg%: Register number,       
'             Value%: Value to insert in register
'              (Note: The registers are from 00-F5 (hex))
OUT &H388, Reg     '388h = address/status port, 389h = dataport
  FOR x = 0 TO 5   ' This tells the SB what register we want to write to


    a = INP(&H388) ' After we write to the address port we must wait 3.3ms

  NEXT x
                                                        
OUT &H389, Value   ' Send the value for the register to 389h
  FOR x = 0 TO 34  ' Here we must also wait, this time 23ms
    a = INP(&H388)
  NEXT x
END SUB

