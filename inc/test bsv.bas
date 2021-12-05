
#include once "inc\fb header.bas"
#include once "inc\graphics.bas"

screenres 320, 200, 0, 8
screenset 1, 0

dim as string filename = command

sprite_put( 0, 0, 0, filename, "pset" )

flip
sleep