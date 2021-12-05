#ifdef __old_gamepad__
DEFSNG A-Z
SUB STICKS (Joyx%, JOYY%, BUT1%, BUt2%, BUT3%)
Joyx% = STICK(0)
JOYY% = STICK(1)

BUT1% = STRIG(1)
BUt2% = STRIG(5)
BUT3% = STRIG(7)
END SUB
#endif
