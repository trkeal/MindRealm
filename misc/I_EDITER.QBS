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
DECLARE SUB GraphicPut (XXXX, YYYY, GGGG$)
DECLARE SUB StringPut (XXXX, YYYY, GGGG$)
DIM SHARED scn(16000)
DIM SHARED bsg(201)
 pi = 3.141592654#
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

KEY OFF
SCREEN 13
WIDTH 40
VIEW PRINT 1 TO 25
COLOR 15
CLS

  PRINT "Mouse:"
MS% = MouseInit%
IF NOT MS% THEN
  PRINT "ú not found"
  LET Amouse$ = "NO"
ELSE
  'mouseshow
  PRINT "ú found and initialized"
  LET Amouse$ = "YES"
END IF

  PRINT "Sound card:"
IF DetectCard = false THEN
  PRINT "ú not found"
  LET Asbcard$ = "NO"
ELSE
  SBInit
  PRINT "ú found and initialized"
  LET Asbcard$ = "YES"
END IF
LET TTTT = 1000
LET speed = .1
LET Soundon = false

LET pause = false

LET rrand = 325
 
  PRINT "Timer:"
'LET time$ = "00:00:00"
TIMER ON
  PRINT ("ú " + STR$(TIMER))
  'PRINT ("ú initialized")
  PRINT ("ú activated")
'RRRR = TIMER
RANDOMIZE rrand
  PRINT ("ú randomized " + STR$(rrand))
 
  PRINT "Time:"
  PRINT ("ú " + TIME$)


  PRINT "Date:"
  PRINT ("ú " + DATE$)

  PRINT "Press the spacebar to start..."

c$ = ""
WHILE c$ <> CHR$(32)
  c$ = INKEY$
  IF c$ = CHR$(27) THEN END
  IF c$ = "@" THEN
    INPUT "rrand:"; rrand
    RANDOMIZE rrand
    c$ = " "
  END IF
WEND


SCREEN 13
VIEW PRINT 1 TO 25

CLS

LINE (0, 0)-(319, 199), 15, B
FOR t = 0 TO 21
xx = 64
yy = 64
LINE (t * 8 + xx, 0 + yy)-(t * 8 + 7 + xx, 15 + yy), t + 32, BF
LINE (t * 8 + 0 + xx, 16 + yy)-(t * 8 + 7 + xx, 31 + yy), t + 32 + 24, BF
LINE (t * 8 + 0 + xx, 32 + yy)-(t * 8 + 7 + xx, 47 + yy), t + 32 + 24 + 24, BF
NEXT t

SLEEP

xx = 79
yy = 49
c = 15
sv$ = "scn_temp.scn"
SprayRadius = 3
bordercolor = 8
CLS
10 :

GET (0, 0)-(159, 99), scn
'DEF SEG = VARSEG(scn(0))
'BSAVE sv$, VARPTR(scn(0)), 20 * 20 + 8
PUT (160, 100), scn, PSET

LINE (-1, yy)-(xx - 1, yy), 15
LINE (xx, -1)-(xx, yy - 1), 15

LINE (160, yy)-(xx + 1, yy), 15
LINE (160, 0)-(319, 99), 0, BF

LINE (xx, 100)-(xx, yy + 1), 15
LINE (0, 100)-(159, 199), 0, BF

LOCATE 3, 22: PRINT ("Color: " + RIGHT$(STR$(1000 + c), 3));
LINE ((22 - 1) * 8 - 2, (3 - 1) * 8 - 2)-((31 - 0) * 8 - 1 + 2, (3 - 0) * 8 - 1 + 2), c, B

15 :
xxo = xx
yyo = yy
c$ = INKEY$
CALL mousestatus(lb%, RB%, Xmouse%, Ymouse%)
IF Amouse$ = "YES" THEN xx = INT(Xmouse% / 4): yy = INT(Ymouse% / 2)
IF c$ = "" AND xx = xxo AND yy = yyo AND lb% = 0 AND RB% = 0 THEN 15
IF c$ = CHR$(27) THEN END
IF INSTR("-", LEFT$(c$ + " ", 1)) > 0 THEN c = c - 1
IF INSTR("+", LEFT$(c$ + " ", 1)) > 0 THEN c = c + 1
IF INSTR("789", LEFT$(c$ + " ", 1)) > 0 THEN yy = yy - 1
IF INSTR("123", LEFT$(c$ + " ", 1)) > 0 THEN yy = yy + 1
IF INSTR("147", LEFT$(c$ + " ", 1)) > 0 THEN xx = xx - 1
IF INSTR("369", LEFT$(c$ + " ", 1)) > 0 THEN xx = xx + 1
IF c > 255 THEN c = 0 ELSE IF c < 0 THEN c = 255
IF xx > 159 THEN xx = 0 ELSE IF xx < 0 THEN xx = 159
IF yy > 99 THEN yy = 0 ELSE IF yy < 0 THEN yy = 99
IF c$ = CHR$(13) OR lb% = -1 THEN
  LINE (xx + 160, yy + 100)-(xxo + 160, yyo + 100), c
END IF
IF INSTR("Pp", LEFT$(c$ + " ", 1)) > 0 THEN
  PAINT (xx + 160, yy + 100), c, bordercolor
END IF
IF RB% = -1 THEN
  RANDOMIZE TIMER
  r = RND(1) * 2 * pi * 3000
  rr = RND(1) * SprayRadius
  xxx = xx + 160 + rr * COS(r)
  yyy = yy + 100 + rr * SIN(r)
  p0 = POINT(xxx, yyy)
  p1 = POINT(xxx - 1, yyy + 0)
  p2 = POINT(xxx + 1, yyy + 0)
  p3 = POINT(xxx + 0, yyy - 1)
  p4 = POINT(xxx + 0, yyy + 1)
  PSET (xxx - 1, yyy + 0), p0
  PSET (xxx + 1, yyy + 0), p1
  PSET (xxx + 0, yyy - 1), p2
  PSET (xxx + 0, yyy + 1), p3
  PSET (xxx + 0, yyy + 0), p4
END IF
GET (160, 100)-(319, 199), scn
'DEF SEG = VARSEG(scn(0))
'BLOAD "scn_temp.scn", VARPTR(scn(0))
PUT (0, 0), scn, PSET

GOTO 10

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

  DEF SEG = VARSEG(bsg(0)): BLOAD GGGG$, VARPTR(bsg(0))
  PUT (XXXX, YYYY), bsg, PSET

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
SUB StringPut (XXXX, YYYY, GGGG$)
'IF GGGG = 0 THEN 10001
'IF GGGG = 3 THEN GGGG = GGGG + INT(gc)
 FOR t = 1 TO LEN(GGGG$)
 xxx = XXXX + (t - 1) * 8
 yyy = YYYY
 IF xxx >= 319 - 8 THEN
   xxx = xxx - 39 * 8
   yyy = yyy + 8
 END IF
 IF xxx >= 319 - 8 THEN
   xxx = 0
 END IF

 IF ASC(MID$(GGGG$, t, 1)) >= 33 AND ASC(MID$(GGGG$, t, 1)) <= 255 THEN

 GGGR$ = RIGHT$(STR$(1000 + ASC(MID$(GGGG$, t, 1))), 3) + "b0808.til"

  DEF SEG = VARSEG(bsg(0)): BLOAD GGGR$, VARPTR(bsg(0))
  PUT (XXXX, YYYY), bsg, PSET

 END IF

 NEXT t

'10001 :
END SUB

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

