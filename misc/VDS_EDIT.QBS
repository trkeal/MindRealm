0 :
'
'
'''scene draw - 2-16-96 - {Aquarius Games}
'  ....
' .  * .                   /           
'.  **  .             \   /   /\    ___   \
'. * ***.              \ /   /     /  /   /
'.****  .               X   <---  /  /   /
'*.  * .quarius        / \   \   /   \  /
'  ....Games          /   \   \/ \    \/
'
'video data strings - 5-01-97
'
'VDS_EDIT.QBS
'
'
4 SCRN = 7
5 PALETTE 0, 0: PALETTE 1, 1: PALETTE 2, 2
6 PALETTE 3, 3: PALETTE 4, 4: PALETTE 5, 5
7 PALETTE 6, 6: PALETTE 7, 7: PALETTE 8, 8
8 PALETTE 9, 9: PALETTE 10, 10: PALETTE 11, 11
9 PALETTE 12, 12: PALETTE 13, 13: PALETTE 14, 14: PALETTE 15, 15
KEY OFF: SCREEN SCRN, 0, 0, 0: COLOR 15, 0: CLS : RANDOMIZE TIMER
LOCATE 1, 1
PRINT "VDS Editor"
INPUT "Width:"; AA
INPUT "Height:"; DD
10 KEY OFF: SCREEN SCRN, 0, 1, 0: COLOR 15, 0: CLS : RANDOMIZE TIMER
15 :
'AA = 16: DD = 16
SZ = 2: BD = (8 - SZ) + 2: LI = 1
16 DIM f$(200)
17 DIM gr(16000): VX = 1: x = 1: y = 1: c = 15
18 DIM P1(8, 8): P1$ = "crsr_001.08x": GOSUB 800
19 DIM S1(8, 8): S1$ = "crsr_001.08x": GOSUB 900
20 REM"Mem Box"
25 'LINE(0,BD+SZ)-((AA*SZ)-1,(DD*SZ)+BD+(SZ-1)),10,B
30 FOR TT = 1 TO DD
40 FOR T = 1 TO AA
45 'IF VX=0 THEN GR(X,Y)=8
50 LINE ((T * SZ) - SZ, (TT * SZ) + BD)-((T * SZ) - 1, (TT * SZ) + BD + (SZ - 1)), gr(T + (TT - 1) * AA), BF
60 NEXT T: NEXT TT
62 'LINE(0,BD+SZ)-((AA*SZ)-1,(DD*SZ)+BD+(SZ-1)),10,B
65 'VX=1:X=1:Y=1:C=15
66 PCOPY 1, 0
68 CC = 15: c$ = " ": GOTO 170
70 '
75 c$ = INKEY$: XX = x: YY = y: IF c$ = "" THEN c$ = " "
76 pb = PEN(3): px = PEN(4): py = PEN(5): sb = STRIG(0): sx = STICK(0): sy = STICK(1)
77 'LINE((X*SZ)-SZ,(Y*SZ)+BD)-((X*SZ)-1,(Y*SZ)+BD+(SZ-1)),GR(X+(Y-1)*AA),BF
78 IF STRIG(0) = -1 THEN c$ = CHR$(13)
79 IF sy < 85 THEN c$ = "+" ELSE IF sy > 125 THEN c$ = "-"
80 IF pb = -1 THEN x = INT(px / SZ) + 1: y = INT((py - BD) / SZ)
82 IF x > AA THEN x = AA ELSE IF x <= 0 THEN x = 1
85 IF y > DD THEN y = DD ELSE IF y <= 0 THEN y = 1
90 IF (c$ = "b" OR INSTR("123", c$) > 0) AND y < DD THEN y = y + 1
91 IF c$ = "B" AND y < DD THEN gr(x + (y - 1) * AA) = c: y = y + 1: gr(x + (y - 1) * AA) = c
100 IF (c$ = "y" OR INSTR("789", c$) > 0) AND y > 1 THEN y = y - 1
101 IF c$ = "Y" AND y > 1 THEN gr(x + (y - 1) * AA) = c: y = y - 1: gr(x + (y - 1) * AA) = c
110 IF (c$ = "h" OR INSTR("369", c$) > 0) AND x < AA THEN x = x + 1
111 IF c$ = "H" AND x < AA THEN gr(x + (y - 1) * AA) = c: x = x + 1: gr(x + (y - 1) * AA) = c
120 IF (c$ = "g" OR INSTR("147", c$) > 0) AND x > 1 THEN x = x - 1
121 IF c$ = "G" AND x > 1 THEN gr(x + (y - 1) * AA) = c: x = x - 1: gr(x + (y - 1) * AA) = c
130 IF c$ = "+" OR c$ = "A" THEN c = c + 1: IF c > 15 THEN c = 0
140 IF c$ = "-" OR c$ = "Z" THEN c = c - 1: IF c < 0 THEN c = 15
145 IF c$ = CHR$(13) THEN gr(x + (y - 1) * AA) = c
155 IF c$ = "q" OR c$ = "Q" THEN LOCATE 20, 1: END
156 IF c$ = CHR$(27) THEN SCREEN 0, 0, 0, 0: WIDTH 80: COLOR 15, 1, 1: CLS : END
157 IF c$ = "r" THEN 30
158 IF c$ = "S" THEN GOSUB 200: GOTO 20
159 IF c$ = "L" THEN GOSUB 1400: GOTO 20
'160 IF c$ = "M" THEN GOSUB 600: GOTO 20
IF c$ = "I" THEN xx1 = x: yy1 = y
IF c$ = "K" THEN xx2 = x: yy2 = y
IF c$ = "J" THEN
  FOR ty = yy1 TO yy2
  FOR tx = xx1 TO xx2
    gr(tx + (ty - 1) * AA) = c
    LINE ((tx * SZ) - SZ, (ty * SZ) + BD)-((tx * SZ) - 1, (ty * SZ) + BD + (SZ - 1)), gr(tx + (ty - 1) * AA), BF
  NEXT tx
  NEXT ty
END IF
IF c$ = "M" THEN
  FOR ty = yy1 TO yy2
  FOR tx = xx1 TO xx2
    IF gr(tx + (ty - 1) * AA) = 0 THEN
      gr(tx + (ty - 1) * AA) = 15
      ELSE
      gr(tx + (ty - 1) * AA) = 0
    END IF
    LINE ((tx * SZ) - SZ, (ty * SZ) + BD)-((tx * SZ) - 1, (ty * SZ) + BD + (SZ - 1)), gr(tx + (ty - 1) * AA), BF
  NEXT tx
  NEXT ty
END IF
161 IF c$ = "|" AND SZ < 50 THEN SZ = SZ + 1: GOTO 20
162 IF c$ = "\" AND SZ > 1 THEN SZ = SZ - 1: GOTO 20
166 CC = 15 - gr(x + (y - 1) * AA)
167 IF px > 311 THEN px = 311
168 IF py > 191 THEN py = 191
169 LINE ((XX * SZ) - SZ, (YY * SZ) + BD)-((XX * SZ) - 1, (YY * SZ) + BD + (SZ - 1)), gr(XX + (YY - 1) * AA), BF
170 LINE ((x * SZ) - SZ, (y * SZ) + BD)-((x * SZ) - 1, (y * SZ) + BD + (SZ - 1)), gr(x + (y - 1) * AA), BF
171 PCOPY 1, 2
172 LINE ((x * SZ) - SZ, (y * SZ) + BD)-((x * SZ) - 1, (y * SZ) + BD + (SZ - 1)), CC, B
173 IF pb = -1 AND sb <> -1 THEN PUT (px, py), P1, XOR: 'sound 300,.05
174 IF pb = -1 AND sb = -1 THEN PUT (px, py), S1, XOR: 'sound 500,.05
175 IF LI = 1 THEN LINE (0, BD + SZ)-((AA * SZ) - 1, (DD * SZ) + BD + (SZ - 1)), 10, B
176 LOCATE 1, 1: PRINT STRING$(40, " ");
177 LOCATE 1, 1: PRINT "Color:"; c;
178 LOCATE 1, 11: PRINT "Size:"; SZ;
179 LOCATE 1, 20: PRINT "Vis Draw";
180 LOCATE 1, 30: PRINT x; ","; y;
181 LOCATE 1, 38: PRINT sb;
182 'IF PB=-1 THEN PRESET(PX,PY)
LINE ((xx1 * SZ) - SZ, (yy1 * SZ) + BD)-((xx2 * SZ) - 1, (yy2 * SZ) + BD + (SZ - 1)), c, B
185 PCOPY 1, 0: PCOPY 2, 1
199 GOTO 70
200 'save
210 SCREEN 9, 0, 0, 0: COLOR 15, 1: WIDTH 80: CLS
220 PRINT "Save picture"
230 LINE INPUT "name for data file:"; D$
231 IF D$ = "" THEN 330
240 OPEN D$ FOR OUTPUT AS 1
241 'PRINT #1,">"
PRINT #1, xx2 - xx1 + 1
PRINT #1, yy2 - yy1 + 1
250 FOR T = yy1 TO yy2: FOR TT = xx1 TO xx2
260 GG$ = RIGHT$(STR$(gr(TT + (T - 1) * AA)), 2): IF LEFT$(GG$, 1) = " " THEN GG$ = "0" + RIGHT$(GG$, 1)
265 WG$ = WG$ + GG$
270 IF TT < xx2 THEN WG$ = WG$ + ","
280 NEXT TT
290 PRINT #1, WG$
300 PRINT WG$
310 WG$ = ""
320 NEXT T
325 CLOSE 1: c$ = INPUT$(1)
330 SCREEN 7, 0, 1, 0: RETURN
400 'Load
410 SCREEN 0, 0, 0, 0: WIDTH 80: COLOR 15, 1, 1: CLS
420 INPUT "Load what file:"; fl$
430 OPEN fl$ FOR INPUT AS 1
440 FOR TT = 1 TO DD: FOR T = 1 TO AA
450 INPUT #1, gr(T + (TT - 1) * AA)
460 NEXT T: NEXT TT
465 CLOSE
470 SCREEN 7, 0, 1, 0: RETURN
500 'Save
510 SCREEN 0, 0, 0, 0: WIDTH 80: COLOR 15, 1, 1: CLS
520 INPUT "Save file as:"; fl$
530 OPEN fl$ FOR OUTPUT AS 1
540 FOR TT = 1 TO DD: FOR T = 1 TO AA
550 PRINT #1, gr(T + (TT - 1) * AA)
560 NEXT T: NEXT TT
565 CLOSE
570 SCREEN 7, 0, 1, 0: RETURN
600 'road Merge
610 SCREEN 0, 0, 0, 0: WIDTH 80: COLOR 15, 1, 1: CLS
620 INPUT "Road Merge what file:"; fl$
630 OPEN fl$ FOR INPUT AS 1
640 FOR TT = 1 TO 60: FOR T = 1 TO 100
650 INPUT #1, r: IF gr(T + (TT - 1) * AA) = 0 AND r > 0 THEN gr(T + (TT - 1) * AA) = 15
660 NEXT T: NEXT TT
665 CLOSE
670 SCREEN 7, 0, 1, 0: RETURN
800 'pen graphic
810 LINE (0, 0)-(319, 199), 0, BF
820 OPEN P1$ FOR INPUT AS 1
830 FOR TT = 1 TO 8: FOR T = 1 TO 8
840 INPUT #1, r
850 PSET (T, TT), r
860 NEXT T: NEXT TT
870 GET (1, 1)-(8, 8), P1
880 LINE (0, 0)-(319, 199), 0, BF: CLOSE 1
890 RETURN
900 'stick graphic
910 LINE (0, 0)-(319, 199), 0, BF
920 OPEN S1$ FOR INPUT AS 1
930 FOR TT = 1 TO 8: FOR T = 1 TO 8
940 INPUT #1, r
950 PSET (T, TT), r
960 NEXT T: NEXT TT
970 GET (1, 1)-(8, 8), S1
980 LINE (0, 0)-(319, 199), 0, BF: CLOSE 1
990 RETURN

1400 'Load

SCREEN 0, 0, 0, 0: WIDTH 80: COLOR 15, 0, 1: CLS : VIEW PRINT 1 TO 25
FILES "*.VDS"
lflc = 200

FOR ylc = 1 TO 25
FOR xlc = 1 TO 4
flc = (ylc - 1) * 4 + xlc
f$(flc) = ""
FOR llc = 1 TO 12
fflc = SCREEN(ylc, (xlc - 1) * 18 + llc)
'IF fflc = 0 OR fflc = 32 THEN fflc = 32: IF flc > 4 AND flc < lflc THEN lflc = flc - 1
f$(flc) = f$(flc) + CHR$(fflc)
NEXT llc
IF INSTR(f$(flc), ".VDS") = 0 THEN
  IF flc > 4 AND flc < lflc THEN
    lflc = flc - 1
  END IF
END IF
NEXT xlc
NEXT ylc

FOR tlc = lflc + 1 TO 200
f$(tlc) = STRING$(12, CHR$(32))
NEXT tlc
rlc = 10
plc = 1 + rlc
qlc = 1
IF plc < 5 + rlc THEN plc = 5 + rlc ELSE IF plc > lflc - rlc THEN plc = lflc - rlc
IF qlc < 5 THEN qlc = 5 ELSE IF qlc > lflc THEN qlc = lflc

IF lflc < 5 + 2 * rlc < lflc AND INT((lflc - 5) / 2) < rlc THEN rlc = INT((lflc - 5) / 2)

SCREEN 0, 0, 0, 0: WIDTH 40: COLOR 15, 1, 1: CLS : VIEW PRINT 1 TO 25

1410 '
COLOR 15, 1
LOCATE 2, 13
PRINT CHR$(218) + STRING$(3, CHR$(196)) + " LOAD " + STRING$(3, CHR$(196)) + CHR$(191);
LOCATE 2 * rlc + 4, 13
PRINT CHR$(192) + STRING$(12, CHR$(196)) + CHR$(217);
FOR tlc = plc - rlc TO plc + rlc
COLOR 15, 1
LOCATE tlc - plc + rlc + 3, 13
PRINT CHR$(179);
IF tlc = qlc THEN COLOR 1, 15
PRINT f$(tlc);
COLOR 15, 1
PRINT CHR$(179);
NEXT tlc

c$ = INKEY$
IF c$ = "+" THEN qlc = qlc + 1
IF c$ = "-" THEN qlc = qlc - 1
IF qlc < plc - rlc THEN plc = plc - 1 ELSE IF qlc > plc + rlc THEN plc = plc + 1
IF plc < 5 + rlc THEN plc = 5 + rlc ELSE IF plc > lflc - rlc THEN plc = lflc - rlc
IF qlc < 5 THEN qlc = 5 ELSE IF qlc > lflc THEN qlc = lflc
IF c$ = CHR$(27) THEN 1465
IF c$ = CHR$(13) THEN fl$ = f$(qlc): GOTO 1421
GOTO 1410

1421 'RIGHT$(fl$, 4) = ".VDS" AND LEN(fl$) = 12 THEN xs = VAL(MID$(fl$, 5, 2)): ys = VAL(MID$(fl$, 7, 2)): GOTO 1430
1422 'INPUT "X-size"; xs
1424 'INPUT "Y-size"; ys
1430 :
OPEN fl$ FOR INPUT AS 1
INPUT #1, AA
INPUT #1, DD
1440 FOR TT = 1 TO DD: FOR T = 1 TO AA
1450 INPUT #1, r: IF r = -1 THEN r = 0

1451 'x1 = INT((t - 1) * (AA / xs)) + 1: y1 = INT((TT - 1) * (DD / ys)) + 1
1452 'x2 = INT((t + 0) * (AA / xs)) + 1: y2 = INT((TT + 0) * (DD / ys)) + 1

1453 'IF x1 < 1 THEN x1 = 1 ELSE IF x1 > AA THEN x1 = AA
1454 'IF y1 < 1 THEN y1 = 1 ELSE IF y1 > DD THEN y1 = DD
1455 'IF x2 < 1 THEN x2 = 1 ELSE IF x2 > AA THEN x2 = AA
1456 'IF y2 < 1 THEN y2 = 1 ELSE IF y2 > DD THEN y2 = DD

1457 'FOR t2 = y1 TO y2: FOR t1 = x1 TO x2: GR(t1 + (t2 - 1) * AA) = r: NEXT t1: NEXT t2
gr(T + (TT - 1) * AA) = r

1460 NEXT T: NEXT TT
1465 CLOSE
1470 SCREEN SCRN, 0, 1, 0: RETURN

