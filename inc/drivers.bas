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
