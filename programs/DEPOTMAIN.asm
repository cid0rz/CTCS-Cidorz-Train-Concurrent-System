#DEPOTMAIN
clr
btr [virtual-signal=signal-grey] ;wait for polling signal
slp 8
xmov mem1 red ; get channel list
btr [virtual-signal=signal-green]
nop
xmov mem2 red
:total_departures
inc r1
bgt r1 cnm2 :check
add r8 mem2@1
jmp :total_departures
:check
slp 10
fig r7 [virtual-signal=signal-destination]
blt r7 r8 :check
mov out1 1[virtual-signal=signal-white]
mov out1 0
jmp 1
