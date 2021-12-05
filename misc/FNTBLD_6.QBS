DIM g(-1 TO 8, -1 TO 8)
SCREEN 7, 0, 1, 0
COLOR 15
OPEN "font_007.dat" FOR OUTPUT AS 1
xx = 0
yy = 0
cc = 15

FOR t = 33 TO 255
LOCATE 1, 1: PRINT CHR$(t)
FOR y = 0 TO 7
FOR x = 0 TO 7
g(x, y) = POINT(x, INT(y * 1))
NEXT x
NEXT y
'FOR y = 0 TO 7
'FOR x = 0 TO 7
'IF (g(x - 1, y) = 15 OR g(x + 1, y) = 15 OR g(x, y - 1) = 15 OR g(x, y + 1) = 15) AND g(x, y) = 0 THEN g(x, y) = 7
'NEXT x
'NEXT y
CLS
FOR y = 0 TO 7
FOR x = 0 TO 7
LINE (x * 8, y * 8)-(x * 8 + 7, y * 8 + 7), g(x, y), BF
NEXT x
NEXT y

10 :
LINE (xx * 8, yy * 8)-(xx * 8 + 7, yy * 8 + 7), g(xx, yy), BF
LINE (xx * 8, yy * 8)-(xx * 8 + 7, yy * 8 + 7), 15 - g(xx, yy), B
LINE (xx * 8 + 1, yy * 8 + 1)-(xx * 8 + 6, yy * 8 + 6), cc, B
LOCATE 20, 1: PRINT STRING$(40, " ");
LOCATE 20, 1: PRINT RIGHT$(STR$(t + 1000), 3); ":"; CHR$(t);
LOCATE 20, 20: PRINT "color:"; cc;
LINE (0 * 8, 0 * 8)-(7 * 8 + 7, 7 * 8 + 7), 15, B
PCOPY 1, 0
LINE (xx * 8, yy * 8)-(xx * 8 + 7, yy * 8 + 7), g(xx, yy), BF

c$ = INPUT$(1)
IF c$ = CHR$(27) THEN END

IF c$ = "+" THEN cc = cc + 1
IF cc > 15 THEN cc = 0
IF c$ = "-" THEN cc = cc - 1
IF cc < 0 THEN cc = 15

IF c$ = CHR$(13) THEN g(xx, yy) = cc

IF c$ = "6" THEN xx = xx + 1
IF xx > 7 THEN xx = 0
IF c$ = "4" THEN xx = xx - 1
IF xx < 0 THEN xx = 7

IF c$ = "2" THEN yy = yy + 1
IF yy > 7 THEN yy = 0
IF c$ = "8" THEN yy = yy - 1
IF yy < 0 THEN yy = 7

IF c$ = " " THEN 20

GOTO 10

20 :

FOR y = 0 TO 7
w$ = ""
FOR x = 0 TO 7
IF x > 0 THEN w$ = w$ + ","
w$ = w$ + RIGHT$(STR$(g(x, y) + 100), 2)
NEXT x
PRINT #1, w$
NEXT y
NEXT t

CLOSE
END

