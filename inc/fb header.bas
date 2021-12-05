
#lang "fblite"
option gosub

dim shared as integer filemode = 0
dim shared as string filename
filename = string$( 0, 0 )
dim shared as string buffer, subject, label, value
buffer = string$( 0, 0 )
subject = string$( 0, 0 )
label = string$( 0, 0 )
value = string$( 0, 0 )

#include once "crt/math.bi"
#include once "file.bi"
'#include once "windows.bi"
#include once "fbgfx.bi"
'
Const Pi = 4 * ATN(1)

dim shared as any ptr Dest

const crlf = chr$( 13 ) + chr$ ( 10 )
const quot = chr$( 34 )
const eq = "="
const colon = ":"
const comma = ","
const semi = ";"

dim shared as integer textfg = 15
dim shared as integer textbg = 1

DECLARE SUB text (yy AS INTEGER, xx AS INTEGER, ss AS STRING, sp AS INTEGER)

DECLARE SUB graphicput (yy1 AS INTEGER, xx1 AS INTEGER, ss1$)

declare sub renderfill( x1 as integer = 0, y1 as integer = 0, x2 as integer = 319, y2 as integer = 199, dither1 as integer = 0, dither2 as integer = -1 )

#include once "inc\mouse.bas"
#include once "inc\gfx\sprites 2x.bas"
#include once "inc\gfx\vector 2x.bas"
#include once "inc\screen scaler.bas"
#include once "inc\outro.bas"
