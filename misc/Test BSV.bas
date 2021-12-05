
#include once "inc\fb header.bas"

screenres 320,200,0,8
screenset 1,0

dim as string r = string$( 0, 0 )
dim as integer i = 0

filemode = freefile
if open("party\party.txt" for input as #filemode) then
	close #filemode
end if

do while not(eof(filemode))
	i+=1
	input #filemode, r
	sprite_put( 0, ( i - 1 ) * 8, 0, "party\" + r, "pset" )	
loop

close #filemode

flip
sleep